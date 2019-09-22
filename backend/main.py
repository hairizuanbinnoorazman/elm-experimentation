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


@app.route("/complexjson")
def complexjson():
    return jsonify({
        "name": "john",
        # "occupation": "12",
        "children": [
                {
                    "name": "john the second",
                    "school": "english"
                },
            {
                    "name": "jane",
                    "school": "english",
                    "language": "french"
                    }
        ],
        "animals": {
            "rabbits": [{"name": "seahorse"}],
            "dogs": [{"name": "louse"}]
        }
    })


if __name__ == '__main__':
    app.run(debug=True)
