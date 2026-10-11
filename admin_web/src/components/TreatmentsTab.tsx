import React from 'react';
import {
  Sparkles,
  Calendar,
  ListOrdered,
  ChevronDown,
  ChevronLeft,
  ChevronRight,
  Plus,
} from 'lucide-react';

export const TreatmentsTab: React.FC = () => {
  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-stone-900 tracking-tight">Quản lý liệu trình</h1>
          <p className="text-xs text-stone-500 mt-1">
            Số buổi chăm sóc · Tài khoản mẫu Nguyễn Minh Anh / WM-000128
          </p>
        </div>
        <button
          onClick={() => alert('Đặt buổi tiếp theo cho Nguyễn Minh Anh (minh họa)')}
          className="flex items-center gap-1.5 px-4 py-2.5 bg-[#8B4513] hover:bg-[#72380F] text-white text-xs font-semibold rounded-xl shadow-sm transition-all self-start sm:self-auto"
        >
          <Plus className="w-4 h-4" />
          <span>Đặt buổi tiếp theo</span>
        </button>
      </div>

      {/* 3 Stats Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div className="bg-white p-4 rounded-2xl border border-stone-200 shadow-sm flex items-center justify-between">
          <div>
            <div className="text-xs font-medium text-stone-500">Gói đang sử dụng</div>
            <div className="text-2xl font-bold text-stone-900 mt-1">2</div>
            <div className="text-[11px] text-stone-400 mt-0.5">Chỉ tài khoản Nguyễn Minh Anh</div>
          </div>
          <Sparkles className="w-6 h-6 text-[#8B4513]" />
        </div>

        <div className="bg-white p-4 rounded-2xl border border-stone-200 shadow-sm flex items-center justify-between">
          <div>
            <div className="text-xs font-medium text-stone-500">Buổi còn lại</div>
            <div className="text-2xl font-bold text-stone-900 mt-1">11</div>
            <div className="text-[11px] text-stone-400 mt-0.5">6 massage + 5 chăm sóc da</div>
          </div>
          <Calendar className="w-6 h-6 text-[#8B4513]" />
        </div>

        <div className="bg-white p-4 rounded-2xl border border-stone-200 shadow-sm flex items-center justify-between">
          <div>
            <div className="text-xs font-medium text-stone-500">Buổi đã sử dụng</div>
            <div className="text-2xl font-bold text-stone-900 mt-1">7</div>
            <div className="text-[11px] text-stone-400 mt-0.5">4 massage + 3 chăm sóc da</div>
          </div>
          <ListOrdered className="w-6 h-6 text-[#8B4513]" />
        </div>
      </div>

      {/* Filter Row */}
      <div className="grid grid-cols-1 md:grid-cols-12 gap-3 bg-white p-3 rounded-2xl border border-stone-200 shadow-sm">
        <div className="md:col-span-6">
          <input
            type="text"
            placeholder="Tìm khách hàng, mã gói hoặc tên liệu trình..."
            className="w-full px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513]"
          />
        </div>
        <div className="md:col-span-2 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Tất cả loại gói</option>
            <option>Massage</option>
            <option>Chăm sóc da</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
        <div className="md:col-span-2 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Đang sử dụng</option>
            <option>Đã hoàn thành</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
        <div className="md:col-span-2 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Hạn đến 31/12/2026</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
      </div>

      {/* Packages Table */}
      <div className="bg-white p-5 rounded-2xl border border-stone-200 shadow-sm">
        <div className="flex items-center justify-between mb-4">
          <h3 className="text-sm font-bold text-stone-900">Gói liệu trình · Nguyễn Minh Anh</h3>
          <span className="text-[11px] font-semibold text-[#8B4513] bg-[#F5EBE1] px-2.5 py-0.5 rounded-full">
            2 bản ghi mẫu
          </span>
        </div>

        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs">
            <thead className="bg-[#F5EBE1] text-stone-700 font-semibold">
              <tr>
                <th className="py-2.5 px-3 rounded-l-lg">Gói / giá mua</th>
                <th className="py-2.5 px-3">Ngày mua / hết hạn</th>
                <th className="py-2.5 px-3">Tổng · đã dùng · còn</th>
                <th className="py-2.5 px-3">Tiến độ</th>
                <th className="py-2.5 px-3 rounded-r-lg">Cơ sở / trạng thái</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-stone-100">
              <tr className="hover:bg-stone-50 bg-amber-50/30">
                <td className="py-3 px-3">
                  <div className="font-bold text-stone-900">Massage thư giãn · 10 buổi</div>
                  <div className="text-[11px] text-stone-500">4.000.000đ</div>
                </td>
                <td className="py-3 px-3 text-stone-600">
                  01/09/2026<br /><span className="text-stone-400">31/12/2026</span>
                </td>
                <td className="py-3 px-3 font-semibold text-stone-800">
                  10 · 4 · 6 buổi
                </td>
                <td className="py-3 px-3">
                  <div className="w-28 bg-stone-100 h-2 rounded-full overflow-hidden">
                    <div className="bg-[#8B4513] h-full" style={{ width: '40%' }}></div>
                  </div>
                  <div className="text-[10px] text-stone-500 mt-1">40% đã dùng</div>
                </td>
                <td className="py-3 px-3">
                  <div className="text-stone-700 font-medium">Quận 3</div>
                  <span className="inline-block mt-0.5 px-2 py-0.5 bg-[#F5EBE1] text-[#8B4513] text-[10px] font-bold rounded">
                    Đang sử dụng
                  </span>
                </td>
              </tr>
              <tr className="hover:bg-stone-50">
                <td className="py-3 px-3">
                  <div className="font-bold text-stone-900">Chăm sóc da · 8 buổi</div>
                  <div className="text-[11px] text-stone-500">3.600.000đ</div>
                </td>
                <td className="py-3 px-3 text-stone-600">
                  05/10/2026<br /><span className="text-stone-400">31/12/2026</span>
                </td>
                <td className="py-3 px-3 font-semibold text-stone-800">
                  8 · 3 · 5 buổi
                </td>
                <td className="py-3 px-3">
                  <div className="w-28 bg-stone-100 h-2 rounded-full overflow-hidden">
                    <div className="bg-[#8B4513] h-full" style={{ width: '37.5%' }}></div>
                  </div>
                  <div className="text-[10px] text-stone-500 mt-1">37,5% đã dùng</div>
                </td>
                <td className="py-3 px-3">
                  <div className="text-stone-700 font-medium">Quận 3</div>
                  <span className="inline-block mt-0.5 px-2 py-0.5 bg-[#F5EBE1] text-[#8B4513] text-[10px] font-bold rounded">
                    Đang sử dụng
                  </span>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <div className="flex items-center justify-between pt-4 mt-2 border-t border-stone-100 text-[11px] text-stone-400">
          <span>Hiển thị 2 / 2 bản ghi minh họa</span>
          <div className="flex items-center gap-1">
            <button className="p-1 rounded hover:bg-stone-100"><ChevronLeft className="w-3.5 h-3.5" /></button>
            <span className="px-2 py-0.5 rounded bg-[#F5EBE1] text-[#8B4513] font-bold">1</span>
            <button className="p-1 rounded hover:bg-stone-100"><ChevronRight className="w-3.5 h-3.5" /></button>
          </div>
        </div>
      </div>

      {/* Bottom Row */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-6">
        {/* Session History (8 cols) */}
        <div className="lg:col-span-8 bg-white p-5 rounded-2xl border border-stone-200 shadow-sm space-y-3">
          <div className="flex items-center justify-between">
            <h3 className="text-sm font-bold text-stone-900">Lịch sử buổi chăm sóc · Gói massage</h3>
            <span className="text-[11px] text-stone-400">
              Số buổi mẫu, tách riêng dịch vụ massage thanh toán 450.000đ ngày 08/10/2026.
            </span>
          </div>

          <div className="space-y-2.5">
            <div className="p-3 bg-[#F5EBE1] rounded-xl flex items-center justify-between text-xs">
              <span className="font-semibold text-stone-800">Buổi 01 · 10/09/2026 · Massage thư giãn</span>
              <span className="px-2 py-0.5 bg-white text-[#8B4513] rounded font-bold text-[10px]">Hoàn thành mẫu</span>
            </div>
            <div className="p-3 bg-[#F5EBE1] rounded-xl flex items-center justify-between text-xs">
              <span className="font-semibold text-stone-800">Buổi 02 · 20/09/2026 · Massage thư giãn</span>
              <span className="px-2 py-0.5 bg-white text-[#8B4513] rounded font-bold text-[10px]">Hoàn thành mẫu</span>
            </div>
            <div className="p-3 bg-[#F5EBE1] rounded-xl flex items-center justify-between text-xs">
              <span className="font-semibold text-stone-800">Buổi 03 · 01/10/2026 · Massage thư giãn</span>
              <span className="px-2 py-0.5 bg-white text-[#8B4513] rounded font-bold text-[10px]">Hoàn thành mẫu</span>
            </div>
          </div>
        </div>

        {/* Selected Package Card (4 cols) */}
        <div className="lg:col-span-4 bg-white p-5 rounded-2xl border border-stone-200 shadow-sm space-y-3 text-xs">
          <h3 className="text-sm font-bold text-stone-900">Gói massage đang chọn</h3>

          <div className="flex items-center gap-2.5 p-2 bg-stone-50 rounded-xl">
            <img
              src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150"
              alt="Avatar"
              className="w-8 h-8 rounded-full object-cover"
            />
            <div>
              <div className="font-bold text-stone-900">Nguyễn Minh Anh</div>
              <div className="text-[10px] text-stone-400">WM-000128 · Hội viên Vàng</div>
            </div>
          </div>

          <div className="space-y-2 pt-2">
            <div className="flex justify-between border-b border-stone-100 py-1">
              <span className="text-stone-400">Số buổi ban đầu:</span>
              <span className="font-bold text-stone-800">10 buổi</span>
            </div>
            <div className="flex justify-between border-b border-stone-100 py-1">
              <span className="text-stone-400">Đã hoàn thành:</span>
              <span className="font-bold text-stone-800">4 buổi</span>
            </div>
            <div className="flex justify-between border-b border-stone-100 py-1">
              <span className="text-stone-400">Còn sử dụng:</span>
              <span className="font-bold text-[#8B4513]">6 buổi</span>
            </div>
          </div>

          <div className="pt-2">
            <div className="flex justify-between text-[11px] font-semibold text-stone-700 mb-1">
              <span>Tiến độ 40%</span>
            </div>
            <div className="w-full bg-stone-100 h-2 rounded-full overflow-hidden">
              <div className="bg-[#8B4513] h-full" style={{ width: '40%' }}></div>
            </div>
          </div>

          <div className="pt-2 flex justify-between text-[11px] text-stone-500">
            <span>Ngày hết hạn:</span>
            <span className="font-semibold text-stone-800">31/12/2026</span>
          </div>
        </div>
      </div>
    </div>
  );
};
