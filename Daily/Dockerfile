----------------------- for Jave see only this -------------------------------------------------
FROM openjdk:17-alpine
WORKDIR /usr/app/
# Use the built JAR file from the target directory
COPY target/app.jar /usr/app/
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]

-------------------------For Nodejs see only this ----------------------------------------------------------
FROM node:16-slim
WORKDIR /app
# Copy dependency files
COPY package*.json ./
RUN npm install
# Copy the rest of the application code
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
---------------------------------------- this is combing of both multistage --------------------------------------
Multip 
✅ Multi-stage Dockerfile Example
Assumptions:
Frontend (Node.js app) is in frontend/

Backend (Java Spring Boot) is in backend/

After building, the frontend is placed into the backend's static/ folder (like backend/src/main/resources/static/)

You use Maven or Gradle to build the Java app (we'll use Maven for this example)

📄 Project Structure:
css
Copy
Edit
.
├── backend/
│   ├── src/
│   └── pom.xml
├── frontend/
│   ├── package.json
│   └── ...
├── Dockerfile
├── .dockerignore
🐳 Multi-stage Dockerfile (frontend + backend)
Dockerfile
Copy
Edit
# --------- Stage 1: Build Frontend ---------
FROM node:16-slim as frontend-builder
WORKDIR /app
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ ./
RUN npm run build

# --------- Stage 2: Build Backend ---------
FROM maven:3.8.7-openjdk-17-slim as backend-builder
WORKDIR /app
COPY backend/pom.xml .
COPY backend/src ./src
# Copy built frontend to backend's static directory
COPY --from=frontend-builder /app/build ./src/main/resources/static
RUN mvn clean package -DskipTests

# --------- Stage 3: Run the Application ---------
FROM openjdk:17-alpine
WORKDIR /app
COPY --from=backend-builder /app/target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]

----------------------------------------------------------------------------------------------------------------------------
------------------------------ Tomcat ----------------------
FROM tomcat:latest
RUN cp -R  /usr/local/tomcat/webapps.dist/*  /usr/local/tomcat/webapps
COPY /webapp/target/*.war /usr/local/tomcat/webapps
----------------------------------------------------------------------------------------------------------------------






















































































































-----------------------Java-------------------------------
FROM openjdk:17-alpine
        
EXPOSE 8080
 
ENV APP_HOME /usr/src/app

COPY target/*.jar $APP_HOME/app.jar

WORKDIR $APP_HOME

CMD ["java", "-jar", "app.jar"]
--------------------------------------- Multi build Stage ----------------------------------------
FROM node:16.17.0-alpine as builder
WORKDIR /app
COPY ./package.json .
COPY ./yarn.lock .
RUN yarn install
COPY . .
ARG TMDB_V3_API_KEY
ENV VITE_APP_TMDB_V3_API_KEY=${TMDB_V3_API_KEY}
ENV VITE_APP_API_ENDPOINT_URL="https://api.themoviedb.org/3"
RUN yarn build

FROM nginx:stable-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/dist .
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
------------------------------------------ Java ---------------------------------------
FROM openjdk:11

COPY target/contact-backend-app.jar  /usr/app/

WORKDIR /usr/app/

ENTRYPOINT ["java", "-jar", "contact-backend-app.jar"]

EXPOSE 8080
---------------------------------- nodejs ---------------------------------------
# Use Node.js 16 slim as the base image
FROM node:16-slim

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React app
RUN npm run build

# Expose port 3000 (or the port your app is configured to listen on)
EXPOSE 3000

# Start your Node.js server (assuming it serves the React app)  
CMD ["npm", "start"]
--------------------------------------- Nodejs --------------------------------------------
# Use Node.js Alpine base image
FROM node:alpine

# Create and set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package.json package-lock.json /app/

# Install dependencies
RUN npm install

# Copy the entire codebase to the working directory
COPY . /app/

# Expose the port your container app
EXPOSE 3000    

# Define the command to start your application (replace "start" with the actual command to start your app)
CMD ["npm", "start"]
--------------------------- Java -------------------------------
FROM openjdk:8-jdk-alpine
WORKDIR /app
COPY ./target/*.jar /app.jar
CMD ["java", "-jar", "app.jar"]
----------------------------------- Node Js ----------------------
FROM node:19-alpine3.15

WORKDIR /reddit-clone

COPY . /reddit-clone
RUN npm install 

EXPOSE 3000
CMD ["npm","run","dev"]

--------------------------- Node .Js --------------------------------------

# Use Node.js Alpine base image
FROM node:alpine

# Create and set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package.json package-lock.json /app/

# Install dependencies
RUN npm install

# Copy the entire codebase to the working directory
COPY . /app/

# Expose the port your container app
EXPOSE 3000    

# Define the command to start your application (replace "start" with the actual command to start your app)
CMD ["npm", "start"]

--------------------------- Java ---------------
FROM openjdk:8
EXPOSE 8080
ADD target/devops-integration.jar devops-integration.jar
ENTRYPOINT ["java","-jar","/devops-integration.jar"]
----------------------------- 
