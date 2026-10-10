export type UserRole = 'admin' | 'doctor' | 'student' | 'patient';

export interface AdminUser {
  id: string;
  name: string;
  email: string;
  phone: string;
  role: UserRole;
  status: 'active' | 'suspended';
  avatar: string;
  createdAt: string;
  extraInfo?: string;
}

export type AppointmentStatus = 'confirmed' | 'pending' | 'completed' | 'cancelled';
export type PaymentStatus = 'paid' | 'unpaid' | 'refunded';

export interface AdminAppointment {
  id: string;
  ticketCode: string;
  patientName: string;
  patientPhone: string;
  doctorName: string;
  serviceName: string;
  date: string;
  timeSlot: string;
  amount: number;
  status: AppointmentStatus;
  paymentStatus: PaymentStatus;
  paymentMethod: string;
}

export interface AdminService {
  id: string;
  name: string;
  category: string;
  price: number;
  durationMinutes: number;
  rating: number;
  doctorCount: number;
  status: 'active' | 'inactive';
}

export interface AdminCourse {
  id: string;
  title: string;
  category: string;
  instructor: string;
  tuitionFee: number;
  studentsCount: number;
  totalLessons: number;
  totalHours: number;
  status: 'published' | 'draft';
}
