# Ruby Trivia Application

## Overview

This is a **Ruby on Rails 7** application designed for trivia quizzes, running in a Dockerized environment. This application includes a basic admin panel and functionality to handle trivia questions and answers.

## Setup Instructions

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed on your machine
- [Docker Compose](https://docs.docker.com/compose/install/) installed

### Getting Started

1. **Clone the Repository**

   ```bash
   git clone <repository-url>
   cd <repository-directory>

Create and Configure the .env File

In the root of the project directory, create a file named .env and add your default password and admin email addresses:

DEFAULT_PASSWORD=your_default_password
ADMIN_EMAIL1=your_admin_email1@example.com
ADMIN_EMAIL2=your_admin_email2@example.com

Replace your_default_password and email addresses with your desired values.

Build and Start Docker Containers

Build the Docker images and start the containers using Docker Compose:

docker-compose build
docker-compose up

Access the Application

Open your web browser and navigate to http://localhost:3000 to access the application.

Admin Panel Setup
To configure the default admin accounts, you need to run the database seeding command inside the Docker container.

Access the Docker Container

Enter the Docker container's bash shell:

bash
Copiar código
docker-compose exec app bash
Run the Database Seeder

Execute the database seeding command to create the default admin accounts:

bash
Copiar código
bundle exec rails db:seed
Adding Default Data
If you want to populate the database with generic data, you can use the dev:setup rake task.

Run the Development Setup Task

Inside the Docker container, execute the following command:

bash
Copiar código
bundle exec rails dev:setup
This will drop and recreate the database, run migrations, and populate it with default subjects and questions.

Additional Information
For more information on managing the application and making changes, refer to the Rails Guides and Docker documentation.