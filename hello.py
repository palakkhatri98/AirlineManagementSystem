# hello.py

from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "Hello, World!"

staff_data = (
    {"id": 1, "name": "John Doe", "department": "IT", "email": "john.doe@example.com"},
    {"id": 2, "name": "Jane Smith", "department": "HR", "email": "jane.smith@example.com"},
    {"id": 3, "name": "Alice Johnson", "department": "Finance", "email": "alice.johnson@example.com"}
)

# Get all staff
@app.route('/staff', methods=['GET'])
def get_staff():
    return jsonify(staff_data), 200