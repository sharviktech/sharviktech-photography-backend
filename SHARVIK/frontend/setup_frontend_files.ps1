# Run this script from the `SHARVIK/frontend` folder (PowerShell).
# It will write/overwrite key Angular files under `src/`.
# Usage: Open PowerShell in this folder and run `./setup_frontend_files.ps1`

$src = Join-Path $PSScriptRoot 'src'
if (-not (Test-Path $src)) {
    Write-Error "Folder 'src' not found. Run this from the SHARVIK/frontend directory where Angular project exists."
    exit 1
}

Function Write-TextFile($relPath, $content) {
    $full = Join-Path $src $relPath
    $dir = Split-Path $full -Parent
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    $content | Out-File -FilePath $full -Encoding UTF8 -Force
    Write-Host "Wrote $relPath"
}

# environments
Write-TextFile 'environments/environment.ts' @"
export const environment = {
  production: false,
  apiBaseUrl: 'https://localhost:5001/api' // adjust to match backend (use http://localhost:5000 if needed)
};
"@

Write-TextFile 'environments/environment.prod.ts' @"
export const environment = {
  production: true,
  apiBaseUrl: 'https://localhost:5001/api'
};
"@

# app module and routing
Write-TextFile 'app/app-routing.module.ts' @"
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { DashboardComponent } from './dashboard/dashboard.component';
import { EmployeesComponent } from './employees/employees.component';
import { EmployeeFormComponent } from './employees/employee-form/employee-form.component';
import { EmployeeViewComponent } from './employees/employee-view/employee-view.component';
import { AboutComponent } from './about/about.component';
import { CategoryComponent } from './category/category.component';
import { DepartmentComponent } from './department/department.component';

const routes: Routes = [
  { path: '', component: DashboardComponent },
  { path: 'employees', component: EmployeesComponent },
  { path: 'employees/add', component: EmployeeFormComponent },
  { path: 'employees/edit/:id', component: EmployeeFormComponent },
  { path: 'employees/view/:id', component: EmployeeViewComponent },
  { path: 'about', component: AboutComponent },
  { path: 'category', component: CategoryComponent },
  { path: 'department', component: DepartmentComponent },
  { path: '**', redirectTo: '' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
"@

Write-TextFile 'app/app.module.ts' @"
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NavbarComponent } from './navbar/navbar.component';
import { DashboardComponent } from './dashboard/dashboard.component';
import { EmployeesComponent } from './employees/employees.component';
import { EmployeeFormComponent } from './employees/employee-form/employee-form.component';
import { EmployeeViewComponent } from './employees/employee-view/employee-view.component';
import { AboutComponent } from './about/about.component';
import { CategoryComponent } from './category/category.component';
import { DepartmentComponent } from './department/department.component';

@NgModule({
  declarations: [
    AppComponent,
    NavbarComponent,
    DashboardComponent,
    EmployeesComponent,
    EmployeeFormComponent,
    EmployeeViewComponent,
    AboutComponent,
    CategoryComponent,
    DepartmentComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule,
    ReactiveFormsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
"@

# app component
Write-TextFile 'app/app.component.html' "<app-navbar></app-navbar>\n<div class=\"container mt-4\">\n  <router-outlet></router-outlet>\n</div>\n"

# navbar
Write-TextFile 'app/navbar/navbar.component.ts' @"
import { Component } from '@angular/core';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html'
})
export class NavbarComponent { }
"@

Write-TextFile 'app/navbar/navbar.component.html' @"
<nav class=\"navbar navbar-expand-lg navbar-light bg-light\">\n  <div class=\"container-fluid\">\n    <a class=\"navbar-brand\" routerLink=\"/\">SHARVIK</a>\n    <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navbarNav\">\n      <span class=\"navbar-toggler-icon\"></span>\n    </button>\n    <div class=\"collapse navbar-collapse\" id=\"navbarNav\">\n      <ul class=\"navbar-nav\">\n        <li class=\"nav-item\"><a class=\"nav-link\" routerLink=\"/\">Dashboard</a></li>\n        <li class=\"nav-item dropdown\">\n          <a class=\"nav-link dropdown-toggle\" href=\"#\" id=\"employeesDropdown\" role=\"button\" data-bs-toggle=\"dropdown\">Employees</a>\n          <ul class=\"dropdown-menu\" aria-labelledby=\"employeesDropdown\">\n            <li><a class=\"dropdown-item\" routerLink=\"/employees\">List</a></li>\n            <li><a class=\"dropdown-item\" routerLink=\"/employees/add\">Add Employee</a></li>\n          </ul>\n        </li>\n        <li class=\"nav-item\"><a class=\"nav-link\" routerLink=\"/about\">About</a></li>\n        <li class=\"nav-item\"><a class=\"nav-link\" routerLink=\"/category\">Category</a></li>\n        <li class=\"nav-item\"><a class=\"nav-link\" routerLink=\"/department\">Department</a></li>\n      </ul>\n    </div>\n  </div>\n</nav>\n"@

# dashboard
Write-TextFile 'app/dashboard/dashboard.component.ts' "import { Component } from '@angular/core';\n\n@Component({ selector: 'app-dashboard', template: `<h2>Dashboard</h2>` })\nexport class DashboardComponent { }\n"

# employees list
Write-TextFile 'app/employees/employees.component.ts' @"
import { Component, OnInit } from '@angular/core';
import { EmployeeService, Employee } from '../services/employee.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-employees',
  templateUrl: './employees.component.html'
})
export class EmployeesComponent implements OnInit {
  employees: Employee[] = [];

  constructor(private service: EmployeeService, private router: Router) { }

  ngOnInit(): void { this.load(); }

  load() { this.service.getAll().subscribe(data => this.employees = data); }

  view(id?: number) { if (id) this.router.navigate(['/employees/view', id]); }
  edit(id?: number) { if (id) this.router.navigate(['/employees/edit', id]); }
  delete(id?: number) { if (!id) return; if (!confirm('Are you sure?')) return; this.service.delete(id).subscribe(() => this.load()); }
}
"@

Write-TextFile 'app/employees/employees.component.html' @"
<div class=\"d-flex justify-content-between align-items-center mb-3\">\n  <h3>Employees</h3>\n  <button class=\"btn btn-primary\" routerLink=\"/employees/add\">Add Employee</button>\n</div>\n\n<table class=\"table table-bordered\">\n  <thead>\n    <tr><th>Name</th><th>Email</th><th>Phone</th><th>Department</th><th>Designation</th><th>Actions</th></tr>\n  </thead>\n  <tbody>\n    <tr *ngFor=\"let e of employees\">\n      <td>{{e.name}}</td><td>{{e.email}}</td><td>{{e.phone}}</td><td>{{e.department}}</td><td>{{e.designation}}</td>\n      <td>\n        <button class=\"btn btn-sm btn-info me-1\" (click)=\"view(e.id)\">View</button>\n        <button class=\"btn btn-sm btn-warning me-1\" (click)=\"edit(e.id)\">Edit</button>\n        <button class=\"btn btn-sm btn-danger\" (click)=\"delete(e.id)\">Delete</button>\n      </td>\n    </tr>\n  </tbody>\n</table>\n"@

# employee form
Write-TextFile 'app/employees/employee-form/employee-form.component.ts' @"
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { EmployeeService } from '../../services/employee.service';
import { ActivatedRoute, Router } from '@angular/router';

@Component({ selector: 'app-employee-form', templateUrl: './employee-form.component.html' })
export class EmployeeFormComponent implements OnInit {
  form: FormGroup;
  id?: number;

  constructor(private fb: FormBuilder, private service: EmployeeService, private route: ActivatedRoute, private router: Router) {
    this.form = this.fb.group({ name: ['', Validators.required], email: ['', [Validators.email]], phone: [''], department: [''], designation: [''] });
  }

  ngOnInit(): void {
    this.route.params.subscribe(p => { if (p['id']) { this.id = +p['id']; this.service.get(this.id).subscribe(e => this.form.patchValue(e)); } });
  }

  save() {
    if (this.form.invalid) return;
    const emp = this.form.value;
    if (this.id) { this.service.update(this.id, emp).subscribe(() => this.router.navigate(['/employees'])); }
    else { this.service.create(emp).subscribe(() => this.router.navigate(['/employees'])); }
  }
}
"@

Write-TextFile 'app/employees/employee-form/employee-form.component.html' @"
<h3 *ngIf=\"!id\">Add Employee</h3>\n<h3 *ngIf=\"id\">Edit Employee</h3>\n\n<form [formGroup]=\"form\" (ngSubmit)=\"save()\">\n  <div class=\"mb-3\">\n    <label class=\"form-label\">Name</label>\n    <input class=\"form-control\" formControlName=\"name\" />\n  </div>\n  <div class=\"mb-3\">\n    <label class=\"form-label\">Email</label>\n    <input class=\"form-control\" formControlName=\"email\" />\n  </div>\n  <div class=\"mb-3\">\n    <label class=\"form-label\">Phone</label>\n    <input class=\"form-control\" formControlName=\"phone\" />\n  </div>\n  <div class=\"mb-3\">\n    <label class=\"form-label\">Department</label>\n    <input class=\"form-control\" formControlName=\"department\" />\n  </div>\n  <div class=\"mb-3\">\n    <label class=\"form-label\">Designation</label>\n    <input class=\"form-control\" formControlName=\"designation\" />\n  </div>\n  <button class=\"btn btn-primary\" type=\"submit\">Save</button>\n  <a class=\"btn btn-secondary ms-2\" routerLink=\"/employees\">Cancel</a>\n</form>\n"@

# employee view
Write-TextFile 'app/employees/employee-view/employee-view.component.ts' @"
import { Component, OnInit } from '@angular/core';
import { EmployeeService, Employee } from '../../services/employee.service';
import { ActivatedRoute, Router } from '@angular/router';

@Component({ selector: 'app-employee-view', templateUrl: './employee-view.component.html' })
export class EmployeeViewComponent implements OnInit {
  employee?: Employee;
  constructor(private service: EmployeeService, private route: ActivatedRoute, private router: Router) { }
  ngOnInit(): void { this.route.params.subscribe(p => { const id = +p['id']; if (id) this.service.get(id).subscribe(e => this.employee = e); }); }
}
"@

Write-TextFile 'app/employees/employee-view/employee-view.component.html' @"
<div *ngIf=\"employee\">\n  <h3>View Employee</h3>\n  <dl class=\"row\">\n    <dt class=\"col-sm-3\">Name</dt><dd class=\"col-sm-9\">{{employee.name}}</dd>\n    <dt class=\"col-sm-3\">Email</dt><dd class=\"col-sm-9\">{{employee.email}}</dd>\n    <dt class=\"col-sm-3\">Phone</dt><dd class=\"col-sm-9\">{{employee.phone}}</dd>\n    <dt class=\"col-sm-3\">Department</dt><dd class=\"col-sm-9\">{{employee.department}}</dd>\n    <dt class=\"col-sm-3\">Designation</dt><dd class=\"col-sm-9\">{{employee.designation}}</dd>\n  </dl>\n  <a class=\"btn btn-secondary\" routerLink=\"/employees\">Back</a>\n</div>\n"@

# service
Write-TextFile 'app/services/employee.service.ts' @"
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';

export interface Employee { id?: number; name: string; email?: string; phone?: string; department?: string; designation?: string; }

@Injectable({ providedIn: 'root' })
export class EmployeeService {
  private apiUrl = `${environment.apiBaseUrl}/employees`;
  constructor(private http: HttpClient) { }
  getAll(): Observable<Employee[]> { return this.http.get<Employee[]>(this.apiUrl); }
  get(id: number) { return this.http.get<Employee>(`${this.apiUrl}/${id}`); }
  create(employee: Employee) { return this.http.post<Employee>(this.apiUrl, employee); }
  update(id: number, employee: Employee) { return this.http.put(`${this.apiUrl}/${id}`, employee); }
  delete(id: number) { return this.http.delete(`${this.apiUrl}/${id}`); }
}
"@

# about, category, department
Write-TextFile 'app/about/about.component.ts' "import { Component } from '@angular/core';\n@Component({ selector: 'app-about', template: `<h3>About</h3><p>Sharvik application sample.</p>` })\nexport class AboutComponent { }\n"
Write-TextFile 'app/category/category.component.ts' "import { Component } from '@angular/core';\n@Component({ selector: 'app-category', template: `<h3>Category</h3><p>Placeholder for Category.</p>` })\nexport class CategoryComponent { }\n"
Write-TextFile 'app/department/department.component.ts' "import { Component } from '@angular/core';\n@Component({ selector: 'app-department', template: `<h3>Department</h3><p>Placeholder for Department.</p>` })\nexport class DepartmentComponent { }\n"

# styles
Write-TextFile 'styles.css' @"
/* Global Styles */
body { margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue', sans-serif; -webkit-font-smoothing: antialiased; -moz-osx-font-smoothing: grayscale; }
code { font-family: source-code-pro, Menlo, Monaco, Consolas, 'Courier New', monospace; }
@import '~bootstrap/dist/css/bootstrap.min.css';
"@

Write-Host "All files written. Run 'npm install' and 'ng serve' in the frontend folder. Update environment.apiBaseUrl if backend uses a different URL." 
