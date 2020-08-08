# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app - My application controller inherits from Sinatra::Base
- [x] Use ActiveRecord for storing information in a database - My models inherit from ActiveRecord::Base and use methods from Active Record
- [x] Include more than one model class (e.g. User, Post, Category) - User and recipe models included
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts) - User has many recipes
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User) - Recipes belong to user
- [x] Include user accounts with unique login attribute (username or email) - Users have a username
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying - Users can CRUD their recipes
- [x] Ensure that users can't modify content created by other users - Users cannot access other users recipes
- [x] Include user input validations - Recipes must have a name
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new) - error messages displayed if login/sign up info not properly filled out
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code - Yeah, read it!

Confirm
- [x] You have a large number of small Git commits - Yes lots of commits
- [x] Your commit messages are meaningful - Yes they are
- [x] You made the changes in a commit that relate to the commit message - Yes
- [x] You don't include changes in a commit that aren't related to the commit message - Yes, although this needs some work
