import { Component } from '@angular/core';

interface Photographer {
  name: string;
  type: string;
  location: string;
  price: number;
  cover: string;
  works: string[];
}

@Component({
  selector: 'app-photographers',
  templateUrl: './photographers.component.html',
  styleUrls: ['./photographers.component.css']
})
export class PhotographersComponent {
  photographers: Photographer[] = [
    {
      name: 'Wedding Specialist',
      type: 'Wedding',
      location: 'New York',
      price: 25000,
      cover: 'https://images.unsplash.com/photo-1519741497674-611481863552',
      works: [
        'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e',
        'https://images.unsplash.com/photo-1519741497674-611481863552',
        'https://images.unsplash.com/photo-1520857014576-2c4f4c972b57'
      ]
    },
    {
      name: 'Portrait Expert',
      type: 'Portrait',
      location: 'Los Angeles',
      price: 8000,
      cover: 'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91',
      works: [
        'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91',
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
        'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df'
      ]
    },
    {
      name: 'Event Pro',
      type: 'Event',
      location: 'Chicago',
      price: 15000,
      cover: 'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f',
      works: [
        'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f',
        'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee',
        'https://images.unsplash.com/photo-1515169067865-5387ec356754'
      ]
    }
  ];

  filteredPhotographers: Photographer[] = this.photographers;
  selectedPhotographer: Photographer | null = null;
  showNotification: boolean = false;

  selectedLocation: string = '';
  selectedBudget: string = '';
  selectedEvent: string = '';

  applyFilters() {
    this.filteredPhotographers = this.photographers.filter(p => {
      let ok = true;

      if (this.selectedLocation) {
        ok = ok && p.location === this.selectedLocation;
      }

      if (this.selectedEvent) {
        ok = ok && p.type === this.selectedEvent;
      }

      if (this.selectedBudget) {
        const [min, max] = this.selectedBudget.split('-').map(Number);
        ok = ok && p.price >= min && p.price <= max;
      }

      return ok;
    });
  }

  openProfile(photographer: Photographer) {
    this.selectedPhotographer = photographer;
  }

  closeProfile(event?: MouseEvent) {
    if (event && event.target !== event.currentTarget) return;
    this.selectedPhotographer = null;
  }

  book() {
    this.selectedPhotographer = null;
    this.showNotification = true;
    setTimeout(() => {
      this.showNotification = false;
    }, 3000);
  }
}
