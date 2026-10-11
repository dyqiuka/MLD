import React, { useState } from 'react';
import {
  CreditCard,
  Download,
  Search,
} from 'lucide-react';
import { AdminAppointment, AppointmentStatus } from '../types';

interface AppointmentsTabProps {
  appointments: AdminAppointment[];
  onUpdateStatus: (id: string, newStatus: AppointmentStatus) => void;
}

export const AppointmentsTab: React.FC<AppointmentsTabProps> = ({
  appointments,
  onUpdateStatus,
}) => {
  const [selectedFilter, setSelectedFilter] = useState<string>('all');
  const [searchQuery, setSearchQuery] = useState<string>('');

  const filteredAppointments = appointments.filter((app) => {
    const matchesFilter = selectedFilter === 'all' || app.status === selectedFilter;
    const matchesSearch =
      app.ticketCode.toLowerCase().includes(searchQuery.toLowerCase()) ||
      app.patientName.toLowerCase().includes(searchQuery.toLowerCase()) ||
      app.doctorName.toLowerCase().includes(searchQuery.toLowerCase()) ||
      app.serviceName.toLowerCase().includes(searchQuery.toLowerCase());
    return matchesFilter && matchesSearch;
  });

  const totalRevenue = appointments
    .filter((a) => a.paymentStatus === 'paid')
    .reduce((sum, a) => sum + a.amount, 0);

  const pendingCount = appointments.filter((a) => a.status === 'pending').length;
  const confirmedCount = appointments.filter((a) => a.status === 'confirmed').length;

  const getStatusBadge = (status: AppointmentStatus) => {
    switch (status) {
      case 'confirmed':
        return {
          label: 'Đã xác nhận',
          bg: 'bg-emerald-100 text-emerald-800',
        };
      case 'pending':
        return {
          label: 'Chờ duyệt',
          bg: 'bg-amber-100 text-amber-800',
        };
      case 'completed':
        return {
          label: 'Hoàn thành',
          bg: 'bg-blue-100 text-blue-800',
        };
      case 'cancelled':
        return {
          label: 'Đã hủy',
          bg: 'bg-rose-100 text-rose-800',
        };
    }
  };

  return (
    <div className="space-y-6">
      {/* Top Metrics Row */}
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-5">
        <div className="bg-white p-5 rounded-2xl border border-slate-200/80 shadow-sm">
          <div className="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1">
            Tổng Doanh Thu Đã Thu
          </div>
          <div className="text-2xl font-black text-slate-900">
            {totalRevenue.toLocaleString('vi-VN')} ₫
          </div>
          <div className="text-[11px] text-emerald-600 font-semibold mt-1">
            Qua VNPay, MoMo, ZaloPay & Thẻ Visa
          </div>
        </div>

        <div className="bg-white p-5 rounded-2xl border border-slate-200/80 shadow-sm">
          <div className="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1">
            Lịch Khám Chờ Phê Duyệt
          </div>
          <div className="text-2xl font-black text-amber-600">{pendingCount} ca</div>
          <div className="text-[11px] text-slate-500 mt-1">Cần điều dưỡng trưởng kiểm tra slot</div>
        </div>

        <div className="bg-white p-5 rounded-2xl border border-slate-200/80 shadow-sm">
          <div className="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1">
            Lịch Đã Khóa Chắc Chắn
          </div>
          <div className="text-2xl font-black text-blue-600">{confirmedCount} ca</div>
          <div className="text-[11px] text-slate-500 mt-1">Sẵn sàng đón tiếp tại Kiosk tiếp nhận</div>
        </div>
      </div>

      {/* Control Bar */}
      <div className="bg-white p-4 rounded-2xl border border-slate-200/80 shadow-sm flex flex-col sm:flex-row items-center justify-between gap-4">
        {/* Search */}
        <div className="relative w-full sm:w-80">
          <Search className="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2" />
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder="Tìm theo mã vé, tên BN, bác sĩ..."
            className="w-full pl-9 pr-4 py-2 bg-slate-50 text-xs rounded-xl border border-slate-200 focus:outline-none focus:border-blue-500"
          />
        </div>

        {/* Status Filters & Export */}
        <div className="flex items-center gap-3 w-full sm:w-auto justify-between sm:justify-end">
          <div className="flex items-center gap-1.5 bg-slate-100 p-1 rounded-xl">
            {[
              { id: 'all', label: 'Tất cả' },
              { id: 'confirmed', label: 'Đã xác nhận' },
              { id: 'pending', label: 'Chờ duyệt' },
              { id: 'completed', label: 'Hoàn thành' },
              { id: 'cancelled', label: 'Đã hủy' },
            ].map((tab) => (
              <button
                key={tab.id}
                onClick={() => setSelectedFilter(tab.id)}
                className={`px-3 py-1.5 rounded-lg text-xs font-semibold transition-all ${
                  selectedFilter === tab.id
                    ? 'bg-white text-blue-600 shadow-sm'
                    : 'text-slate-500 hover:text-slate-800'
                }`}
              >
                {tab.label}
              </button>
            ))}
          </div>

          <button
            onClick={() => alert('Đã xuất báo cáo lịch hẹn và đối soát thanh toán định dạng CSV/Excel!')}
            className="flex items-center gap-1.5 px-3 py-2 rounded-xl bg-slate-100 hover:bg-slate-200 text-slate-700 text-xs font-bold transition-all shrink-0"
          >
            <Download className="w-4 h-4" />
            <span className="hidden sm:inline">Xuất File Excel</span>
          </button>
        </div>
      </div>

      {/* Table */}
      <div className="bg-white rounded-2xl border border-slate-200/80 shadow-sm overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs">
            <thead className="bg-slate-50/80 text-slate-500 uppercase tracking-wider text-[11px] border-b border-slate-100 font-semibold">
              <tr>
                <th className="py-3 px-5">Mã Vé & Ngày Giờ</th>
                <th className="py-3 px-5">Bệnh Nhân</th>
                <th className="py-3 px-5">Dịch Vụ Khám</th>
                <th className="py-3 px-5">Bác Sĩ</th>
                <th className="py-3 px-5">Cổng Thanh Toán</th>
                <th className="py-3 px-5">Tổng Tiền</th>
                <th className="py-3 px-5">Trạng Thái</th>
                <th className="py-3 px-5 text-right">Phê Duyệt</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100 text-slate-700">
              {filteredAppointments.map((app) => {
                const statusBadge = getStatusBadge(app.status);
                return (
                  <tr key={app.id} className="hover:bg-slate-50/80 transition-colors">
                    <td className="py-3.5 px-5">
                      <div className="font-bold text-blue-600">{app.ticketCode}</div>
                      <div className="text-[11px] text-slate-500">
                        {app.timeSlot} • {app.date}
                      </div>
                    </td>
                    <td className="py-3.5 px-5">
                      <div className="font-bold text-slate-900">{app.patientName}</div>
                      <div className="text-[11px] text-slate-400">{app.patientPhone}</div>
                    </td>
                    <td className="py-3.5 px-5 font-medium">{app.serviceName}</td>
                    <td className="py-3.5 px-5 text-slate-600">{app.doctorName}</td>
                    <td className="py-3.5 px-5">
                      <span className="inline-flex items-center gap-1 font-semibold text-slate-700">
                        <CreditCard className="w-3.5 h-3.5 text-blue-500" />
                        {app.paymentMethod}
                      </span>
                    </td>
                    <td className="py-3.5 px-5 font-bold text-slate-900">
                      {app.amount.toLocaleString('vi-VN')} ₫
                    </td>
                    <td className="py-3.5 px-5">
                      <span
                        className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-[10px] font-bold ${statusBadge?.bg || 'bg-slate-100 text-slate-700'}`}
                      >
                        {statusBadge?.label || 'Không xác định'}
                      </span>
                    </td>
                    <td className="py-3.5 px-5 text-right">
                      <div className="flex items-center justify-end gap-1.5">
                        {app.status === 'pending' && (
                          <button
                            onClick={() => onUpdateStatus(app.id, 'confirmed')}
                            className="px-2.5 py-1 rounded-lg bg-emerald-600 hover:bg-emerald-700 text-white font-bold text-[11px] transition-colors"
                          >
                            Duyệt
                          </button>
                        )}
                        {app.status === 'confirmed' && (
                          <button
                            onClick={() => onUpdateStatus(app.id, 'completed')}
                            className="px-2.5 py-1 rounded-lg bg-blue-600 hover:bg-blue-700 text-white font-bold text-[11px] transition-colors"
                          >
                            Xong
                          </button>
                        )}
                        {app.status !== 'cancelled' && (
                          <button
                            onClick={() => onUpdateStatus(app.id, 'cancelled')}
                            className="px-2 py-1 rounded-lg border border-slate-200 text-slate-400 hover:text-rose-600 hover:bg-rose-50 font-bold text-[11px] transition-colors"
                          >
                            Hủy
                          </button>
                        )}
                      </div>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};
