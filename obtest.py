""" Open Banking Test. Please run this application, then write an external test (*not* a unit test!) which calls the
HTTP endpoint to ensure that the following are true:

1) The animals list includes Giraffe, Lion, and Mouse
2) The people list contains no names longer than ten characters
3) There exists a person whose name is the same as the name of an animal

Send us the code for your tests. This can be in *any* language you think appropriate, including Bash.

(c) Open Banking Limited 2018.

"""
import json
from flask import Flask
app = Flask(__name__)

@app.route('/animals')
def animals():
    data = {"names": ["Giraffe", "Donkey", "Wolf", "Lion", "Sparrow", "Mouse"]}
    response = app.response_class(
        response=json.dumps(data),
        status=200,
        mimetype='application/json'
    )
    return response

@app.route('/people')
def people():
    data = {"names": ["Bob", "Sandra", "Wolf", "Carol", "Karim", "Shahab"]}
    response = app.response_class(
        response=json.dumps(data),
        status=200,
        mimetype='application/json'
    )
    return response

if __name__ == "__main__":
    app.run()