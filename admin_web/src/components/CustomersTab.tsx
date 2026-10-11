import React, { useState } from 'react';
import {
  Users,
  Award,
  Sparkles,
  Plus,
  ChevronDown,
  ChevronLeft,
  ChevronRight,
  ArrowLeft,
} from 'lucide-react';

export const CustomersTab: React.FC = () => {
  const [selectedCustomerId, setSelectedCustomerId] = useState<string | null>(null);
  const [detailTab, setDetailTab] = useState<'overview' | 'appointments' | 'treatments' | 'courses'>('overview');

  const customers = [
    {
      id: 'c1',
      name: 'Nguyễn Minh Anh',
      code: 'WM-000128',
      phone: '0912 345 678',
      tier: 'Vàng · 2.450 điểm',
      source: 'Ứng dụng mẫu',
      lastVisit: '08/10/2026',
      packages: '2 gói · 11 buổi còn',
      courses: '3 khóa · 1 đang học',
      branch: 'Quận 3',
      tag: 'Khách hàng & học viên',
      avatar: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150',
    },
    {
      id: 'c2',
      name: 'Trần Ngọc Linh',
      code: 'WM-MH-002',
      phone: '09•••••• 214',
      tier: 'Bạc',
      source: 'Tư vấn tại cơ sở',
      lastVisit: '06/10/2026',
      packages: 'Chăm sóc da · Chưa có gói mẫu',
      courses: 'Chưa có',
      branch: 'Cầu Giấy',
      tag: 'Đang theo dõi',
    },
    {
      id: 'c3',
      name: 'Phạm Thanh Mai',
      code: 'WM-MH-003',
      phone: '09•••••• 503',
      tier: 'Thành viên',
      source: 'Giới thiệu mẫu',
      lastVisit: '04/10/2026',
      packages: 'Quan tâm học nghề · Hồ sơ tuyển sinh mới',
      courses: 'Chưa có',
      branch: 'Quận 3',
      tag: 'Khách tiềm năng',
    },
    {
      id: 'c4',
      name: 'Lê Bảo Ngọc',
      code: 'WM-MH-004',
      phone: '08•••••• 608',
      tier: 'Bạc',
      source: 'Ứng dụng mẫu',
      lastVisit: '07/10/2026',
      packages: 'Dịch vụ chăm sóc da · Chưa có gói mẫu',
      courses: 'Chưa có',
      branch: 'Quận 3',
      tag: 'Đang theo dõi',
    },
    {
      id: 'c5',
      name: 'Võ Hải Yến',
      code: 'WM-MH-005',
      phone: '09•••••• 821',
      tier: 'Thành viên',
      source: 'Tư vấn tại cơ sở',
      lastVisit: '03/10/2026',
      packages: 'Dịch vụ cơ thể · Chưa có gói mẫu',
      courses: 'Chưa có',
      branch: 'Quận 3',
      tag: 'Đang theo dõi',
    },
    {
      id: 'c6',
      name: 'Đặng Quốc Huy',
      code: 'WM-MH-006',
      phone: '08•••••• 906',
      tier: 'Thành viên',
      source: 'Giới thiệu mẫu',
      lastVisit: '02/10/2026',
      packages: 'Massage thư giãn · Chưa có gói mẫu',
      courses: 'Chưa có',
      branch: 'Quận 3',
      tag: 'Đang theo dõi',
    },
  ];

  // If a customer is selected, show Screen W04 (Hồ sơ khách hàng)
  if (selectedCustomerId) {
    return (
      <div className="space-y-6">
        {/* Back and Breadcrumb */}
        <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
          <div>
            <button
              onClick={() => setSelectedCustomerId(null)}
              className="inline-flex items-center gap-1.5 text-xs text-stone-500 hover:text-stone-800 font-medium mb-1"
            >
              <ArrowLeft className="w-3.5 h-3.5" />
              <span>Quay lại danh sách khách hàng</span>
            </button>
            <h1 className="text-2xl font-bold text-stone-900 tracking-tight">Hồ sơ khách hàng</h1>
            <p className="text-xs text-stone-500 mt-0.5">
              Khách hàng / Nguyễn Minh Anh · WM-000128 · Hồ sơ minh họa
            </p>
          </div>
          <button
            onClick={() => alert('Tạo lịch hẹn cho Nguyễn Minh Anh (minh họa)')}
            className="px-4 py-2.5 bg-[#8B4513] hover:bg-[#72380F] text-white text-xs font-semibold rounded-xl shadow-sm transition-all"
          >
            Tạo lịch hẹn
          </button>
        </div>

        {/* Sub Tabs */}
        <div className="flex border-b border-stone-200 gap-6 text-xs font-semibold">
          <button
            onClick={() => setDetailTab('overview')}
            className={`pb-2.5 transition-colors ${
              detailTab === 'overview'
                ? 'border-b-2 border-[#8B4513] text-[#8B4513]'
                : 'text-stone-500 hover:text-stone-800'
            }`}
          >
            Tổng quan
          </button>
          <button
            onClick={() => setDetailTab('appointments')}
            className={`pb-2.5 transition-colors ${
              detailTab === 'appointments'
                ? 'border-b-2 border-[#8B4513] text-[#8B4513]'
                : 'text-stone-500 hover:text-stone-800'
            }`}
          >
            Lịch hẹn
          </button>
          <button
            onClick={() => setDetailTab('treatments')}
            className={`pb-2.5 transition-colors ${
              detailTab === 'treatments'
                ? 'border-b-2 border-[#8B4513] text-[#8B4513]'
                : 'text-stone-500 hover:text-stone-800'
            }`}
          >
            Liệu trình
          </button>
          <button
            onClick={() => setDetailTab('courses')}
            className={`pb-2.5 transition-colors ${
              detailTab === 'courses'
                ? 'border-b-2 border-[#8B4513] text-[#8B4513]'
                : 'text-stone-500 hover:text-stone-800'
            }`}
          >
            Học tập
          </button>
        </div>

        {/* 2 Column Layout */}
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-6">
          {/* Left Column: Customer VIP Profile Card (4 cols) */}
          <div className="lg:col-span-4 space-y-4">
            <div className="bg-white p-5 rounded-2xl border border-stone-200 shadow-sm space-y-4">
              <div className="flex items-center gap-3">
                <img
                  src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150"
                  alt="Avatar"
                  className="w-14 h-14 rounded-full object-cover border border-stone-200"
                />
                <div>
                  <h3 className="font-bold text-stone-900 text-base">Nguyễn Minh Anh</h3>
                  <div className="text-xs text-stone-500">0912 345 678 · Đã xác thực</div>
                  <div className="text-xs font-semibold text-[#8B4513] mt-0.5">Hội viên Vàng</div>
                </div>
              </div>

              {/* VIP Card Graphic */}
              <div className="bg-gradient-to-br from-[#8B5E34] to-[#5D3F22] rounded-2xl p-4 text-white shadow-md">
                <div className="text-[11px] font-semibold text-amber-200 uppercase tracking-wider">
                  Hội viên Vàng
                </div>
                <div className="text-2xl font-black mt-1">2.450 điểm</div>
                <div className="text-[11px] text-white/70 mt-0.5">Mã hội viên · WM-000128</div>
                <div className="mt-4 pt-3 border-t border-white/20 flex justify-between items-center text-[11px]">
                  <span>Xem thẻ hội viên</span>
                  <span>→</span>
                </div>
              </div>

              <div className="pt-2 text-xs space-y-1 text-stone-600">
                <div className="flex justify-between">
                  <span>Chi nhánh ưu tiên:</span>
                  <span className="font-bold text-stone-800">Quận 3</span>
                </div>
                <div className="text-[11px] text-stone-400">
                  Lịch sử đa chi nhánh: Quận 3 và Cầu Giấy.
                </div>
              </div>

              <button
                onClick={() => alert('Chỉnh sửa thông tin khách hàng')}
                className="w-full py-2 border border-stone-300 rounded-xl text-xs font-semibold text-stone-700 hover:bg-stone-50"
              >
                Chỉnh sửa hồ sơ
              </button>
            </div>

            {/* Preferences */}
            <div className="bg-white p-5 rounded-2xl border border-stone-200 shadow-sm space-y-3">
              <h4 className="text-xs font-bold text-stone-900 uppercase tracking-wider">
                Sở thích & quyền truy cập
              </h4>
              <p className="text-xs text-stone-600 leading-relaxed">
                Ưu tiên không gian yên tĩnh, nhạc nhẹ và lịch hẹn buổi chiều.
              </p>
              <span className="inline-block px-2.5 py-1 bg-[#F5EBE1] text-[#8B4513] text-[10px] font-bold rounded-lg">
                Chỉ nhân sự được phân quyền
              </span>
            </div>
          </div>

          {/* Right Column: Appointments, Packages, Courses (8 cols) */}
          <div className="lg:col-span-8 space-y-5">
            {/* 2 Lịch hẹn sắp tới */}
            <div className="bg-white p-5 rounded-2xl border border-stone-200 shadow-sm">
              <div className="flex items-center justify-between mb-3">
                <h3 className="text-sm font-bold text-stone-900">2 lịch hẹn sắp tới</h3>
                <span className="text-[11px] font-semibold text-[#8B4513] bg-[#F5EBE1] px-2 py-0.5 rounded-full">
                  2 bản ghi mẫu
                </span>
              </div>

              <div className="overflow-x-auto">
                <table className="w-full text-left text-xs">
                  <thead className="bg-[#F5EBE1] text-stone-700 font-semibold">
                    <tr>
                      <th className="py-2 px-3 rounded-l-lg">Ngày & giờ</th>
                      <th className="py-2 px-3">Dịch vụ / mã lịch</th>
                      <th className="py-2 px-3">Nhân sự / phòng</th>
                      <th className="py-2 px-3 rounded-r-lg">Trạng thái</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-stone-100">
                    <tr>
                      <td className="py-3 px-3 font-semibold text-stone-800">
                        12/10/2026<br /><span className="font-normal text-stone-500">14:00–15:00</span>
                      </td>
                      <td className="py-3 px-3">
                        <div className="font-bold text-stone-900">SPA-DEMO-000128</div>
                        <div className="text-stone-500">Massage thư giãn toàn thân</div>
                      </td>
                      <td className="py-3 px-3 text-stone-700">
                        Trần Minh Phương<br /><span className="text-stone-400">Quận 3 · Phòng 01</span>
                      </td>
                      <td className="py-3 px-3">
                        <span className="px-2 py-1 bg-amber-50 text-amber-700 border border-amber-200 rounded text-[10px] font-bold">
                          Chờ thanh toán
                        </span>
                      </td>
                    </tr>
                    <tr>
                      <td className="py-3 px-3 font-semibold text-stone-800">
                        15/10/2026<br /><span className="font-normal text-stone-500">09:00–10:00</span>
                      </td>
                      <td className="py-3 px-3">
                        <div className="font-bold text-stone-900">SPA-DEMO-PKG-000129</div>
                        <div className="text-stone-500">Massage · Buổi 05</div>
                      </td>
                      <td className="py-3 px-3 text-stone-700">
                        Trần Minh Phương<br /><span className="text-stone-400">Quận 3 · Phòng 01</span>
                      </td>
                      <td className="py-3 px-3">
                        <span className="px-2 py-1 bg-emerald-50 text-emerald-700 border border-emerald-200 rounded text-[10px] font-bold">
                          Đã xác nhận (mô phỏng)
                        </span>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>

            {/* Packages Row */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div className="bg-white p-4 rounded-2xl border border-stone-200 shadow-sm space-y-2">
                <h4 className="text-sm font-bold text-stone-900">Massage 10 buổi</h4>
                <div className="text-xs text-stone-500">Tổng / đã dùng / còn lại: <strong className="text-stone-800">10 / 4 / 6 buổi</strong></div>
                <div className="w-full bg-stone-100 h-2 rounded-full overflow-hidden">
                  <div className="bg-[#8B4513] h-full" style={{ width: '40%' }}></div>
                </div>
                <div className="text-[11px] text-stone-400">Hạn sử dụng: 31/12/2026 · Quận 3</div>
              </div>

              <div className="bg-white p-4 rounded-2xl border border-stone-200 shadow-sm space-y-2">
                <h4 className="text-sm font-bold text-stone-900">Chăm sóc da 8 buổi</h4>
                <div className="text-xs text-stone-500">Tổng / đã dùng / còn lại: <strong className="text-stone-800">8 / 3 / 5 buổi</strong></div>
                <div className="w-full bg-stone-100 h-2 rounded-full overflow-hidden">
                  <div className="bg-[#8B4513] h-full" style={{ width: '37.5%' }}></div>
                </div>
                <div className="text-[11px] text-stone-400">Hạn sử dụng: 31/12/2026 · Quận 3</div>
              </div>
            </div>

            {/* Học tập · 3 khóa đã ghi danh */}
            <div className="bg-white p-5 rounded-2xl border border-stone-200 shadow-sm">
              <div className="flex items-center justify-between mb-3">
                <h3 className="text-sm font-bold text-stone-900">Học tập · 3 khóa đã ghi danh</h3>
                <span className="text-[11px] font-semibold text-[#8B4513] bg-[#F5EBE1] px-2 py-0.5 rounded-full">
                  3 bản ghi mẫu
                </span>
              </div>

              <div className="space-y-3">
                <div className="p-3 rounded-xl bg-stone-50 flex items-center justify-between">
                  <div>
                    <div className="text-xs font-bold text-stone-900">Kỹ thuật Massage Chuyên Nghiệp</div>
                    <div className="text-[11px] text-stone-500">MCN-0926 · 12 tuần / 144 giờ</div>
                  </div>
                  <div className="text-right">
                    <span className="px-2 py-0.5 bg-amber-100 text-amber-800 text-[10px] font-bold rounded">
                      Đang học
                    </span>
                    <div className="text-[11px] text-stone-600 mt-1">20% · 4/20 bài · Điểm 8/9</div>
                  </div>
                </div>

                <div className="p-3 rounded-xl bg-stone-50 flex items-center justify-between">
                  <div>
                    <div className="text-xs font-bold text-stone-900">Massage Cơ Bản · MCB-0726</div>
                    <div className="text-[11px] text-stone-500">Hoàn thành 28/08/2026</div>
                  </div>
                  <div className="text-right">
                    <span className="px-2 py-0.5 bg-emerald-100 text-emerald-800 text-[10px] font-bold rounded">
                      Hoàn thành
                    </span>
                    <div className="text-[11px] text-stone-600 mt-1">Lý thuyết 8.5 · Thực hành 9.0</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }

  // Otherwise, show Screen W03: Customer List
  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-stone-900 tracking-tight">Khách hàng</h1>
          <p className="text-xs text-stone-500 mt-1">
            Tra cứu đa chi nhánh · 6 hồ sơ giả định, không phải dữ liệu khách hàng thật.
          </p>
        </div>
        <button
          onClick={() => alert('Thêm khách hàng mới (minh họa)')}
          className="flex items-center gap-1.5 px-4 py-2.5 bg-[#8B4513] hover:bg-[#72380F] text-white text-xs font-semibold rounded-xl shadow-sm transition-all self-start sm:self-auto"
        >
          <Plus className="w-4 h-4" />
          <span>Thêm khách hàng</span>
        </button>
      </div>

      {/* 3 Stats Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div className="bg-white p-4 rounded-2xl border border-stone-200 shadow-sm flex items-center justify-between">
          <div>
            <div className="text-xs font-medium text-stone-500">Hồ sơ trong danh sách mẫu</div>
            <div className="text-2xl font-bold text-stone-900 mt-1">6</div>
            <div className="text-[11px] text-stone-400 mt-0.5">Khách hàng & học viên minh họa</div>
          </div>
          <Users className="w-6 h-6 text-[#8B4513]" />
        </div>

        <div className="bg-white p-4 rounded-2xl border border-stone-200 shadow-sm flex items-center justify-between">
          <div>
            <div className="text-xs font-medium text-stone-500">Tài khoản đang chọn</div>
            <div className="text-2xl font-bold text-stone-900 mt-1">2.450 điểm</div>
            <div className="text-[11px] text-stone-400 mt-0.5">Nguyễn Minh Anh · Hội viên Vàng</div>
          </div>
          <Award className="w-6 h-6 text-[#8B4513]" />
        </div>

        <div className="bg-white p-4 rounded-2xl border border-stone-200 shadow-sm flex items-center justify-between">
          <div>
            <div className="text-xs font-medium text-stone-500">Liệu trình của Minh Anh</div>
            <div className="text-2xl font-bold text-stone-900 mt-1">11 buổi</div>
            <div className="text-[11px] text-stone-400 mt-0.5">2 gói đang dùng · 7 buổi đã dùng</div>
          </div>
          <Sparkles className="w-6 h-6 text-[#8B4513]" />
        </div>
      </div>

      {/* Filter Row */}
      <div className="grid grid-cols-1 md:grid-cols-12 gap-3 bg-white p-3 rounded-2xl border border-stone-200 shadow-sm">
        <div className="md:col-span-6">
          <input
            type="text"
            placeholder="Tìm tên, mã hội viên hoặc số điện thoại..."
            className="w-full px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513]"
          />
        </div>
        <div className="md:col-span-2 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Hạng hội viên</option>
            <option>Vàng</option>
            <option>Bạc</option>
            <option>Thành viên</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
        <div className="md:col-span-2 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Trạng thái hồ sơ</option>
            <option>Khách hàng & học viên</option>
            <option>Đang theo dõi</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
        <div className="md:col-span-2 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Dịch vụ / học viên</option>
            <option>Có liệu trình</option>
            <option>Học viên</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
      </div>

      {/* Customer Table */}
      <div className="bg-white p-5 rounded-2xl border border-stone-200 shadow-sm">
        <div className="flex items-center justify-between mb-4">
          <h3 className="text-sm font-bold text-stone-900">Danh sách khách hàng</h3>
          <span className="text-[11px] font-semibold text-[#8B4513] bg-[#F5EBE1] px-2.5 py-0.5 rounded-full">
            6 bản ghi mẫu
          </span>
        </div>

        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs">
            <thead className="bg-[#F5EBE1] text-stone-700 font-semibold">
              <tr>
                <th className="py-2.5 px-3 rounded-l-lg">Khách hàng / liên hệ</th>
                <th className="py-2.5 px-3">Hạng & nguồn</th>
                <th className="py-2.5 px-3">Lần gần nhất</th>
                <th className="py-2.5 px-3">Gói / học tập</th>
                <th className="py-2.5 px-3">Chi nhánh ưu tiên</th>
                <th className="py-2.5 px-3 rounded-r-lg">Trạng thái / thao tác</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-stone-100">
              {customers.map((c) => (
                <tr key={c.id} className="hover:bg-stone-50">
                  <td className="py-3 px-3">
                    <div className="flex items-center gap-2.5">
                      {c.avatar ? (
                        <img src={c.avatar} alt={c.name} className="w-8 h-8 rounded-full object-cover" />
                      ) : (
                        <div className="w-8 h-8 rounded-full bg-[#F5EBE1] text-[#8B4513] font-bold flex items-center justify-center text-xs">
                          {c.name.charAt(0)}
                        </div>
                      )}
                      <div>
                        <div className="font-semibold text-stone-900">{c.name}</div>
                        <div className="text-[11px] text-stone-400">{c.code} · {c.phone}</div>
                      </div>
                    </div>
                  </td>
                  <td className="py-3 px-3">
                    <div className="font-medium text-stone-800">{c.tier}</div>
                    <div className="text-[11px] text-stone-400">{c.source}</div>
                  </td>
                  <td className="py-3 px-3 text-stone-600">{c.lastVisit}</td>
                  <td className="py-3 px-3">
                    <div className="text-stone-800">{c.packages}</div>
                    <div className="text-[11px] text-stone-400">{c.courses}</div>
                  </td>
                  <td className="py-3 px-3 text-stone-700">{c.branch}</td>
                  <td className="py-3 px-3">
                    <span className="inline-block px-2 py-0.5 bg-[#F5EBE1] text-[#8B4513] text-[10px] font-bold rounded">
                      {c.tag}
                    </span>
                    <button
                      onClick={() => setSelectedCustomerId(c.id)}
                      className="block text-[11px] text-[#8B4513] font-bold mt-1 hover:underline cursor-pointer"
                    >
                      Xem hồ sơ
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        <div className="flex items-center justify-between pt-4 mt-2 border-t border-stone-100 text-[11px] text-stone-400">
          <span>Hiển thị 6 / 6 bản ghi minh họa</span>
          <div className="flex items-center gap-1">
            <button className="p-1 rounded hover:bg-stone-100"><ChevronLeft className="w-3.5 h-3.5" /></button>
            <span className="px-2 py-0.5 rounded bg-[#F5EBE1] text-[#8B4513] font-bold">1</span>
            <button className="p-1 rounded hover:bg-stone-100"><ChevronRight className="w-3.5 h-3.5" /></button>
          </div>
        </div>
      </div>
    </div>
  );
};
