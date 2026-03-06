# OceanViewResort
OceanView Resort – Room Reservation System
A Java web application for managing hotel room reservations at Ocean View Resort, Galle.
Built with Java 11 · JSP/JSTL · MySQL · Maven · Apache Tomcat 7

Prerequisites

Java JDK 11+
Maven 3.6+
MySQL 8.0+


Database Setup

Open MySQL and run the schema file:

sqlsource path/to/schema.sql
Or paste the contents of schema.sql directly into MySQL Workbench and execute.

This creates the ocean_view_db database with all tables, stored procedure, trigger, and sample data.


Update the database credentials in DBConnection.java:

java// src/main/java/com/oceanview/util/DBConnection.java
private static final String URL  = "jdbc:mysql://localhost:3306/ocean_view_db";
private static final String USER = "root";       // your MySQL username
private static final String PASSWORD = "2000";   // your MySQL password

Run the Application
mvn clean compile tomcat7:run
Then open your browser at:
http://localhost:8080/OceanView

Login Credentials

Staff / Admin Portal
Username-admin 
Password-admin123
Role-Admin

Username-staff     
Password-staff123
Role-Staff

Customer Portal
Register a new account at the Customer Login page → Register here