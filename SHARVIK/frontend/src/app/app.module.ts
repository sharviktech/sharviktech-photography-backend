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
import { HomeComponent } from './home/home.component';
import { PhotographersComponent } from './photographers/photographers.component';
import { BookingsComponent } from './bookings/bookings.component';
import { LoginComponent } from './login/login.component';

@NgModule({
  declarations: [
    AppComponent,
    NavbarComponent,
    DashboardComponent,
    EmployeesComponent,
    EmployeeFormComponent,
    EmployeeViewComponent,
    HomeComponent,
    PhotographersComponent,
    BookingsComponent,
    LoginComponent
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
