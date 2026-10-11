import React from 'react';
import {
  Plus,
  ChevronDown,
  Clock,
  Sparkles,
} from 'lucide-react';

interface StaffScheduleTabProps {
  onNavigateTab: (tab: string) => void;
}

export const StaffScheduleTab: React.FC<StaffScheduleTabProps> = ({ onNavigateTab }) => {
  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-stone-900 tracking-tight">Lịch kỹ thuật viên</h1>
          <p className="text-xs text-stone-500 mt-1">
            Thứ hai, 12/10/2026 · Quận 3 · Mở cửa 09:00–20:00
          </p>
        </div>
        <button
          onClick={() => alert('Tạo lịch hẹn mới (minh họa)')}
          className="flex items-center gap-1.5 px-4 py-2.5 bg-[#8B4513] hover:bg-[#72380F] text-white text-xs font-semibold rounded-xl shadow-sm transition-all self-start sm:self-auto"
        >
          <Plus className="w-4 h-4" />
          <span>Tạo lịch hẹn</span>
        </button>
      </div>

      {/* Filter Row */}
      <div className="grid grid-cols-1 md:grid-cols-12 gap-3 bg-white p-3 rounded-2xl border border-stone-200 shadow-sm">
        <div className="md:col-span-5">
          <input
            type="text"
            placeholder="Tìm khách hàng hoặc mã lịch hẹn..."
            className="w-full px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513]"
          />
        </div>
        <div className="md:col-span-2 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>12/10/2026 · Ngày</option>
            <option>13/10/2026</option>
            <option>14/10/2026</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
        <div className="md:col-span-3 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Kỹ thuật viên / Phòng</option>
            <option>Trần Minh Phương (Phòng 01)</option>
            <option>Nguyễn Thu Hà (Phòng 02)</option>
            <option>Lê Hoài An (Phòng 03)</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
        <div className="md:col-span-2 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Tất cả trạng thái</option>
            <option>Chờ thanh toán</option>
            <option>Đã xác nhận</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
      </div>

      {/* Main Grid: Left Schedule Grid (8 cols) + Right Selected Panel (4 cols) */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-6">
        {/* Schedule Matrix (8 cols) */}
        <div className="lg:col-span-8 bg-white p-5 rounded-2xl border border-stone-200 shadow-sm overflow-x-auto">
          <div className="min-w-[600px]">
            {/* Header Columns */}
            <div className="grid grid-cols-4 border-b border-stone-200 pb-3">
              <div className="text-xs font-bold text-stone-400">GIỜ</div>
              <div className="text-xs">
                <div className="font-bold text-stone-900">Trần Minh Phương</div>
                <div className="text-[11px] text-stone-500">Massage · Phòng 01</div>
              </div>
              <div className="text-xs">
                <div className="font-bold text-stone-900">Nguyễn Thu Hà</div>
                <div className="text-[11px] text-stone-500">Chăm sóc da · Phòng 02</div>
              </div>
              <div className="text-xs">
                <div className="font-bold text-stone-900">Lê Hoài An</div>
                <div className="text-[11px] text-stone-500">Cơ thể · Phòng 03</div>
              </div>
            </div>

            {/* Time Slot Rows */}
            <div className="divide-y divide-stone-100 text-xs">
              {/* 09:00 */}
              <div className="grid grid-cols-4 py-3 min-h-[58px] items-center">
                <div className="font-bold text-stone-400">09:00</div>
                <div className="bg-[#F5EBE1] border border-[#E5D5C5] p-2 rounded-xl">
                  <div className="font-bold text-stone-900 text-[11px]">Massage · Đặng Quốc Huy</div>
                  <div className="text-[10px] text-stone-500">09:30–10:30 · Mẫu độc lập</div>
                </div>
                <div></div>
                <div></div>
              </div>

              {/* 10:00 */}
              <div className="grid grid-cols-4 py-3 min-h-[58px] items-center">
                <div className="font-bold text-stone-400">10:00</div>
                <div></div>
                <div className="bg-[#F5EBE1] border border-[#E5D5C5] p-2 rounded-xl">
                  <div className="font-bold text-stone-900 text-[11px]">Chăm sóc da · Trần Ngọc Linh</div>
                  <div className="text-[10px] text-stone-500">10:00–11:00 · Mẫu độc lập</div>
                </div>
                <div></div>
              </div>

              {/* 11:00 */}
              <div className="grid grid-cols-4 py-3 min-h-[58px] items-center">
                <div className="font-bold text-stone-400">11:00</div>
                <div></div>
                <div></div>
                <div className="bg-[#F5EBE1] border border-[#E5D5C5] p-2 rounded-xl">
                  <div className="font-bold text-stone-900 text-[11px]">Chăm sóc cơ thể · Võ Hải Yến</div>
                  <div className="text-[10px] text-stone-500">11:00–12:00 · Mẫu độc lập</div>
                </div>
              </div>

              {/* 12:00 Lunch break */}
              <div className="grid grid-cols-4 py-2 min-h-[46px] items-center bg-stone-50/70">
                <div className="font-bold text-stone-400">12:00</div>
                <div className="text-center text-[10px] text-stone-400 italic">12:00–13:00 · Nghỉ trưa</div>
                <div className="text-center text-[10px] text-stone-400 italic">12:00–13:00 · Nghỉ trưa</div>
                <div className="text-center text-[10px] text-stone-400 italic">12:00–13:00 · Nghỉ trưa</div>
              </div>

              {/* 13:00 */}
              <div className="grid grid-cols-4 py-3 min-h-[58px] items-center">
                <div className="font-bold text-stone-400">13:00</div>
                <div></div>
                <div className="bg-[#F5EBE1] border border-[#E5D5C5] p-2 rounded-xl">
                  <div className="font-bold text-stone-900 text-[11px]">Chăm sóc da · Lê Bảo Ngọc</div>
                  <div className="text-[10px] text-stone-500">13:30–14:30 · Mẫu độc lập</div>
                </div>
                <div></div>
              </div>

              {/* 14:00 Focus Item: Nguyen Minh Anh */}
              <div className="grid grid-cols-4 py-3 min-h-[70px] items-center bg-amber-50/30">
                <div className="font-bold text-stone-400">14:00</div>
                <div className="bg-white border-2 border-[#8B4513] p-2.5 rounded-xl shadow-sm">
                  <div className="font-bold text-stone-900 text-[11px] flex justify-between">
                    <span>Massage · Nguyễn Minh Anh</span>
                    <span className="text-[#8B4513] text-[9px]">Chờ cọc</span>
                  </div>
                  <div className="text-[10px] text-stone-500 mt-0.5">14:00–15:00 · Chờ thanh toán</div>
                </div>
                <div></div>
                <div></div>
              </div>

              {/* 15:00 Buffer cleaning */}
              <div className="grid grid-cols-4 py-2 min-h-[46px] items-center">
                <div className="font-bold text-stone-400">15:00</div>
                <div className="bg-stone-100 text-stone-500 p-1.5 rounded-lg text-[10px] text-center">
                  15:00–15:15 · Vệ sinh / giữ phòng
                </div>
                <div></div>
                <div></div>
              </div>

              {/* 16:00 to 18:00 */}
              <div className="grid grid-cols-4 py-3 min-h-[50px] items-center text-stone-300">
                <div className="font-bold text-stone-400">16:00</div>
                <div>—</div>
                <div>—</div>
                <div>—</div>
              </div>
            </div>
          </div>
        </div>

        {/* Selected Slot Panel (4 cols) */}
        <div className="lg:col-span-4 space-y-4">
          <div className="bg-white p-5 rounded-2xl border border-stone-200 shadow-sm space-y-4">
            <div className="flex items-center justify-between">
              <h3 className="text-sm font-bold text-stone-900">Lịch đang chọn</h3>
              <span className="text-[10px] font-bold px-2 py-0.5 rounded bg-[#F5EBE1] text-[#8B4513]">
                Giữ chỗ minh họa
              </span>
            </div>

            {/* Customer card snippet */}
            <div className="flex items-center gap-3 p-2.5 rounded-xl bg-stone-50">
              <img
                src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150"
                alt="Avatar"
                className="w-10 h-10 rounded-full object-cover border"
              />
              <div>
                <div className="font-bold text-xs text-stone-900">Nguyễn Minh Anh</div>
                <div className="text-[10px] text-stone-400">WM-000128 · SPA-DEMO-000128</div>
              </div>
            </div>

            {/* Booking Details */}
            <div className="space-y-2 text-xs">
              <div className="font-bold text-sm text-stone-900">Massage thư giãn toàn thân</div>
              <div className="flex justify-between py-1 border-b border-stone-100">
                <span className="text-stone-400">Thời gian:</span>
                <span className="font-medium text-stone-800">14:00–15:00</span>
              </div>
              <div className="flex justify-between py-1 border-b border-stone-100">
                <span className="text-stone-400">Ngày:</span>
                <span className="font-medium text-stone-800">12/10/2026</span>
              </div>
              <div className="flex justify-between py-1 border-b border-stone-100">
                <span className="text-stone-400">Kỹ thuật viên:</span>
                <span className="font-semibold text-stone-800">Trần Minh Phương</span>
              </div>
              <div className="flex justify-between py-1 border-b border-stone-100">
                <span className="text-stone-400">Nguồn lực:</span>
                <span className="font-medium text-stone-800">Phòng 01 · Quận 3</span>
              </div>
              <div className="flex justify-between py-1 border-b border-stone-100">
                <span className="text-stone-400">Dịch vụ 60 phút:</span>
                <span className="font-bold text-stone-900">450.000đ</span>
              </div>
              <div className="flex justify-between py-1 border-b border-stone-100">
                <span className="text-stone-400">Cọc cần thu:</span>
                <span className="font-bold text-[#8B4513]">150.000đ</span>
              </div>
              <div className="flex justify-between py-1 border-b border-stone-100">
                <span className="text-stone-400">Thanh toán sau:</span>
                <span className="font-bold text-stone-800">300.000đ</span>
              </div>
            </div>

            <div className="flex items-center gap-1.5 text-xs text-amber-700 font-semibold bg-amber-50 p-2.5 rounded-xl border border-amber-200">
              <Clock className="w-3.5 h-3.5" />
              <span>Chờ thanh toán</span>
            </div>

            {/* Buffer notice */}
            <div className="bg-[#F5EBE1] p-3 rounded-xl border border-[#E5D5C5] text-xs">
              <div className="font-bold text-stone-900">Giữ nguồn lực đến 15:15</div>
              <p className="text-[11px] text-stone-600 mt-1">
                Vùng đệm vệ sinh: 15:00–15:15. Khoản cọc chưa thu, chưa phải lịch đã xác nhận toàn.
              </p>
            </div>

            <button
              onClick={() => onNavigateTab('cashier')}
              className="w-full py-2.5 bg-[#8B4513] hover:bg-[#72380F] text-white text-xs font-semibold rounded-xl shadow-sm transition-all"
            >
              Xem đơn thu ngân
            </button>
          </div>

          {/* Gợi ý khung trống */}
          <div className="bg-white p-4 rounded-2xl border border-stone-200 shadow-sm text-xs space-y-2">
            <h4 className="font-bold text-stone-900 flex items-center gap-1.5">
              <Sparkles className="w-3.5 h-3.5 text-[#8B4513]" />
              Gợi ý khung trống
            </h4>
            <div className="text-stone-600 text-[11px]">
              Phương · Phòng 01: từ 15:15.
            </div>
            <div className="text-stone-600 text-[11px]">
              Thu Hà · Phòng 02: từ 14:45 (gồm 15 phút vệ sinh sau lịch mẫu).
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};
