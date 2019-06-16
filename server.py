from flask import Flask, render_template, request, redirect, session, flash
from mysqlconn import connectToMySQL
from flask_bcrypt import Bcrypt   
app = Flask(__name__)
app.secret_key = 'keep it secret, keep it safe' 
bcrypt = Bcrypt(app)

import re	   
EMAIL_REGEX = re.compile(r'^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9._-]+\.[a-zA-Z]+$') 
PASS_REGEX = re.compile(r"^(?=.*[\d])(?=.*[A-Z])(?=.*[a-z])(?=.*[@#$])[\w\d@#$]{6,12}$")

@app.route("/main")
def show_main_forms():
    return render_template("main.html")

@app.route('/process', methods=['POST'])
def process():
    is_valid = True
    if len(request.form['name']) < 1:
        is_valid = False
        flash("Please enter your name")
    if len(request.form['alias']) < 1:
    	is_valid = False
    	flash("Please enter a nick name")
    if request.form['pwd'] != request.form['cpwd']:
        is_valid = False
        flash("Passwords do not match!")
    
    if not EMAIL_REGEX.match(request.form['email']):    
        is_valid = False
        flash("Invalid email address!")
    if not PASS_REGEX.match(request.form['pwd']):
        is_valid = False
        flash("Invalid password type! it should be of length range 6-12 and contain one uppercase, one lowercase, one digit and one special character")
    if is_valid: 
        hash_pass = bcrypt.generate_password_hash(request.form['pwd'])
        query = "INSERT INTO user_info(name, alias, email, password, created_at, updated_at) VALUES (%(fn)s, %(ln)s, %(eml)s, %(pass)s, NOW(), NOW());"
        data = {
            'fn': request.form['name'],
            'ln': request.form['alias'],
            'eml': request.form['email'],
            'pass': hash_pass
        }
        mysql = connectToMySQL('solo_project')
        new_user = mysql.query_db(query, data)
        flash("You are successfully added!")
    return redirect('/main') 

@app.route('/process_login', methods=['POST'])
def login():
    is_valid = True
    if len(request.form['email']) < 1:
        is_valid = False
        flash("Please enter your e-mail")
    if len(request.form['pass']) < 1:
    	is_valid = False
    	flash("Please enter your password")
    if not EMAIL_REGEX.match(request.form['email']): 
        is_valid = False
        flash("Invalid email address!")
    if not PASS_REGEX.match(request.form['pass']):
        is_valid = False
        flash("Invalid password type!")
    if is_valid:
        query = "SELECT * from user_info where email=%(eml)s;"
        data = {'eml': request.form['email'] }
        mysql = connectToMySQL('solo_project')
        result = mysql.query_db(query, data)
        if result:
            if bcrypt.check_password_hash(result[0]['password'], request.form['pass']):
                session['userid'] = result[0]['id']
                session['alias'] = result[0]['alias']
                return redirect('/ideas')
    flash("You could not be logged in")
    return redirect("/main")

@app.route('/ideas')
def success_login():
    # query = "SELECT * FROM posts;"
    # data2 = { 'id': session['userid']}
    # mysql1 = connectToMySQL('solo_project')
    # result1 = mysql1.query_db(query, data2)

    # query1 = "SELECT users.first_name, grants.granted_wish, grants.wish_date, grants.created_at, grants.likes, grants.id FROM users join app_wish.grants on users.id = grants.user_id;"
    # mysql = connectToMySQL('app_wish')
    # result2 = mysql.query_db(query1)
    
    return render_template('index.html')

if __name__ == "__main__":
    app.run(debug=True)