I want you to scaffold a full-stack application with Angular frontend, .NET 9 Web API backend, and SQL Server database.

Project Details

Solution / Project Name: SHARVIK

Root Location: F:\Sharvik Tech\Projects

Backend Requirements (.NET 9 Web API)

Create a .NET 9 Web API project.

Use Entity Framework Core with SQL Server.

Create an Employee entity with the following fields:

Id (int, primary key)

Name

Email

Phone

Department

Designation

Implement full CRUD APIs:

Create Employee

Get All Employees

Get Employee by Id

Update Employee

Delete Employee

Use clean architecture and best practices.

Frontend Requirements (Angular)

Create a new Angular application.

Configure it to consume the .NET Web API.

Add a global navigation bar visible on all pages.

Navbar Structure

Dashboard (default page on app load)

Employees (dropdown)

About

Category

Department

Category and Department can be dummy components with placeholder text.

Dashboard Page

Display “Dashboard” text when the application loads initially.

Employees Module

Create an Employees page.

Display employees in a grid/table.

Each row should have actions:

View

Edit

Delete

Add an “Add Employee” button above the grid.

Implement forms for:

Add Employee

Edit Employee

View Employee (read-only)

General Requirements

Use Angular routing properly.

Keep components modular and clean.

Follow standard coding practices.

Generate complete runnable code for both frontend and backend.