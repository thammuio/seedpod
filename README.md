# Seedpod

With Agile on the rise, Agile project management software has become more competitive than ever. The best software addresses three pain points common for Agile teams:

Agile reporting and metrics: Time tracking and projection, easy-to-understand progress reports for stakeholders, quality assurance, and percentage complete

Communication: Communicate updates with local and distributed teams, and share task lists, feedback, and assignments

Project assessment: Identify and remedy project obstacles, evaluate performance, and appraise financials

### Deploy to heroku

## General Notes
Create a new project :
rails new RadhaApp
First we will have faculty Registration/Atuhentication for faculty
We will use "Devise" gem to authenticate faculty. Install "Devise" from its professional site. "https://github.com/plataformatec/devise", Follow each steps from staring.
After we will have Faculty(user) model with default Fields. e.g. (Email, Password, Password_confirmation)
 Note : Check migration file for detailed information about all the fields that devise gives by deafault
If you want to go with CRUD ( Create, Read, Update, Delete ) with Model, View, Controller, simply generate a scaffold.
rails generate scaffold plan title:string description:text faculty_id:integer
Que : What is Scaffold?
Ans : A scaffold in Rails is a full set of model, database migration for that model, controller to
manipulate it, views to view and manipulate the data, and a test suite for each of the above.
 Note : Here faculty_id is foreign key of faculty table. The relationship is " One Faculty Can Create Many Plans " (one - many)
Define a relationship between Faculty(User) model and plan model
In /app/model/faculty.rb
has_many plans
In /app/model/plan.rb
belongs_to faculty
Create a team scaffold :
rails generate scaffold team name:string team_description:text
Syntax : rails generate scaffold <model-name> <field-name-1>:<data-type> <field-name-2>:<data-type>
Relationship : Plan can have many teams (Plan can be requested to many teams) (Many to Many)
To manage many to many relationship we need 3rd Model(table) named plan_teams, which will store plan_id and team_id.
rails generate model plan_teams
goto /db/migrate/*************_create_plan_teams.rb
def change
create_table :plan_teams do |t|
t.belongs_to :plan
t.belongs_to :team
t.timestamps
end
add_index :plan_teams, :plan_id
add_index :plan_teams, :team_id
end
In /app/model/plan.rb
has_many :plan_teams
has_many :teams, through: :plan_teams
In /app/model/plan_team.rb
belongs_to :team
belongs_to :plan
In /app/model/team.rb
has_many :plan_teams
has_many :plans, through: :plan_teams
Create a controller manually to contact with model, There can be numbers of controller, they can communicate with one model.
rails generate controller pending_plan_approve pending approve resend
Syntax : rails generate controller <controller-name> <action-name-1> <action-name-2>
Create a model :
rails generate model submitted_plan plan_id:integer student_id:integer
Syntax : rails generate <model-name> <field-name-1>:<data-type> <field-name-2>:<data-type>
Gem file
gem 'bcrypt-ruby', :require => "bcrypt"
 To make password secure (http://bcrypt-ruby.rubyforge.org/)
gem 'devise'
 For user atuhentication. (https://github.com/plataformatec/devise)
gem "rails_best_practices"
 Code optimization, and to follows rails standard format to code.( https://github.com/railsbp/rails_best_practices)
gem 'friendly_id', '~> 5.0.0'
 For Friendly urls (https://github.com/norman/friendly_id)
gem "yard"
 Documenting code. (http://yardoc.org/)
Routes :
Basically routes will be generated automatically when controller will created
(http://guides.rubyonrails.org/routing.html)
Default routing :
get "controller/action"
Custom Routes :
match "/custome-route-name-will-be-displayed-in-browser-url" => "controller#action", :as => :route_name, via: [:get]
match "/faculty/:id/plan/:name" => "plans#show", :as => :view_plan, via: [ :get ]
In rails 4 routes to POST data you should include [ :post, :patch ]
match "plans" => "plans#update", :as => :update_plan, via: [ :post, :patch ]
From console run this command to show all route
$ rake routes

## Resources to Learn

Below is the great link to start with:

https://www.railstutorial.org/book