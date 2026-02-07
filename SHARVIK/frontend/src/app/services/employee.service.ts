import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { environment } from '../../environments/environment';

export interface Employee {
  id?: number;
  name: string;
  email?: string;
  phone?: string;
  department?: string;
  designation?: string;
}

@Injectable({
  providedIn: 'root'
})
export class EmployeeService {
  private apiUrl = `${environment.apiBaseUrl}/employees`;

  constructor(private http: HttpClient) { }

  getAll(): Observable<Employee[]> {
    return this.http.get<any>(this.apiUrl).pipe(
      map(resp => {
        if (Array.isArray(resp)) return resp as Employee[];
        if (resp && Array.isArray(resp.data)) return resp.data as Employee[];
        if (resp && Array.isArray(resp.employees)) return resp.employees as Employee[];
        if (resp && typeof resp === 'object') return [resp as Employee];
        return [] as Employee[];
      })
    );
  }

  get(id: number) {
    return this.http.get<any>(`${this.apiUrl}/${id}`).pipe(
      map(resp => {
        if (!resp) return resp;
        if (resp && resp.data) return resp.data as Employee;
        return resp as Employee;
      })
    );
  }

  create(employee: Employee) {
    return this.http.post<Employee>(this.apiUrl, employee);
  }

  update(id: number, employee: Employee) {
    return this.http.put(`${this.apiUrl}/${id}`, employee);
  }

  delete(id: number) {
    return this.http.delete(`${this.apiUrl}/${id}`);
  }
}
