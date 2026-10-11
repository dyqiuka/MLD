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

export interface Branch {
  id: string;
  name: string;
  address: string;
  hours: string;
  services: string[];
  resources: string;
  status: string;
}

export interface CustomerProfile {
  id: string;
  code: string;
  name: string;
  phone: string;
  tier: string;
  points: number;
  lastVisit: string;
  packagesCount: number;
  remainingSessions: number;
  enrolledCourses: number;
  activeCourses: number;
  branch: string;
  status: string;
  avatar?: string;
}

export interface StaffScheduleSlot {
  id: string;
  technicianName: string;
  specialty: string;
  room: string;
  timeSlot: string;
  customerName: string;
  customerCode: string;
  serviceName: string;
  price: number;
  deposit: number;
  remaining: number;
  status: 'pending_payment' | 'confirmed' | 'free' | 'break';
}

export interface TreatmentPackage {
  id: string;
  name: string;
  customerName: string;
  customerCode: string;
  price: number;
  purchasedDate: string;
  expiryDate: string;
  totalSessions: number;
  usedSessions: number;
  remainingSessions: number;
  branch: string;
  status: string;
}

export interface AdmissionRecord {
  id: string;
  code: string;
  candidateName: string;
  phone: string;
  courseName: string;
  tuitionFee: number;
  deposit: number;
  remaining: number;
  stage: 'new' | 'consulting' | 'pending_payment' | 'pending_class';
  notes?: string;
}

export interface Instructor {
  id: string;
  code: string;
  name: string;
  specialty: string;
  assignedClasses: string[];
  branch: string;
  status: string;
}

export interface StudentProgress {
  id: string;
  code: string;
  memberCode: string;
  name: string;
  courseName: string;
  classCode: string;
  branch: string;
  progressPercent: number;
  completedLessons: number;
  totalLessons: number;
  attendance: string;
  status: string;
}

export interface TrainingClass {
  id: string;
  code: string;
  courseName: string;
  instructorName: string;
  branch: string;
  room: string;
  schedule: string;
  enrolledStudents: number;
  maxStudents: number;
  status: string;
}
