import json
import requests
import boto3

from draw import Drawer, Rect


prev_content = ''

session = requests.session()

drawer = Drawer(1920, 1080)

s3 = boto3.resource('s3')
bucket = s3.Bucket('s3.doldamgil.spidycoder.com')


def heartbeat():
    global prev_content
    try:
        response = session.patch('https://test.rest.doldamgil.spidycoder.com:4430/gyms/1/edges/1')
        content = response.content.decode('utf-8')
        data = json.loads(content)

        if prev_content != content:
            prev_content = content

            gym_id = data['gymId']
            edge_code = data['edgeCode']
            wall_creation_time = data['wallCreationTime']
            creator_id = data['creatorId']
            route_creation_time = data['routeCreationTime']
            climber_id = data['climberId']
            wall_url = f'gyms/{gym_id}/edges/{edge_code}/walls/{wall_creation_time}'

            bucket.download_file(
                Key=wall_url+'/info',
                Filename='wall-info.json'
            )
            bucket.download_file(
                Key=wall_url+f'/routes/{creator_id}/{route_creation_time}',
                Filename='route.json'
            )

            holds = {}
            with open('wall-info.json') as fp:
                details_json = json.load(fp)
                for hold_json in details_json['holds']:
                    holds[hold_json['id']] = \
                        ((hold_json['x1'], hold_json['y1']), (hold_json['x2'], hold_json['y2']))

            steps = []
            with open('route.json') as fp:
                route_json = json.load(fp)
                for hold_id in route_json['steps']:
                    steps.append(Rect(*holds[hold_id], (0, 255, 0)))
                for hold_id in route_json['start']:
                    steps.append(Rect(*holds[hold_id], (255, 0, 0)))
                for hold_id in route_json['finish']:
                    steps.append(Rect(*holds[hold_id], (0, 0, 255)))

            drawer.shapes = steps

    except requests.exceptions.ConnectionError:
        pass


if __name__ == '__main__':
    drawer.show(heartbeat)
    drawer.close()
