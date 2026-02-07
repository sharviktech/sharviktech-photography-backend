import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './home/home.component';
import { PhotographersComponent } from './photographers/photographers.component';
import { BookingsComponent } from './bookings/bookings.component';
import { DashboardComponent } from './dashboard/dashboard.component';
import { LoginComponent } from './login/login.component';
import { EmployeesComponent } from './employees/employees.component';
import { EmployeeFormComponent } from './employees/employee-form/employee-form.component';
import { EmployeeViewComponent } from './employees/employee-view/employee-view.component';

const routes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'photographers', component: PhotographersComponent },
  { path: 'bookings', component: BookingsComponent },
  { path: 'dashboard', component: DashboardComponent },
  { path: 'login', component: LoginComponent },
  { path: 'employees', component: EmployeesComponent },
  { path: 'employees/add', component: EmployeeFormComponent },
  { path: 'employees/edit/:id', component: EmployeeFormComponent },
  { path: 'employees/view/:id', component: EmployeeViewComponent },
  { path: '**', redirectTo: '' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
