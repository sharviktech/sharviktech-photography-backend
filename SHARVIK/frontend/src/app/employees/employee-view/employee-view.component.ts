import { Component, OnInit } from '@angular/core';
import { EmployeeService, Employee } from '../../services/employee.service';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-employee-view',
  templateUrl: './employee-view.component.html',
  styleUrls: ['./employee-view.component.css']
})
export class EmployeeViewComponent implements OnInit {
  employee?: Employee;

  constructor(private service: EmployeeService, private route: ActivatedRoute, private router: Router) { }

  ngOnInit(): void {
    this.route.params.subscribe(p => {
      const id = +p['id'];
      if (id) this.service.get(id).subscribe(e => this.employee = e);
    });
  }
}
