import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css']
})
export class NavbarComponent {
  currentRoute: string = 'home';

  constructor(private router: Router) {
    this.router.events.subscribe(() => {
      const url = this.router.url;
      if (url === '/' || url === '') this.currentRoute = 'home';
      else if (url.includes('photographers')) this.currentRoute = 'photographers';
      else if (url.includes('bookings')) this.currentRoute = 'bookings';
      else if (url.includes('dashboard')) this.currentRoute = 'dashboard';
      else if (url.includes('login')) this.currentRoute = 'login';
    });
  }

  navigate(route: string) {
    this.currentRoute = route;
  }
}
