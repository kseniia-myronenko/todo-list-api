# Todo List API
<div style="display: flex;">
<img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/kseniia-myronenko/todo-list-api">
<img alt="GitHub all releases" src="https://img.shields.io/github/downloads/kseniia-myronenko/todo-list-api/total">
</div>
<div style="display: flex;">
<img src="https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white" />
<img src="https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white" />
</div><br>
<p>This is API for simple productivity improvement tool. It lets users an ability to easy manage and control their own projects and tasks.</p>
<h2>Configuration</h2>

<ol>
<li><b>Ruby:</b> 3.1.0</li>
<li><b>Rails:</b> ~> 7.0.3</li>
<li><b>Database:</b> PostgreSQL</li>
</ol>

<h2>Run app</h2>
<ol>
<li>Setup gems, database & seeds:</li>
<pre>
bundle install<br>
rails db:create<br>
rails db:migrate<br>
rails db:seed
</pre>
<li>Import Postman collection <code>todo-list-api/postman_collection/todolist_postman_collection.json</code></li>
<li>Start server</li>
<pre>
rails s
</pre>
<li>Before testing endpoints create session in Postman: <code>Sessions/Post session</code></li>
<li>Check swagger documentation by visiting <code>http://localhost:3000/api-docs</code></li>
</ol>
<h2>Use case</h2>
<ol>
<li>Login or sign up to the system.</li>
<li>On the main page <code>localhost:3000/api/v1</code> create a project.</li>
<li>Create task in the project. It's possible to set deadline and mark task as 'done'.</li>
<li>On the project page <code>localhost:3000/api/v1/:project_id</code> it's possible to sort tasks by position asc/desk and created_at asc/desc.</li>
<li>User can create comments to the task.</li>
<li>User can add images to the comments in <code>jpg, jpeg, png</code> formats up to 10 MB.</li>
</ol>
