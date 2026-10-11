import React from 'react';
import {
  ChevronDown,
  ChevronLeft,
  ChevronRight,
} from 'lucide-react';

export const StudentsTab: React.FC = () => {
  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-stone-900 tracking-tight">Học viên</h1>
          <p className="text-xs text-stone-500 mt-1">
            Quản lý tiến độ học tập, chuyên cần và kết quả · 5 học viên mẫu.
          </p>
        </div>
        <button
          onClick={() => alert('Cập nhật điểm và chuyên cần (minh họa)')}
          className="px-4 py-2.5 bg-[#8B4513] hover:bg-[#72380F] text-white text-xs font-semibold rounded-xl shadow-sm transition-all self-start sm:self-auto"
        >
          Cập nhật học tập
        </button>
      </div>

      {/* Filter Row */}
      <div className="grid grid-cols-1 md:grid-cols-12 gap-3 bg-white p-3 rounded-2xl border border-stone-200 shadow-sm">
        <div className="md:col-span-5">
          <input
            type="text"
            placeholder="Tìm học viên, mã hồ sơ hoặc lớp..."
            className="w-full px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513]"
          />
        </div>
        <div className="md:col-span-3 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Tất cả khóa / lớp</option>
            <option>Massage Chuyên Nghiệp (MCN-0926)</option>
            <option>Chăm sóc da</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
        <div className="md:col-span-2 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Trạng thái học tập</option>
            <option>Đang học</option>
            <option>Hoàn thành</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
        <div className="md:col-span-2 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Tất cả chi nhánh</option>
            <option>Quận 3</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
      </div>

      {/* Students Table */}
      <div className="bg-white p-5 rounded-2xl border border-stone-200 shadow-sm">
        <div className="flex items-center justify-between mb-4">
          <h3 className="text-sm font-bold text-stone-900">Danh sách học viên minh họa</h3>
          <span className="text-[11px] font-semibold text-[#8B4513] bg-[#F5EBE1] px-2.5 py-0.5 rounded-full">
            5 bản ghi mẫu
          </span>
        </div>

        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs">
            <thead className="bg-[#F5EBE1] text-stone-700 font-semibold">
              <tr>
                <th className="py-2.5 px-3 rounded-l-lg">Học viên</th>
                <th className="py-2.5 px-3">Khóa / lớp</th>
                <th className="py-2.5 px-3">Tiến độ</th>
                <th className="py-2.5 px-3">Chuyên cần</th>
                <th className="py-2.5 px-3">Hồ sơ học phí</th>
                <th className="py-2.5 px-3 rounded-r-lg">Trạng thái / thao tác</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-stone-100">
              {/* Row 1: Nguyen Minh Anh */}
              <tr className="hover:bg-stone-50 bg-amber-50/30">
                <td className="py-3 px-3">
                  <div className="flex items-center gap-2.5">
                    <img
                      src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150"
                      alt="Avatar"
                      className="w-8 h-8 rounded-full object-cover"
                    />
                    <div>
                      <div className="font-bold text-stone-900">Nguyễn Minh Anh</div>
                      <div className="text-[11px] text-stone-400">HV-MH-128 · WM-000128</div>
                    </div>
                  </div>
                </td>
                <td className="py-3 px-3">
                  <div className="font-medium text-stone-800">Massage Chuyên Nghiệp</div>
                  <div className="text-[11px] text-stone-400">MCN-0926 · Quận 3</div>
                </td>
                <td className="py-3 px-3 font-semibold text-stone-800">20% · 4/20 bài</td>
                <td className="py-3 px-3">
                  <div className="text-stone-800 font-medium">8/9 buổi</div>
                  <div className="text-[10px] text-stone-400">88,9%</div>
                </td>
                <td className="py-3 px-3 text-stone-500 text-[11px]">
                  Theo hồ sơ lớp hiện tại<br />Cọc lớp mới tách riêng
                </td>
                <td className="py-3 px-3">
                  <span className="px-2 py-0.5 bg-amber-100 text-amber-800 text-[10px] font-bold rounded">
                    Đang học
                  </span>
                  <button className="block text-[11px] text-[#8B4513] font-bold mt-1 hover:underline">
                    Xem hồ sơ
                  </button>
                </td>
              </tr>

              {/* Row 2: Bui Thao Vy */}
              <tr className="hover:bg-stone-50">
                <td className="py-3 px-3">
                  <div className="flex items-center gap-2.5">
                    <div className="w-8 h-8 rounded-full bg-stone-100 text-stone-700 font-bold flex items-center justify-center">
                      TV
                    </div>
                    <div>
                      <div className="font-bold text-stone-900">Bùi Thảo Vy</div>
                      <div className="text-[11px] text-stone-400">HV-MH-201 · 09•••••• 215</div>
                    </div>
                  </div>
                </td>
                <td className="py-3 px-3">
                  <div className="font-medium text-stone-800">Chăm sóc da · Mẫu</div>
                  <div className="text-[11px] text-stone-400">Lớp thực hành · Quận 3</div>
                </td>
                <td className="py-3 px-3 font-semibold text-stone-800">30% · 6/20 bài</td>
                <td className="py-3 px-3">
                  <div className="text-stone-800 font-medium">5/6 buổi</div>
                  <div className="text-[10px] text-stone-400">83,3%</div>
                </td>
                <td className="py-3 px-3 text-stone-500 text-[11px]">Chưa đối chiếu mẫu</td>
                <td className="py-3 px-3">
                  <span className="px-2 py-0.5 bg-amber-100 text-amber-800 text-[10px] font-bold rounded">
                    Đang học
                  </span>
                </td>
              </tr>

              {/* Row 3: Hoang Gia Han */}
              <tr className="hover:bg-stone-50">
                <td className="py-3 px-3">
                  <div className="flex items-center gap-2.5">
                    <div className="w-8 h-8 rounded-full bg-stone-100 text-stone-700 font-bold flex items-center justify-center">
                      GH
                    </div>
                    <div>
                      <div className="font-bold text-stone-900">Hoàng Gia Hân</div>
                      <div className="text-[11px] text-stone-400">HV-MH-202 · 08•••••• 439</div>
                    </div>
                  </div>
                </td>
                <td className="py-3 px-3">
                  <div className="font-medium text-stone-800">Spa cơ bản · Mẫu</div>
                  <div className="text-[11px] text-stone-400">Lớp thực hành · Quận 3</div>
                </td>
                <td className="py-3 px-3 font-semibold text-stone-800">60% · 12/20 bài</td>
                <td className="py-3 px-3">
                  <div className="text-stone-800 font-medium">6/6 buổi</div>
                  <div className="text-[10px] text-stone-400">100%</div>
                </td>
                <td className="py-3 px-3 text-stone-500 text-[11px]">Chưa đối chiếu mẫu</td>
                <td className="py-3 px-3">
                  <span className="px-2 py-0.5 bg-amber-100 text-amber-800 text-[10px] font-bold rounded">
                    Đang học
                  </span>
                </td>
              </tr>

              {/* Row 4: Trinh Tuan Kiet */}
              <tr className="hover:bg-stone-50">
                <td className="py-3 px-3">
                  <div className="flex items-center gap-2.5">
                    <div className="w-8 h-8 rounded-full bg-stone-100 text-stone-700 font-bold flex items-center justify-center">
                      TK
                    </div>
                    <div>
                      <div className="font-bold text-stone-900">Trịnh Tuấn Kiệt</div>
                      <div className="text-[11px] text-stone-400">HV-MH-203 · 09•••••• 527</div>
                    </div>
                  </div>
                </td>
                <td className="py-3 px-3">
                  <div className="font-medium text-stone-800">Massage cơ bản · Mẫu</div>
                  <div className="text-[11px] text-stone-400">Khóa sắp mở · Quận 3</div>
                </td>
                <td className="py-3 px-3 text-stone-500">0% · Chưa bắt đầu</td>
                <td className="py-3 px-3 text-stone-500">Chưa có buổi</td>
                <td className="py-3 px-3 text-stone-500 text-[11px]">Chưa đối chiếu mẫu</td>
                <td className="py-3 px-3">
                  <span className="px-2 py-0.5 bg-blue-50 text-blue-700 text-[10px] font-bold rounded">
                    Sắp học
                  </span>
                </td>
              </tr>

              {/* Row 5: Nguyen Khanh Ly */}
              <tr className="hover:bg-stone-50">
                <td className="py-3 px-3">
                  <div className="flex items-center gap-2.5">
                    <div className="w-8 h-8 rounded-full bg-stone-100 text-stone-700 font-bold flex items-center justify-center">
                      KL
                    </div>
                    <div>
                      <div className="font-bold text-stone-900">Nguyễn Khánh Ly</div>
                      <div className="text-[11px] text-stone-400">HV-MH-204 · 09•••••• 814</div>
                    </div>
                  </div>
                </td>
                <td className="py-3 px-3">
                  <div className="font-medium text-stone-800">Spa cơ bản · Mẫu</div>
                  <div className="text-[11px] text-stone-400">Khóa đã kết thúc · Quận 3</div>
                </td>
                <td className="py-3 px-3 font-semibold text-stone-800">100% · 20/20 bài</td>
                <td className="py-3 px-3">
                  <div className="text-stone-800 font-medium">9/10 buổi</div>
                  <div className="text-[10px] text-stone-400">90%</div>
                </td>
                <td className="py-3 px-3 text-stone-500 text-[11px]">Chưa đối chiếu mẫu</td>
                <td className="py-3 px-3">
                  <span className="px-2 py-0.5 bg-emerald-100 text-emerald-800 text-[10px] font-bold rounded">
                    Hoàn thành mẫu
                  </span>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <div className="flex items-center justify-between pt-4 border-t border-stone-100 text-[11px] text-stone-400">
          <span>Hiển thị 5 / 5 bản ghi minh họa</span>
          <div className="flex items-center gap-1">
            <button className="p-1 rounded hover:bg-stone-100"><ChevronLeft className="w-3.5 h-3.5" /></button>
            <span className="px-2 py-0.5 rounded bg-[#F5EBE1] text-[#8B4513] font-bold">1</span>
            <button className="p-1 rounded hover:bg-stone-100"><ChevronRight className="w-3.5 h-3.5" /></button>
          </div>
        </div>
      </div>

      {/* Bottom Row */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-6">
        {/* Completed Course Result (8 cols) */}
        <div className="lg:col-span-8 bg-white p-5 rounded-2xl border border-stone-200 shadow-sm space-y-4">
          <div className="flex items-center justify-between">
            <h3 className="text-sm font-bold text-stone-900">
              Kết quả khóa đã hoàn thành · Minh Anh
            </h3>
            <span className="text-[11px] font-semibold text-[#8B4513] bg-[#F5EBE1] px-2.5 py-0.5 rounded-full">
              1 bản ghi mẫu
            </span>
          </div>

          <div className="overflow-x-auto">
            <table className="w-full text-left text-xs">
              <thead className="bg-[#F5EBE1] text-stone-700 font-semibold">
                <tr>
                  <th className="py-2.5 px-3 rounded-l-lg">Khóa học / thời điểm</th>
                  <th className="py-2.5 px-3">Hoàn thành</th>
                  <th className="py-2.5 px-3">Lý thuyết</th>
                  <th className="py-2.5 px-3">Thực hành</th>
                  <th className="py-2.5 px-3 rounded-r-lg">Chuyên cần</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td className="py-3 px-3">
                    <div className="font-bold text-stone-900">Massage Cơ Bản · MCB-0726</div>
                    <div className="text-[11px] text-stone-400">28/08/2026</div>
                  </td>
                  <td className="py-3 px-3 font-semibold text-stone-800">100% · 20/20</td>
                  <td className="py-3 px-3 font-semibold text-stone-800">8,5 / 10</td>
                  <td className="py-3 px-3 font-semibold text-stone-800">9 / 10</td>
                  <td className="py-3 px-3 font-semibold text-stone-800">90%</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        {/* Progress Summary Card (4 cols) */}
        <div className="lg:col-span-4 bg-white p-5 rounded-2xl border border-stone-200 shadow-sm space-y-3 text-xs">
          <h3 className="text-sm font-bold text-stone-900">Tiến độ · Nguyễn Minh Anh</h3>

          <div className="flex items-center gap-2.5 p-2 bg-stone-50 rounded-xl">
            <img
              src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150"
              alt="Avatar"
              className="w-8 h-8 rounded-full object-cover"
            />
            <div>
              <div className="font-bold text-stone-900">Nguyễn Minh Anh</div>
              <div className="text-[10px] text-stone-400">MCN-0926 · Nguyễn Thanh Hương</div>
            </div>
          </div>

          <div className="space-y-1 pt-2">
            <div className="flex justify-between font-semibold text-stone-700">
              <span>20% · 4/20 bài đã hoàn thành</span>
            </div>
            <div className="w-full bg-stone-100 h-2 rounded-full overflow-hidden">
              <div className="bg-[#8B4513] h-full" style={{ width: '20%' }}></div>
            </div>
          </div>

          <div className="space-y-1.5 pt-2 border-t border-stone-100">
            <div className="flex justify-between text-stone-500">
              <span>Khóa đã ghi danh:</span>
              <span className="font-bold text-stone-900">3 khóa</span>
            </div>
            <div className="flex justify-between text-stone-500">
              <span>Đang / xong / sắp học:</span>
              <span className="font-bold text-stone-900">1 / 1 / 1</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};
