from flask import Flask, request, make_response
import requests


app = Flask(__name__)

session = requests.session()


@app.route('/doldamgil-edge', methods=['PATCH'])
def choose_route():
    data = request.get_json()
    print(data)
    return make_response(data, 200)


@app.route('/heartbeat', methods=['PATCH'])
def heartbeat():
    try:
        response = session.patch('http://test.rest.doldamgil.spidycoder.com:8080/gyms/1/edges/1')
        print(response)
        return make_response('connection succeed', 200)
    except ConnectionError:
        return make_response('connection error', 200)


if __name__ == '__main__':
    app.run(port=9090, debug=True)

