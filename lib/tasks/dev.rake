RAKEDEFAULT_PASSWORD = '@S123456'
namespace :dev do
  desc "Set up the development environment"
  task setup: :environment do
      show_spinner("Dropping DB...") { %x(rails db:drop) }
      show_spinner("Creating DB...") { %x(rails db:create) }
      show_spinner("Making Migrations...") { %x(rails db:migrate) }
      show_spinner("Registering Users...") { %x(rails dev:add_default_user) }
      show_spinner("Registering Subjects...") { %x(rails dev:add_subjects) }
      show_spinner("Registering Questions...") { %x(rails dev:add_answers_questions) }
  end

  desc "Add Default Users"
  task add_default_user: :environment do
    users = [
      { email: "user@gmail.com", password: RAKEDEFAULT_PASSWORD, password_confirmation: RAKEDEFAULT_PASSWORD },
      { email: "test@gmail.com", password: RAKEDEFAULT_PASSWORD, password_confirmation: RAKEDEFAULT_PASSWORD },
    ]

    users.each do |user|
      User.create!(user)
    end
  end

  desc "Add Subjects"
  task add_subjects: :environment do
    subjects = [
      "Basic Syntax of Ruby",
      "Control Structures in Ruby",
      "Object-Oriented Programming in Ruby",
      "Classes and Modules in Ruby",
      "String and Array Manipulation in Ruby",
      "Gems and Bundler",
      "Rails Environment Setup",
      "Structure of a Rails Application",
      "Rails Conventions",
      "MVC (Model-View-Controller)",
      "Generators and Scaffolding",
      "Active Record",
      "Database Migrations",
      "Validations and Callbacks",
      "Model Associations",
      "Database Queries with Active Record",
      "Views and Layouts",
      "ERB (Embedded Ruby)",
      "View Helpers",
      "Forms and Form Helpers",
      "Routing in Rails",
      "Controllers in Rails",
      "Authentication and Authorization",
      "Debugging and Logging",
      "Testing in Rails",
      "RSpec and FactoryBot",
      "API Integration",
      "Action Mailer",
      "Active Job and Background Jobs",
      "WebSockets and ActionCable",
      "Deploying Rails Applications",
      "Security in Rails",
      "Performance Optimization",
      "Internationalization (i18n) in Rails"
    ]

    subjects.each do |subject|
      Subject.create!(description: subject)
    end
  end

  desc "Add Questions and Answers"
  task add_answers_questions: :environment do
    subjects = Subject.all

    questions_data = {
      "Basic Syntax of Ruby" => [
        {
          description: "How do you declare a variable in Ruby?",
          answers: [
            { description: "Using the '=' symbol", correct: true, explanation: "The '=' symbol is used for assignment." },
            { description: "Using 'let'", correct: false, explanation: "'let' is not a keyword in Ruby." },
            { description: "Using 'var'", correct: false, explanation: "'var' is not a keyword in Ruby." },
            { description: "Using 'const'", correct: false, explanation: "'const' is not a keyword in Ruby." },
            { description: "It's unnecessary to declare variables", correct: false, explanation: "Variables must be declared." }
          ]
        },
        {
          description: "What is the difference between 'nil' and 'false'?",
          answers: [
            { description: "'false' is a boolean value", correct: true, explanation: "'false' is one of the two boolean values." },
            { description: "'nil' is a boolean value", correct: false, explanation: "'nil' is not boolean." },
            { description: "'nil' represents the absence of value", correct: true, explanation: "'nil' indicates that there is no value." },
            { description: "'false' represents the absence of value", correct: false, explanation: "'false' is a specific value." },
            { description: "'nil' is an error", correct: false, explanation: "'nil' is not an error." }
          ]
        },
        {
          description: "What is the correct structure of a method in Ruby?",
          answers: [
            { description: "method method_name", correct: false, explanation: "This is not the correct syntax." },
            { description: "function method_name; end", correct: false, explanation: "Ruby does not use 'function'." },
            { description: "def: method_name; end", correct: false, explanation: "The use of ':' is incorrect." },
            { description: "method_name = def; end", correct: false, explanation: "This is not a method definition." },
            { description: "def method_name; end", correct: true, explanation: "The correct syntax for defining a method." }
          ]
        },
        {
          description: "How do you write a comment in Ruby?",
          answers: [
            { description: "// This is a comment", correct: false, explanation: "// is not used in Ruby." },
            { description: "/* This is a comment */", correct: false, explanation: "Ruby does not use block comments like this." },
            { description: "# This is a multi-line comment", correct: false, explanation: "This is incorrect; Ruby does not support multi-line comments with '#'" },
            { description: "# This is a comment", correct: true, explanation: "Comments in Ruby start with '#'" },
            { description: "# TODO: This is a comment", correct: true, explanation: "Ruby supports TODO comments using '#'" }
          ]
        },
        {
          description: "What is the use of 'puts' in Ruby?",
          answers: [
            { description: "To print output to the console", correct: true, explanation: "'puts' is used to output text." },
            { description: "To create a method", correct: false, explanation: "'puts' is not related to method creation." },
            { description: "To return a value", correct: false, explanation: "'puts' returns 'nil' after outputting." },
            { description: "To raise an error", correct: false, explanation: "'puts' is not for raising errors." },
            { description: "To write to a file", correct: false, explanation: "'puts' does not write to files." }
          ]
        }
      ],
      "Control Structures in Ruby" => [
        {
          description: "Which control structure is used to iterate over a range of values in Ruby?",
          answers: [
            { description: "if statement", correct: false, explanation: "'if' is a conditional statement, not a looping structure." },
            { description: "for loop", correct: true, explanation: "The 'for' loop is used to iterate over a range or collection of elements in Ruby." },
            { description: "while loop", correct: false, explanation: "'while' loops through a block as long as a condition is true, but does not iterate over a range directly." },
            { description: "case statement", correct: false, explanation: "'case' is used for multi-way branching, not iteration." },
            { description: "do-while loop", correct: false, explanation: "'do-while' is not commonly used in Ruby; a 'while' loop is used instead." }
          ]
        },
        {
          description: "What is the purpose of the 'break' statement in Ruby?",
          answers: [
            { description: "To continue to the next iteration", correct: false, explanation: "The 'next' statement is used to skip to the next iteration." },
            { description: "To restart the loop", correct: false, explanation: "There is no 'restart' command in Ruby. You must control looping manually." },
            { description: "To stop a loop early", correct: true, explanation: "The 'break' statement immediately exits the loop, regardless of its condition." },
            { description: "To pause execution", correct: false, explanation: "'break' does not pause; it exits the loop entirely." },
            { description: "To check for a condition", correct: false, explanation: "Conditions are checked with 'if' or 'unless', not with 'break'." }
          ]
        },
        {
          description: "Which keyword is used to skip the remaining code in a loop iteration in Ruby?",
          answers: [
            { description: "next", correct: true, explanation: "The 'next' keyword is used to skip to the next iteration of a loop." },
            { description: "break", correct: false, explanation: "'break' exits the loop, while 'next' skips to the next iteration." },
            { description: "redo", correct: false, explanation: "'redo' restarts the current iteration without checking the condition." },
            { description: "continue", correct: false, explanation: "'continue' is not a valid keyword in Ruby, 'next' serves this purpose." },
            { description: "return", correct: false, explanation: "'return' exits the method or block, not just the loop iteration." }
          ]
        },
        {
          description: "What does the 'unless' keyword do in Ruby?",
          answers: [
            { description: "Executes code if a condition is false", correct: true, explanation: "'unless' executes the code block only if the condition is false." },
            { description: "Executes code if a condition is true", correct: false, explanation: "'if', not 'unless', is used to execute code when a condition is true." },
            { description: "Repeats code while a condition is false", correct: false, explanation: "'while' is used for loops, not 'unless'." },
            { description: "Skips the current iteration of a loop", correct: false, explanation: "'next' is used to skip iterations, not 'unless'." },
            { description: "Exits a loop early", correct: false, explanation: "'break' is used to exit a loop, not 'unless'." }
          ]
        },
        {
          description: "Which control structure in Ruby is best for handling multiple conditions?",
          answers: [
            { description: "if statement", correct: false, explanation: "'if' can handle conditions but becomes unwieldy with many options." },
            { description: "while loop", correct: false, explanation: "'while' is used for looping, not condition branching." },
            { description: "for loop", correct: false, explanation: "'for' is primarily used for iterating, not for condition handling." },
            { description: "case statement", correct: true, explanation: "The 'case' statement is ideal for handling multiple conditions in Ruby." },
            { description: "until loop", correct: false, explanation: "'until' is used for looping, not for handling multiple conditions." }
          ]
        }
      ],

      "Object-Oriented Programming in Ruby" => [
        {
          description: "What is the purpose of 'initialize' method in Ruby classes?",
          answers: [
            { description: "To set up the initial state of an object", correct: true, explanation: "'initialize' is used as the constructor to set the initial state of an object." },
            { description: "To define class-level methods", correct: false, explanation: "Class-level methods are defined with 'self.method_name', not with 'initialize'." },
            { description: "To clean up resources after an object is destroyed", correct: false, explanation: "Ruby uses garbage collection, and 'initialize' is not responsible for cleanup." },
            { description: "To manage memory allocation", correct: false, explanation: "Memory management is handled automatically in Ruby, not by 'initialize'." },
            { description: "To define the class itself", correct: false, explanation: "The 'initialize' method only defines how objects are created, not the class." }
          ]
        },
        {
          description: "Which keyword is used to define a class in Ruby?",
          answers: [
            { description: "def", correct: false, explanation: "'def' is used to define methods, not classes." },
            { description: "class", correct: true, explanation: "The 'class' keyword is used to define a new class in Ruby." },
            { description: "module", correct: false, explanation: "'module' is used to define modules, which are similar to classes but cannot be instantiated." },
            { description: "new", correct: false, explanation: "'new' is a method used to create an instance of a class, not to define a class." },
            { description: "initialize", correct: false, explanation: "'initialize' is a method within the class, not the keyword to define a class." }
          ]
        },
        {
          description: "What is the purpose of 'self' in Ruby?",
          answers: [
            { description: "To define class-level methods", correct: false, explanation: "'self' can be used to define class-level methods, but its main purpose is to refer to the current object." },
            { description: "To refer to the parent class", correct: false, explanation: "'super' is used to refer to the parent class, not 'self'." },
            { description: "To refer to the current object", correct: true, explanation: "'self' refers to the current object within a class or module." },
            { description: "To declare private methods", correct: false, explanation: "'private' is used to declare private methods, not 'self'." },
            { description: "To invoke class methods", correct: false, explanation: "'self' can refer to the class within class methods, but it does not specifically invoke them." }
          ]
        },
        {
          description: "What does the term 'inheritance' refer to in Ruby?",
          answers: [
            { description: "A class inheriting behavior from another class", correct: true, explanation: "Inheritance allows a class to inherit behavior from a superclass." },
            { description: "Sharing methods between modules", correct: false, explanation: "Modules use 'include' and 'extend' for method sharing, not inheritance." },
            { description: "A method inheriting arguments", correct: false, explanation: "Methods do not inherit arguments, but classes can inherit methods." },
            { description: "An object inheriting another object’s state", correct: false, explanation: "Inheritance refers to class-level behavior, not specific object states." },
            { description: "Overriding methods in a class", correct: false, explanation: "Overriding refers to redefining a method in a subclass, but it is part of inheritance." }
          ]
        },
        {
          description: "What does 'super' do in Ruby?",
          answers: [
            { description: "Creates a new instance of a class", correct: false, explanation: "'super' refers to superclass methods, not instance creation." },
            { description: "Initializes an object", correct: false, explanation: "'initialize' is used to set up objects, not 'super'." },
            { description: "Calls a method with the same name in the superclass", correct: true, explanation: "'super' invokes the parent class method with the same name." },
            { description: "Defines a class-level method", correct: false, explanation: "'super' calls a parent method, not defines methods." },
            { description: "Refers to the current object", correct: false, explanation: "'self' refers to the current object, not 'super'." }
          ]
        }
      ],

      "Classes and Modules in Ruby" => [
        {
          description: "What is the main difference between a class and a module in Ruby?",
          answers: [
            { description: "A class can be instantiated, but a module cannot", correct: true, explanation: "Classes can create objects (instances), while modules cannot." },
            { description: "A module can have instance variables, but a class cannot", correct: false, explanation: "Both classes and modules can have instance variables." },
            { description: "A module can inherit from other modules, but a class cannot", correct: false, explanation: "Classes support inheritance, while modules do not." },
            { description: "Classes are used for grouping methods, modules are not", correct: false, explanation: "Both can be used to group methods, but modules are usually for mixins." },
            { description: "Modules allow for multiple inheritance, while classes don't", correct: false, explanation: "Ruby doesn't support multiple inheritance, but modules can be mixed into classes." }
          ]
        },
        {
          description: "How do you include methods from a module into a Ruby class?",
          answers: [
            { description: "Using the 'extend' keyword", correct: false, explanation: "'extend' is used to add methods as class methods, not instance methods." },
            { description: "By inheriting from the module", correct: false, explanation: "Modules cannot be inherited from, but classes can be." },
            { description: "By creating an instance of the module", correct: false, explanation: "Modules cannot be instantiated; only classes can be." },
            { description: "By assigning the module to a variable", correct: false, explanation: "Modules are not assigned like variables, they are mixed in or extended." },
            { description: "Using the 'include' keyword", correct: true, explanation: "The 'include' keyword is used to mix module methods as instance methods in a class." }
          ]
        },
        {
          description: "Which keyword is used to define a class in Ruby?",
          answers: [
            { description: "module", correct: false, explanation: "'module' is used to define a module, not a class." },
            { description: "def", correct: false, explanation: "'def' is used to define methods within a class, not the class itself." },
            { description: "new", correct: false, explanation: "'new' is used to instantiate an object of a class, not to define the class." },
            { description: "initialize", correct: false, explanation: "'initialize' is a method for setting up the state of an object, but it is defined inside a class." },
            { description: "class", correct: true, explanation: "The 'class' keyword is used to define a new class in Ruby." }
          ]
        },
        {
          description: "What does 'self' refer to inside a Ruby class?",
          answers: [
            { description: "The parent class", correct: false, explanation: "'super' refers to the parent class, not 'self'." },
            { description: "The class itself", correct: false, explanation: "Within a class method, 'self' refers to the class, but in instance methods it refers to the object." },
            { description: "A class variable", correct: false, explanation: "'@@' is used for class variables, not 'self'." },
            { description: "The current instance of the class", correct: true, explanation: "'self' refers to the current instance of the class when used inside instance methods." },
            { description: "A module", correct: false, explanation: "'self' does not refer to a module, but to the class or object." }
          ]
        },
        {
          description: "How do you create a subclass in Ruby?",
          answers: [
            { description: "Using the 'super' keyword", correct: false, explanation: "'super' is used to call methods from the parent class, not to define a subclass." },
            { description: "Using 'inherits'", correct: false, explanation: "Ruby uses the '<' symbol for inheritance, not the word 'inherits'." },
            { description: "Using 'extends'", correct: false, explanation: "'extend' is used to mix in module methods as class methods, not for inheritance." },
            { description: "Using the '<' symbol", correct: true, explanation: "In Ruby, a subclass is created using '<', which means it inherits from the superclass." },
            { description: "Using 'include'", correct: false, explanation: "'include' is used for mixing in module methods, not for creating a subclass." }
          ]
        }
      ],

      "String and Array Manipulation in Ruby" => [
        {
          description: "Which method is used to concatenate two strings in Ruby?",
          answers: [
            { description: "'+'", correct: true, explanation: "The '+' operator concatenates two strings in Ruby." },
            { description: "'concat'", correct: false, explanation: "'concat' can be used but it modifies the original string." },
            { description: "'append'", correct: false, explanation: "'append' is not a Ruby method; '<<' can append strings." },
            { description: "'merge'", correct: false, explanation: "'merge' is used for hashes, not strings." },
            { description: "'join'", correct: false, explanation: "'join' is used to combine elements of an array, not strings." }
          ]
        },
        {
          description: "How can you convert a string to an array of characters in Ruby?",
          answers: [
            { description: "'chars'", correct: true, explanation: "'chars' splits a string into an array of characters." },
            { description: "'split'", correct: false, explanation: "'split' divides a string based on a delimiter, not by individual characters." },
            { description: "'to_a'", correct: false, explanation: "'to_a' is not available for strings, but for other data types like ranges." },
            { description: "'flatten'", correct: false, explanation: "'flatten' is used to remove nested arrays, not to split strings." },
            { description: "'compact'", correct: false, explanation: "'compact' removes nil values from arrays, not for strings." }
          ]
        },
        {
          description: "Which method is used to add an element to the end of an array?",
          answers: [
            { description: "'prepend'", correct: false, explanation: "'prepend' adds elements to the beginning, not the end." },
            { description: "'insert'", correct: false, explanation: "'insert' adds elements at a specific position, not necessarily the end." },
            { description: "'push'", correct: true, explanation: "'push' adds an element to the end of an array." },
            { description: "'append'", correct: false, explanation: "'append' is not a valid Ruby array method; 'push' or '<<' is used." },
            { description: "'concat'", correct: false, explanation: "'concat' combines arrays but is not used to add individual elements." }
          ]
        },
        {
          description: "What does the 'map' method do in Ruby?",
          answers: [
            { description: "It selects specific elements from an array", correct: false, explanation: "'select' is used for selecting specific elements based on a condition." },
            { description: "It removes nil elements from an array", correct: false, explanation: "'compact' removes nil elements, not 'map'." },
            { description: "It sorts the array", correct: false, explanation: "'sort' is used for sorting arrays, not 'map'." },
            { description: "It concatenates arrays", correct: false, explanation: "'concat' or '+' are used for concatenating arrays." },
            { description: "It applies a block of code to each element and returns a new array", correct: true, explanation: "'map' iterates over an array and returns a new array with the results." }
          ]
        },
        {
          description: "How do you remove the last element of an array in Ruby?",
          answers: [
            { description: "'shift'", correct: false, explanation: "'shift' removes the first element, not the last." },
            { description: "'pop'", correct: true, explanation: "'pop' removes and returns the last element of an array." },
            { description: "'delete_at'", correct: false, explanation: "'delete_at' removes an element at a specific index, not necessarily the last." },
            { description: "'remove'", correct: false, explanation: "'remove' is not a valid Ruby method for arrays." },
            { description: "'slice'", correct: false, explanation: "'slice' returns a section of the array but does not modify the original array." }
          ]
        }
      ],

      "Gems and Bundler" => [
        {
          description: "What is a Ruby Gem?",
          answers: [
            { description: "A core component of the Ruby language", correct: false, explanation: "Gems are not part of Ruby's core but are third-party packages." },
            { description: "A way to store data in a Ruby application", correct: false, explanation: "Gems are not used for data storage but for distributing Ruby code." },
            { description: "A Ruby library or package that can be installed and used in Ruby applications", correct: true, explanation: "Gems are self-contained packages of Ruby code that can be shared and reused in applications." },
            { description: "A configuration tool for Ruby applications", correct: false, explanation: "Gems are not specifically configuration tools; they provide libraries or utilities." },
            { description: "A virtual machine for running Ruby applications", correct: false, explanation: "A Ruby gem is a package, not a virtual machine." }
          ]
        },
        {
          description: "How do you install a gem in your Ruby application?",
          answers: [
            { description: "Using the 'gem install' command", correct: true, explanation: "'gem install' is the command to install gems in Ruby." },
            { description: "By adding the gem to the Ruby source code", correct: false, explanation: "Gems are not added directly to the Ruby source code but managed through a Gemfile or 'gem install'." },
            { description: "By downloading the gem manually", correct: false, explanation: "Although you can download gems, they are typically installed using 'gem install' or Bundler." },
            { description: "By using the 'require' keyword in Ruby", correct: false, explanation: "'require' is used to load the gem into the code after it has been installed." },
            { description: "By compiling the gem with Ruby's compiler", correct: false, explanation: "Ruby gems are typically installed as pre-built packages and don't require compilation by the user." }
          ]
        },
        {
          description: "What is Bundler in Ruby?",
          answers: [
            { description: "A tool for managing Ruby's garbage collection", correct: false, explanation: "Bundler is for managing dependencies, not garbage collection." },
            { description: "A built-in tool for managing Ruby classes", correct: false, explanation: "Bundler is for managing gem dependencies, not Ruby classes." },
            { description: "A dependency manager for Ruby gems", correct: true, explanation: "Bundler manages gem dependencies in Ruby projects, ensuring that all gems are properly installed and versioned." },
            { description: "A web framework for building Ruby applications", correct: false, explanation: "Bundler is not a web framework; it is specifically for managing gems." },
            { description: "A virtual environment manager for Ruby", correct: false, explanation: "Bundler manages gem dependencies, not virtual environments." }
          ]
        },
        {
          description: "How do you specify a gem and its version in a Gemfile?",
          answers: [
            { description: "require 'gem_name', 'version_number'", correct: false, explanation: "'require' is used to load gems after installation, not to specify them in a Gemfile." },
            { description: "install 'gem_name', 'version_number'", correct: false, explanation: "The 'install' command is not used to define gems in a Gemfile." },
            { description: "load 'gem_name', 'version_number'", correct: false, explanation: "'load' is not used for defining gems or versions in a Gemfile." },
            { description: "gem 'gem_name', 'version_number'", correct: true, explanation: "In a Gemfile, you specify a gem and its version with 'gem' followed by the name and version in quotes." },
            { description: "gemset 'gem_name', 'version_number'", correct: false, explanation: "There is no 'gemset' keyword in the Gemfile for specifying gems." }
          ]
        },
        {
          description: "How do you install all the gems listed in a Gemfile?",
          answers: [
            { description: "By running 'gem install Gemfile'", correct: false, explanation: "You cannot use 'gem install' with a Gemfile; 'bundle install' must be used." },
            { description: "By running 'bundle update'", correct: false, explanation: "'bundle update' updates gems, but 'bundle install' is for initial installation." },
            { description: "By running 'bundle install'", correct: true, explanation: "'bundle install' installs all gems listed in the Gemfile along with their dependencies." },
            { description: "By running 'gemfile install'", correct: false, explanation: "There is no 'gemfile install' command in Ruby." },
            { description: "By running 'require Gemfile'", correct: false, explanation: "'require' is for loading gems, not for installing them from the Gemfile." }
          ]
        }
      ],

      "Rails Environment Setup" => [
        {
          description: "Which file is used to manage gem dependencies in a Rails project?",
          answers: [
            { description: "database.yml", correct: false, explanation: "database.yml configures the database connection, not gem dependencies." },
            { description: "Gemfile", correct: true, explanation: "The Gemfile is used to list and manage gem dependencies in Rails projects." },
            { description: "config.rb", correct: false, explanation: "config.rb is not used for managing dependencies in Rails." },
            { description: "routes.rb", correct: false, explanation: "routes.rb defines the application's routes, not gem dependencies." },
            { description: "application.rb", correct: false, explanation: "application.rb configures the Rails application, but gem dependencies are handled in the Gemfile." }
          ]
        },
        {
          description: "What command is used to create a new Rails project?",
          answers: [
            { description: "rails new project_name", correct: true, explanation: "'rails new project_name' generates a new Rails application with the necessary files and folder structure." },
            { description: "rails generate project project_name", correct: false, explanation: "The 'rails generate' command is for generating individual components within a Rails project, not for creating a new project." },
            { description: "bundle new project_name", correct: false, explanation: "'bundle new' is not a valid command for creating Rails projects." },
            { description: "gem new project_name", correct: false, explanation: "'gem new' is not used for Rails projects; it's for creating new Ruby gems." },
            { description: "rake new project_name", correct: false, explanation: "'rake new' is not used to create Rails projects." }
          ]
        },
        {
          description: "How do you start a Rails server in a development environment?",
          answers: [
            { description: "rails start", correct: false, explanation: "'rails start' is not a valid command for running the server." },
            { description: "rails server", correct: true, explanation: "The 'rails server' command starts a Rails server in the development environment by default." },
            { description: "rake server", correct: false, explanation: "'rake server' is not used for running Rails servers." },
            { description: "ruby server.rb", correct: false, explanation: "Rails has a built-in command to run the server; 'ruby server.rb' is not used." },
            { description: "bundle exec server", correct: false, explanation: "The correct command to run the server is 'rails server', not 'bundle exec server'." }
          ]
        },
        {
          description: "Which file contains the environment-specific configuration for a Rails application?",
          answers: [
            { description: "Gemfile", correct: false, explanation: "The Gemfile lists gem dependencies, not environment configurations." },
            { description: "routes.rb", correct: false, explanation: "routes.rb defines application routes, not environment-specific settings." },
            { description: "application.rb", correct: false, explanation: "'application.rb' contains general application configuration, not specific environment settings." },
            { description: "database.yml", correct: false, explanation: "database.yml configures database connections, not the environment settings." },
            { description: "config/environments/development.rb", correct: true, explanation: "Each environment (development, test, production) has its own configuration file under the 'config/environments' directory." }
          ]
        },
        {
          description: "How can you switch the Rails environment when starting the server?",
          answers: [
            { description: "rails server -e production", correct: true, explanation: "The '-e' option allows you to specify the environment when starting the Rails server." },
            { description: "rails environment production", correct: false, explanation: "This is not the correct syntax to switch environments." },
            { description: "rails start production", correct: false, explanation: "'rails start' is not a valid command in Rails." },
            { description: "bundle exec environment production", correct: false, explanation: "This is not the correct command to change the Rails environment." },
            { description: "rake environment production", correct: false, explanation: "'rake environment production' is not used for switching environments." }
          ]
        }
      ],

      "Structure of a Rails Application" => [
        {
          description: "What does the 'config' directory in a Rails project contain?",
          answers: [
            { description: "All database migrations", correct: false, explanation: "Database migrations are stored in the 'db/migrate' directory, not 'config'." },  # A
            { description: "Configuration files for the application, including database settings and environment-specific configurations", correct: true, explanation: "The 'config' directory holds various configuration files, such as 'database.yml' and environment-specific configurations." },  # B
            { description: "The application's views", correct: false, explanation: "The views are stored in the 'app/views' directory." },  # C
            { description: "Log files for the application", correct: false, explanation: "Log files are stored in the 'log' directory, not 'config'." },  # D
            { description: "Compiled assets", correct: false, explanation: "Compiled assets are typically stored in the 'public/assets' directory." }  # E
          ].shuffle!
        },
        {
          description: "Which folder contains static files such as images, CSS, and JavaScript in a Rails project?",
          answers: [
            { description: "app/assets", correct: true, explanation: "The 'app/assets' directory contains static files like images, stylesheets, and JavaScript files." },  # A
            { description: "public/system", correct: false, explanation: "'public/system' is used for file uploads but not for static assets." },  # B
            { description: "app/views", correct: false, explanation: "'app/views' contains the views, not static assets." },  # C
            { description: "config/assets", correct: false, explanation: "The 'config' folder is for configuration files, not static assets." },  # D
            { description: "lib/assets", correct: false, explanation: "'lib/assets' is used for libraries, but static files are primarily in 'app/assets'." }  # E
          ].shuffle!
        },
        {
          description: "What is the naming convention for Rails models?",
          answers: [
            { description: "They are singular and capitalized (e.g., 'User', 'Post')", correct: true, explanation: "Rails follows the convention of naming models in the singular form and capitalized." },  # A
            { description: "They are prefixed with 'Model_' (e.g., 'Model_User', 'Model_Post')", correct: false, explanation: "Models are named without the 'Model_' prefix." },  # B
            { description: "They are plural and lowercase (e.g., 'users', 'posts')", correct: false, explanation: "The plural form is used for table names, not model names." },  # C
            { description: "They are written in camel case (e.g., 'userPost')", correct: false, explanation: "Camel case is not used for model names in Rails." },  # D
            { description: "They are suffixed with '_model' (e.g., 'User_model', 'Post_model')", correct: false, explanation: "Models do not use the '_model' suffix." }  # E
          ].shuffle!
        },
        {
          description: "Where are Rails controllers typically stored in a Rails project?",
          answers: [
            { description: "app/controllers", correct: true, explanation: "Rails controllers are stored in the 'app/controllers' directory, which handles the business logic and interaction with models and views." },  # A
            { description: "app/models", correct: false, explanation: "'app/models' is used for the application's models, not controllers." },  # B
            { description: "lib/controllers", correct: false, explanation: "The 'lib' directory is for libraries, not for controllers." },  # C
            { description: "app/views", correct: false, explanation: "The 'app/views' directory stores templates, not controllers." },  # D
            { description: "config/controllers", correct: false, explanation: "Controllers are not stored in the 'config' folder." }  # E
          ].shuffle!
        },
        {
          description: "Which command generates the default Rails application structure?",
          answers: [
            { description: "rails new", correct: true, explanation: "The 'rails new' command creates a new Rails project with the default folder structure." },  # A
            { description: "rails generate", correct: false, explanation: "'rails generate' is used for generating components within a Rails project, but not the entire project structure." },  # B
            { description: "bundle exec rails new", correct: false, explanation: "You can use 'bundle exec rails new', but the 'rails new' command alone is sufficient." },  # C
            { description: "rails start", correct: false, explanation: "'rails start' is not a valid command for creating a new project." },  # D
            { description: "rails init", correct: false, explanation: "There is no 'rails init' command in Rails for creating projects." }  # E
          ].shuffle!
        }
      ],

      "Rails Conventions" => [
        {
          description: "Which folder contains static files such as images, CSS, and JavaScript in a Rails project?",
          answers: [
            { description: "app/assets", correct: true, explanation: "The 'app/assets' directory contains static files like images, stylesheets, and JavaScript files." },  # A
            { description: "public/system", correct: false, explanation: "'public/system' is used for file uploads but not for static assets." },  # B
            { description: "app/views", correct: false, explanation: "'app/views' contains the views, not static assets." },  # C
            { description: "config/assets", correct: false, explanation: "The 'config' folder is for configuration files, not static assets." },  # D
            { description: "lib/assets", correct: false, explanation: "'lib/assets' is used for libraries, but static files are primarily in 'app/assets'." }  # E
          ].shuffle!
        },
        {
          description: "What is the naming convention for Rails models?",
          answers: [
            { description: "They are singular and capitalized (e.g., 'User', 'Post')", correct: true, explanation: "Rails follows the convention of naming models in the singular form and capitalized." },  # A
            { description: "They are prefixed with 'Model_' (e.g., 'Model_User', 'Model_Post')", correct: false, explanation: "Models are named without the 'Model_' prefix." },  # B
            { description: "They are plural and lowercase (e.g., 'users', 'posts')", correct: false, explanation: "The plural form is used for table names, not model names." },  # C
            { description: "They are written in camel case (e.g., 'userPost')", correct: false, explanation: "Camel case is not used for model names in Rails." },  # D
            { description: "They are suffixed with '_model' (e.g., 'User_model', 'Post_model')", correct: false, explanation: "Models do not use the '_model' suffix." }  # E
          ].shuffle!
        },
        {
          description: "What is the purpose of the 'Gemfile' in a Rails project?",
          answers: [
            { description: "To specify the gems and dependencies required by the application", correct: true, explanation: "The 'Gemfile' lists the gems that the Rails application depends on." },  # A
            { description: "To manage database schemas", correct: false, explanation: "Database schemas are managed through migrations and schema files, not the 'Gemfile'." },  # B
            { description: "To list all the application’s routes", correct: false, explanation: "The routes are listed in 'config/routes.rb', not in the 'Gemfile'." },  # C
            { description: "To define environment-specific settings", correct: false, explanation: "Environment-specific settings are defined in files under 'config/environments', not in the 'Gemfile'." },  # D
            { description: "To configure the testing framework", correct: false, explanation: "While testing gems may be specified in the 'Gemfile', the file itself does not configure the testing framework." }  # E
          ].shuffle!
        },
        {
          description: "Where are Rails controllers typically stored in a Rails project?",
          answers: [
            { description: "app/controllers", correct: true, explanation: "Rails controllers are stored in the 'app/controllers' directory, which handles the business logic and interaction with models and views." },  # A
            { description: "app/models", correct: false, explanation: "'app/models' is used for the application's models, not controllers." },  # B
            { description: "lib/controllers", correct: false, explanation: "The 'lib' directory is for libraries, not for controllers." },  # C
            { description: "app/views", correct: false, explanation: "The 'app/views' directory stores templates, not controllers." },  # D
            { description: "config/controllers", correct: false, explanation: "Controllers are not stored in the 'config' folder." }  # E
          ].shuffle!
        },
        {
          description: "Which command generates the default Rails application structure?",
          answers: [
            { description: "rails new", correct: true, explanation: "The 'rails new' command creates a new Rails project with the default folder structure." },  # A
            { description: "rails generate", correct: false, explanation: "'rails generate' is used for generating components within a Rails project, but not the entire project structure." },  # B
            { description: "bundle exec rails new", correct: false, explanation: "You can use 'bundle exec rails new', but the 'rails new' command alone is sufficient." },  # C
            { description: "rails start", correct: false, explanation: "'rails start' is not a valid command for creating a new project." },  # D
            { description: "rails init", correct: false, explanation: "There is no 'rails init' command in Rails for creating projects." }  # E
          ].shuffle!
        }
      ],

      "MVC (Model-View-Controller)" => [
        {
          description: "What is the main purpose of the Model in MVC architecture?",
          answers: [
            { description: "To manage the user interface and display data", correct: false, explanation: "The View manages the user interface, while the Model handles the data." },
            { description: "To handle the business logic and data manipulation", correct: true, explanation: "The Model is responsible for business logic and data management." },
            { description: "To process HTTP requests", correct: false, explanation: "Controllers handle HTTP requests, not Models." },
            { description: "To manage routing and navigation", correct: false, explanation: "Routing is managed by the router, not the Model." },
            { description: "To provide data validation and authentication", correct: false, explanation: "While data validation can occur in the Model, authentication is generally handled in Controllers or dedicated services." }
          ].shuffle!
        },
        {
          description: "Which component of MVC is responsible for rendering the user interface?",
          answers: [
            { description: "Model", correct: false, explanation: "The Model does not render the UI; that's the role of the View." },
            { description: "View", correct: true, explanation: "The View is responsible for rendering the user interface based on data from the Model." },
            { description: "Controller", correct: false, explanation: "The Controller manages the flow of data but does not render the UI." },
            { description: "Router", correct: false, explanation: "The Router directs requests but does not handle rendering." },
            { description: "Service", correct: false, explanation: "Services encapsulate business logic but do not render UI." }
          ].shuffle!
        },
        {
          description: "In MVC, what does the Controller do?",
          answers: [
            { description: "It interacts with the Model to process data", correct: true, explanation: "The Controller acts as an intermediary between the Model and the View, processing data and handling user input." },
            { description: "It renders the HTML templates for the user interface", correct: false, explanation: "The View is responsible for rendering HTML templates, not the Controller." },
            { description: "It defines the database schema", correct: false, explanation: "The Model defines the database schema, while the Controller handles user input and interactions." },
            { description: "It routes requests to appropriate actions", correct: false, explanation: "Routing is managed by the router, although Controllers handle the actions after routing." },
            { description: "It manages user sessions", correct: false, explanation: "User session management can occur in Controllers or other middleware, but it is not the primary role of the Controller." }
          ].shuffle!
        },
        {
          description: "What role does the View play in MVC?",
          answers: [
            { description: "It contains the logic for processing user input", correct: false, explanation: "Processing user input is the role of the Controller." },
            { description: "It displays data to the user", correct: true, explanation: "The View is responsible for displaying data to the user in a format they can understand." },
            { description: "It manages the application state", correct: false, explanation: "The Model manages the application state, not the View." },
            { description: "It handles all database queries", correct: false, explanation: "Database queries are handled by the Model." },
            { description: "It connects to external services", correct: false, explanation: "Connecting to external services is typically managed within Models or dedicated service objects." }
          ].shuffle!
        },
        {
          description: "What does the acronym MVC stand for?",
          answers: [
            { description: "Model-View-Controller", correct: true, explanation: "MVC stands for Model-View-Controller, which is a design pattern for separating application logic." },
            { description: "Multi-View-Component", correct: false, explanation: "This is not the correct interpretation of the acronym MVC." },
            { description: "Model-Variable-Controller", correct: false, explanation: "This is not a valid interpretation of MVC." },
            { description: "View-Controller-Model", correct: false, explanation: "The correct order is Model-View-Controller." },
            { description: "Model-View-Collaborator", correct: false, explanation: "This is not a recognized term related to MVC." }
          ].shuffle!
        }
      ],

      "Generators and Scaffolding" => [
        {
          description: "What is the primary purpose of Rails generators?",
          answers: [
            { description: "To create reusable components and libraries", correct: false, explanation: "Generators primarily create application-specific files, not reusable components." },
            { description: "To automate the creation of files and boilerplate code", correct: true, explanation: "Generators automate the creation of necessary files and boilerplate code for models, controllers, views, etc." },
            { description: "To manage database migrations", correct: false, explanation: "While generators can create migration files, their main purpose is not migration management." },
            { description: "To handle routing for the application", correct: false, explanation: "Routing is handled by the router, not by generators." },
            { description: "To configure external services", correct: false, explanation: "Configuration of external services is done manually, not through generators." }
          ].shuffle!
        },
        {
          description: "Which command would you use to generate a scaffold in Rails?",
          answers: [
            { description: "rails scaffold generate", correct: false, explanation: "The correct command is 'rails generate scaffold', not the other way around." },
            { description: "rails generate scaffold", correct: true, explanation: "The command 'rails generate scaffold' creates a complete set of files for a resource including model, view, and controller." },
            { description: "rails new scaffold", correct: false, explanation: "There is no 'rails new scaffold' command; scaffolding is part of the 'generate' command." },
            { description: "rails create scaffold", correct: false, explanation: "'rails create scaffold' is not a valid command in Rails." },
            { description: "rails make scaffold", correct: false, explanation: "'rails make scaffold' is also not a valid command in Rails." }
          ].shuffle!
        },
        {
          description: "What files does running 'rails generate scaffold Post title:string body:text' create?",
          answers: [
            { description: "Only the model file for Post", correct: false, explanation: "'rails generate scaffold' creates multiple files, not just the model." },
            { description: "A model, controller, views, and a migration for the Post", correct: true, explanation: "It generates the model, controller, views, and migration for the specified resource." },
            { description: "Only the view files for the Post", correct: false, explanation: "It generates more than just view files." },
            { description: "Only the migration file for Post", correct: false, explanation: "The command generates multiple components, not just the migration." },
            { description: "A helper file for Post", correct: false, explanation: "Helper files are not directly created by this command." }
          ].shuffle!
        },
        {
          description: "How can you see a list of available generators in Rails?",
          answers: [
            { description: "By running 'rails generate --help'", correct: true, explanation: "You can see all available generators by running 'rails generate --help'." },
            { description: "By checking the 'lib/generators' folder", correct: false, explanation: "The 'lib/generators' folder contains custom generators, but not a comprehensive list." },
            { description: "By running 'rails generators'", correct: false, explanation: "'rails generators' is not a valid command." },
            { description: "By running 'rails help generators'", correct: false, explanation: "While 'rails help' can show some help, it does not specifically list generators." },
            { description: "By checking the Rails documentation online", correct: false, explanation: "The documentation does provide information, but the command is the easiest way to see available generators." }
          ].shuffle!
        },
        {
          description: "What does running 'rails generate migration CreatePosts title:string body:text' do?",
          answers: [
            { description: "Creates a model and a controller for Post", correct: false, explanation: "'rails generate migration' does not create a model or controller; it only creates a migration file." },
            { description: "Creates a new migration file for creating the posts table", correct: true, explanation: "'rails generate migration CreatePosts' creates a new migration file for creating the posts table." },
            { description: "Creates a scaffold for the Post resource", correct: false, explanation: "A scaffold requires the 'scaffold' command, not just 'migration'." },
            { description: "Creates a new database for the application", correct: false, explanation: "The migration command does not create a database; it modifies the schema." },
            { description: "Creates a new view for the Post", correct: false, explanation: "The command only generates a migration file, not views." }
          ].shuffle!
        }
      ],

      "Active Record" => [
        {
          description: "What is Active Record in Rails?",
          answers: [
            { description: "An interface for managing HTML views", correct: false, explanation: "Active Record is not for managing views; it's a part of the Model layer." },
            { description: "An ORM (Object-Relational Mapping) framework", correct: true, explanation: "Active Record is an ORM that connects classes to database tables." },
            { description: "A routing framework in Rails", correct: false, explanation: "Routing is handled separately in Rails, not by Active Record." },
            { description: "A library for handling JavaScript", correct: false, explanation: "Active Record does not deal with JavaScript; it is focused on data management." },
            { description: "A testing framework for Rails applications", correct: false, explanation: "Testing frameworks are separate from Active Record." }
          ].shuffle!
        },
        {
          description: "How does Active Record handle database interactions?",
          answers: [
            { description: "Through raw SQL queries only", correct: false, explanation: "Active Record abstracts SQL, allowing for method calls instead." },
            { description: "By providing a set of methods to interact with the database", correct: true, explanation: "Active Record provides methods for querying and manipulating data." },
            { description: "By using JSON APIs", correct: false, explanation: "Active Record interacts with the database using Ruby methods, not JSON APIs." },
            { description: "By generating static HTML files", correct: false, explanation: "Active Record is focused on data management, not static file generation." },
            { description: "By managing CSS styles", correct: false, explanation: "CSS styling is unrelated to Active Record." }
          ].shuffle!
        },
        {
          description: "What method would you use to find a record by its ID in Active Record?",
          answers: [
            { description: "Model.find_by_id(id)", correct: false, explanation: "While 'find_by_id' is valid, 'find' is more commonly used." },
            { description: "Model.find(id)", correct: true, explanation: "The 'find' method retrieves a record by its ID." },
            { description: "Model.where(id: id)", correct: false, explanation: "'where' returns an array of records, not a single one." },
            { description: "Model.get(id)", correct: false, explanation: "'get' is not a valid Active Record method." },
            { description: "Model.retrieve(id)", correct: false, explanation: "'retrieve' is not an Active Record method." }
          ].shuffle!
        },
        {
          description: "Which of the following is a feature of Active Record?",
          answers: [
            { description: "Supports validation of model attributes", correct: true, explanation: "Active Record includes validation features to ensure data integrity." },
            { description: "Generates routing configurations automatically", correct: false, explanation: "Routing is managed by the router, not Active Record." },
            { description: "Handles view rendering", correct: false, explanation: "View rendering is handled by the View layer, not Active Record." },
            { description: "Automatically handles user sessions", correct: false, explanation: "User session management is not a function of Active Record." },
            { description: "Manages external API integrations", correct: false, explanation: "Active Record does not manage API integrations." }
          ].shuffle!
        },
        {
          description: "What is a 'scope' in Active Record?",
          answers: [
            { description: "A way to define a custom validation method", correct: false, explanation: "Scopes are not for validations; they define queries." },
            { description: "A method to specify commonly used queries", correct: true, explanation: "Scopes are used to encapsulate common queries for reuse." },
            { description: "A class method for managing user sessions", correct: false, explanation: "Scopes are related to queries, not session management." },
            { description: "A feature for handling HTTP requests", correct: false, explanation: "HTTP request handling is outside the scope of Active Record." },
            { description: "A tool for managing database migrations", correct: false, explanation: "Scopes are for queries, not migrations." }
          ].shuffle!
        }
      ],

      "Database Migrations" => [
        {
          description: "What is the purpose of database migrations in Rails?",
          answers: [
            { description: "To create and modify database schemas", correct: true, explanation: "Migrations allow developers to version and manage database schema changes." },
            { description: "To seed the database with initial data", correct: false, explanation: "Seeding is done using the 'db:seed' task, not migrations." },
            { description: "To configure routing for the application", correct: false, explanation: "Routing is unrelated to migrations." },
            { description: "To manage user authentication", correct: false, explanation: "User authentication management is separate from migrations." },
            { description: "To handle view rendering", correct: false, explanation: "View rendering is not part of migrations." }
          ].shuffle!
        },
        {
          description: "How do you create a new migration in Rails?",
          answers: [
            { description: "rails migrate new MigrationName", correct: false, explanation: "'migrate' is not the correct command; 'generate' is used instead." },
            { description: "rails generate migration MigrationName", correct: true, explanation: "'rails generate migration' creates a new migration file." },
            { description: "rails create migration MigrationName", correct: false, explanation: "'create' is not a valid command in this context." },
            { description: "rails new migration MigrationName", correct: false, explanation: "'new' is not a valid command for creating migrations." },
            { description: "rails migration MigrationName", correct: false, explanation: "The correct command is 'generate', not just 'migration'." }
          ].shuffle!
        },
        {
          description: "What method would you use to run pending migrations?",
          answers: [
            { description: "rails migrate", correct: false, explanation: "'rails migrate' is not the correct command." },
            { description: "rails db:migrate", correct: true, explanation: "The correct command to run pending migrations is 'rails db:migrate'." },
            { description: "rails run migrations", correct: false, explanation: "'run migrations' is not a valid command." },
            { description: "rails update", correct: false, explanation: "'update' is not the correct way to run migrations." },
            { description: "rails execute migrations", correct: false, explanation: "'execute migrations' is not a recognized command." }
          ].shuffle!
        },
        {
          description: "What does the 'up' method in a migration do?",
          answers: [
            { description: "It defines how to revert the migration", correct: false, explanation: "'down' is the method used for reverting." },
            { description: "It specifies changes to apply to the database schema", correct: true, explanation: "The 'up' method contains the logic for applying changes to the database." },
            { description: "It runs the database server", correct: false, explanation: "Migrations do not run the database server." },
            { description: "It generates a new model", correct: false, explanation: "The 'up' method is not for generating models." },
            { description: "It modifies existing records in the database", correct: false, explanation: "'up' applies schema changes, not record modifications." }
          ].shuffle!
        },
        {
          description: "How can you roll back the last migration?",
          answers: [
            { description: "rails db:rollback", correct: true, explanation: "'rails db:rollback' rolls back the last migration applied." },
            { description: "rails migrate rollback", correct: false, explanation: "'migrate rollback' is not a valid command." },
            { description: "rails db:migrate down", correct: false, explanation: "'migrate down' is not a recognized command." },
            { description: "rails undo last migration", correct: false, explanation: "'undo last migration' is not a valid command." },
            { description: "rails revert last migration", correct: false, explanation: "'revert last migration' is not a valid command." }
          ].shuffle!
        }
      ],

      "Validations and Callbacks" => [
        {
          description: "What is the primary purpose of model validations in Rails?",
          answers: [
            { description: "To ensure data integrity before saving to the database", correct: true, explanation: "Validations prevent invalid data from being saved, ensuring data integrity." },
            { description: "To define associations between models", correct: false, explanation: "Associations are defined separately from validations." },
            { description: "To automatically generate controller actions", correct: false, explanation: "Controller actions are defined independently from model validations." },
            { description: "To configure the user interface for forms", correct: false, explanation: "Validations focus on data integrity, not UI configuration." },
            { description: "To manage session data for users", correct: false, explanation: "Session management is separate from validations." }
          ].shuffle!
        },
        {
          description: "Which method is commonly used to validate the presence of a model attribute?",
          answers: [
            { description: "validates_presence_of :attribute", correct: false, explanation: "This method is older; the newer syntax is preferred." },
            { description: "validates :attribute, presence: true", correct: true, explanation: "This is the current syntax used for presence validation." },
            { description: "validates :attribute, required: true", correct: false, explanation: "There is no 'required' option in Rails validations." },
            { description: "validate_presence :attribute", correct: false, explanation: "'validate_presence' is not a valid validation method." },
            { description: "check_presence :attribute", correct: false, explanation: "This is not a recognized method in Rails." }
          ].shuffle!
        },
        {
          description: "What are callbacks in Rails models?",
          answers: [
            { description: "Methods that automatically handle HTTP requests", correct: false, explanation: "Callbacks are not related to handling HTTP requests." },
            { description: "Hooks into the lifecycle of an Active Record object", correct: true, explanation: "Callbacks allow you to execute code at specific points in an object's lifecycle." },
            { description: "Methods used for data seeding", correct: false, explanation: "Callbacks are not used for seeding data." },
            { description: "Static methods defined on a model", correct: false, explanation: "Callbacks are not static methods; they are instance methods." },
            { description: "A way to define user authentication", correct: false, explanation: "Callbacks are unrelated to user authentication." }
          ].shuffle!
        },
        {
          description: "Which callback is triggered before a record is saved to the database?",
          answers: [
            { description: "after_save", correct: false, explanation: "The 'after_save' callback is triggered after the record is saved." },
            { description: "before_save", correct: true, explanation: "The 'before_save' callback is called right before the record is saved." },
            { description: "before_validation", correct: false, explanation: "'before_validation' is called before validations, not save." },
            { description: "before_create", correct: false, explanation: "'before_create' is called before a record is created, not saved." },
            { description: "after_initialize", correct: false, explanation: "'after_initialize' is called when a record is instantiated, not when saving." }
          ].shuffle!
        },
        {
          description: "What will happen if a validation fails in Rails?",
          answers: [
            { description: "The record will be saved anyway", correct: false, explanation: "If validations fail, the record will not be saved." },
            { description: "The record will be saved but marked as invalid", correct: false, explanation: "Invalid records cannot be saved." },
            { description: "An error message will be added to the model", correct: true, explanation: "The model will contain error messages for any failed validations." },
            { description: "All validations will be skipped", correct: false, explanation: "If validations are defined, they will be enforced." },
            { description: "The application will crash", correct: false, explanation: "The application does not crash; it simply fails to save the record." }
          ].shuffle!
        }
      ],

      "Model Associations" => [
        {
          description: "What is the purpose of model associations in Rails?",
          answers: [
            { description: "To establish relationships between different models", correct: true, explanation: "Associations define how models relate to one another." },
            { description: "To manage session data for users", correct: false, explanation: "Session management is separate from model associations." },
            { description: "To handle data validation", correct: false, explanation: "Validations and associations serve different purposes." },
            { description: "To generate database migrations automatically", correct: false, explanation: "Associations do not generate migrations; they define relationships." },
            { description: "To render views dynamically", correct: false, explanation: "View rendering is unrelated to model associations." }
          ].shuffle!
        },
        {
          description: "Which association would you use to indicate that a model belongs to another model?",
          answers: [
            { description: "has_many", correct: false, explanation: "'has_many' indicates a one-to-many relationship." },
            { description: "has_one", correct: false, explanation: "'has_one' indicates a one-to-one relationship." },
            { description: "belongs_to", correct: true, explanation: "'belongs_to' indicates a one-to-one relationship where the current model contains the foreign key." },
            { description: "has_and_belongs_to_many", correct: false, explanation: "'has_and_belongs_to_many' indicates a many-to-many relationship." },
            { description: "is_connected_to", correct: false, explanation: "'is_connected_to' is not a valid association in Rails." }
          ].shuffle!
        },
        {
          description: "What does the 'has_many' association imply?",
          answers: [
            { description: "A one-to-one relationship between models", correct: false, explanation: "'has_many' defines a one-to-many relationship." },
            { description: "A many-to-many relationship", correct: false, explanation: "'has_many' requires a join table for many-to-many relationships." },
            { description: "That the model can have multiple associated records", correct: true, explanation: "'has_many' allows a model to have multiple associated records." },
            { description: "A relationship where one model owns another", correct: false, explanation: "Ownership is not implied by 'has_many'; it's defined by 'belongs_to'." },
            { description: "That there are no restrictions on associated records", correct: false, explanation: "'has_many' does not imply unrestricted associations." }
          ].shuffle!
        },
        {
          description: "How would you set up a many-to-many relationship between models?",
          answers: [
            { description: "Use 'has_many :through' with a join table", correct: true, explanation: "'has_many :through' allows for many-to-many associations with additional attributes." },
            { description: "Use 'belongs_to' in both models", correct: false, explanation: "'belongs_to' is not used for many-to-many relationships." },
            { description: "Just use 'has_many' in both models", correct: false, explanation: "'has_many' alone does not define a many-to-many relationship." },
            { description: "Define the relationship in the controller", correct: false, explanation: "Relationships are defined in models, not controllers." },
            { description: "Utilize polymorphic associations", correct: false, explanation: "Polymorphic associations allow a model to belong to more than one other model, not specifically many-to-many." }
          ].shuffle!
        },
        {
          description: "What is a polymorphic association in Rails?",
          answers: [
            { description: "An association that can point to multiple models", correct: true, explanation: "Polymorphic associations allow a model to belong to more than one model type." },
            { description: "A one-to-many relationship between two models", correct: false, explanation: "This describes a regular association, not polymorphic." },
            { description: "An association that cannot be defined in a migration", correct: false, explanation: "Polymorphic associations can be defined in migrations." },
            { description: "A feature for handling user authentication", correct: false, explanation: "Polymorphic associations are unrelated to authentication." },
            { description: "A method for automatically creating database tables", correct: false, explanation: "Associations do not create tables; migrations handle that." }
          ].shuffle!
        }
      ],

      "Database Queries with Active Record" => [
        {
          description: "What is the purpose of Active Record in Ruby on Rails?",
          answers: [
            { description: "It is used for database interactions and managing data models.", correct: true, explanation: "Active Record provides an interface for interacting with the database, allowing for easy CRUD operations." },
            { description: "It is a built-in templating engine for rendering views.", correct: false, explanation: "Active Record is focused on database interactions, not rendering views." },
            { description: "It helps in managing application configurations.", correct: false, explanation: "Active Record deals with data models and not application configurations." },
            { description: "It is responsible for routing requests in a Rails application.", correct: false, explanation: "Routing is managed by Action Dispatch, not Active Record." },
            { description: "It provides a way to generate CSS styles in Rails applications.", correct: false, explanation: "CSS styles are managed separately, not through Active Record." }
          ].shuffle!,
        },
        {
          description: "How do you retrieve all records from a table using Active Record?",
          answers: [
            { description: "By using the all method on the model, e.g., ModelName.all.", correct: true, explanation: "The all method fetches all records from the corresponding table." },
            { description: "By using the find method, e.g., ModelName.find.", correct: false, explanation: "The find method retrieves records by their ID, not all records." },
            { description: "By executing raw SQL queries directly.", correct: false, explanation: "While possible, it is not the recommended way to fetch records in Rails." },
            { description: "By calling the records method on the model.", correct: false, explanation: "There is no records method; the all method is used instead." },
            { description: "By using the each method on the model, e.g., ModelName.each.", correct: false, explanation: "The each method iterates over a collection but does not retrieve records." }
          ].shuffle!,
        },
        {
          description: "What is the difference between where and find_by in Active Record?",
          answers: [
            { description: "where returns an array of records, while find_by returns a single record.", correct: true, explanation: "where is used for querying multiple records, whereas find_by fetches the first matching record." },
            { description: "find_by can only be used with primary keys, while where can be used with any attribute.", correct: false, explanation: "Both can be used with any attribute, but find_by retrieves only one record." },
            { description: "where can be chained with other query methods, but find_by cannot.", correct: false, explanation: "find_by can be chained but is limited to returning a single record." },
            { description: "where always returns the last record, while find_by returns the first.", correct: false, explanation: "Neither method has such behavior; they are based on conditions provided." },
            { description: "find_by raises an error if no record is found, while where returns an empty array.", correct: false, explanation: "find_by returns nil if no record is found." }
          ].shuffle!,
        },
        {
          description: "What is eager loading in Active Record, and why is it beneficial?",
          answers: [
            { description: "Eager loading loads associated records in advance to avoid N+1 queries.", correct: true, explanation: "It improves performance by reducing the number of queries executed." },
            { description: "It loads all records in a single query regardless of associations.", correct: false, explanation: "Eager loading specifically targets associated records to optimize loading." },
            { description: "Eager loading is a method for caching records in memory.", correct: false, explanation: "Eager loading optimizes data retrieval, not caching." },
            { description: "It is a way to handle transactions in Active Record.", correct: false, explanation: "Transactions are managed differently; eager loading is for data retrieval." },
            { description: "Eager loading is only useful for large datasets.", correct: false, explanation: "It benefits any situation with associations, regardless of data size." }
          ].shuffle!,
        },
        {
          description: "What are scopes in Active Record, and how are they useful?",
          answers: [
            { description: "Scopes are predefined queries that can be reused throughout the application.", correct: true, explanation: "They help in maintaining DRY code and reusable query logic." },
            { description: "Scopes are used to define controller actions in Rails applications.", correct: false, explanation: "Scopes are part of the model layer, not the controller." },
            { description: "They are only available in Rails 6 and later versions.", correct: false, explanation: "Scopes have been available in Active Record for a long time." },
            { description: "Scopes are used for setting up background jobs in Rails.", correct: false, explanation: "Background jobs are managed differently; scopes are for queries." },
            { description: "They can only be defined for single model queries, not joins.", correct: false, explanation: "Scopes can be defined for complex queries, including joins." }
          ].shuffle!,
        }
      ],

      "Views and Layouts" => [
        {
          description: "What is the primary purpose of views in a Rails application?",
          answers: [
            { description: "To render the user interface of the application.", correct: true, explanation: "Views are responsible for presenting data to the user." },
            { description: "To handle data processing and business logic.", correct: false, explanation: "Controllers handle business logic, while views focus on presentation." },
            { description: "To manage database connections and queries.", correct: false, explanation: "Database interactions are handled by Active Record, not views." },
            { description: "To define routing for the application.", correct: false, explanation: "Routing is managed separately in the routes file." },
            { description: "To serve static assets like images and stylesheets.", correct: false, explanation: "Static assets are served differently from views." }
          ].shuffle!,
        },
        {
          description: "How do layouts differ from views in Rails?",
          answers: [
            { description: "Layouts provide a common structure for multiple views, while views display specific content.", correct: true, explanation: "Layouts encapsulate shared elements like headers and footers." },
            { description: "Views can contain layouts, but layouts cannot include views.", correct: false, explanation: "Layouts are separate from views; they provide a wrapper." },
            { description: "Layouts are used exclusively for API responses, while views are for HTML.", correct: false, explanation: "Layouts can be used for both HTML and API responses." },
            { description: "Layouts can only be defined at the application level, not per controller.", correct: false, explanation: "Layouts can be customized at the controller or action level." },
            { description: "There is no difference; they are interchangeable terms.", correct: false, explanation: "Layouts and views serve distinct purposes in a Rails application." }
          ].shuffle!,
        },
        {
          description: "What is the purpose of the application layout file in Rails?",
          answers: [
            { description: "It serves as a default layout for all views in the application.", correct: true, explanation: "The application layout provides a consistent structure across the app." },
            { description: "It is used to define routes for the application.", correct: false, explanation: "Routing is managed in the routes file, not in the layout." },
            { description: "It is only used for rendering JSON responses.", correct: false, explanation: "Layouts are primarily used for HTML views, not JSON responses." },
            { description: "It must be included in every view explicitly.", correct: false, explanation: "Layouts are automatically applied unless specified otherwise." }
          ].shuffle!,
        },
        {
          description: "How can you customize the layout used for a specific action in a controller?",
          answers: [
            { description: "By using the layout method within the controller, e.g., layout 'special', only: [:new].", correct: true, explanation: "This allows for flexibility in defining different layouts for different actions." },
            { description: "By renaming the layout file to match the action name, Rails will automatically use it.", correct: false, explanation: "While naming conventions matter, explicitly setting the layout in the controller is necessary for customization." },
            { description: "Layouts can only be customized globally, not per action.", correct: false, explanation: "Layouts can be customized on a per-action basis in the controller." },
            { description: "You cannot customize layouts in Rails applications.", correct: false, explanation: "Rails provides mechanisms to customize layouts for individual actions." }
          ].shuffle!,
        },
        {
          description: "What is the difference between the 'render' and 'redirect_to' methods in a Rails controller?",
          answers: [
            { description: "'render' displays a view template without changing the URL, while 'redirect_to' issues a new HTTP request to a different URL.", correct: true, explanation: "'render' is used to show a view directly, while 'redirect_to' changes the URL." },
            { description: "'redirect_to' can only be used with GET requests, while 'render' can be used with any HTTP method.", correct: false, explanation: "Both methods can be used with various HTTP methods." },
            { description: "'render' automatically performs a redirect, while 'redirect_to' renders the specified view.", correct: false, explanation: "'render' does not redirect; it displays a view." },
            { description: "'render' can only be used within the same controller, while 'redirect_to' can navigate to other controllers.", correct: false, explanation: "Both methods can be used to navigate between actions across controllers." }
          ].shuffle!,
        }
      ],

      "ERB (Embedded Ruby)" => [
        {
          description: "What does ERB stand for, and what is its primary purpose in Ruby on Rails?",
          answers: [
            { description: "ERB stands for Embedded Ruby, and it is used to embed Ruby code within HTML templates.", correct: true, explanation: "ERB allows developers to dynamically generate HTML by inserting Ruby code directly into templates." },
            { description: "ERB stands for Easy Ruby Blocks, used exclusively for Ruby scripting.", correct: false, explanation: "ERB is specifically for embedding Ruby code in HTML, not for Ruby scripting." },
            { description: "ERB is a database query language for Ruby applications.", correct: false, explanation: "ERB is not related to databases; it is focused on templating." },
            { description: "ERB is a command-line tool for managing Ruby applications.", correct: false, explanation: "ERB is not a command-line tool; it is a templating system." },
            { description: "ERB is used for styling HTML pages in Rails applications.", correct: false, explanation: "ERB does not handle styling; it is focused on embedding Ruby code in HTML." }
          ].shuffle!,
        },
        {
          description: "How do you use Ruby code within an ERB template?",
          answers: [
            { description: "You can embed Ruby code within <% %> tags for control flow and <%= %> tags to output values.", correct: true, explanation: "ERB uses <% %> for executing Ruby code and <%= %> for displaying output." },
            { description: "You must wrap all Ruby code in triple curly braces {{}}.", correct: false, explanation: "Triple curly braces are not used in ERB; it uses <% %> and <%= %>." },
            { description: "You can only use Ruby code in the header of an ERB file.", correct: false, explanation: "Ruby code can be used anywhere within an ERB file, not just in the header." },
            { description: "Ruby code in ERB templates must be placed in a separate .rb file.", correct: false, explanation: "ERB allows Ruby code directly in the template without needing a separate file." },
            { description: "You can use ERB in JavaScript files to generate dynamic JavaScript.", correct: false, explanation: "ERB is primarily for HTML; while it can be used in JavaScript, it is not its main purpose." }
          ].shuffle!,
        },
        {
          description: "What is the purpose of using <%= %> versus <% %> in an ERB template?",
          answers: [
            { description: "<%= %> is used to output values to the rendered HTML, while <% %> is used for control flow and does not output.", correct: true, explanation: "The <%= %> tag prints the result to the view, whereas <% %> executes Ruby code without printing." },
            { description: "They are interchangeable; both will output to the view.", correct: false, explanation: "<%= %> outputs, while <% %> does not produce output." },
            { description: "<%= %> can only be used with strings, while <% %> can be used with any Ruby code.", correct: false, explanation: "Both can handle any Ruby code, but <%= %> specifically outputs the result." },
            { description: "<% %> is used for comments, while <%= %> is used for outputting HTML.", correct: false, explanation: "Neither tag is used for comments; ERB comments use <%-# %>." }
          ].shuffle!,
        },
        {
          description: "How can you include partials in an ERB template?",
          answers: [
            { description: "You can include partials using the render method, e.g., <%= render 'partial_name' %>.", correct: true, explanation: "The render method is used to include partial templates within views." },
            { description: "Partials must be included using the include method.", correct: false, explanation: "There is no include method for partials; use render instead." },
            { description: "You cannot include partials directly within ERB templates.", correct: false, explanation: "ERB templates allow for including partials using render." },
            { description: "You can use <%= partial 'partial_name' %> to include partials.", correct: false, explanation: "The correct syntax is <%= render 'partial_name' %>." }
          ].shuffle!,
        },
        {
          description: "What is the purpose of the <%- %> tag in ERB?",
          answers: [
            { description: "The <%- %> tag is used to execute Ruby code without producing output, including removing whitespace.", correct: true, explanation: "<%- %> does not output anything to the view and is useful for controlling whitespace." },
            { description: "<%- %> is used to include JavaScript code within ERB templates.", correct: false, explanation: "The <%- %> tag is not specifically for JavaScript; it is for Ruby code without output." },
            { description: "<%- %> allows for comments within ERB templates.", correct: false, explanation: "ERB comments are made with <%-# %>, not <%- %>." },
            { description: "<%- %> is used for outputting raw HTML without escaping.", correct: false, explanation: "Raw HTML is output with <%= raw(value) %>, not with <%- %>." }
          ].shuffle!,
        }
      ],

      "View Helpers" => [
        {
          description: "What are view helpers in Ruby on Rails, and why are they used?",
          answers: [
            { description: "View helpers are methods designed to simplify the code in views by encapsulating complex logic and making the templates cleaner.", correct: true, explanation: "Helpers keep views organized and maintainable by abstracting repetitive code." },
            { description: "View helpers are used to handle database transactions within views.", correct: false, explanation: "Helpers do not manage database transactions; they assist in rendering views." },
            { description: "They are exclusively for formatting HTML elements.", correct: false, explanation: "Helpers can format HTML, but they serve broader purposes, such as encapsulating logic." },
            { description: "View helpers are methods that are automatically included in all models.", correct: false, explanation: "Helpers are included in views, not models." },
            { description: "They provide security features for preventing SQL injections.", correct: false, explanation: "Security features are handled at the model and controller levels, not in view helpers." }
          ].shuffle!,
        },
        {
          description: "How can you create a custom view helper in a Rails application?",
          answers: [
            { description: "You can define a custom helper method in the app/helpers directory, typically in a file that corresponds to the controller.", correct: true, explanation: "Helpers are defined in specific files within the helpers directory to organize methods by controller." },
            { description: "Custom view helpers must be placed in the model classes.", correct: false, explanation: "Helpers are separate from models and should be defined in the helpers directory." },
            { description: "You can only create view helpers within the application controller.", correct: false, explanation: "Helpers can be defined in any helper file, not just the application controller." },
            { description: "Custom view helpers can only be defined using the class method syntax.", correct: false, explanation: "Helpers can be defined using standard method syntax." }
          ].shuffle!,
        },
        {
          description: "What is the difference between built-in view helpers and custom view helpers?",
          answers: [
            { description: "Built-in helpers are provided by Rails for common tasks, while custom helpers are defined by developers for specific application needs.", correct: true, explanation: "Built-in helpers are pre-defined, while custom helpers are tailored to application requirements." },
            { description: "Custom helpers are less efficient than built-in helpers.", correct: false, explanation: "Performance depends on implementation; custom helpers can be just as efficient." },
            { description: "There is no difference; both serve the same purpose.", correct: false, explanation: "Built-in helpers are standardized, while custom helpers are user-defined." },
            { description: "Built-in helpers can only be used in specific controllers, while custom helpers are available globally.", correct: false, explanation: "Both types of helpers can be used in any view where they are included." }
          ].shuffle!,
        },
        {
          description: "Which of the following is a common built-in view helper method in Rails?",
          answers: [
            { description: "link_to is a helper method used to generate HTML anchor tags.", correct: true, explanation: "link_to creates hyperlinks easily within views." },
            { description: "db_connect is a helper for establishing database connections.", correct: false, explanation: "db_connect is not a view helper; it is not related to rendering views." },
            { description: "generate_css is used to apply CSS styles directly in ERB files.", correct: false, explanation: "There is no built-in helper called generate_css; styles are applied using CSS files." },
            { description: "format_date is a helper for parsing date strings into Ruby objects.", correct: false, explanation: "format_date is not a built-in view helper; date formatting is typically handled differently." }
          ].shuffle!,
        },
        {
          description: "How do you use a view helper in an ERB template?",
          answers: [
            { description: "You can call a helper method directly within the ERB template using its name, e.g., <%= link_to 'Home', root_path %>.", correct: true, explanation: "Helper methods are called directly in ERB templates to render views." },
            { description: "Helpers must be called using JavaScript syntax.", correct: false, explanation: "Helpers are called using Ruby syntax in ERB templates, not JavaScript." },
            { description: "You must define a helper in the application controller to use it in views.", correct: false, explanation: "Helpers are defined in the helpers directory and can be used directly in views." },
            { description: "Helpers can only be used within specific methods in the controller.", correct: false, explanation: "Helpers are accessible in any view where they are included." }
          ].shuffle!,
        }
      ],

      "Forms and Form Helpers" => [
    {
      description: "What is the primary purpose of form helpers in Ruby on Rails?",
      answers: [
        { description: "Form helpers are designed to simplify the creation of HTML forms by providing methods that handle form elements and their corresponding labels, validations, and error messages.", correct: true, explanation: "Form helpers reduce repetitive code and make form generation easier and more readable." },
        { description: "They are used to handle user authentication and authorization within the application.", correct: false, explanation: "Form helpers are focused on form generation, not user authentication." },
        { description: "Form helpers allow for direct manipulation of the database without writing SQL queries.", correct: false, explanation: "Form helpers are for rendering forms, not for database manipulation." },
        { description: "They are used to apply styles to HTML forms using CSS classes.", correct: false, explanation: "While form helpers can include CSS classes, their primary function is to generate form elements." },
        { description: "Form helpers only work with text input fields and do not support other input types.", correct: false, explanation: "Form helpers support a variety of input types, including checkboxes, radio buttons, and file uploads." }
      ].shuffle!,
    },
    {
      description: "How can you create a form using form helpers in Rails?",
      answers: [
        { description: "You can create a form using the form_with or form_for methods, specifying the model and action attributes.", correct: true, explanation: "form_with or form_for simplifies form creation by linking it to a specific model." },
        { description: "Forms can only be created using raw HTML; form helpers are not allowed.", correct: false, explanation: "Rails provides form helpers to make form creation easier, but raw HTML can also be used." },
        { description: "You must create a separate controller method for each form you want to build.", correct: false, explanation: "Forms can share controller actions and routes." },
        { description: "Forms are created using the create_form method in the application controller.", correct: false, explanation: "There is no create_form method; forms are created using form_with or form_for." },
        { description: "Form helpers require the use of JavaScript to function correctly.", correct: false, explanation: "Form helpers work with HTML and Ruby, not specifically requiring JavaScript." }
      ].shuffle!,
    },
    {
      description: "What is the difference between form_for and form_with in Rails?",
      answers: [
        { description: "form_with is a newer method that allows for remote forms by default, while form_for is primarily for standard forms.", correct: true, explanation: "form_with supports AJAX and can handle both remote and non-remote forms." },
        { description: "form_for is only used for creating forms for new records, while form_with can be used for both new and existing records.", correct: false, explanation: "Both methods can be used for new and existing records." },
        { description: "form_for generates static HTML, whereas form_with generates dynamic HTML.", correct: false, explanation: "Both generate HTML dynamically; form_with is just the newer syntax." },
        { description: "There is no difference; both methods serve the same purpose and functionality.", correct: false, explanation: "form_with is the recommended method going forward, especially for AJAX forms." }
      ].shuffle!,
    },
    {
      description: "How can you handle form validations in Rails?",
      answers: [
        { description: "You can define validations in the model using Active Record's validation methods like validates :attribute, presence: true.", correct: true, explanation: "Model validations ensure data integrity before saving to the database." },
        { description: "Validations are managed directly in the controller methods, not in the model.", correct: false, explanation: "Validations should be in the model to maintain separation of concerns." },
        { description: "Rails automatically validates all form fields by default without needing to specify.", correct: false, explanation: "You must explicitly define validations for each attribute." },
        { description: "Form validations can only be performed using JavaScript on the client side.", correct: false, explanation: "While JavaScript can validate forms, Rails performs server-side validations in the model." },
        { description: "Validations can be added to forms by including a validation tag within the ERB file.", correct: false, explanation: "Validations are defined in the model, not in the view templates." }
      ].shuffle!,
    },
    {
      description: "What is the purpose of the 'fields_for' helper in Rails forms?",
      answers: [
        { description: "'fields_for' is used to create form fields for associated objects within a parent form, allowing nested attributes.", correct: true, explanation: "It helps in managing complex forms involving multiple models." },
        { description: "'fields_for' is used to apply CSS classes to form fields.", correct: false, explanation: "'fields_for' is not for styling; it manages nested attributes." },
        { description: "'fields_for' can only be used with form_for and cannot be combined with form_with.", correct: false, explanation: "'fields_for' can be used with both form_with and form_for." },
        { description: "'fields_for' is only available in the Rails console, not in views.", correct: false, explanation: "'fields_for' is specifically for use in views when generating forms." }
      ].shuffle!,
    }
  ],

    "Routing in Rails" => [
      {
        description: "What is the purpose of routing in a Ruby on Rails application?",
        answers: [
          { description: "Routing in Rails directs incoming requests to the appropriate controller actions based on the URL patterns and HTTP methods.", correct: true, explanation: "Routing acts as the traffic manager for a Rails application." },
          { description: "Routing is responsible for connecting the database to the application.", correct: false, explanation: "Routing manages request handling, not database connections." },
          { description: "It serves static files directly without involving the controller.", correct: false, explanation: "Routing directs requests to controllers, even for static files." },
          { description: "Routing is only needed for RESTful applications.", correct: false, explanation: "Routing is necessary for all Rails applications, RESTful or not." },
          { description: "Routing determines the layout files used for rendering views.", correct: false, explanation: "Routing does not manage view rendering; it directs requests to controllers." }
        ].shuffle!,
      },
      {
        description: "How do you define a route in Rails for a standard RESTful resource?",
        answers: [
          { description: "You use the resources method in the routes.rb file, e.g., resources :posts.", correct: true, explanation: "This generates the standard RESTful routes for the resource." },
          { description: "You define routes using the route_for method with specific HTTP verbs.", correct: false, explanation: "route_for is not a valid method for defining routes." },
          { description: "You must manually specify all seven RESTful routes for a resource.", correct: false, explanation: "resources automatically generates all routes for you." },
          { description: "You cannot define routes for nested resources in Rails.", correct: false, explanation: "Rails allows for defining nested routes for related resources." },
          { description: "Routes must be defined in alphabetical order in the routes.rb file.", correct: false, explanation: "There is no requirement for the order of route definitions." }
        ].shuffle!,
      },
      {
        description: "What is the significance of the root route in a Rails application?",
        answers: [
          { description: "The root route defines the default landing page for the application when no specific route is provided.", correct: true, explanation: "It specifies which controller action is invoked for the home page." },
          { description: "The root route is only used for API applications.", correct: false, explanation: "The root route applies to all types of Rails applications." },
          { description: "It can only point to a controller action, not a static page.", correct: false, explanation: "The root route can direct to any valid route, including static pages." },
          { description: "The root route must be defined before all other routes in routes.rb.", correct: false, explanation: "While it's common to define it first, there is no strict requirement for its position." }
        ].shuffle!,
      },
      {
        description: "How can you create a named route in Rails, and what is its purpose?",
        answers: [
          { description: "You can create a named route by using the 'get' method followed by a path and specifying a name, e.g., get 'about', to: 'pages#about', as: :about.", correct: true, explanation: "Named routes allow you to reference the route easily in your code." },
          { description: "Named routes can only be defined for RESTful resources.", correct: false, explanation: "Named routes can be created for any route, not just RESTful resources." },
          { description: "Named routes must be defined in the application controller.", correct: false, explanation: "Named routes are defined in the routes.rb file, not the controller." },
          { description: "You cannot use named routes with URL helpers.", correct: false, explanation: "Named routes are specifically designed to work with URL helpers." }
        ].shuffle!,
      },
      {
        description: "What are route constraints, and how can they be used in Rails routing?",
        answers: [
          { description: "Route constraints are conditions that must be met for a route to be matched, such as ensuring a parameter is a number or matching a specific subdomain.", correct: true, explanation: "Constraints allow for more control over route matching." },
          { description: "They are used to enforce security measures on routes, preventing unauthorized access.", correct: false, explanation: "Constraints do not enforce security; they control route matching." },
          { description: "Route constraints can only be applied to custom routes, not to standard RESTful routes.", correct: false, explanation: "Constraints can be applied to any route definition." },
          { description: "You define route constraints in the controller, not in the routes.rb file.", correct: false, explanation: "Constraints are defined within the routes.rb file." }
        ].shuffle!,
      }
    ],

    "Controllers in Rails" => [
      {
        description: "What is the primary role of a controller in a Ruby on Rails application?",
        answers: [
          { description: "The controller handles the incoming requests, processes user input, interacts with models, and determines which view to render.", correct: true, explanation: "Controllers act as the intermediary between the model and the view, orchestrating the flow of data." },
          { description: "Controllers are responsible for defining the database schema and migrations.", correct: false, explanation: "Database schema and migrations are handled by models and migration files, not controllers." },
          { description: "The main job of a controller is to manage user authentication and authorization.", correct: false, explanation: "While controllers can handle authentication, their primary role is to process requests and responses." },
          { description: "Controllers are only responsible for rendering static pages and cannot interact with dynamic data.", correct: false, explanation: "Controllers can handle both static and dynamic data." },
          { description: "Controllers cannot respond to AJAX requests.", correct: false, explanation: "Controllers can handle AJAX requests just like any other request." }
        ].shuffle!,
      },
      {
        description: "How do you define a controller action in Rails?",
        answers: [
          { description: "A controller action is defined as a public method within a controller class, typically following RESTful conventions.", correct: true, explanation: "Each action corresponds to a specific HTTP verb and is responsible for handling a particular type of request." },
          { description: "Controller actions must always return a JSON response regardless of the request type.", correct: false, explanation: "Controller actions can return various types of responses, including HTML, JSON, and XML." },
          { description: "You cannot define multiple actions within a single controller.", correct: false, explanation: "You can define multiple actions in a single controller class." },
          { description: "Controller actions are always private methods to ensure security.", correct: false, explanation: "Controller actions need to be public methods to be accessible as endpoints." }
        ].shuffle!,
      },
      {
        description: "What is the purpose of the 'before_action' callback in Rails controllers?",
        answers: [
          { description: "The 'before_action' callback is used to execute specific methods before certain controller actions, allowing for shared logic, such as authentication or setting instance variables.", correct: true, explanation: "This helps keep your controller code DRY and maintainable." },
          { description: "It is used to define the order in which actions are executed within a controller.", correct: false, explanation: "'before_action' does not determine action order; it executes defined methods before specified actions." },
          { description: "Callbacks can only be used for filtering user input, not for executing any method.", correct: false, explanation: "Callbacks can execute any method, not just input filtering." },
          { description: "There are no limits on how many 'before_action' callbacks you can define in a single controller.", correct: false, explanation: "While you can define many callbacks, excessive use may lead to complexity." }
        ].shuffle!,
      },
      {
        description: "In Rails, what does the 'respond_to' method accomplish in a controller?",
        answers: [
          { description: "The 'respond_to' method allows the controller to respond differently based on the requested format, such as HTML, JSON, or XML.", correct: true, explanation: "This method enhances the flexibility of responses depending on client needs." },
          { description: "It is used to redirect users to a different URL after completing an action.", correct: false, explanation: "'respond_to' does not handle redirection; it manages response formats." },
          { description: "It can only be used with GET requests and not with POST or other HTTP verbs.", correct: false, explanation: "'respond_to' can be used with any HTTP verb." },
          { description: "The 'respond_to' method cannot be used in conjunction with AJAX requests.", correct: false, explanation: "'respond_to' works well with AJAX, providing the correct response format." }
        ].shuffle!,
      },
      {
        description: "How can you handle errors and exceptions in a Rails controller?",
        answers: [
          { description: "You can use the 'rescue_from' method to catch exceptions and handle them gracefully, providing custom error responses.", correct: true, explanation: "'rescue_from' allows you to define error handling logic in one place." },
          { description: "Error handling must be done in the model layer; controllers cannot handle exceptions.", correct: false, explanation: "Controllers can and should handle exceptions to provide user-friendly error messages." },
          { description: "You can only log errors; there is no way to provide custom responses for errors in controllers.", correct: false, explanation: "You can log errors and also provide custom error responses." },
          { description: "Exceptions in controllers are always logged automatically without needing to specify anything.", correct: false, explanation: "While Rails does log errors, it's often best to implement custom handling." }
        ].shuffle!,
      }
    ],

    "Authentication and Authorization" => [
      {
        description: "What is the difference between authentication and authorization in a web application?",
        answers: [
          { description: "Authentication verifies the identity of a user, while authorization determines what an authenticated user is allowed to do.", correct: true, explanation: "Authentication checks who you are; authorization checks what you can access." },
          { description: "Authentication and authorization are the same processes in a web application.", correct: false, explanation: "They serve different purposes: one is about identity, the other about permissions." },
          { description: "Authorization occurs before authentication in the user login process.", correct: false, explanation: "Authentication occurs first, followed by authorization." },
          { description: "Authorization involves verifying user credentials against a database.", correct: false, explanation: "That task is part of authentication, not authorization." }
        ].shuffle!,
      },
      {
        description: "How can you implement user authentication in a Rails application?",
        answers: [
          { description: "You can use gems like Devise or Auth0, which provide comprehensive authentication solutions including user registration, password recovery, and session management.", correct: true, explanation: "These gems streamline the process of adding authentication to Rails applications." },
          { description: "User authentication can only be implemented through custom-built solutions without using any external libraries.", correct: false, explanation: "While you can build custom solutions, using established gems is highly recommended for security and ease of use." },
          { description: "All authentication must be handled manually by defining custom methods in the ApplicationController.", correct: false, explanation: "While you can define methods in ApplicationController, using gems simplifies the process." },
          { description: "User authentication is not required for web applications and can be omitted.", correct: false, explanation: "Most applications benefit from authentication to protect user data and resources." }
        ].shuffle!,
      },
      {
        description: "What are Rails 'before_action' filters used for in the context of authorization?",
        answers: [
          { description: "Before_action filters can be used to enforce authorization checks before executing controller actions, ensuring users have the required permissions.", correct: true, explanation: "This prevents unauthorized access to sensitive actions." },
          { description: "They are only useful for performing validations on form data before it reaches the model layer.", correct: false, explanation: "Before_action filters can handle both validation and authorization." },
          { description: "Before_action filters are irrelevant to authorization and should only be used for logging user activity.", correct: false, explanation: "They play a crucial role in managing user access to resources." },
          { description: "Authorization checks must be done in the view layer, not in the controller layer.", correct: false, explanation: "Authorization checks are typically handled in the controller using before_action." }
        ].shuffle!,
      },
      {
        description: "How can you restrict access to certain actions in a Rails controller based on user roles?",
        answers: [
          { description: "You can implement role-based access control (RBAC) by checking the user's role within a before_action filter and redirecting or denying access as necessary.", correct: true, explanation: "RBAC helps manage user permissions efficiently." },
          { description: "You cannot restrict access in Rails; all users have equal access to all actions by default.", correct: false, explanation: "Access can and should be controlled based on user roles." },
          { description: "Role restrictions must be defined in the routes file, not in the controller.", correct: false, explanation: "Role restrictions are enforced in the controller using before_action filters." },
          { description: "Access restrictions can only be implemented through complex configurations in the database.", correct: false, explanation: "Access restrictions can be defined through controller logic using simple checks." }
        ].shuffle!,
      },
      {
        description: "What is the purpose of using the 'current_user' helper method in Rails applications with authentication?",
        answers: [
          { description: "The 'current_user' method provides access to the currently logged-in user, making it easier to check their permissions and personalize the application experience.", correct: true, explanation: "'current_user' is essential for maintaining user-specific context throughout the application." },
          { description: "It is used to log in users by verifying their credentials against the database.", correct: false, explanation: "Current_user simply returns the logged-in user; it does not handle the login process." },
          { description: "The 'current_user' method is automatically defined in Rails without any additional code or configuration.", correct: false, explanation: "'current_user' needs to be defined as part of your authentication system, often through a gem like Devise." },
          { description: "The 'current_user' method can only be used in views, not in controllers.", correct: false, explanation: "'current_user' can be accessed in both views and controllers." }
        ].shuffle!,
      }
    ],

    "Debugging and Logging" => [
    {
      description: "What is the primary purpose of logging in a Rails application?",
      answers: [
        { description: "Logging is used to track application events and errors, providing insights for debugging and performance monitoring.", correct: true, explanation: "Logs help developers understand the application's behavior in production." },
        { description: "Logging is solely for tracking user interactions with the web interface.", correct: false, explanation: "While user interactions can be logged, logging serves broader purposes including system events." },
        { description: "Logs are only generated when errors occur.", correct: false, explanation: "Logs can record various events, not just errors." },
        { description: "Logging should only be used in development environments, not in production.", correct: false, explanation: "Effective logging is crucial in production for diagnosing issues." }
      ].shuffle!,
    },
    {
      description: "Which of the following methods can be used for debugging Rails applications?",
      answers: [
        { description: "You can use the 'byebug' gem to set breakpoints in your code, allowing you to inspect variables and the call stack at runtime.", correct: true, explanation: "'byebug' provides an interactive debugging experience." },
        { description: "Debugging is best done by simply printing messages to the console; no tools are needed.", correct: false, explanation: "While print statements can help, structured debugging tools provide better insights." },
        { description: "Rails does not support debugging; all debugging must be done outside of the application.", correct: false, explanation: "Rails provides several tools and gems to assist with debugging." },
        { description: "You can only debug Rails applications using the built-in debugger in your text editor.", correct: false, explanation: "While editors can have debugging support, many gems are available for Rails." }
      ].shuffle!,
    },
    {
      description: "How can you set the log level in a Rails application?",
      answers: [
        { description: "You can set the log level in the 'config/environments/*.rb' files using the 'config.log_level' setting, allowing you to control the verbosity of log output.", correct: true, explanation: "Adjusting log levels can help manage log file size and focus on relevant information." },
        { description: "Log levels are automatically determined by Rails and cannot be changed by the developer.", correct: false, explanation: "Developers can customize log levels according to their needs." },
        { description: "The log level can only be set during application initialization and cannot be changed at runtime.", correct: false, explanation: "Log levels can be changed at runtime, though it's not common practice." },
        { description: "Log levels must be set in the database, not in configuration files.", correct: false, explanation: "Log levels are configured in environment-specific files, not in the database." }
      ].shuffle!,
    },
    {
      description: "What is the role of the 'logger' object in Rails?",
      answers: [
        { description: "The 'logger' object allows you to record messages to the log file, which can be useful for tracking application behavior and diagnosing issues.", correct: true, explanation: "The logger provides methods for different log levels (e.g., info, debug, error)." },
        { description: "The 'logger' is only used for error handling and does not support other logging types.", correct: false, explanation: "The logger can handle various types of messages, not just errors." },
        { description: "You cannot access the logger object outside of the application controller.", correct: false, explanation: "The logger is accessible in any part of the Rails application." },
        { description: "The logger is automatically generated and cannot be customized by the developer.", correct: false, explanation: "Developers can customize the logger's behavior and output." }
      ].shuffle!,
    },
    {
      description: "What is a common practice when debugging in production?",
      answers: [
        { description: "You should avoid using debugging tools directly in production and instead rely on logging and error reporting services to monitor issues.", correct: true, explanation: "Direct debugging in production can affect performance and expose sensitive data." },
        { description: "Debugging can be performed freely in production without consequences.", correct: false, explanation: "Debugging in production should be approached with caution to maintain application integrity." },
        { description: "It's acceptable to disable logging in production to enhance performance.", correct: false, explanation: "Logging is crucial in production for diagnosing problems." },
        { description: "All debugging must be done with the application offline to ensure security.", correct: false, explanation: "Debugging can happen while the application is running, but caution is required." }
      ].shuffle!,
    }
    ],

    "Testing in Rails" => [
      {
        description: "What is the purpose of unit testing in Rails?",
        answers: [
          { description: "Unit testing focuses on testing individual components or methods in isolation, ensuring that each part of the application functions correctly.", correct: true, explanation: "This helps catch errors early in the development process." },
          { description: "Unit testing is primarily used to test the entire application as a whole.", correct: false, explanation: "That describes integration testing, which evaluates the entire system." },
          { description: "Unit tests are only concerned with the visual presentation of the application.", correct: false, explanation: "Unit tests assess functionality, not presentation." },
          { description: "Unit tests can only be performed on models, not controllers or views.", correct: false, explanation: "Unit tests can be applied to any component, including controllers and views." }
        ].shuffle!,
      },
      {
        description: "Which testing framework is commonly used in Rails applications?",
        answers: [
          { description: "RSpec is a popular testing framework that provides a domain-specific language (DSL) for writing expressive and readable tests.", correct: true, explanation: "RSpec enhances the testing experience by allowing clear descriptions of test cases." },
          { description: "Minitest is the only available testing framework in Rails and cannot be replaced by any other framework.", correct: false, explanation: "While Minitest is included by default, RSpec and other frameworks can also be used." },
          { description: "Rails does not support automated testing; all tests must be executed manually.", correct: false, explanation: "Rails has robust support for automated testing through various frameworks." },
          { description: "Testing frameworks are only necessary in large applications and not in smaller ones.", correct: false, explanation: "Testing is important regardless of application size to ensure quality." }
        ].shuffle!,
      },
      {
        description: "How do you run tests in a Rails application?",
        answers: [
          { description: "You can run tests using the command 'rails test' for Minitest or 'rspec' for RSpec, depending on the testing framework used.", correct: true, explanation: "Running tests is straightforward with the appropriate commands." },
          { description: "Tests cannot be run from the command line; they must be executed through a graphical user interface.", correct: false, explanation: "Tests can be run easily from the command line." },
          { description: "You can only run one specific test at a time; batch running is not supported.", correct: false, explanation: "You can run all tests or specific subsets of tests." },
          { description: "Test results are only visible in the console, not in any file.", correct: false, explanation: "Test results can be output to the console and also logged to files." }
        ].shuffle!,
      },
      {
        description: "What is the purpose of integration testing in Rails?",
        answers: [
          { description: "Integration testing verifies that different components of the application work together as expected, simulating user interactions across multiple parts of the application.", correct: true, explanation: "Integration tests help ensure that the overall application behavior is correct." },
          { description: "Integration testing focuses solely on the performance of the database.", correct: false, explanation: "While database interactions can be tested, integration testing covers broader application interactions." },
          { description: "Integration tests are only required for large applications and are not necessary for smaller projects.", correct: false, explanation: "Integration testing is beneficial for any application size." },
          { description: "Integration tests must be written in a separate file from unit tests and cannot be combined.", correct: false, explanation: "Integration and unit tests can be organized in the same test directory but serve different purposes." }
        ].shuffle!,
      },
      {
        description: "How can you ensure that tests do not affect the production database in Rails?",
        answers: [
          { description: "Rails uses separate databases for testing, as specified in the 'config/database.yml' file, ensuring that test runs do not interfere with production data.", correct: true, explanation: "This separation is essential for maintaining data integrity." },
          { description: "Tests will always use the production database unless specified otherwise.", correct: false, explanation: "Rails defaults to using a separate test database." },
          { description: "You can disable the database for testing, but this is not recommended.", correct: false, explanation: "Disabling the database would prevent any meaningful tests." },
          { description: "Tests are run directly on the production database, but rollback mechanisms are in place to prevent data loss.", correct: false, explanation: "Running tests directly on production is highly discouraged." }
        ].shuffle!,
      }
    ],

    "Testing in Rails" => [
    {
      description: "What is the main purpose of writing tests for a Rails application?",
      answers: [
        { description: "To ensure that individual components and the application as a whole work as expected, preventing bugs and regressions in future development.", correct: true, explanation: "Testing provides confidence that changes do not break existing functionality." },
        { description: "To increase the development time significantly, making the project more complex.", correct: false, explanation: "While writing tests requires time, it ultimately saves time by catching bugs early." },
        { description: "To replace the need for code reviews, as tests alone can guarantee code quality.", correct: false, explanation: "Code reviews and testing serve different purposes; both are necessary for quality assurance." },
        { description: "To ensure that the application performs well under load, focusing solely on performance testing.", correct: false, explanation: "Performance testing is a part of testing but does not cover functional correctness." },
        { description: "To create documentation for the code, as tests serve as a way to describe how the application should behave.", correct: false, explanation: "While tests can act as documentation, their primary purpose is to verify functionality." }
      ].shuffle!,
    },
    {
      description: "Which of the following statements is true about unit tests in Rails?",
      answers: [
        { description: "Unit tests focus on testing individual methods or functions in isolation, ensuring that each unit of code behaves correctly.", correct: true, explanation: "This isolation helps identify bugs more effectively." },
        { description: "Unit tests require a fully running Rails application to be executed.", correct: false, explanation: "Unit tests can run independently of the application being fully operational." },
        { description: "Unit tests are only necessary for models, not for controllers or views.", correct: false, explanation: "Unit tests can be applied to any Ruby object, including controllers and views." },
        { description: "Unit tests are meant to cover the entire application at once, rather than individual components.", correct: false, explanation: "That describes integration testing, which assesses overall application behavior." },
        { description: "Unit tests should be avoided in favor of manual testing for all components.", correct: false, explanation: "Unit tests are crucial for automated testing and should not be replaced by manual testing." }
      ].shuffle!,
    },
    {
      description: "How can you run all tests in a Rails application?",
      answers: [
        { description: "You can run all tests by executing the command 'rails test' or 'rspec' in the terminal, depending on the testing framework in use.", correct: true, explanation: "This command executes all the tests defined in your application." },
        { description: "Tests can only be run one at a time; batch execution is not possible.", correct: false, explanation: "You can run all tests together or specify particular tests to run." },
        { description: "You must run tests from the Rails console only, as the command line does not support test execution.", correct: false, explanation: "Tests can be executed from the command line or console." },
        { description: "The tests will automatically execute every time you save a file in the application.", correct: false, explanation: "You need to manually run tests; however, some tools can monitor files and run tests automatically." },
        { description: "All tests must be run from within a specific environment; otherwise, they will fail.", correct: false, explanation: "Tests can be run in any environment as long as the database is set up correctly." }
      ].shuffle!,
    },
    {
      description: "What role do fixtures play in Rails testing?",
      answers: [
        { description: "Fixtures are used to set up a known state of the database for tests, providing sample data that can be easily reused across multiple test cases.", correct: true, explanation: "They help maintain consistency in testing by providing standard data." },
        { description: "Fixtures are only applicable for integration tests, not for unit tests.", correct: false, explanation: "Fixtures can be used in both unit and integration tests." },
        { description: "Fixtures cannot be modified once they are created and must remain static.", correct: false, explanation: "You can modify fixtures as needed for different test scenarios." },
        { description: "Using fixtures is optional; all tests can run without them.", correct: false, explanation: "While optional, fixtures help standardize test data." },
        { description: "Fixtures are generated automatically for every model and cannot be customized.", correct: false, explanation: "You can create custom fixtures tailored to your testing needs." }
      ].shuffle!,
    },
    {
      description: "What is the difference between functional tests and integration tests in Rails?",
      answers: [
        { description: "Functional tests focus on individual actions within controllers, while integration tests evaluate the interaction between multiple components or user flows.", correct: true, explanation: "This distinction is crucial for understanding the scope of each type of test." },
        { description: "Functional tests are only applicable to view components, while integration tests cover all models.", correct: false, explanation: "Functional tests assess controller actions, not just views." },
        { description: "Integration tests can only be performed using RSpec, while functional tests use Minitest exclusively.", correct: false, explanation: "Both types of tests can be written using either RSpec or Minitest." },
        { description: "There is no significant difference between functional tests and integration tests; they serve the same purpose.", correct: false, explanation: "They have distinct focuses and methodologies." },
        { description: "Functional tests require a running server, while integration tests can be executed without one.", correct: false, explanation: "Both types of tests can run without a running server." }
      ].shuffle!,
    }
  ],
    "RSpec and FactoryBot" => [
      {
        description: "What is RSpec primarily used for in a Rails application?",
        answers: [
          { description: "RSpec is a testing framework that allows developers to write human-readable and expressive tests for Ruby applications, facilitating behavior-driven development (BDD).", correct: true, explanation: "Its syntax and structure make tests easier to understand and maintain." },
          { description: "RSpec is solely for performance testing and does not support unit or functional testing.", correct: false, explanation: "RSpec supports a variety of testing types, including unit and integration tests." },
          { description: "RSpec is a library that only works with JavaScript, not Ruby or Rails.", correct: false, explanation: "RSpec is specifically designed for testing Ruby applications, including those built with Rails." },
          { description: "RSpec can replace the need for any other testing framework in a Rails application, as it covers all testing needs.", correct: false, explanation: "While powerful, RSpec can be used alongside other tools and frameworks." },
          { description: "RSpec tests can only be executed from within a Rails console, not from the command line.", correct: false, explanation: "RSpec tests can be run directly from the command line." }
        ].shuffle!,
      },
      {
        description: "How does FactoryBot enhance the testing process in Rails?",
        answers: [
          { description: "FactoryBot provides a way to define blueprints for creating test data, allowing developers to easily generate objects with default attributes without needing to create them manually.", correct: true, explanation: "This streamlines the setup of test data and promotes reusability." },
          { description: "FactoryBot only works with RSpec and cannot be used in Minitest.", correct: false, explanation: "FactoryBot is compatible with both RSpec and Minitest." },
          { description: "Using FactoryBot means tests cannot use fixtures, as they serve the same purpose.", correct: false, explanation: "FactoryBot and fixtures can be used together, each serving different needs." },
          { description: "FactoryBot automatically creates database records for every test run, regardless of the developer's needs.", correct: false, explanation: "FactoryBot creates objects only when explicitly instructed by the developer." },
          { description: "FactoryBot is a GUI tool for visualizing test data and cannot be used in code.", correct: false, explanation: "FactoryBot is a code-based library that helps manage test data in applications." }
        ].shuffle!,
      },
      {
        description: "What is the syntax for defining a factory with FactoryBot?",
        answers: [
          { description: "You define a factory using the 'FactoryBot.define' method, specifying the factory name and the attributes for the model it represents, e.g., 'FactoryBot.define { factory :user { ... } }'.", correct: true, explanation: "This syntax allows for clean and clear definitions of test data." },
          { description: "Factories are defined using a YAML file, not in Ruby code.", correct: false, explanation: "Factory definitions are typically done in Ruby, not YAML." },
          { description: "FactoryBot requires factories to be defined inside the model files.", correct: false, explanation: "Factories are usually defined in a dedicated 'factories' directory." },
          { description: "Factory definitions must include an explicit database transaction each time they are called.", correct: false, explanation: "FactoryBot handles object creation without requiring explicit transactions in the definition." },
          { description: "You cannot specify default attributes for factories; they must be set explicitly each time.", correct: false, explanation: "Factories allow for default attributes to be specified." }
        ].shuffle!,
      },
      {
        description: "How can you create an instance of a user using FactoryBot?",
        answers: [
          { description: "You can create a user instance by calling 'FactoryBot.create(:user)', which creates and saves the user to the database.", correct: true, explanation: "This method generates a new user object with any default attributes defined in the factory." },
          { description: "FactoryBot cannot create instances; it can only define factories.", correct: false, explanation: "FactoryBot is designed to create instances based on defined factories." },
          { description: "You must define a new method in your model to integrate FactoryBot for instance creation.", correct: false, explanation: "FactoryBot works directly with existing models without requiring changes." },
          { description: "Instances created with FactoryBot cannot be saved to the database.", correct: false, explanation: "FactoryBot can create and persist instances in the database." },
          { description: "You need to run a separate command to create instances; they cannot be created within the test file.", correct: false, explanation: "Instances can be created directly within the test files." }
        ].shuffle!,
      },
      {
        description: "What is the main advantage of using RSpec for testing Rails applications compared to other frameworks?",
        answers: [
          { description: "RSpec provides a DSL (Domain Specific Language) that allows for writing clear, descriptive tests that closely resemble natural language, making them more accessible to developers and stakeholders.", correct: true, explanation: "This clarity promotes understanding of the application's behavior." },
          { description: "RSpec is the only testing framework that supports mocking and stubbing effectively.", correct: false, explanation: "While RSpec has powerful mocking and stubbing capabilities, other frameworks can support these features too." },
          { description: "RSpec tests can only be written for models; they cannot test controllers or views.", correct: false, explanation: "RSpec can be used to test all components of a Rails application." },
          { description: "Using RSpec is mandatory in Rails applications, and developers cannot use any other testing frameworks.", correct: false, explanation: "Rails supports multiple testing frameworks, and developers can choose based on their preferences." },
          { description: "RSpec cannot handle asynchronous tests effectively, making it less useful for modern applications.", correct: false, explanation: "RSpec supports various testing scenarios, including asynchronous testing." }
        ].shuffle!,
      }
    ],

    "API Integration" => [
      {
        description: "What is the primary purpose of integrating APIs in a Rails application?",
        answers: [
          { description: "To enable communication between different systems or applications, allowing data exchange and functionality sharing.", correct: true, explanation: "APIs facilitate integration, enabling various systems to work together." },
          { description: "To replace the need for a database entirely in a Rails application.", correct: false, explanation: "APIs do not replace databases; they can interact with them but serve a different purpose." },
          { description: "To make the application solely dependent on third-party services, eliminating local processing.", correct: false, explanation: "APIs allow for integration but do not require complete dependency on external services." },
          { description: "To improve the user interface by adding more complex visual elements to the application.", correct: false, explanation: "APIs focus on data and functionality rather than UI enhancements." },
          { description: "To ensure that all application components are written in the same programming language.", correct: false, explanation: "APIs can facilitate integration between different programming languages." }
        ].shuffle!,
      },
      {
        description: "Which gem is commonly used in Rails applications for making HTTP requests to external APIs?",
        answers: [
          { description: "HTTParty is a popular gem for making HTTP requests in a simple and straightforward manner.", correct: true, explanation: "HTTParty simplifies the process of sending HTTP requests." },
          { description: "Devise is used for user authentication and does not handle HTTP requests.", correct: false, explanation: "Devise is focused on authentication and authorization, not API requests." },
          { description: "Pundit is primarily for authorization and cannot be used for making HTTP requests.", correct: false, explanation: "Pundit does not interact with HTTP requests or external APIs." },
          { description: "ActiveRecord is used for database interactions, not for making HTTP requests.", correct: false, explanation: "ActiveRecord handles database interactions, not API requests." },
          { description: "FactoryBot is for creating test data and cannot be used for making API calls.", correct: false, explanation: "FactoryBot is focused on test data generation, not API integration." }
        ].shuffle!,
      },
      {
        description: "What is the function of the 'serialize' method in Rails when working with APIs?",
        answers: [
          { description: "The 'serialize' method converts a Ruby object into a format suitable for transmission over the network, commonly JSON or XML.", correct: true, explanation: "Serialization is essential for API communication, allowing data to be easily shared." },
          { description: "The 'serialize' method is used to save data directly to the database without needing to validate it.", correct: false, explanation: "'serialize' focuses on data formatting, not database persistence." },
          { description: "The 'serialize' method encrypts data before sending it over the network to enhance security.", correct: false, explanation: "Serialization formats data but does not inherently provide encryption." },
          { description: "The 'serialize' method is used to render views in Rails applications.", correct: false, explanation: "It does not relate to view rendering." },
          { description: "The 'serialize' method creates a backup of data in a file format.", correct: false, explanation: "'serialize' is for formatting data, not for creating backups." }
        ].shuffle!,
      },
      {
        description: "Which HTTP method is typically used to retrieve data from an API?",
        answers: [
          { description: "The GET method is used to request data from a specified resource.", correct: true, explanation: "GET requests are designed for data retrieval." },
          { description: "The POST method is used exclusively for updating existing data on the server.", correct: false, explanation: "POST is generally for creating new data." },
          { description: "The PUT method is only used for deleting resources from the server.", correct: false, explanation: "PUT is used for updating resources, while DELETE is for removing them." },
          { description: "The PATCH method is used for retrieving data from the server.", correct: false, explanation: "PATCH is used to partially update existing resources." },
          { description: "The OPTIONS method is for posting new data to the server.", correct: false, explanation: "OPTIONS is used to describe the communication options for the target resource." }
        ].shuffle!,
      },
      {
        description: "How can you handle API authentication in a Rails application?",
        answers: [
          { description: "API authentication can be managed using tokens, where clients send a token with each request to verify their identity.", correct: true, explanation: "Token-based authentication is a common approach for APIs." },
          { description: "API authentication can only be done using session cookies, similar to traditional web applications.", correct: false, explanation: "While session cookies are used in web apps, APIs typically use tokens for stateless authentication." },
          { description: "API authentication is not necessary if the application is public and does not require user data.", correct: false, explanation: "Even public APIs often have some form of access control." },
          { description: "API authentication is managed exclusively on the client-side, with no server-side validation.", correct: false, explanation: "Server-side validation is essential for ensuring the integrity of API requests." },
          { description: "API authentication can only be achieved by storing user passwords in the API request.", correct: false, explanation: "Passwords should never be transmitted in requests; use secure tokens instead." }
        ].shuffle!,
      }
    ],

    "Action Mailer" => [
      {
        description: "What is the main purpose of Action Mailer in a Rails application?",
        answers: [
          { description: "Action Mailer is a framework for sending and receiving emails from a Rails application, enabling features like HTML emails and attachments.", correct: true, explanation: "It simplifies the process of managing emails in Rails." },
          { description: "Action Mailer is used exclusively for sending text messages and cannot handle emails.", correct: false, explanation: "Action Mailer is specifically designed for email functionality." },
          { description: "Action Mailer replaces the need for a front-end framework in a Rails application.", correct: false, explanation: "Action Mailer is focused on email management, not front-end functionality." },
          { description: "Action Mailer is only used for sending promotional emails and cannot handle user notifications.", correct: false, explanation: "It can handle various email types, including notifications." },
          { description: "Action Mailer requires a separate server to send emails, which complicates its implementation.", correct: false, explanation: "While an SMTP server is needed, Action Mailer simplifies the process of configuring email delivery." }
        ].shuffle!,
      },
      {
        description: "How do you define a mailer class in Rails?",
        answers: [
          { description: "You define a mailer class by creating a new Ruby class that inherits from 'ApplicationMailer' and defining methods for each type of email you want to send.", correct: true, explanation: "This structure allows for organized email management." },
          { description: "Mailer classes must be defined in the same file as the models they send emails for.", correct: false, explanation: "Mailer classes can be defined in separate files for better organization." },
          { description: "A mailer class must include a module named 'EmailSender' to function properly.", correct: false, explanation: "No specific module is required; inheritance from 'ApplicationMailer' is sufficient." },
          { description: "Mailer classes cannot have instance methods; they must be defined as class methods only.", correct: false, explanation: "Mailer classes can have both class and instance methods." },
          { description: "You must define a mailer class for each type of email you want to send, even if they share similar content.", correct: false, explanation: "You can reuse mailer classes with different parameters for similar emails." }
        ].shuffle!,
      },
      {
        description: "What command do you use to generate a new mailer in a Rails application?",
        answers: [
          { description: "You use the command 'rails generate mailer MailerName' to create a new mailer.", correct: true, explanation: "This command scaffolds a new mailer with the necessary files." },
          { description: "You cannot generate mailers using the Rails command line; they must be created manually.", correct: false, explanation: "Rails provides generators to streamline mailer creation." },
          { description: "The command for generating a mailer is 'rails create mailer MailerName'.", correct: false, explanation: "The correct command uses 'generate', not 'create'." },
          { description: "You must provide a template file along with the mailer name when generating it.", correct: false, explanation: "You can define templates separately after generating the mailer." },
          { description: "Generating a mailer automatically sends a test email.", correct: false, explanation: "Generating a mailer only creates the necessary files; it does not send any emails." }
        ].shuffle!,
      },
      {
        description: "How can you send an email using Action Mailer?",
        answers: [
          { description: "You can send an email by calling the mailer method followed by 'deliver_now' or 'deliver_later', e.g., 'UserMailer.welcome_email(user).deliver_now'.", correct: true, explanation: "This syntax executes the email sending process." },
          { description: "You must use 'send_email' as the method to dispatch emails in Action Mailer.", correct: false, explanation: "'send_email' is not a method in Action Mailer; use the defined mailer method." },
          { description: "Emails can only be sent during the Rails application initialization process.", correct: false, explanation: "Emails can be sent at any point after the application has started." },
          { description: "You cannot send emails asynchronously with Action Mailer.", correct: false, explanation: "'deliver_later' allows for asynchronous email sending." },
          { description: "Emails are sent automatically when a user registers without explicit calls to Action Mailer.", correct: false, explanation: "Explicit calls to mailer methods are required to send emails." }
        ].shuffle!,
      },
      {
        description: "What configuration is needed to set up SMTP for Action Mailer?",
        answers: [
          { description: "You need to configure the SMTP settings in 'config/environments/development.rb' or 'production.rb', specifying the address, port, user name, and password.", correct: true, explanation: "This setup allows Action Mailer to connect to the SMTP server for sending emails." },
          { description: "SMTP configuration is handled automatically by Action Mailer without any user input.", correct: false, explanation: "You must provide SMTP settings for Action Mailer to function." },
          { description: "You can only use Action Mailer with built-in mail servers; external SMTP servers are not supported.", correct: false, explanation: "Action Mailer supports external SMTP servers." },
          { description: "SMTP settings must be defined within the mailer class itself.", correct: false, explanation: "SMTP settings are defined in the environment configuration files." },
          { description: "You must create a separate initializer file specifically for SMTP settings when using Action Mailer.", correct: false, explanation: "You can define SMTP settings directly in the environment configurations." }
        ].shuffle!,
      }
    ],

    "Active Job and Background Jobs" => [
    {
      description: "What is the primary purpose of Active Job in a Rails application?",
      answers: [
        { description: "Active Job provides a framework for declaring jobs and making them run on a variety of queueing backends, facilitating background processing.", correct: true, explanation: "It standardizes job processing across different queuing systems." },
        { description: "Active Job is exclusively for scheduling tasks to run at specific times without user interaction.", correct: false, explanation: "Active Job handles background processing, not just scheduled tasks." },
        { description: "Active Job is used to manage database transactions in Rails applications.", correct: false, explanation: "Active Job focuses on job processing, not database management." },
        { description: "Active Job requires a separate server for all job processing to occur.", correct: false, explanation: "While a server may be necessary for background jobs, Active Job can run in the same application environment." },
        { description: "Active Job is a front-end library used for creating user interfaces in Rails applications.", correct: false, explanation: "Active Job is focused on background job management, not front-end development." }
      ].shuffle!,
    },
    {
      description: "Which of the following is a common use case for background jobs in Rails applications?",
      answers: [
        { description: "Sending confirmation emails after user registration is a common use case for background jobs, ensuring timely delivery without blocking the main application thread.", correct: true, explanation: "Background jobs allow for asynchronous processing, improving user experience." },
        { description: "Loading the homepage of a web application must be done through background jobs to improve speed.", correct: false, explanation: "Background jobs are not needed for rendering views, which should be done synchronously." },
        { description: "Updating the layout of a page should be done using background jobs to ensure a responsive design.", correct: false, explanation: "UI updates should be handled on the front end, not as background jobs." },
        { description: "Background jobs are used exclusively for processing payments and cannot be used for other tasks.", correct: false, explanation: "Background jobs can handle a variety of tasks, not just payment processing." },
        { description: "Real-time notifications can only be sent using synchronous processes, not background jobs.", correct: false, explanation: "Background jobs can be used for tasks like sending notifications, allowing the main process to continue." }
      ].shuffle!,
    },
    {
      description: "How do you define a background job in a Rails application using Active Job?",
      answers: [
        { description: "You define a background job by creating a new Ruby class that inherits from 'ApplicationJob' and defining a 'perform' method to specify the job's behavior.", correct: true, explanation: "This structure is essential for defining background jobs in Rails." },
        { description: "Background jobs must be defined in the same file as the controller that initiates them.", correct: false, explanation: "Background jobs can be organized in separate files for better code management." },
        { description: "You must define a job as a module and include it in other classes to function properly.", correct: false, explanation: "Inheritance from 'ApplicationJob' is the standard practice for defining jobs." },
        { description: "A background job cannot have instance variables or methods; it must be defined as a class method only.", correct: false, explanation: "Background jobs can include both instance and class methods." },
        { description: "You must define a background job for each specific task, even if they perform similar functions.", correct: false, explanation: "You can reuse job classes for similar tasks by passing different parameters." }
      ].shuffle!,
    },
    {
      description: "Which command is used to enqueue a job in a Rails application?",
      answers: [
        { description: "You can enqueue a job by calling the 'perform_later' method on the job class, e.g., 'UserMailer.welcome_email(user).deliver_later'.", correct: true, explanation: "'perform_later' schedules the job to be executed later." },
        { description: "To enqueue a job, use the command 'enqueue JobName' directly in the Rails console.", correct: false, explanation: "'enqueue' is not a valid command in Active Job." },
        { description: "You must always use the 'perform_now' method to schedule jobs in Rails applications.", correct: false, explanation: "'perform_now' executes the job immediately, rather than enqueuing it." },
        { description: "Jobs can only be enqueued using Rake tasks and cannot be called directly from the application code.", correct: false, explanation: "Jobs can be enqueued directly within application code." },
        { description: "You must create a separate queue for each job type when enqueuing jobs.", correct: false, explanation: "Active Job supports using the same queue for different job types." }
      ].shuffle!,
    },
    {
      description: "What is the role of a queue adapter in Active Job?",
      answers: [
        { description: "A queue adapter determines how jobs are enqueued and processed, specifying the underlying system used for job management (e.g., Sidekiq, Resque).", correct: true, explanation: "Queue adapters provide the mechanism for job execution." },
        { description: "A queue adapter manages the user interface of the application, ensuring that users can easily schedule jobs.", correct: false, explanation: "Queue adapters handle backend processing, not UI management." },
        { description: "A queue adapter is responsible for handling errors during job execution, ensuring jobs are retried if they fail.", correct: false, explanation: "While some queue adapters provide error handling features, their primary role is job management." },
        { description: "A queue adapter is required for all background jobs, regardless of the application's architecture.", correct: false, explanation: "While most applications use queue adapters, it is not a strict requirement for all jobs." },
        { description: "A queue adapter determines the logging format for job execution in the Rails application.", correct: false, explanation: "Logging is managed separately from the queue adapter." }
      ].shuffle!,
    }
    ],

    "WebSockets and ActionCable" => [
      {
        description: "What is the primary purpose of ActionCable in a Rails application?",
        answers: [
          { description: "ActionCable integrates WebSockets into Rails, allowing for real-time features like notifications and chat.", correct: true, explanation: "It enables real-time communication between the server and clients." },
          { description: "ActionCable is used exclusively for managing RESTful API calls in Rails applications.", correct: false, explanation: "ActionCable is focused on WebSockets, not RESTful APIs." },
          { description: "ActionCable provides a way to manage file uploads asynchronously without user intervention.", correct: false, explanation: "While it enables real-time features, file uploads are managed separately." },
          { description: "ActionCable requires a separate Ruby server to handle WebSocket connections.", correct: false, explanation: "ActionCable runs within the Rails application environment." },
          { description: "ActionCable is primarily for creating static HTML pages in Rails applications.", correct: false, explanation: "It is focused on real-time features, not static content generation." }
        ].shuffle!,
      },
      {
        description: "How do you create a channel in ActionCable?",
        answers: [
          { description: "You create a channel by generating a new channel class using 'rails generate channel ChannelName', then defining methods to handle subscriptions and messages.", correct: true, explanation: "This command sets up the necessary structure for a channel." },
          { description: "Channels can only be created by manually writing all the necessary boilerplate code without any generators.", correct: false, explanation: "Rails provides generators to simplify channel creation." },
          { description: "You must define a channel as a module within the application controller.", correct: false, explanation: "Channels are defined as classes, not modules." },
          { description: "A channel cannot have multiple subscribers; it can only handle one user at a time.", correct: false, explanation: "Channels can handle multiple subscribers simultaneously." },
          { description: "You need to create a separate file for each user subscribing to a channel.", correct: false, explanation: "All users can subscribe to the same channel class." }
        ].shuffle!,
      },
      {
        description: "What method is used to broadcast messages to all subscribers of a channel in ActionCable?",
        answers: [
          { description: "You use the 'broadcast_to' method to send messages to all subscribers of a channel.", correct: true, explanation: "'broadcast_to' effectively sends the message to every user connected to that channel." },
          { description: "The method 'send_message' is used to deliver messages to channel subscribers.", correct: false, explanation: "'send_message' is not a valid method in ActionCable." },
          { description: "You must manually iterate over each subscriber to send individual messages.", correct: false, explanation: "ActionCable handles broadcasting to all subscribers automatically." },
          { description: "Messages can only be sent through ActionCable when the server starts, not while the application is running.", correct: false, explanation: "Messages can be sent at any time while the application is running." },
          { description: "The method 'push_to_channel' is required to send messages to subscribers.", correct: false, explanation: "'push_to_channel' is not a valid method in ActionCable." }
        ].shuffle!,
      },
      {
        description: "Which of the following is true about WebSockets in the context of ActionCable?",
        answers: [
          { description: "WebSockets provide a full-duplex communication channel, enabling real-time data exchange between clients and the server.", correct: true, explanation: "This allows for instant communication without polling." },
          { description: "WebSockets can only be used for text-based communication, not binary data.", correct: false, explanation: "WebSockets support both text and binary data transmission." },
          { description: "WebSockets require constant HTTP requests to maintain a connection.", correct: false, explanation: "Once established, WebSockets maintain an open connection without needing constant HTTP requests." },
          { description: "WebSockets are limited to one-on-one communication and cannot handle group messages.", correct: false, explanation: "WebSockets can facilitate group communication through channels." },
          { description: "WebSockets can only operate over HTTP/1.1 and not with HTTP/2 or HTTP/3.", correct: false, explanation: "WebSockets can work over both HTTP/1.1 and newer versions." }
        ].shuffle!,
      },
      {
        description: "What configuration is needed to enable ActionCable in a Rails application?",
        answers: [
          { description: "You need to define the ActionCable URL in 'config/cable.yml' and mount it in the routes file.", correct: true, explanation: "This configuration sets up ActionCable in your application." },
          { description: "ActionCable is enabled by default and requires no additional configuration.", correct: false, explanation: "You must define the configuration explicitly." },
          { description: "You must install a separate gem to enable ActionCable functionality.", correct: false, explanation: "ActionCable is built into Rails and does not require external gems." },
          { description: "ActionCable can only be configured in the production environment, not in development.", correct: false, explanation: "You can configure ActionCable in any environment." },
          { description: "You need to set up a dedicated WebSocket server to use ActionCable.", correct: false, explanation: "ActionCable runs on the existing Rails server." }
        ].shuffle!,
      }
    ],

    "Deploying Rails Applications" => [
    {
      description: "What is a common step when deploying a Rails application to a production environment?",
      answers: [
        { description: "Running database migrations using 'rails db:migrate RAILS_ENV=production' to ensure the production database is up-to-date.", correct: true, explanation: "Migrations are essential to apply database schema changes in production." },
        { description: "Compiling assets using 'rails assets:clean' to remove old assets before deployment.", correct: false, explanation: "'rails assets:clean' removes old assets but doesn't compile them; you need 'rails assets:precompile'." },
        { description: "Using the command 'rails deploy' to automatically deploy the application.", correct: false, explanation: "'rails deploy' is not a valid command; deployment typically requires manual configuration." },
        { description: "Disabling all logging to improve application performance in production.", correct: false, explanation: "Logging is crucial for monitoring and debugging in production." },
        { description: "Uploading the application files directly to the server via FTP without using a deployment tool.", correct: false, explanation: "Direct uploads via FTP are not recommended for managing deployments." }
      ].shuffle!,
    },
    {
      description: "Which tool is commonly used for automating the deployment of Rails applications?",
      answers: [
        { description: "Capistrano is widely used to automate the deployment process for Rails applications, allowing for easy rollbacks and task execution.", correct: true, explanation: "Capistrano provides a robust framework for deploying applications." },
        { description: "Bundler is the primary tool for deploying Rails applications to production.", correct: false, explanation: "Bundler manages gems but does not handle deployment." },
        { description: "Rake is the standard tool for deploying Rails applications directly from the command line.", correct: false, explanation: "Rake is used for task management, not for deployment." },
        { description: "Puma is a deployment tool specifically designed for Rails applications.", correct: false, explanation: "Puma is a web server, not a deployment tool." },
        { description: "Heroku is a local tool for deploying Rails applications on your personal machine.", correct: false, explanation: "Heroku is a cloud platform for deploying applications, not a local tool." }
      ].shuffle!,
    },
    {
      description: "What command is used to precompile assets for a Rails application before deployment?",
      answers: [
        { description: "The command 'rails assets:precompile' is used to compile all the asset files into a single directory for production use.", correct: true, explanation: "Precompiling assets improves performance in production." },
        { description: "You use 'rails assets:compile' to precompile assets before deploying.", correct: false, explanation: "'rails assets:compile' is not a valid command." },
        { description: "Assets are automatically compiled during the deployment process and do not require a separate command.", correct: false, explanation: "You must precompile assets before deployment to ensure they are ready." },
        { description: "Running 'rails server' automatically compiles assets for deployment.", correct: false, explanation: "'rails server' starts the development server but does not precompile assets." },
        { description: "The command 'rails deploy:assets' is used to handle asset compilation.", correct: false, explanation: "'rails deploy:assets' is not a recognized command in Rails." }
      ].shuffle!,
    },
    {
      description: "What is the purpose of using a reverse proxy like Nginx in front of a Rails application?",
      answers: [
        { description: "Nginx serves as a reverse proxy to handle incoming HTTP requests and forward them to the Rails application, improving performance and providing SSL termination.", correct: true, explanation: "It enhances performance and security for web applications." },
        { description: "Nginx is used to compile Ruby code before it runs in the Rails application.", correct: false, explanation: "Nginx does not compile code; it serves static files and proxies requests." },
        { description: "A reverse proxy like Nginx is unnecessary for Rails applications because Rails can handle all HTTP requests directly.", correct: false, explanation: "While Rails can handle requests, a reverse proxy offers benefits like load balancing and caching." },
        { description: "Nginx must be configured to run as a full application server instead of just a proxy.", correct: false, explanation: "Nginx is designed to act as a reverse proxy and is not a full application server." },
        { description: "Using Nginx is only beneficial for applications with high traffic and is not needed for small-scale applications.", correct: false, explanation: "Nginx can benefit applications of all sizes by improving request handling." }
      ].shuffle!,
    },
    {
      description: "When deploying a Rails application, why is it important to set environment variables?",
      answers: [
        { description: "Environment variables store sensitive information like API keys and database credentials securely without hardcoding them in the application code.", correct: true, explanation: "This practice enhances security and flexibility." },
        { description: "Environment variables are unnecessary for production environments and can be hardcoded instead.", correct: false, explanation: "Hardcoding sensitive information is a security risk." },
        { description: "Setting environment variables allows for automatic testing of the application in production.", correct: false, explanation: "While environment variables can be used in testing, they primarily secure sensitive data." },
        { description: "Environment variables are used to store static assets for the application.", correct: false, explanation: "Static assets are managed separately from environment variables." },
        { description: "You can only use environment variables with Docker and cannot use them in traditional Rails deployments.", correct: false, explanation: "Environment variables can be used in various deployment setups, not just Docker." }
      ].shuffle!,
    }
    ],

    "Security in Rails" => [
      {
        description: "What is the purpose of the 'strong parameters' feature in Rails?",
        answers: [
          { description: "Strong parameters are used to prevent mass assignment vulnerabilities by requiring explicit whitelisting of parameters in controllers.", correct: true, explanation: "This enhances security by controlling which parameters can be mass-assigned." },
          { description: "Strong parameters are designed to automatically validate all incoming data from forms.", correct: false, explanation: "Strong parameters do not perform validation; they control parameter assignment." },
          { description: "They are used to encrypt sensitive data before it is saved to the database.", correct: false, explanation: "Strong parameters do not provide encryption features." },
          { description: "Strong parameters automatically sanitize user input to prevent XSS attacks.", correct: false, explanation: "While they help with mass assignment, sanitization must be handled separately." },
          { description: "Strong parameters can only be used with Rails models and not in controllers.", correct: false, explanation: "They are specifically a controller feature." }
        ].shuffle!,
      },
      {
        description: "Which of the following is a best practice for securing a Rails application?",
        answers: [
          { description: "Regularly updating Rails and its dependencies to address security vulnerabilities and using a tool like Bundler Audit to check for known issues.", correct: true, explanation: "Keeping dependencies updated is crucial for security." },
          { description: "Using plain text for sensitive information in the application's source code.", correct: false, explanation: "Sensitive information should never be hardcoded in source code." },
          { description: "Allowing users to create passwords without any complexity requirements to enhance user experience.", correct: false, explanation: "Weak passwords can compromise security; enforcing complexity is essential." },
          { description: "Disabling all security features in Rails to improve performance.", correct: false, explanation: "Disabling security features significantly increases vulnerability." },
          { description: "Using the same API key across all environments for simplicity.", correct: false, explanation: "API keys should be environment-specific to enhance security." }
        ].shuffle!,
      },
      {
        description: "What is Cross-Site Scripting (XSS) and how can it be prevented in Rails?",
        answers: [
          { description: "XSS is a vulnerability that allows attackers to inject malicious scripts into web pages. It can be prevented by using built-in helpers like 'sanitize' and escaping user input.", correct: true, explanation: "Rails provides methods to protect against XSS." },
          { description: "XSS only occurs in applications that do not use HTTPS, and switching to HTTPS is the only solution.", correct: false, explanation: "XSS can occur regardless of HTTPS; proper input handling is needed." },
          { description: "To prevent XSS, all user input should be entirely removed from the application.", correct: false, explanation: "User input can be safely displayed if properly sanitized or escaped." },
          { description: "XSS attacks are mitigated by disabling JavaScript on all web pages.", correct: false, explanation: "Disabling JavaScript does not address the root cause of XSS vulnerabilities." },
          { description: "Rails automatically prevents all XSS attacks, so developers do not need to take any additional precautions.", correct: false, explanation: "Developers must implement measures to safeguard against XSS." }
        ].shuffle!,
      },
      {
        description: "How can you secure sensitive data in a Rails application?",
        answers: [
          { description: "By using Rails' built-in encryption mechanisms, such as ActiveSupport::MessageEncryptor, to encrypt sensitive information before storage.", correct: true, explanation: "Encryption protects sensitive data at rest." },
          { description: "Storing sensitive data in plain text to ensure easy access by developers.", correct: false, explanation: "Plain text storage is a significant security risk." },
          { description: "Only using environment variables for sensitive data storage without any encryption.", correct: false, explanation: "Environment variables should complement, not replace, encryption for sensitive data." },
          { description: "Logging sensitive data to track user activity for security audits.", correct: false, explanation: "Logging sensitive information can expose it and should be avoided." },
          { description: "Making sensitive data accessible to all users for convenience.", correct: false, explanation: "Access to sensitive data should be restricted." }
        ].shuffle!,
      },
      {
        description: "What is SQL Injection, and how can it be mitigated in a Rails application?",
        answers: [
          { description: "SQL Injection is an attack that allows an attacker to execute arbitrary SQL code in the database. It can be mitigated by using ActiveRecord query methods and prepared statements to prevent user input from directly affecting SQL queries.", correct: true, explanation: "Rails uses parameterized queries to protect against SQL Injection." },
          { description: "SQL Injection only occurs in applications that do not use a web framework like Rails.", correct: false, explanation: "SQL Injection can affect any application that interacts with a database." },
          { description: "The best way to prevent SQL Injection is to avoid using databases altogether.", correct: false, explanation: "Databases are essential, but security measures should be implemented." },
          { description: "SQL Injection attacks can be entirely prevented by using only the 'find' method in ActiveRecord.", correct: false, explanation: "'find' does not prevent SQL Injection; proper query practices must be followed." },
          { description: "Using raw SQL queries is the safest way to interact with the database.", correct: false, explanation: "Raw SQL queries can introduce vulnerabilities if not properly handled." }
        ].shuffle!,
      }
    ],

    "Performance Optimization" => [
    {
      description: "Which of the following techniques can improve the performance of a Rails application?",
      answers: [
        { description: "Using caching strategies like fragment caching, action caching, and low-level caching to reduce the load on the database.", correct: true, explanation: "Caching reduces the need to regenerate content for every request." },
        { description: "Always avoiding the use of database indexes to simplify the database structure.", correct: false, explanation: "Database indexes are crucial for improving query performance." },
        { description: "Writing complex SQL queries without using ActiveRecord to optimize performance.", correct: false, explanation: "While raw SQL can be faster, it compromises maintainability and security." },
        { description: "Increasing the number of database connections to handle more concurrent users.", correct: false, explanation: "Too many connections can overwhelm the database and degrade performance." },
        { description: "Disabling all logging in production to improve performance.", correct: false, explanation: "While logging can be controlled, completely disabling it can hinder debugging." }
      ].shuffle!,
    },
    {
      description: "What is the benefit of using a Content Delivery Network (CDN) with a Rails application?",
      answers: [
        { description: "A CDN distributes static assets across multiple servers, reducing latency and improving load times for users globally.", correct: true, explanation: "CDNs enhance performance by delivering content from the nearest server." },
        { description: "CDNs are only useful for dynamic content and have no impact on static assets.", correct: false, explanation: "CDNs are primarily designed to optimize the delivery of static assets." },
        { description: "Using a CDN increases the size of the assets, making them slower to download.", correct: false, explanation: "CDNs aim to decrease the size of the payload and improve delivery speed." },
        { description: "A CDN can eliminate the need for any server-side logic in a Rails application.", correct: false, explanation: "CDNs assist with asset delivery but do not replace server-side logic." },
        { description: "CDNs only benefit applications with high traffic and are not needed for small-scale applications.", correct: false, explanation: "CDNs can benefit any application by enhancing asset delivery speed." }
      ].shuffle!,
    },
    {
      description: "Which Rails feature can be used to avoid N+1 query problems?",
      answers: [
        { description: "Using the 'includes' method in ActiveRecord queries to eager load associations, thereby reducing the number of database queries.", correct: true, explanation: "Eager loading helps prevent N+1 query issues by loading associated records in a single query." },
        { description: "Always using the 'find' method for loading records instead of querying associations.", correct: false, explanation: "Using 'find' does not address N+1 issues; eager loading is required." },
        { description: "Limiting the number of records returned from the database to reduce load time.", correct: false, explanation: "While limiting records can help, it does not prevent N+1 queries." },
        { description: "Using raw SQL queries instead of ActiveRecord to load all data in one go.", correct: false, explanation: "Raw SQL can bypass the ORM benefits, but it does not inherently prevent N+1 queries." },
        { description: "Caching all queries to speed up database access regardless of how data is loaded.", correct: false, explanation: "Caching is helpful, but it does not solve the N+1 problem." }
      ].shuffle!,
    },
    {
      description: "How can background jobs improve the performance of a Rails application?",
      answers: [
        { description: "By offloading time-consuming tasks, such as sending emails or processing files, to background workers, thereby freeing up web server resources for handling requests.", correct: true, explanation: "Background jobs allow the application to respond faster to user requests." },
        { description: "Background jobs always run in the same thread as web requests to ensure faster execution.", correct: false, explanation: "Background jobs run in separate processes to avoid blocking the main application thread." },
        { description: "Using background jobs requires more server resources, which can slow down the application.", correct: false, explanation: "While background jobs use resources, they enhance performance by freeing up the web process." },
        { description: "All tasks must be completed synchronously in Rails; background jobs are not recommended.", correct: false, explanation: "Rails supports asynchronous processing through background jobs for better performance." },
        { description: "Background jobs increase the complexity of the application without providing any real benefits.", correct: false, explanation: "Background jobs improve responsiveness and user experience by processing tasks asynchronously." }
      ].shuffle!,
    },
    {
      description: "What is the purpose of using the 'rack-mini-profiler' gem in a Rails application?",
      answers: [
        { description: "The 'rack-mini-profiler' gem helps to profile and monitor the performance of a Rails application, identifying slow queries and rendering times.", correct: true, explanation: "This tool provides insights to optimize performance." },
        { description: "It is used for caching views in a Rails application.", correct: false, explanation: "'rack-mini-profiler' is for profiling, not caching." },
        { description: "The gem encrypts sensitive data in Rails applications for security purposes.", correct: false, explanation: "The gem does not provide encryption features." },
        { description: "Using 'rack-mini-profiler' increases the overall load time of the application significantly.", correct: false, explanation: "While it adds some overhead, the insights gained can lead to performance improvements." },
        { description: "The gem replaces the need for unit tests in a Rails application.", correct: false, explanation: "The gem is for profiling, not for testing." }
      ].shuffle!,
    }
  ],

    "Internationalization (i18n) in Rails" => [
    {
      description: "What is the purpose of the i18n (internationalization) feature in Rails?",
      answers: [
        { description: "i18n allows developers to build applications that support multiple languages and locales, making it easier to adapt the application for different regions.", correct: true, explanation: "Internationalization is crucial for reaching a global audience." },
        { description: "i18n is used solely for formatting dates and times in the application.", correct: false, explanation: "i18n encompasses much more than just date and time formatting." },
        { description: "It requires developers to write different code for each language supported.", correct: false, explanation: "i18n allows the same codebase to support multiple languages through translations." },
        { description: "i18n is only useful for applications targeting a local audience.", correct: false, explanation: "i18n is essential for any application that may serve international users." },
        { description: "The i18n feature only affects the user interface and does not impact backend processes.", correct: false, explanation: "i18n can impact both frontend and backend aspects of the application." }
      ].shuffle!,
    },
    {
      description: "How can you define translations for different locales in a Rails application?",
      answers: [
        { description: "Translations are defined in YAML files located in the 'config/locales' directory, with separate files for each locale.", correct: true, explanation: "YAML files are the standard way to store translations in Rails." },
        { description: "Translations must be hardcoded directly into the view templates.", correct: false, explanation: "Hardcoding translations in views is not a good practice; use YAML files instead." },
        { description: "All translations are stored in the database and fetched dynamically during runtime.", correct: false, explanation: "While dynamic fetching is possible, YAML files are the preferred method for static translations." },
        { description: "The Rails application automatically generates translations for all available locales.", correct: false, explanation: "Translations must be manually defined by developers." },
        { description: "You can define translations in Ruby files instead of YAML for better performance.", correct: false, explanation: "YAML files are the standard format for i18n in Rails." }
      ].shuffle!,
    },
    {
      description: "What method is used to retrieve translations in Rails views?",
      answers: [
        { description: "The 't' (translate) method is used to retrieve translations for specific keys defined in the locale files.", correct: true, explanation: "Using 't' provides a simple way to access translations." },
        { description: "You use 'translate' method instead of 't' for fetching translations.", correct: false, explanation: "'translate' is an alias for 't', but 't' is the preferred shorthand." },
        { description: "Translations are accessed through direct database queries in Rails.", correct: false, explanation: "Translations are defined in locale files, not in the database." },
        { description: "You must use the 'localize' method to get translations in views.", correct: false, explanation: "'localize' is used for formatting data, not for retrieving translations." },
        { description: "You can use plain Ruby strings to fetch translations without any method.", correct: false, explanation: "You must use the appropriate method to retrieve translations." }
      ].shuffle!,
    },
    {
      description: "Which of the following is a key benefit of using the i18n feature in Rails?",
      answers: [
        { description: "It simplifies the process of adding support for multiple languages, allowing for a more global user base.", correct: true, explanation: "i18n streamlines language support, enhancing usability for diverse audiences." },
        { description: "i18n eliminates the need for a database entirely in a Rails application.", correct: false, explanation: "i18n does not affect the necessity of a database; it only helps with translations." },
        { description: "It automatically translates content into all available languages without developer input.", correct: false, explanation: "i18n provides tools for developers to define translations, but it does not perform automatic translations." },
        { description: "Using i18n slows down the application significantly due to added complexity.", correct: false, explanation: "i18n can introduce complexity, but it does not inherently slow down the application." },
        { description: "i18n restricts the application to a single language and does not support multilingual capabilities.", correct: false, explanation: "i18n is designed to support multiple languages, not restrict them." }
      ].shuffle!,
    },
    {
      description: "How can you change the application's locale dynamically in a Rails application?",
      answers: [
        { description: "You can set the locale by modifying the 'I18n.locale' variable in a controller or a before_action filter based on user preferences.", correct: true, explanation: "Dynamically changing the locale enhances user experience." },
        { description: "You cannot change the locale once the application starts; it must be set in the configuration file.", correct: false, explanation: "The locale can be changed at runtime based on user preferences." },
        { description: "Rails applications can only support one static locale that cannot be changed.", correct: false, explanation: "Rails supports dynamic locale changes." },
        { description: "You must restart the Rails server to apply any locale changes.", correct: false, explanation: "Locale changes take effect immediately when modified in the application." },
        { description: "Changing the locale requires direct modifications to the locale files in production.", correct: false, explanation: "Locale changes can be made in memory without modifying files." }
      ].shuffle!,
    }
    ]



    }

    questions_data.each do |subject_description, questions|
      subject = Subject.find_by(description: subject_description)
      next unless subject

      questions.each do |question_data|
        question = Question.create!(description: question_data[:description], subject: subject)
        question_data[:answers].each do |answer_data|
          Answer.create!(description: answer_data[:description], correct: answer_data[:correct], explanation: answer_data[:explanation], question: question)
        end
      end
    end
  end

  def show_spinner(task_name)
    spinner = TTY::Spinner.new("[:spinner] #{task_name}")
    spinner.auto_spin
    yield
    spinner.success
  end
end
