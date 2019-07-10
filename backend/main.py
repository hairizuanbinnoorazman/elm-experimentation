from flask import Flask, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)


@app.route("/")
def hello():
    return "Hello World!"


@app.route("/json")
def returnjson():
    return jsonify(
        {"name": "john",
         "occupation": "worker",
         "age": 12
         })
