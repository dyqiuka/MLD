import React, { useState } from 'react';
import { Sidebar } from './components/Sidebar';
import { Header } from './components/Header';
import { OverviewTab } from './components/OverviewTab';
import { UsersTab } from './components/UsersTab';
import { AppointmentsTab } from './components/AppointmentsTab';
import { ServicesTab } from './components/ServicesTab';
import { CoursesTab } from './components/CoursesTab';
import {
  AdminUser,
  AdminAppointment,
  AdminService,
  AdminCourse,
  AppointmentStatus,
  UserRole,
} from './types';

export const App: React.FC = () => {
  const [currentTab, setCurrentTab] = useState<string>('overview');

  // Seed Users
  const [users, setUsers] = useState<AdminUser[]>([
    {
      id: 'usr_01',
      name: 'Nguyễn Thanh Tùng',
      email: 'thanhtung.nguyen@email.vn',
      phone: '0988 123 456',
      role: 'patient',
      status: 'active',
      avatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
      createdAt: '12/09/2026',
      extraInfo: 'Hạng Gold (1,850 pts)',
    },
    {
      id: 'usr_02',
      name: 'Lê Hoàng Yến Nhi',
      email: 'yennhi.le@medilearn.edu.vn',
      phone: '0977 889 911',
      role: 'student',
      status: 'active',
      avatar: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150',
      createdAt: '15/09/2026',
      extraInfo: 'MSSV: MLD-K24-884 (Điều dưỡng Kaigo)',
    },
    {
      id: 'usr_03',
      name: 'PGS. TS. BS. Nguyễn Văn Hùng',
      email: 'hung.nguyen@medilearn.vn',
      phone: '0912 345 678',
      role: 'doctor',
      status: 'active',
      avatar: 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=150',
      createdAt: '01/01/2025',
      extraInfo: 'Trưởng khoa Tim Mạch & Nội Khoa',
    },
    {
      id: 'usr_04',
      name: 'ThS. BS. Trần Thị Mai',
      email: 'mai.tran@medilearn.vn',
      phone: '0908 777 666',
      role: 'doctor',
      status: 'active',
      avatar: 'https://images.unsplash.com/photo-1594824813590-b18bb3901b0b?w=150',
      createdAt: '10/03/2025',
      extraInfo: 'Chuyên gia Da Liễu Thẩm Mỹ',
    },
    {
      id: 'usr_05',
      name: 'Trần Minh Hoàng',
      email: 'admin.hoang@medilearn.vn',
      phone: '0901 000 999',
      role: 'admin',
      status: 'active',
      avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
      createdAt: '01/01/2024',
      extraInfo: 'Super Admin Hệ Thống',
    },
  ]);

  // Seed Appointments
  const [appointments, setAppointments] = useState<AdminAppointment[]>([
    {
      id: 'app_01',
      ticketCode: 'MED-2026-9812',
      patientName: 'Nguyễn Thanh Tùng',
      patientPhone: '0988 123 456',
      doctorName: 'PGS. TS. BS. Nguyễn Văn Hùng',
      serviceName: 'Gói Khám Tổng Quát Toàn Diện VIP',
      date: '11/10/2026',
      timeSlot: '09:00 - 09:30',
      amount: 2850000,
      status: 'confirmed',
      paymentStatus: 'paid',
      paymentMethod: 'VNPay QR',
    },
    {
      id: 'app_02',
      ticketCode: 'MED-2026-8842',
      patientName: 'Vũ Thị Minh Hạnh',
      patientPhone: '0903 445 566',
      doctorName: 'ThS. BS. Trần Thị Mai',
      serviceName: 'Khám & Phục Hồi Da Chuyên Sâu Y Khoa',
      date: '11/10/2026',
      timeSlot: '10:00 - 10:30',
      amount: 950000,
      status: 'confirmed',
      paymentStatus: 'paid',
      paymentMethod: 'Ví MoMo',
    },
    {
      id: 'app_03',
      ticketCode: 'MED-2026-7731',
      patientName: 'Đặng Quốc Bảo',
      patientPhone: '0919 888 222',
      doctorName: 'BS. CKII. Lê Hoàng Nam',
      serviceName: 'Khám Răng Tổng Quát & Cạo Vôi Siêu Âm',
      date: '12/10/2026',
      timeSlot: '14:00 - 14:30',
      amount: 450000,
      status: 'pending',
      paymentStatus: 'unpaid',
      paymentMethod: 'Thanh toán tại viện',
    },
  ]);

  // Seed Services
  const [services, setServices] = useState<AdminService[]>([
    {
      id: 'srv_01',
      name: 'Gói Khám Tổng Quát Toàn Diện VIP',
      category: 'Khám Tổng Quát',
      price: 2850000,
      durationMinutes: 90,
      rating: 4.9,
      doctorCount: 4,
      status: 'active',
    },
    {
      id: 'srv_02',
      name: 'Tầm Soát Tim Mạch & Huyết Áp Chuyên Sâu',
      category: 'Tim Mạch',
      price: 1800000,
      durationMinutes: 60,
      rating: 4.88,
      doctorCount: 2,
      status: 'active',
    },
    {
      id: 'srv_03',
      name: 'Khám & Phục Hồi Da Chuyên Sâu Y Khoa',
      category: 'Da Liễu',
      price: 950000,
      durationMinutes: 45,
      rating: 4.95,
      doctorCount: 3,
      status: 'active',
    },
    {
      id: 'srv_04',
      name: 'Khám Răng Tổng Quát & Cạo Vôi Siêu Âm',
      category: 'Nha Khoa',
      price: 450000,
      durationMinutes: 40,
      rating: 4.85,
      doctorCount: 2,
      status: 'active',
    },
  ]);

  // Seed Courses
  const [courses, setCourses] = useState<AdminCourse[]>([
    {
      id: 'crs_01',
      title: 'Kỹ Thuật Viên Điều Dưỡng Chuyên Nghiệp Quốc Tế',
      category: 'Điều dưỡng',
      instructor: 'PGS. TS. BS. Nguyễn Văn Hùng',
      tuitionFee: 6500000,
      studentsCount: 1420,
      totalLessons: 24,
      totalHours: 48,
      status: 'published',
    },
    {
      id: 'crs_02',
      title: 'Chứng Chỉ Chăm Sóc Người Cao Tuổi Chuẩn Kaigo Nhật Bản',
      category: 'Chăm sóc cao tuổi',
      instructor: 'ThS. BS. Đặng Thùy Dung',
      tuitionFee: 5800000,
      studentsCount: 980,
      totalLessons: 18,
      totalHours: 36,
      status: 'published',
    },
    {
      id: 'crs_03',
      title: 'Kỹ Thuật Viên Thẩm Mỹ Da Liễu Y Khoa Chuyên Nghiệp',
      category: 'Thẩm mỹ y khoa',
      instructor: 'ThS. BS. Trần Thị Mai',
      tuitionFee: 8900000,
      studentsCount: 2150,
      totalLessons: 30,
      totalHours: 60,
      status: 'published',
    },
  ]);

  // Tab Header Metadata
  const getTabHeader = () => {
    switch (currentTab) {
      case 'overview':
      case 'branches':
      case 'reports':
        return {
          title: 'Bảng Điều Khiển Tổng Quan & Báo Cáo',
          subtitle: 'Giám sát chỉ số khám chữa bệnh, doanh thu và chương trình đào tạo thời gian thực',
        };
      case 'users':
      case 'customers':
      case 'teachers':
      case 'students':
        return {
          title: 'Quản Lý Người Dùng & Phân Quyền',
          subtitle: 'Phân quyền bảo mật RBAC: Bác sĩ, Học viên đào tạo nghề, Khách hàng và Quản trị viên',
        };
      case 'appointments':
      case 'cashier':
        return {
          title: 'Quản Lý Lịch Hẹn & Thu Ngân',
          subtitle: 'Phê duyệt ca khám, kiểm tra doanh thu các cổng thanh toán điện tử',
        };
      case 'services':
      case 'treatments':
        return {
          title: 'Hệ Thống Quản Trị Nội Dung (CMS) - Dịch Vụ Y Tế',
          subtitle: 'Cập nhật danh mục gói khám, bảng giá viện phí và bác sĩ phụ trách',
        };
      case 'courses':
      case 'enrollment':
      case 'training':
        return {
          title: 'Học Viện Nghề Y Dược - Quản Lý Khóa Huấn Luyện',
          subtitle: 'Điều phối giáo trình bài giảng, học phí chứng chỉ và đánh giá năng lực',
        };
      default:
        return {
          title: 'Bảng Quản Trị MediLearn',
          subtitle: 'Healthcare & Vocational Academy',
        };
    }
  };

  const headerInfo = getTabHeader();

  return (
    <div className="flex h-screen bg-slate-50 overflow-hidden font-sans">
      {/* Sidebar Navigation */}
      <Sidebar currentTab={currentTab} onSelectTab={setCurrentTab} />

      {/* Main Body */}
      <div className="flex-1 flex flex-col min-w-0 overflow-hidden">
        <Header
          title={headerInfo.title}
          subtitle={headerInfo.subtitle}
          onQuickAction={
            currentTab === 'services'
              ? () => setCurrentTab('services')
              : currentTab === 'courses'
              ? () => setCurrentTab('courses')
              : undefined
          }
          quickActionLabel={
            currentTab === 'services'
              ? 'Thêm Dịch Vụ'
              : currentTab === 'courses'
              ? 'Tạo Khóa Học'
              : undefined
          }
        />

        <main className="flex-1 overflow-y-auto p-8">
          <div className="max-w-7xl mx-auto">
            {['overview', 'branches', 'reports'].includes(currentTab) && (
              <OverviewTab
                recentAppointments={appointments}
                onViewAllAppointments={() => setCurrentTab('appointments')}
              />
            )}

            {['users', 'customers', 'teachers', 'students'].includes(currentTab) && (
              <UsersTab
                users={users}
                onAddUser={(user) => {
                  setUsers([
                    {
                      ...user,
                      id: `usr_${Date.now()}`,
                      createdAt: new Date().toLocaleDateString('vi-VN'),
                    },
                    ...users,
                  ]);
                }}
                onToggleStatus={(userId) => {
                  setUsers(
                    users.map((u) =>
                      u.id === userId
                        ? { ...u, status: u.status === 'active' ? 'suspended' : 'active' }
                        : u
                    )
                  );
                }}
                onChangeRole={(userId, newRole: UserRole) => {
                  setUsers(
                    users.map((u) => (u.id === userId ? { ...u, role: newRole } : u))
                  );
                }}
                onDeleteUser={(userId) => {
                  setUsers(users.filter((u) => u.id !== userId));
                }}
              />
            )}

            {['appointments', 'cashier'].includes(currentTab) && (
              <AppointmentsTab
                appointments={appointments}
                onUpdateStatus={(id, newStatus: AppointmentStatus) => {
                  setAppointments(
                    appointments.map((a) =>
                      a.id === id ? { ...a, status: newStatus } : a
                    )
                  );
                }}
              />
            )}

            {['services', 'treatments'].includes(currentTab) && (
              <ServicesTab
                services={services}
                onAddService={(srv) => {
                  setServices([{ ...srv, id: `srv_${Date.now()}` }, ...services]);
                }}
                onToggleStatus={(id) => {
                  setServices(
                    services.map((s) =>
                      s.id === id
                        ? { ...s, status: s.status === 'active' ? 'inactive' : 'active' }
                        : s
                    )
                  );
                }}
                onDeleteService={(id) => {
                  setServices(services.filter((s) => s.id !== id));
                }}
              />
            )}

            {['courses', 'enrollment', 'training'].includes(currentTab) && (
              <CoursesTab
                courses={courses}
                onAddCourse={(crs) => {
                  setCourses([{ ...crs, id: `crs_${Date.now()}` }, ...courses]);
                }}
                onToggleStatus={(id) => {
                  setCourses(
                    courses.map((c) =>
                      c.id === id
                        ? { ...c, status: c.status === 'published' ? 'draft' : 'published' }
                        : c
                    )
                  );
                }}
                onDeleteCourse={(id) => {
                  setCourses(courses.filter((c) => c.id !== id));
                }}
              />
            )}
          </div>
        </main>
      </div>
    </div>
  );
};
