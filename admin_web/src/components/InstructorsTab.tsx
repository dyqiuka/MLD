import React from 'react';
import {
  Plus,
  ChevronDown,
  ChevronLeft,
  ChevronRight,
} from 'lucide-react';

export const InstructorsTab: React.FC = () => {
  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-stone-900 tracking-tight">Giảng viên</h1>
          <p className="text-xs text-stone-500 mt-1">
            Hồ sơ giảng viên, phân công lớp và lịch giảng dạy minh họa.
          </p>
        </div>
        <button
          onClick={() => alert('Thêm giảng viên mới (minh họa)')}
          className="flex items-center gap-1.5 px-4 py-2.5 bg-[#8B4513] hover:bg-[#72380F] text-white text-xs font-semibold rounded-xl shadow-sm transition-all self-start sm:self-auto"
        >
          <Plus className="w-4 h-4" />
          <span>Thêm giảng viên</span>
        </button>
      </div>

      {/* Filter Row */}
      <div className="grid grid-cols-1 md:grid-cols-12 gap-3 bg-white p-3 rounded-2xl border border-stone-200 shadow-sm">
        <div className="md:col-span-5">
          <input
            type="text"
            placeholder="Tìm tên hoặc mã giảng viên..."
            className="w-full px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513]"
          />
        </div>
        <div className="md:col-span-3 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Tất cả cơ sở</option>
            <option>Quận 3</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
        <div className="md:col-span-2 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Chuyên môn</option>
            <option>Massage chuyên nghiệp</option>
            <option>Chăm sóc da</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
        <div className="md:col-span-2 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Trạng thái phân công</option>
            <option>Có phân công</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
      </div>

      {/* Main 2 Column Grid */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-6">
        {/* Left: Instructors Table (8 cols) */}
        <div className="lg:col-span-8 bg-white p-5 rounded-2xl border border-stone-200 shadow-sm space-y-4">
          <div className="flex items-center justify-between">
            <h3 className="text-sm font-bold text-stone-900">Giảng viên trong danh sách mẫu</h3>
            <span className="text-[11px] font-semibold text-[#8B4513] bg-[#F5EBE1] px-2.5 py-0.5 rounded-full">
              3 bản ghi mẫu
            </span>
          </div>

          <div className="overflow-x-auto">
            <table className="w-full text-left text-xs">
              <thead className="bg-[#F5EBE1] text-stone-700 font-semibold">
                <tr>
                  <th className="py-2.5 px-3 rounded-l-lg">Giảng viên</th>
                  <th className="py-2.5 px-3">Chuyên môn</th>
                  <th className="py-2.5 px-3">Lớp được phân công</th>
                  <th className="py-2.5 px-3 rounded-r-lg">Cơ sở / trạng thái</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-stone-100">
                <tr className="hover:bg-stone-50 bg-amber-50/30">
                  <td className="py-3 px-3">
                    <div className="flex items-center gap-2.5">
                      <div className="w-8 h-8 rounded-full bg-[#F5EBE1] text-[#8B4513] font-bold flex items-center justify-center">
                        TH
                      </div>
                      <div>
                        <div className="font-bold text-stone-900">Nguyễn Thanh Hương</div>
                        <div className="text-[11px] text-stone-400">GV-MH-001 · Giảng viên kỹ thuật Spa</div>
                      </div>
                    </div>
                  </td>
                  <td className="py-3 px-3 text-stone-700 font-medium">Massage chuyên nghiệp</td>
                  <td className="py-3 px-3">
                    <div className="text-stone-900">MCN-0926 · Đang học</div>
                    <div className="text-[11px] text-stone-400">MCN-1026 · Dự kiến</div>
                  </td>
                  <td className="py-3 px-3">
                    <div className="text-stone-700 font-medium">Quận 3</div>
                    <span className="inline-block mt-0.5 px-2 py-0.5 bg-[#F5EBE1] text-[#8B4513] text-[10px] font-bold rounded">
                      Có phân công mẫu
                    </span>
                  </td>
                </tr>

                <tr className="hover:bg-stone-50">
                  <td className="py-3 px-3">
                    <div className="flex items-center gap-2.5">
                      <div className="w-8 h-8 rounded-full bg-stone-100 text-stone-600 font-bold flex items-center justify-center">
                        MC
                      </div>
                      <div>
                        <div className="font-bold text-stone-900">Trần Minh Châu</div>
                        <div className="text-[11px] text-stone-400">GV-MH-002 · Hồ sơ giả định</div>
                      </div>
                    </div>
                  </td>
                  <td className="py-3 px-3 text-stone-700 font-medium">Chăm sóc da</td>
                  <td className="py-3 px-3">
                    <div className="text-stone-900">Chuyên đề mẫu</div>
                    <div className="text-[11px] text-stone-400">14/10/2026</div>
                  </td>
                  <td className="py-3 px-3">
                    <div className="text-stone-700 font-medium">Quận 3</div>
                    <span className="inline-block mt-0.5 px-2 py-0.5 bg-[#F5EBE1] text-[#8B4513] text-[10px] font-bold rounded">
                      Có phân công mẫu
                    </span>
                  </td>
                </tr>

                <tr className="hover:bg-stone-50">
                  <td className="py-3 px-3">
                    <div className="flex items-center gap-2.5">
                      <div className="w-8 h-8 rounded-full bg-stone-100 text-stone-600 font-bold flex items-center justify-center">
                        QB
                      </div>
                      <div>
                        <div className="font-bold text-stone-900">Lê Quốc Bảo</div>
                        <div className="text-[11px] text-stone-400">GV-MH-003 · Hồ sơ giả định</div>
                      </div>
                    </div>
                  </td>
                  <td className="py-3 px-3 text-stone-700 font-medium">Chăm sóc cơ thể</td>
                  <td className="py-3 px-3">
                    <div className="text-stone-900">Chuyên đề mẫu</div>
                    <div className="text-[11px] text-stone-400">15/10/2026</div>
                  </td>
                  <td className="py-3 px-3">
                    <div className="text-stone-700 font-medium">Quận 3</div>
                    <span className="inline-block mt-0.5 px-2 py-0.5 bg-[#F5EBE1] text-[#8B4513] text-[10px] font-bold rounded">
                      Có phân công mẫu
                    </span>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>

          <div className="flex items-center justify-between pt-4 border-t border-stone-100 text-[11px] text-stone-400">
            <span>Hiển thị 3 / 3 bản ghi minh họa</span>
            <div className="flex items-center gap-1">
              <button className="p-1 rounded hover:bg-stone-100"><ChevronLeft className="w-3.5 h-3.5" /></button>
              <span className="px-2 py-0.5 rounded bg-[#F5EBE1] text-[#8B4513] font-bold">1</span>
              <button className="p-1 rounded hover:bg-stone-100"><ChevronRight className="w-3.5 h-3.5" /></button>
            </div>
          </div>
        </div>

        {/* Right: Selected Instructor (4 cols) */}
        <div className="lg:col-span-4 space-y-4">
          <div className="bg-white p-5 rounded-2xl border border-stone-200 shadow-sm space-y-3 text-xs">
            <h3 className="text-sm font-bold text-stone-900">Giảng viên đang chọn</h3>

            <div className="flex items-center gap-2.5 p-2 bg-stone-50 rounded-xl">
              <div className="w-9 h-9 rounded-full bg-[#F5EBE1] text-[#8B4513] font-bold flex items-center justify-center">
                TH
              </div>
              <div>
                <div className="font-bold text-stone-900">Nguyễn Thanh Hương</div>
                <div className="text-[10px] text-stone-400">GV-MH-001 · Quận 3</div>
              </div>
            </div>

            <span className="inline-block px-2.5 py-0.5 bg-[#F5EBE1] text-[#8B4513] text-[10px] font-bold rounded">
              Giảng viên kỹ thuật Spa
            </span>

            <div className="space-y-2 pt-2">
              <div className="font-bold text-sm text-stone-900">Kỹ thuật Massage Chuyên Nghiệp</div>
              <div className="flex justify-between border-b border-stone-100 py-1">
                <span className="text-stone-400">Lớp đang giảng dạy:</span>
                <span className="font-bold text-stone-800">MCN-0926</span>
              </div>
              <div className="flex justify-between border-b border-stone-100 py-1">
                <span className="text-stone-400">Lớp sắp phân công:</span>
                <span className="font-semibold text-stone-800">MCN-1026</span>
              </div>
              <div className="flex justify-between border-b border-stone-100 py-1">
                <span className="text-stone-400">Ngày mở lớp mới:</span>
                <span className="font-medium text-stone-800">23/10/2026</span>
              </div>
              <div className="flex justify-between border-b border-stone-100 py-1">
                <span className="text-stone-400">Buổi thực hành kế tiếp:</span>
                <span className="font-semibold text-stone-800">16/10/2026</span>
              </div>
              <div className="flex justify-between border-b border-stone-100 py-1">
                <span className="text-stone-400">Thời gian:</span>
                <span className="font-medium text-stone-800">13:00–17:00</span>
              </div>
              <div className="flex justify-between border-b border-stone-100 py-1">
                <span className="text-stone-400">Phòng:</span>
                <span className="font-semibold text-stone-800">Thực hành 02</span>
              </div>
            </div>

            <button
              onClick={() => alert('Phân công lớp cho Nguyễn Thanh Hương (minh họa)')}
              className="w-full py-2.5 border border-stone-300 hover:border-stone-400 text-stone-800 font-semibold rounded-xl text-xs transition-all"
            >
              Phân công lớp
            </button>
            <div className="text-[10px] text-stone-400 italic">
              Hồ sơ, vai trò và phân công đều là minh họa, không xác nhận bằng cấp hoặc chứng chỉ nghề.
            </div>
          </div>
        </div>
      </div>

      {/* Bottom Row */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-6">
        {/* Teaching Schedule of the Week (8 cols) */}
        <div className="lg:col-span-8 bg-white p-5 rounded-2xl border border-stone-200 shadow-sm space-y-3">
          <h3 className="text-sm font-bold text-stone-900">
            Lịch giảng dạy tuần · 12/10/2026 – 18/10/2026
          </h3>

          <div className="space-y-2.5 text-xs">
            <div className="p-3 bg-[#F5EBE1] rounded-xl flex items-center justify-between">
              <div>
                <span className="font-bold text-stone-900">14/10/2026 · 09:00–12:00</span>
                <div className="text-[11px] text-stone-600 mt-0.5">Trần Minh Châu · Chuyên đề chăm sóc da · Phòng thực hành 01</div>
              </div>
            </div>
            <div className="p-3 bg-[#F5EBE1] rounded-xl flex items-center justify-between">
              <div>
                <span className="font-bold text-stone-900">15/10/2026 · 09:00–12:00</span>
                <div className="text-[11px] text-stone-600 mt-0.5">Lê Quốc Bảo · Chuyên đề cơ thể · Phòng thực hành 03</div>
              </div>
            </div>
            <div className="p-3 bg-[#F5EBE1] rounded-xl flex items-center justify-between border-2 border-[#8B4513]/30">
              <div>
                <span className="font-bold text-[#8B4513]">16/10/2026 · 13:00–17:00</span>
                <div className="text-[11px] text-stone-600 mt-0.5">Nguyễn Thanh Hương · MCN-0926 · Phòng thực hành 02</div>
              </div>
            </div>
          </div>
          <div className="text-[10px] text-stone-400 italic">
            Chuyên đề của Minh Châu và Quốc Bảo là dữ liệu mới giả định; không trùng giảng viên hoặc phòng với MCN-0926.
          </div>
        </div>

        {/* Availability & Notes (4 cols) */}
        <div className="lg:col-span-4 bg-[#F5EBE1] p-5 rounded-2xl border border-[#E5D5C5] text-xs space-y-2 flex flex-col justify-between">
          <div>
            <h4 className="font-bold text-stone-900">Khả dụng & lưu ý</h4>
            <div className="mt-2 text-stone-700 leading-relaxed text-[11px]">
              <strong>Đối chiếu lịch trước khi phân công:</strong> Trong tuần chọn, Hương có buổi 16/10/2026, 13:00–17:00. MCN-1026 chỉ bắt đầu từ 23/10/2026.
            </div>
          </div>
          <div className="text-[10px] text-stone-500 italic pt-2 border-t border-[#E5D5C5]">
            Các khung giờ ngoài lịch hiển thị chưa được xác nhận là khả dụng. Không có thực hiện phân công tự động.
          </div>
        </div>
      </div>
    </div>
  );
};
