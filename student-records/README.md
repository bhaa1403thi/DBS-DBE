# Student Records Application

Complete Student Records REST API based on the supplied project-building and installation documents.

## Stack
- Java 17
- Spring Boot 3.5.6
- Spring Web
- Spring Data MongoDB
- Spring Validation
- Spring Security
- JJWT 0.11.5
- MongoDB Community Server
- VS Code
- Postman

## Project structure
```text
student-records/
├── pom.xml
├── mvnw
├── mvnw.cmd
├── .mvn/wrapper/maven-wrapper.properties
├── postman/student-records.postman_collection.json
└── src/main/
    ├── java/com/example/studentrecords/
    │   ├── StudentRecordsApplication.java
    │   ├── entity/Student.java
    │   ├── entity/User.java
    │   ├── dto/StudentRequest.java
    │   ├── dto/RegisterRequest.java
    │   ├── dto/LoginRequest.java
    │   ├── repository/StudentRepository.java
    │   ├── repository/UserRepository.java
    │   ├── service/StudentService.java
    │   ├── controller/StudentController.java
    │   ├── controller/AuthController.java
    │   ├── exception/GlobalExceptionHandler.java
    │   └── security/
    │       ├── CustomUserDetailsService.java
    │       ├── JwtUtil.java
    │       ├── JwtAuthFilter.java
    │       └── SecurityConfig.java
    └── resources/application.properties
```

## 1. Install prerequisites
Follow the supplied installation document:
1. JDK 17
2. VS Code
3. Extension Pack for Java
4. Spring Boot Extension Pack
5. MongoDB Community Server
6. MongoDB Compass (recommended)
7. Postman (recommended)

Global Maven is optional. The included Windows `mvnw.cmd` can download a project-local Maven distribution if Maven is not already installed, provided your PC has internet access.

## 2. Start MongoDB
Make sure the MongoDB Windows service is running.

Optional Compass connection:
`mongodb://localhost:27017`

## 3. Open the project
Extract `student-records.zip`.

In VS Code choose **File -> Open Folder** and select the `student-records` folder itself — the folder containing `pom.xml`.

Do NOT open only `src`.

## 4. Check Java
In VS Code Terminal:
```bat
java -version
javac -version
```
The supplied documents specify Java 17.

## 5. Run the application
From the folder containing `pom.xml`:
```bat
mvnw.cmd spring-boot:run
```

If Maven is already installed, this also works:
```bat
mvn spring-boot:run
```

The application listens on:
`http://localhost:9090`

## 6. Test with Postman
The application requires registration and login before protected student operations.

### Register
POST `http://localhost:9090/auth/register`
```json
{
  "username": "asha",
  "password": "secret123"
}
```

### Login
POST `http://localhost:9090/auth/login`
```json
{
  "username": "asha",
  "password": "secret123"
}
```

Copy the returned JWT token.

### Create student
POST `http://localhost:9090/students`
Authorization -> Bearer Token -> paste the JWT.

```json
{
  "name": "Asha Rao",
  "age": 20,
  "course": "B.Tech CSE",
  "email": "asha@example.com"
}
```

### Read all
GET `http://localhost:9090/students`

### Read one
GET `http://localhost:9090/students/{id}`

### Update
PUT `http://localhost:9090/students/{id}`
```json
{
  "name": "Asha Rao",
  "age": 21,
  "course": "B.Tech CSE",
  "email": "asha.rao@example.com"
}
```

### Delete
DELETE `http://localhost:9090/students/{id}`

All `/students` requests require the JWT Bearer token.

## 7. Import the ready Postman collection
In Postman:
- Click **Import**.
- Select `postman/student-records.postman_collection.json`.
- Run Register -> Login -> Create Student -> Get All Students -> Get Student By ID -> Update -> Delete.
- The collection is preconfigured for `http://localhost:9090`; the Login request saves the JWT and Create Student saves the new ID automatically.

The Login request stores the JWT automatically in the collection variable `token`, and Create Student stores the returned ID in `studentId`.

## 8. MongoDB result
The configured connection is:
`mongodb://localhost:27017/student_records`

MongoDB creates the database/collections when documents are first saved. After registration and student creation, Compass should show:
```text
student_records
├── users
└── students
```

## 9. Validation test
POST `/students` with:
```json
{
  "name": "",
  "age": 10,
  "course": "",
  "email": "not-an-email"
}
```

Expected result: HTTP 400 with `error` set to `VALIDATION_ERROR` and a `details` object.

## 10. If `mvnw.cmd` fails
Use:
```bat
mvn -version
```
If Maven is installed, run:
```bat
mvn spring-boot:run
```
If MongoDB connection is refused, start the MongoDB Windows service and run the application again.

## Configuration
`src/main/resources/application.properties` contains:
```properties
spring.application.name=student-records
spring.data.mongodb.uri=mongodb://localhost:27017/student_records
jwt.secret=replace-this-with-a-long-random-secret-at-least-32-characters
jwt.expiration-ms=3600000
server.port=9090
```

For a real deployment, replace the JWT secret with a securely managed secret rather than committing it to source control.
