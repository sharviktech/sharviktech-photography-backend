import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent {
  email: string = '';
  password: string = '';
  rememberMe: boolean = false;

  constructor(private router: Router) { }

  onLogin() {
    if (this.email && this.password) {
      alert('Login successful! (Demo mode)');
      this.router.navigate(['/']);
    } else {
      alert('Please fill in all fields');
    }
  }
}
