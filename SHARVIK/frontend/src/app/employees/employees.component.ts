import { Component, OnInit } from '@angular/core';
import { EmployeeService, Employee } from '../services/employee.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-employees',
  templateUrl: './employees.component.html',
  styleUrls: ['./employees.component.css']
})
export class EmployeesComponent implements OnInit {
  employees: any;

  constructor(private service: EmployeeService, private router: Router) { }

  ngOnInit(): void {
    this.load();
  }

  load() {
    this.service.getAll().subscribe({
      next: data => {
        console.log('Employees load response:', data);
        this.employees = data;
      },
      error: err => {
        console.error('Failed to load employees', err);
        this.employees = [];
      }
    });
  }

  view(id?: number) {
    if (id) this.router.navigate(['/employees/view', id]);
  }

  edit(id?: number) {
    if (id) this.router.navigate(['/employees/edit', id]);
  }

  delete(id?: number) {
    if (!id) return;
    if (!confirm('Are you sure?')) return;
    this.service.delete(id).subscribe(() => this.load());
  }
}
