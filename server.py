from flask import Flask, render_template, request, redirect, session, flash
from mysqlconn import connectToMySQL
from flask_bcrypt import Bcrypt   
app = Flask(__name__)
app.secret_key = 'keep it secret, keep it safe' 
bcrypt = Bcrypt(app)

import re	   
EMAIL_REGEX = re.compile(r'^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9._-]+\.[a-zA-Z]+$') 
PASS_REGEX = re.compile(r"^(?=.*[\d])(?=.*[A-Z])(?=.*[a-z])(?=.*[@#$])[\w\d@#$]{6,12}$")

@app.route("/")
def show_main():
    return render_template("main.html")
@app.route("/main")
def show_main_forms():
    return render_template("forms.html")

@app.route('/process', methods=['POST'])
def process():
    is_valid = True
    if len(request.form['name']) < 1 or len(request.form['alias']) < 1 or len(request.form['pwd']) < 1 or len(request.form['cpwd']) < 1 or len(request.form['email']) < 1:
        is_valid = False
        flash("Please make sure to enter all the fields!")
        return redirect('/main') 
    if request.form['pwd'] != request.form['cpwd']:
        is_valid = False
        flash("Passwords do not match!")
        return redirect('/main') 
    if not EMAIL_REGEX.match(request.form['email']):    
        is_valid = False
        flash("Invalid email address!")
        return redirect('/main') 
    if not PASS_REGEX.match(request.form['pwd']):
        is_valid = False
        flash("Invalid password type! it should be of length range 6-12 and contain one uppercase, one lowercase, one digit and one special character")
        return redirect('/main') 
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

@app.route('/process-login', methods=['POST'])
def login():
    is_valid = True
    if len(request.form['email']) < 1 or len(request.form['pwd']) < 1:
        is_valid = False
        flash("Please enter your e-mail and password")
        return redirect('/main')
    if not EMAIL_REGEX.match(request.form['email']): 
        is_valid = False
        flash("Invalid email address!")
        return redirect('/main')
    if not PASS_REGEX.match(request.form['pwd']):
        is_valid = False
        flash("Invalid password type!")
        return redirect('/main')
    if is_valid:
        query = "SELECT * from user_info where email=%(eml)s;"
        data = {'eml': request.form['email'] }
        mysql = connectToMySQL('solo_project')
        result = mysql.query_db(query, data)
        if result:
            if bcrypt.check_password_hash(result[0]['password'], request.form['pwd']):
                session['userid'] = result[0]['id']
                session['alias'] = result[0]['alias']
                return redirect('/ideas')
    flash("You could not be logged in")
    return redirect("/main")
@app.route('/process-idea', methods=['POST'])
def save_ideas():
    is_valid = True
    if len(request.form['post']) < 1:
        is_valid = False
        flash("Please enter your post")
        return redirect('/ideas')
    if is_valid:
        query = "INSERT INTO posts(user_id, post, created_at, updated_at) VALUES (%(uid)s, %(pos)s, NOW(), NOW());"
        data = {
            'uid': session['userid'],
            'pos': request.form['post']
        }
        mysql = connectToMySQL('solo_project')
        new_user = mysql.query_db(query, data)
        flash("Your post is successfully added!")
        return redirect('/ideas')
    return redirect("/ideas")

@app.route('/ideas')
def success_login():
    query = "SELECT posts.user_id, posts.id, user_info.alias, posts.post FROM posts join user_info on user_info.id = posts.user_id;"
    mysql1 = connectToMySQL('solo_project')
    result = mysql1.query_db(query)
    
    l_count = {}
    for k in result:
        print(k['id'])
        query1 = "SELECT count(*) as likes FROM likes_info where posts_id=%(id)s;"
        data = {'id': k['id'] }
        mysql1 = connectToMySQL('solo_project')
        result1 = mysql1.query_db(query1,data)
        # print("###################################3")
        # print(result1)
        l_count[k['id']] = result1[0]['likes']
    # print("***************************")
    # print(result1)
    # print(l_count)

    return render_template('index.html', ideas=result, likes=l_count)

@app.route('/likes/<post_id>/add_like',methods=['POST'])
def add_like(post_id):
    query = "INSERT INTO likes_info(posts_id, users_id, created_at, updated_at) VALUES (%(pid)s, %(uid)s, NOW(), NOW());"
    data = {
        'uid': session['userid'],
        'pid': post_id
    }
    mysql = connectToMySQL('solo_project')
    new_user_id = mysql.query_db(query, data)
    print(new_user_id)
    flash("You liked a post just now!")
    return redirect('/ideas')

@app.route('/posts/<post_id>/delete',methods=['POST'])
def delete_data(post_id):
    mysql = connectToMySQL('solo_project')	
    query = 'DELETE FROM posts WHERE id=%(id)s;'
    data = { "id": post_id }
    del_post = mysql.query_db(query, data)
    flash("You deleted a post just now!")
    return redirect("/ideas")

@app.route('/users/<user_id>')
def user_info(user_id):
    mysql = connectToMySQL('solo_project')	
    query = 'SELECT count(posts.user_id) as t_posts, user_info.name, user_info.alias, user_info.email  FROM user_info join posts on posts.user_id = user_info.id where user_id = %(id)s;'
    data = { "id": user_id }
    user_info = mysql.query_db(query, data)
    mysql = connectToMySQL('solo_project')
    query = 'SELECT count(likes_info.users_id) as t_likes from user_info join likes_info on likes_info.users_id = user_info.id where users_id=%(id)s;'
    data1 = { "id": user_id }
    user_likes = mysql.query_db(query, data1)
    print("*******************(((((((((((((((")
    print(user_info)
    print(user_likes)

    return render_template("user_info.html", info = user_info[0], t_likes=user_likes[0])

@app.route('/log_out')
def success_logout():
    session.clear()
    return redirect('/main')

if __name__ == "__main__":
    app.run(debug=True)