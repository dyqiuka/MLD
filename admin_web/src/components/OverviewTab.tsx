import React from 'react';
import {
  DollarSign,
  Users,
  CalendarCheck,
  TrendingUp,
  ArrowUpRight,
  Clock,
  CheckCircle2,
  AlertCircle,
  CreditCard,
} from 'lucide-react';
import { AdminAppointment } from '../types';

interface OverviewTabProps {
  recentAppointments: AdminAppointment[];
  onViewAllAppointments: () => void;
}

export const OverviewTab: React.FC<OverviewTabProps> = ({
  recentAppointments,
  onViewAllAppointments,
}) => {
  const stats = [
    {
      label: 'Doanh thu tháng',
      value: '8.550.000đ',
      change: '+14.2%',
      icon: DollarSign,
      subtext: 'So với tháng trước',
    },
    {
      label: 'Khách hàng mới',
      value: '3',
      change: '+2',
      icon: Users,
      subtext: 'Tháng 10/2026 · Minh họa',
    },
    {
      label: 'Lịch hẹn đã xác nhận',
      value: '2',
      change: '',
      icon: CalendarCheck,
      subtext: 'Sắp tới · 10/2026',
    },
    {
      label: 'Dịch vụ phổ biến nhất',
      value: '3',
      change: '',
      icon: TrendingUp,
      subtext: 'Nguyễn Minh Anh · Minh họa',
    },
  ];

  return (
    <div className="space-y-6">
      {/* Page Title & Actions */}
      <div className="flex items-center justify-between">
        <div>
          <h2 className="text-xl font-bold text-gray-900">Tổng quan vận hành</h2>
          <p className="text-sm text-gray-500">
            Báo cáo tình hình hoạt động cập nhật – 01/10/2026 – 31/10/2026
          </p>
        </div>
        <button
          onClick={onViewAllAppointments}
          className="px-4 py-2.5 rounded-lg bg-[#9A5B22] hover:bg-[#8A4A11] text-white text-sm font-bold shadow transition-all"
        >
          Tạo lịch hẹn mới
        </button>
      </div>

      {/* KPI Cards Grid */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
        {stats.map((s, idx) => {
          const Icon = s.icon;
          return (
            <div
              key={idx}
              className="bg-white p-5 rounded-2xl border border-gray-200 shadow-sm hover:shadow-md transition-shadow cursor-pointer"
            >
              <div className="flex items-center justify-between mb-3">
                <span className="text-xs font-semibold text-gray-500 uppercase tracking-wider">
                  {s.label}
                </span>
                <div className="w-9 h-9 rounded-xl bg-[#FDF6E9] flex items-center justify-center">
                  <Icon className="w-5 h-5 text-[#9A5B22]" />
                </div>
              </div>
              <div className="text-2xl font-black text-gray-900 tracking-tight">
                {s.value}
              </div>
              <div className="mt-2.5 flex items-center gap-1.5 text-xs">
                {s.change && (
                  <span className="inline-flex items-center text-emerald-600 font-bold bg-emerald-50 px-1.5 py-0.5 rounded">
                    <ArrowUpRight className="w-3.5 h-3.5" />
                    {s.change}
                  </span>
                )}
                <span className="text-gray-500 text-[11px] truncate">{s.subtext}</span>
              </div>
            </div>
          );
        })}
      </div>

      {/* Chart & Distribution Row */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Weekly Revenue & Volume Chart Simulation */}
        <div className="lg:col-span-2 bg-white p-6 rounded-2xl border border-gray-200 shadow-sm">
          <div className="flex items-center justify-between mb-6">
            <div>
              <h3 className="font-bold text-gray-900 text-base">Thực thu theo ngày</h3>
              <p className="text-xs text-gray-500">Biểu đồ doanh thu 7 ngày gần nhất · Dữ liệu minh họa</p>
            </div>
            <div className="flex items-center gap-3 text-xs">
              <span className="flex items-center gap-1.5 font-semibold text-gray-600">
                <span className="w-3 h-3 rounded bg-[#9A5B22]"></span> Dịch vụ
              </span>
              <span className="flex items-center gap-1.5 font-semibold text-gray-600">
                <span className="w-3 h-3 rounded bg-amber-400"></span> Học phí
              </span>
            </div>
          </div>

          {/* Bar Chart Simulation */}
          <div className="h-56 flex items-end justify-between gap-4 pt-4 border-b border-gray-100">
            {[
              { day: 'Th 2', service: 85, tuition: 60 },
              { day: 'Th 3', service: 92, tuition: 70 },
              { day: 'Th 4', service: 110, tuition: 85 },
              { day: 'Th 5', service: 95, tuition: 65 },
              { day: 'Th 6', service: 130, tuition: 95 },
              { day: 'Th 7', service: 145, tuition: 120 },
              { day: 'CN', service: 120, tuition: 80 },
            ].map((col, i) => (
              <div key={i} className="flex-1 flex flex-col items-center gap-2 h-full justify-end group">
                <div className="w-full flex items-end justify-center gap-1.5 h-44">
                  <div
                    style={{ height: `${(col.service / 150) * 100}%` }}
                    className="w-4 rounded-t-md bg-[#9A5B22] group-hover:bg-[#8A4A11] transition-all shadow-sm"
                    title={`Dịch vụ: ${col.service} giao dịch`}
                  ></div>
                  <div
                    style={{ height: `${(col.tuition / 150) * 100}%` }}
                    className="w-4 rounded-t-md bg-amber-400 group-hover:bg-amber-500 transition-all shadow-sm"
                    title={`Học phí: ${col.tuition} giao dịch`}
                  ></div>
                </div>
                <span className="text-[11px] font-medium text-gray-400">{col.day}</span>
              </div>
            ))}
          </div>
        </div>

        {/* Operational Highlights Box */}
        <div className="bg-white p-6 rounded-2xl border border-gray-200 shadow-sm flex flex-col justify-between">
          <div>
            <h3 className="font-bold text-gray-900 text-base mb-1">Cảnh báo & Tác vụ</h3>
            <p className="text-xs text-gray-500 mb-4">Các tác vụ cần xử lý</p>

            <div className="space-y-3">
              <div className="p-3 rounded-xl bg-amber-50 border border-amber-200/80 flex items-start gap-3">
                <AlertCircle className="w-4 h-4 text-amber-600 shrink-0 mt-0.5" />
                <div className="text-xs">
                  <div className="font-bold text-amber-900">1 Lịch hẹn chờ xác nhận</div>
                  <div className="text-amber-700 text-[11px]">Đặng Quốc Bảo – 12/10/2026</div>
                </div>
              </div>

              <div className="p-3 rounded-xl bg-blue-50 border border-blue-200/80 flex items-start gap-3">
                <Clock className="w-4 h-4 text-blue-600 shrink-0 mt-0.5" />
                <div className="text-xs">
                  <div className="font-bold text-blue-900">2 Thanh toán chưa hoàn tất</div>
                  <div className="text-blue-700 text-[11px]">Cần xác nhận chuyển khoản ngân hàng</div>
                </div>
              </div>

              <div className="p-3 rounded-xl bg-emerald-50 border border-emerald-200/80 flex items-start gap-3">
                <CheckCircle2 className="w-4 h-4 text-emerald-600 shrink-0 mt-0.5" />
                <div className="text-xs">
                  <div className="font-bold text-emerald-900">Hệ thống hoạt động ổn định</div>
                  <div className="text-emerald-700 text-[11px]">Tất cả dịch vụ đang bình thường</div>
                </div>
              </div>
            </div>
          </div>

          <button
            onClick={onViewAllAppointments}
            className="w-full mt-4 py-2.5 rounded-xl bg-[#FDF6E9] hover:bg-[#F5E6D0] font-bold text-[#9A5B22] text-xs transition-colors border border-[#E5D5C0]"
          >
            Quản Lý Lịch Hẹn Ngay
          </button>
        </div>
      </div>

      {/* Bill Summary Row */}
      <div className="bg-white p-6 rounded-2xl border border-gray-200 shadow-sm">
        <div className="flex items-center justify-between mb-4">
          <h3 className="font-bold text-gray-900 text-base">Biên lai chi nhánh</h3>
          <span className="text-xs text-gray-500">Cập nhật: 10/10/2026 · Minh họa</span>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs">
            <thead className="bg-gray-50 text-gray-500 uppercase tracking-wider text-[11px] border-b border-gray-100 font-semibold">
              <tr>
                <th className="py-3 px-4">Chi nhánh</th>
                <th className="py-3 px-4">Số giao dịch</th>
                <th className="py-3 px-4">Doanh thu tổng</th>
                <th className="py-3 px-4">Thanh toán online</th>
                <th className="py-3 px-4">Trạng thái</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100 text-gray-700">
              <tr className="hover:bg-gray-50/80 transition-colors">
                <td className="py-3 px-4 font-bold text-gray-900">Chi nhánh mẫu 01 – Quận 3</td>
                <td className="py-3 px-4">3</td>
                <td className="py-3 px-4 font-bold text-[#9A5B22]">4.250.000 ₫</td>
                <td className="py-3 px-4">2 / 3</td>
                <td className="py-3 px-4">
                  <span className="inline-flex items-center px-2 py-0.5 rounded-full text-[10px] font-bold bg-emerald-100 text-emerald-800">
                    Hoạt động
                  </span>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      {/* Recent Appointments Table */}
      <div className="bg-white rounded-2xl border border-gray-200 shadow-sm overflow-hidden">
        <div className="p-5 border-b border-gray-100 flex items-center justify-between">
          <div>
            <h3 className="font-bold text-gray-900 text-base">Lịch hẹn vắn tắt – Nguyễn Minh Anh</h3>
            <p className="text-xs text-gray-500">Các giao dịch gần nhất · Dữ liệu minh họa</p>
          </div>
          <button
            onClick={onViewAllAppointments}
            className="text-xs font-bold text-[#9A5B22] hover:text-[#8A4A11] transition-colors"
          >
            Xem toàn bộ ({recentAppointments.length})
          </button>
        </div>

        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs">
            <thead className="bg-gray-50/80 text-gray-500 uppercase tracking-wider text-[11px] border-b border-gray-100 font-semibold">
              <tr>
                <th className="py-3 px-5">Mã Vé</th>
                <th className="py-3 px-5">Khách Hàng</th>
                <th className="py-3 px-5">Dịch Vụ</th>
                <th className="py-3 px-5">Chuyên Viên</th>
                <th className="py-3 px-5">Thời Gian</th>
                <th className="py-3 px-5">Chi Phí</th>
                <th className="py-3 px-5">Thanh Toán</th>
                <th className="py-3 px-5">Trạng Thái</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100 text-gray-700">
              {recentAppointments.slice(0, 5).map((app) => (
                <tr key={app.id} className="hover:bg-gray-50/80 transition-colors">
                  <td className="py-3.5 px-5 font-bold text-[#9A5B22]">{app.ticketCode}</td>
                  <td className="py-3.5 px-5">
                    <div className="font-bold text-gray-800">{app.patientName}</div>
                    <div className="text-[11px] text-gray-400">{app.patientPhone}</div>
                  </td>
                  <td className="py-3.5 px-5 font-medium max-w-[180px] truncate">{app.serviceName}</td>
                  <td className="py-3.5 px-5 text-gray-600">{app.doctorName}</td>
                  <td className="py-3.5 px-5">
                    <div className="font-semibold text-gray-800">{app.timeSlot}</div>
                    <div className="text-[11px] text-gray-400">{app.date}</div>
                  </td>
                  <td className="py-3.5 px-5 font-bold text-gray-800">
                    {app.amount.toLocaleString('vi-VN')} ₫
                  </td>
                  <td className="py-3.5 px-5">
                    <span className={`inline-flex items-center px-2 py-0.5 rounded-full text-[10px] font-bold ${
                      app.paymentStatus === 'paid' 
                        ? 'bg-emerald-100 text-emerald-800' 
                        : 'bg-amber-100 text-amber-800'
                    }`}>
                      {app.paymentStatus === 'paid' ? 'Đã thanh toán' : 'Chưa thanh toán'}
                    </span>
                  </td>
                  <td className="py-3.5 px-5">
                    <span className={`inline-flex items-center px-2 py-0.5 rounded-full text-[10px] font-bold ${
                      app.status === 'confirmed' 
                        ? 'bg-emerald-100 text-emerald-800' 
                        : app.status === 'pending'
                        ? 'bg-amber-100 text-amber-800'
                        : 'bg-red-100 text-red-800'
                    }`}>
                      {app.status === 'confirmed' ? 'Đã xác nhận' : app.status === 'pending' ? 'Chờ xác nhận' : 'Đã hủy'}
                    </span>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {/* Footer Note */}
      <div className="text-center text-xs text-gray-400 py-4">
        Dữ liệu minh họa · Các thông tin trên không phải dữ liệu giao dịch thực tế
      </div>
    </div>
  );
};
