============================================================
LIBRARY MANAGEMENT SYSTEM
ALL PROGRAMS - NOTEPAD VERSION
============================================================

TECHNOLOGY:
ReactJS + Vite
Spring Boot 3
Spring Security + JWT + BCrypt
MySQL 8
MySQL Workbench
Postman
Spring Data JPA / Hibernate
Spring @Async

============================================================
IMPORTANT
============================================================

This ZIP contains every program as a .TXT file so that it can
be opened in Windows Notepad.

The .TXT extension is only for reading/copying the program.

For running the project, use the original project ZIP or copy
each program into the correct filename and folder.

============================================================
FOLDER 01 - BACKEND JAVA
============================================================

Contains all Java programs:

LibraryApplication.java
AuthController.java
BookController.java
GlobalExceptionHandler.java
HealthController.java

BookCreateRequest.java
BookResponse.java
MemberRequest.java
TokenResponse.java

Book.java
Member.java

BookRepository.java
MemberRepository.java

CurrentMember.java
JwtAuthenticationFilter.java
JwtService.java
SecurityConfig.java

AuditService.java
BookService.java
EmbeddingService.java

============================================================
FOLDER 02 - BACKEND RESOURCES
============================================================

pom.xml
application.properties
docker-compose.yml

============================================================
FOLDER 03 - FRONTEND REACTJS
============================================================

package.json
vite.config.js
index.html

main.jsx
App.jsx
api.js
styles.css

============================================================
FOLDER 04 - MYSQL WORKBENCH
============================================================

library_database.sql

Run this SQL in MySQL Workbench:

CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

Then start Spring Boot.

============================================================
FOLDER 05 - POSTMAN
============================================================

Library_API.postman_collection.json

Import this file into Postman.

Recommended sequence:

1. Health
2. Register Member
3. Login
4. Add Book
5. Semantic Search
6. Validation tests
7. Unauthorized-access test

============================================================
FOLDER 06 - RUN COMMANDS
============================================================

BACKEND:

cd backend
mvn spring-boot:run

FRONTEND:

cd frontend
npm install
npm run dev

BACKEND URL:

http://localhost:8080

FRONTEND URL:

http://localhost:5173

HEALTH:

http://localhost:8080/api/health

============================================================
MYSQL SETTINGS
============================================================

Database:
library_db

Host:
localhost

Port:
3306

Username:
root

Password:
root

If your MySQL password is different, edit:

backend/src/main/resources/application.properties

============================================================
POSTMAN AUTHENTICATION
============================================================

Login first.

The Postman collection saves the returned JWT token in:

{{token}}

Protected APIs use:

Authorization: Bearer {{token}}

============================================================
BOOK VALIDATION
============================================================

ISBN:
Exactly 13 digits.

Example:

9781234567890

Price:
Must be greater than 0.

Published date:
Cannot be a future date.

============================================================
SECURITY
============================================================

Passwords are stored using BCrypt.

Book APIs require a valid JWT.

Without a valid JWT:

HTTP 401 Unauthorized

============================================================
BACKGROUND TASK
============================================================

When a book is added, Spring Boot starts an asynchronous
audit task.

Log file:

backend/logs/book_events.txt

============================================================
SEMANTIC SEARCH
============================================================

This MySQL implementation does not use PostgreSQL pgvector.

Book embeddings are stored in MySQL and cosine similarity is
calculated by the Spring Boot service.

============================================================
END
============================================================
