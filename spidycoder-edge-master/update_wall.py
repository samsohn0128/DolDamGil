import boto3
import json
import cv2
import requests

from capture import capture
from infer_wall import infer_wall

frame = capture(1280, 720)
cv2.imwrite('wall-background.jpg', frame)

holds = infer_wall('wall-background.jpg')
wall_info = {'holds': holds}
wall_info_json = json.dumps(wall_info)

session = requests.session()
response = session.post('https://test.rest.doldamgil.spidycoder.com:4430/gyms/1/edges/1/walls')
content = response.content.decode('utf-8')
data = json.loads(content)
gym_id = data['gymId']
edge_code = data['edgeCode']
creation_time = data['creationTime']
wall_url = f'gyms/{gym_id}/edges/{edge_code}/walls/{creation_time}'

s3 = boto3.resource('s3')
bucket = s3.Bucket('s3.doldamgil.spidycoder.com')
with open('wall-background.jpg', 'rb') as image:
    bucket.put_object(
        Key=wall_url+'/background.jpg',
        Body=image,
        ACL='public-read',
        ContentType='image/jpeg',
    )
bucket.put_object(
    Key=wall_url+'/info',
    Body=wall_info_json,
    ACL='public-read',
    ContentType='application/json',
)
