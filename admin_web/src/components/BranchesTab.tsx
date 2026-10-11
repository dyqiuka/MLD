import React, { useState } from 'react';
import { Plus, ChevronDown, ChevronLeft, ChevronRight, AlertCircle } from 'lucide-react';

export const BranchesTab: React.FC = () => {
  const [selectedBranchId, setSelectedBranchId] = useState('b1');

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-stone-900 tracking-tight">Quản lý chi nhánh</h1>
          <p className="text-xs text-stone-500 mt-1">
            Danh mục cơ sở, dịch vụ và cấu hình vận hành minh họa.
          </p>
        </div>
        <button
          onClick={() => alert('Thêm cơ sở mới (tính năng minh họa)')}
          className="flex items-center gap-1.5 px-4 py-2.5 bg-[#8B4513] hover:bg-[#72380F] text-white text-xs font-semibold rounded-xl shadow-sm transition-all self-start sm:self-auto"
        >
          <Plus className="w-4 h-4" />
          <span>Thêm chi nhánh</span>
        </button>
      </div>

      {/* Filter Row */}
      <div className="grid grid-cols-1 md:grid-cols-12 gap-3 bg-white p-3 rounded-2xl border border-stone-200 shadow-sm">
        <div className="md:col-span-6">
          <input
            type="text"
            placeholder="Tìm tên hoặc địa chỉ chi nhánh..."
            className="w-full px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513]"
          />
        </div>
        <div className="md:col-span-2 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Tỉnh / thành phố</option>
            <option>TP. Hồ Chí Minh</option>
            <option>Hà Nội</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
        <div className="md:col-span-2 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Tất cả trạng thái</option>
            <option>Đang hoạt động</option>
            <option>Tạm ngưng</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
        <div className="md:col-span-2 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Tất cả dịch vụ</option>
            <option>Massage</option>
            <option>Chăm sóc da</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
      </div>

      {/* Table: Danh sách chi nhánh */}
      <div className="bg-white p-5 rounded-2xl border border-stone-200 shadow-sm">
        <div className="flex items-center justify-between mb-4">
          <h3 className="text-sm font-bold text-stone-900">Danh sách chi nhánh</h3>
          <span className="text-[11px] font-semibold text-[#8B4513] bg-[#F5EBE1] px-2.5 py-0.5 rounded-full">
            2 bản ghi mẫu
          </span>
        </div>

        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs">
            <thead className="bg-[#F5EBE1] text-stone-700 font-semibold">
              <tr>
                <th className="py-2.5 px-3 rounded-l-lg">Cơ sở & địa chỉ minh họa</th>
                <th className="py-2.5 px-3">Giờ mở cửa</th>
                <th className="py-2.5 px-3">Dịch vụ cung cấp</th>
                <th className="py-2.5 px-3">Nguồn lực mẫu</th>
                <th className="py-2.5 px-3 rounded-r-lg">Trạng thái / thao tác</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-stone-100">
              <tr
                onClick={() => setSelectedBranchId('b1')}
                className={`hover:bg-stone-50 cursor-pointer ${selectedBranchId === 'b1' ? 'bg-amber-50/40' : ''}`}
              >
                <td className="py-3 px-3">
                  <div className="font-semibold text-stone-900">Chi nhánh mẫu 01 — Quận 3</div>
                  <div className="text-[11px] text-stone-400 mt-0.5">123 Đường Mẫu, Phường Mẫu, TP. Hồ Chí Minh</div>
                </td>
                <td className="py-3 px-3 text-stone-700">09:00–20:00</td>
                <td className="py-3 px-3 text-stone-600">Massage · Chăm sóc da · Chăm sóc cơ thể</td>
                <td className="py-3 px-3 text-stone-600">3 phòng dịch vụ · 3 kỹ thuật viên mẫu</td>
                <td className="py-3 px-3">
                  <span className="inline-block px-2 py-0.5 bg-[#F5EBE1] text-[#8B4513] text-[10px] font-bold rounded">
                    Đang hoạt động mẫu
                  </span>
                  <button className="block text-[11px] text-[#8B4513] font-bold mt-1 hover:underline">
                    Quản lý cơ sở
                  </button>
                </td>
              </tr>
              <tr
                onClick={() => setSelectedBranchId('b2')}
                className={`hover:bg-stone-50 cursor-pointer ${selectedBranchId === 'b2' ? 'bg-amber-50/40' : ''}`}
              >
                <td className="py-3 px-3">
                  <div className="font-semibold text-stone-900">Chi nhánh mẫu 02 — Cầu Giấy</div>
                  <div className="text-[11px] text-stone-400 mt-0.5">45 Đường Minh Họa, Phường Mẫu, Hà Nội</div>
                </td>
                <td className="py-3 px-3 text-stone-700">09:00–18:00</td>
                <td className="py-3 px-3 text-stone-600">Chỉ chăm sóc da</td>
                <td className="py-3 px-3 text-stone-600">2 phòng dịch vụ mẫu · Nhân sự: chưa gán</td>
                <td className="py-3 px-3">
                  <span className="inline-block px-2 py-0.5 bg-[#F5EBE1] text-[#8B4513] text-[10px] font-bold rounded">
                    Đang hoạt động mẫu
                  </span>
                  <button className="block text-[11px] text-[#8B4513] font-bold mt-1 hover:underline">
                    Quản lý cơ sở
                  </button>
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

      {/* Bottom Detail Row */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-6">
        {/* Selected Branch Detail (8 cols) */}
        <div className="lg:col-span-8 bg-white p-5 rounded-2xl border border-stone-200 shadow-sm space-y-4">
          <div className="flex items-center justify-between">
            <h3 className="text-sm font-bold text-stone-900">
              Cơ sở đang chọn · {selectedBranchId === 'b1' ? 'Quận 3' : 'Cầu Giấy'}
            </h3>
            <span className="text-[11px] font-semibold text-[#8B4513] bg-[#F5EBE1] px-2.5 py-0.5 rounded-full">
              Chi nhánh mẫu {selectedBranchId === 'b1' ? '01 — Quận 3' : '02 — Cầu Giấy'}
            </span>
          </div>

          <div className="text-xs text-stone-600">
            123 Đường Mẫu, Phường Mẫu, TP. Hồ Chí Minh
          </div>
          <div className="text-[11px] text-stone-400">
            Địa chỉ, thời gian mở cửa và năng lực phòng đều là minh họa.
          </div>

          <div className="grid grid-cols-2 md:grid-cols-3 gap-4 pt-3 border-t border-stone-100 text-xs">
            <div>
              <span className="text-stone-400">Phòng dịch vụ:</span>
              <div className="font-semibold text-stone-800 mt-0.5">01 · 02 · 03</div>
            </div>
            <div>
              <span className="text-stone-400">Khung giờ đặt lịch:</span>
              <div className="font-semibold text-stone-800 mt-0.5">09:00–20:00</div>
            </div>
            <div>
              <span className="text-stone-400">Vùng đệm vệ sinh:</span>
              <div className="font-semibold text-stone-800 mt-0.5">15 phút / lịch</div>
            </div>
          </div>

          {/* Alert note */}
          <div className="bg-[#F5EBE1] p-3.5 rounded-xl border border-[#E5D5C5] text-xs text-stone-700">
            <div className="font-bold text-stone-900 flex items-center gap-1.5">
              <AlertCircle className="w-3.5 h-3.5 text-[#8B4513]" />
              Kiểm tra nguồn lực trước khi xếp lịch
            </div>
            <p className="text-[11px] text-stone-600 mt-1">
              Đối chiếu giữ chỗ, thời lượng dịch vụ và 15 phút vệ sinh cho cả phòng và kỹ thuật viên. Đây là quy tắc mẫu, chưa có kiểm tra tự động.
            </p>
          </div>
        </div>

        {/* Payment Configuration (4 cols) */}
        <div className="lg:col-span-4 bg-white p-5 rounded-2xl border border-stone-200 shadow-sm space-y-4">
          <h3 className="text-sm font-bold text-stone-900">Cấu hình thanh toán</h3>
          
          <div className="space-y-2 text-xs">
            <div className="flex justify-between py-1.5 border-b border-stone-100">
              <span className="text-stone-500">Tại cơ sở</span>
              <span className="font-semibold text-stone-800">Cho phép · mẫu</span>
            </div>
            <div className="flex justify-between py-1.5 border-b border-stone-100">
              <span className="text-stone-500">Cọc dịch vụ</span>
              <span className="font-bold text-[#8B4513]">150.000đ</span>
            </div>
            <div className="flex justify-between py-1.5 border-b border-stone-100">
              <span className="text-stone-500">Còn lại tại cơ sở</span>
              <span className="font-bold text-stone-800">300.000đ</span>
            </div>
          </div>

          <div className="bg-[#F5EBE1] p-3 rounded-xl border border-[#E5D5C5] text-xs">
            <div className="font-bold text-stone-900">Ngân hàng / QR chưa cấu hình</div>
            <p className="text-[11px] text-stone-600 mt-1">
              Không có số tài khoản hay QR thanh toán hợp lệ. Cổng trực tuyến chưa kết nối.
            </p>
          </div>

          <div className="text-[10px] text-stone-400 italic">
            Chính sách này minh họa đơn SPA-DEMO-000128 tại Quận 3; không áp dụng mặc định cho mọi dịch vụ.
          </div>
        </div>
      </div>
    </div>
  );
};
