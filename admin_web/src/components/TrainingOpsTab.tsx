import React from 'react';
import {
  Plus,
  ChevronDown,
  Video,
  FileCheck,
} from 'lucide-react';

export const TrainingOpsTab: React.FC = () => {
  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-stone-900 tracking-tight">Vận hành đào tạo</h1>
          <p className="text-xs text-stone-500 mt-1">
            Lớp học, phòng thực hành và chương trình · Tuần 12/10/2026 – 18/10/2026
          </p>
        </div>
        <button
          onClick={() => alert('Tạo lớp học mới (minh họa)')}
          className="flex items-center gap-1.5 px-4 py-2.5 bg-[#8B4513] hover:bg-[#72380F] text-white text-xs font-semibold rounded-xl shadow-sm transition-all self-start sm:self-auto"
        >
          <Plus className="w-4 h-4" />
          <span>Tạo lớp học</span>
        </button>
      </div>

      {/* Filter Row */}
      <div className="grid grid-cols-1 md:grid-cols-12 gap-3 bg-white p-3 rounded-2xl border border-stone-200 shadow-sm">
        <div className="md:col-span-5">
          <input
            type="text"
            placeholder="Tìm lớp, giảng viên hoặc phòng..."
            className="w-full px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513]"
          />
        </div>
        <div className="md:col-span-3 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>12/10/2026 – 18/10/2026</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
        <div className="md:col-span-2 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Quận 3</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
        <div className="md:col-span-2 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Tất cả trạng thái</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
      </div>

      {/* Main 2 Column Grid */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-6">
        {/* Practice Room Weekly Schedule (8 cols) */}
        <div className="lg:col-span-8 bg-white p-5 rounded-2xl border border-stone-200 shadow-sm space-y-4 overflow-x-auto">
          <div className="flex items-center justify-between">
            <h3 className="text-sm font-bold text-stone-900">Lịch phòng thực hành tuần</h3>
            <span className="text-[11px] font-semibold text-[#8B4513] bg-[#F5EBE1] px-2.5 py-0.5 rounded-full">
              3 buổi mẫu đã lập
            </span>
          </div>

          <div className="min-w-[650px]">
            {/* Week Days Header */}
            <div className="grid grid-cols-8 border-b border-stone-200 pb-2 text-xs font-bold text-stone-500 text-center">
              <div className="text-left font-bold text-stone-400">PHÒNG</div>
              <div>Thứ hai<br /><span className="text-[10px] font-normal">12/10</span></div>
              <div>Thứ ba<br /><span className="text-[10px] font-normal">13/10</span></div>
              <div>Thứ tư<br /><span className="text-[10px] font-normal">14/10</span></div>
              <div>Thứ năm<br /><span className="text-[10px] font-normal">15/10</span></div>
              <div>Thứ sáu<br /><span className="text-[10px] font-normal">16/10</span></div>
              <div>Thứ bảy<br /><span className="text-[10px] font-normal">17/10</span></div>
              <div>Chủ nhật<br /><span className="text-[10px] font-normal">18/10</span></div>
            </div>

            {/* Room 1 */}
            <div className="grid grid-cols-8 py-3 border-b border-stone-100 items-center min-h-[60px] text-xs">
              <div className="font-semibold text-stone-800">Phòng thực hành 01</div>
              <div></div>
              <div></div>
              <div className="p-2 bg-[#F5EBE1] border border-[#E5D5C5] rounded-xl text-center">
                <div className="font-bold text-stone-900 text-[10px]">Chăm sóc da</div>
                <div className="text-[9px] text-stone-500">09:00–12:00 · Minh Châu</div>
              </div>
              <div></div>
              <div></div>
              <div></div>
              <div></div>
            </div>

            {/* Room 2: Focus MCN-0926 */}
            <div className="grid grid-cols-8 py-3 border-b border-stone-100 items-center min-h-[70px] text-xs bg-amber-50/20">
              <div className="font-semibold text-stone-800">Phòng thực hành 02</div>
              <div></div>
              <div></div>
              <div></div>
              <div></div>
              <div className="p-2 bg-white border-2 border-[#8B4513] rounded-xl text-center shadow-sm">
                <div className="font-bold text-[#8B4513] text-[10px]">MCN-0926</div>
                <div className="text-[9px] text-stone-600">13:00–17:00 · Thanh Hương</div>
              </div>
              <div></div>
              <div></div>
            </div>

            {/* Room 3 */}
            <div className="grid grid-cols-8 py-3 items-center min-h-[60px] text-xs">
              <div className="font-semibold text-stone-800">Phòng thực hành 03</div>
              <div></div>
              <div></div>
              <div></div>
              <div className="p-2 bg-[#F5EBE1] border border-[#E5D5C5] rounded-xl text-center">
                <div className="font-bold text-stone-900 text-[10px]">Chăm sóc cơ thể</div>
                <div className="text-[9px] text-stone-500">09:00–12:00 · Quốc Bảo</div>
              </div>
              <div></div>
              <div></div>
              <div></div>
            </div>
          </div>

          <div className="text-[10px] text-stone-400 italic pt-2">
            MCN-0926 có lịch định kỳ thứ 6–7–Chủ nhật, 13:00–17:00. Tuần chọn chỉ hiển thị buổi 16/10/2026 đã có nội dung mẫu; các buổi khác chưa lập chi tiết.
          </div>
        </div>

        {/* Right: Selected Session (4 cols) */}
        <div className="lg:col-span-4 space-y-4">
          <div className="bg-white p-5 rounded-2xl border border-stone-200 shadow-sm space-y-3 text-xs">
            <div className="flex items-center justify-between">
              <h3 className="text-sm font-bold text-stone-900">Buổi đang chọn · 16/10/2026</h3>
              <span className="text-[10px] font-bold px-2 py-0.5 rounded bg-stone-100 text-stone-600">
                Chưa diễn ra
              </span>
            </div>

            <div className="font-bold text-stone-900 text-sm">
              Thực hành kỹ thuật massage cơ bản
            </div>

            <div className="space-y-2 pt-2">
              <div className="flex justify-between border-b border-stone-100 py-1">
                <span className="text-stone-400">Lớp / phòng:</span>
                <span className="font-bold text-stone-800">MCN-0926 · Phòng 02</span>
              </div>
              <div className="flex justify-between border-b border-stone-100 py-1">
                <span className="text-stone-400">Giảng viên:</span>
                <span className="font-semibold text-stone-800">Nguyễn Thanh Hương</span>
              </div>
              <div className="flex justify-between border-b border-stone-100 py-1">
                <span className="text-stone-400">Khung buổi học:</span>
                <span className="font-medium text-stone-800">13:00–17:00</span>
              </div>
              <div className="flex justify-between border-b border-stone-100 py-1">
                <span className="text-stone-400 flex items-center gap-1"><Video className="w-3 h-3" /> Video Bài 05:</span>
                <span className="font-bold text-stone-800">18 phút</span>
              </div>
              <div className="flex justify-between border-b border-stone-100 py-1">
                <span className="text-stone-400">Thực hành:</span>
                <span className="font-bold text-stone-800">120 phút</span>
              </div>
              <div className="flex justify-between border-b border-stone-100 py-1">
                <span className="text-stone-400">Chuẩn bị phòng:</span>
                <span className="font-medium text-stone-800">12:45–13:00</span>
              </div>
            </div>

            <div className="p-2.5 bg-amber-50 rounded-xl text-amber-800 text-[11px] font-semibold flex items-center gap-1.5 border border-amber-200">
              <FileCheck className="w-3.5 h-3.5" />
              <span>Điểm danh chờ xác nhận</span>
            </div>

            <div className="text-[10px] text-stone-400 italic">
              Nhân sự được phân quyền đối chiếu chuyên cần sau buổi học; không có điểm danh QR thực tế.
            </div>

            <button
              onClick={() => alert('Lập lịch thực hành cho buổi kế tiếp (minh họa)')}
              className="w-full py-2.5 border border-stone-300 hover:border-stone-400 text-stone-800 font-semibold rounded-xl text-xs transition-all"
            >
              Lập lịch thực hành
            </button>
          </div>
        </div>
      </div>

      {/* Bottom Table: Danh sách lớp đào tạo */}
      <div className="bg-white p-5 rounded-2xl border border-stone-200 shadow-sm">
        <div className="flex items-center justify-between mb-4">
          <h3 className="text-sm font-bold text-stone-900">Danh sách lớp đào tạo</h3>
          <span className="text-[11px] font-semibold text-[#8B4513] bg-[#F5EBE1] px-2.5 py-0.5 rounded-full">
            3 bản ghi mẫu
          </span>
        </div>

        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs">
            <thead className="bg-[#F5EBE1] text-stone-700 font-semibold">
              <tr>
                <th className="py-2.5 px-3 rounded-l-lg">Khóa / lớp</th>
                <th className="py-2.5 px-3">Giảng viên</th>
                <th className="py-2.5 px-3">Cơ sở / phòng</th>
                <th className="py-2.5 px-3">Lịch học / bắt đầu</th>
                <th className="py-2.5 px-3">Sĩ số mẫu</th>
                <th className="py-2.5 px-3 rounded-r-lg">Trạng thái</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-stone-100">
              <tr className="hover:bg-stone-50 bg-amber-50/20">
                <td className="py-3 px-3">
                  <div className="font-bold text-stone-900">Kỹ thuật Massage Chuyên Nghiệp</div>
                  <div className="text-[11px] text-stone-400">MCN-0926 · Khóa hiện tại</div>
                </td>
                <td className="py-3 px-3 font-medium text-stone-800">Nguyễn Thanh Hương</td>
                <td className="py-3 px-3 text-stone-600">Quận 3 · Thực hành 02</td>
                <td className="py-3 px-3">
                  <div className="text-stone-800">Thứ 6–7–CN · 13:00–17:00</div>
                  <div className="text-[10px] text-stone-400">Đang triển khai</div>
                </td>
                <td className="py-3 px-3 font-semibold text-stone-800">16/20</td>
                <td className="py-3 px-3">
                  <span className="px-2 py-0.5 bg-amber-100 text-amber-800 text-[10px] font-bold rounded">
                    Đang học
                  </span>
                </td>
              </tr>

              <tr className="hover:bg-stone-50">
                <td className="py-3 px-3">
                  <div className="font-bold text-stone-900">Kỹ thuật Massage Chuyên Nghiệp</div>
                  <div className="text-[11px] text-stone-400">MCN-1026 · Đợt tuyển sinh mới</div>
                </td>
                <td className="py-3 px-3 font-medium text-stone-800">Nguyễn Thanh Hương</td>
                <td className="py-3 px-3 text-stone-600">Quận 3 · Thực hành 02 · Dự kiến</td>
                <td className="py-3 px-3">
                  <div className="text-stone-800">Thứ 6–7–CN · 13:00–17:00</div>
                  <div className="text-[10px] text-stone-400">Bắt đầu 23/10/2026</div>
                </td>
                <td className="py-3 px-3 text-stone-500">0/20</td>
                <td className="py-3 px-3">
                  <span className="px-2 py-0.5 bg-stone-100 text-stone-600 text-[10px] font-bold rounded">
                    Chờ hồ sơ / cọc
                  </span>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};
