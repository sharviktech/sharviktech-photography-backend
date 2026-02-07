import { Component } from '@angular/core';
import { Router } from '@angular/router';

interface Booking {
  id: number;
  photographerName: string;
  eventType: string;
  date: Date;
  location: string;
  price: number;
  status: string;
}

@Component({
  selector: 'app-bookings',
  templateUrl: './bookings.component.html',
  styleUrls: ['./bookings.component.css']
})
export class BookingsComponent {
  bookings: Booking[] = [
    {
      id: 1,
      photographerName: 'Wedding Specialist',
      eventType: 'Wedding',
      date: new Date('2026-03-15'),
      location: 'New York',
      price: 25000,
      status: 'Confirmed'
    },
    {
      id: 2,
      photographerName: 'Portrait Expert',
      eventType: 'Portrait',
      date: new Date('2026-02-20'),
      location: 'Los Angeles',
      price: 8000,
      status: 'Pending'
    }
  ];

  constructor(private router: Router) { }

  goToPhotographers() {
    this.router.navigate(['/photographers']);
  }

  cancelBooking(id: number) {
    if (confirm('Are you sure you want to cancel this booking?')) {
      this.bookings = this.bookings.filter(b => b.id !== id);
    }
  }
}
