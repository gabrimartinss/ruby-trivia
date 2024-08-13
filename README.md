# Ruby Trivia Application

## Overview

This is a **Ruby on Rails 7** application designed originally for ruby on rails trivia quizzes, running in a Dockerized environment. This application includes a basic admin panel and functionality to handle trivia questions and answers.

## Setup Instructions

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed on your machine
- [Docker Compose](https://docs.docker.com/compose/install/) installed

### Getting Started

1. **Clone the Repository**

   ```bash
   git clone <repository-url>
   cd <repository-directory>

2. **Create and Configure the .env File**

In the root of the project directory, create a file named .env and add your default password and admin email addresses:

 ```.env
DEFAULT_PASSWORD=example123
ADMIN_EMAIL1=your_admin_email1@example.com
ADMIN_EMAIL2=your_admin_email2@example.com
 ```
Replace your_default_password and email addresses with your desired values.

### Build and Start Docker Containers

1. **Build the Docker images and start the containers using Docker Compose:**
 ```
docker-compose build
docker-compose up
 ```
Or you can use makefile
 ```
make build
make up
 ```
Access the Application

Open your web browser and navigate to http://localhost:3000 to access the application.

### Admin Panel Setup
1. **If you want to populate the database with generic data, you can use the dev:setup rake task.**

bash
```
bundle exec rails dev:setup
```
This will drop and recreate the database, run migrations, and populate it with default subjects and questions.

2. **To configure the default admin accounts, you need to run the database seeding command inside the Docker container.
Enter the Docker container's bash shell:**

bash
```
bundle exec rails db:seed
```
now you can access http://localhost:3000/admins/sign_in || localhost:3000/admins_backoffice/home/index and put your admin info

Additional Information
For more information on managing the application and making changes, refer to the Rails Guides and Docker documentation.
