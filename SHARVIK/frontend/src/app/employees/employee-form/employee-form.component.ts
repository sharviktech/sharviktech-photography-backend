import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { EmployeeService } from '../../services/employee.service';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-employee-form',
  templateUrl: './employee-form.component.html',
  styleUrls: ['./employee-form.component.css']
})
export class EmployeeFormComponent implements OnInit {
  form: FormGroup;
  id?: number;

  constructor(private fb: FormBuilder, private service: EmployeeService, private route: ActivatedRoute, private router: Router) {
    this.form = this.fb.group({
      name: ['', Validators.required],
      email: ['',[Validators.email]],
      phone: [''],
      department: [''],
      designation: ['']
    });
  }

  ngOnInit(): void {
    this.route.params.subscribe(p => {
      if (p['id']) {
        this.id = +p['id'];
        this.service.get(this.id).subscribe(e => this.form.patchValue(e));
      }
    });
  }

  save() {
    if (this.form.invalid) return;

    const emp = this.form.value;
    if (this.id) {
      this.service.update(this.id, emp).subscribe(() => this.router.navigate(['/employees']));
    } else {
      this.service.create(emp).subscribe(() => this.router.navigate(['/employees']));
    }
  }
}
