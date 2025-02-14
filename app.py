from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

# Database Configuration
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:postgres@localhost:5432/airline_management'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False  # To suppress warnings

db = SQLAlchemy(app)

# Define the User Model (if needed)
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(100), unique=True, nullable=False)

    def __repr__(self):
        return f'<User {self.name}>'

# Define the Staff Model
class Staff(db.Model):
    __tablename__ = 'staff'  # Match your PostgreSQL table name

    staff_id = db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    staff_name = db.Column(db.Text, nullable=False)
    phone = db.Column(db.String(10), nullable=False)
    email_id = db.Column(db.Text, unique=True, nullable=False)
    address = db.Column(db.Text)
    staff_type = db.Column(db.Text, nullable=False)
    age = db.Column(db.Integer)

    def to_dict(self):
        return {
            "staff_id": self.staff_id,
            "staff_name": self.staff_name,
            "phone": self.phone,
            "email_id": self.email_id,
            "address": self.address,
            "staff_type": self.staff_type,
            "age": self.age
        }

# Initialize Database
with app.app_context():
    db.create_all()

@app.route('/')
def home():
    return "Flask is connected to PostgreSQL!"

# ✅ Add the POST Route for Staff Here
@app.route('/staff', methods=['POST'])
def add_staff():
    try:
        data = request.json  # Get JSON data from request

        # Validate required fields
        required_fields = ["staff_name", "phone", "email_id", "staff_type", "age"]
        for field in required_fields:
            if field not in data:
                return jsonify({"error": f"'{field}' is required"}), 400

        # Create new staff object
        new_staff = Staff(
            staff_name=data['staff_name'],
            phone=data['phone'],
            email_id=data['email_id'],
            address=data.get('address', None),  # Optional field
            staff_type=data['staff_type'],
            age=data['age']
        )

        # Add to the database
        db.session.add(new_staff)
        db.session.commit()

        return jsonify({"message": "Staff added successfully!", "staff": new_staff.to_dict()}), 201
    
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
