import React from 'react';
import {
  Plus,
  ChevronDown,
  ChevronLeft,
  ChevronRight,
  Clock,
  Send,
  AlertCircle,
} from 'lucide-react';

export const AdmissionsTab: React.FC = () => {
  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-stone-900 tracking-tight">Tuyển sinh</h1>
          <p className="text-xs text-stone-500 mt-1">
            Theo dõi hồ sơ tư vấn, khoản cọc và kế hoạch xếp lớp · 4 hồ sơ mẫu.
          </p>
        </div>
        <button
          onClick={() => alert('Tạo hồ sơ tuyển sinh mới (minh họa)')}
          className="flex items-center gap-1.5 px-4 py-2.5 bg-[#8B4513] hover:bg-[#72380F] text-white text-xs font-semibold rounded-xl shadow-sm transition-all self-start sm:self-auto"
        >
          <Plus className="w-4 h-4" />
          <span>Tạo hồ sơ tuyển sinh</span>
        </button>
      </div>

      {/* 4 Pipeline Stats Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        <div className="bg-white p-4 rounded-2xl border border-stone-200 shadow-sm">
          <div className="text-xs font-bold text-stone-700">Hồ sơ mới</div>
          <div className="text-xl font-bold text-stone-900 mt-1">1 hồ sơ mẫu</div>
          <div className="text-[11px] text-stone-400 mt-0.5">Phạm Thanh Mai</div>
        </div>

        <div className="bg-white p-4 rounded-2xl border border-stone-200 shadow-sm">
          <div className="text-xs font-bold text-stone-700">Chờ tư vấn</div>
          <div className="text-xl font-bold text-stone-900 mt-1">1 hồ sơ mẫu</div>
          <div className="text-[11px] text-stone-400 mt-0.5">Trần Ngọc Linh</div>
        </div>

        <div className="bg-white p-4 rounded-2xl border border-stone-200 shadow-sm">
          <div className="text-xs font-bold text-stone-700">Chờ thanh toán</div>
          <div className="text-xl font-bold text-[#8B4513] mt-1">1 hồ sơ mẫu</div>
          <div className="text-[11px] text-stone-400 mt-0.5">Nguyễn Minh Anh · HV-DEMO-000256</div>
        </div>

        <div className="bg-white p-4 rounded-2xl border border-stone-200 shadow-sm">
          <div className="text-xs font-bold text-stone-700">Chờ xếp lớp</div>
          <div className="text-xl font-bold text-stone-900 mt-1">1 hồ sơ mẫu</div>
          <div className="text-[11px] text-stone-400 mt-0.5">Nguyễn Minh Anh · Spa Cơ bản</div>
        </div>
      </div>

      {/* Filter Row */}
      <div className="grid grid-cols-1 md:grid-cols-12 gap-3 bg-white p-3 rounded-2xl border border-stone-200 shadow-sm">
        <div className="md:col-span-5">
          <input
            type="text"
            placeholder="Tìm tên, số điện thoại, mã hồ sơ..."
            className="w-full px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513]"
          />
        </div>
        <div className="md:col-span-3 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Tất cả chương trình</option>
            <option>Kỹ thuật Massage Chuyên Nghiệp</option>
            <option>Kỹ thuật Spa Cơ bản</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
        <div className="md:col-span-2 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Tất cả giai đoạn</option>
            <option>Chờ thanh toán</option>
            <option>Chờ xếp lớp</option>
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

      {/* Main 2 Column Grid */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-6">
        {/* Left: Admissions Table (8 cols) */}
        <div className="lg:col-span-8 bg-white p-5 rounded-2xl border border-stone-200 shadow-sm space-y-4">
          <div className="flex items-center justify-between">
            <h3 className="text-sm font-bold text-stone-900">Hồ sơ tuyển sinh minh họa</h3>
            <span className="text-[11px] font-semibold text-[#8B4513] bg-[#F5EBE1] px-2.5 py-0.5 rounded-full">
              4 bản ghi mẫu
            </span>
          </div>

          <div className="overflow-x-auto">
            <table className="w-full text-left text-xs">
              <thead className="bg-[#F5EBE1] text-stone-700 font-semibold">
                <tr>
                  <th className="py-2.5 px-3 rounded-l-lg">Ứng viên / mã hồ sơ</th>
                  <th className="py-2.5 px-3">Chương trình / lớp</th>
                  <th className="py-2.5 px-3">Học phí / khoản thu</th>
                  <th className="py-2.5 px-3 rounded-r-lg">Giai đoạn</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-stone-100">
                <tr className="hover:bg-stone-50 bg-amber-50/30">
                  <td className="py-3 px-3">
                    <div className="font-bold text-stone-900">Nguyễn Minh Anh</div>
                    <div className="text-[11px] text-stone-400">HV-DEMO-000256</div>
                  </td>
                  <td className="py-3 px-3">
                    <div className="font-medium text-stone-800">Kỹ thuật Massage Chuyên Nghiệp</div>
                    <div className="text-[11px] text-stone-400">MCN-1026 · 23/10/2026</div>
                  </td>
                  <td className="py-3 px-3">
                    <div className="font-bold text-stone-900">9.000.000đ</div>
                    <div className="text-[11px] text-[#8B4513] font-semibold">Cọc 2.000.000đ chưa thu</div>
                  </td>
                  <td className="py-3 px-3">
                    <span className="inline-flex items-center gap-1 px-2.5 py-1 bg-amber-50 text-amber-700 border border-amber-200 rounded text-[10px] font-bold">
                      <Clock className="w-3 h-3" />
                      Chờ thanh toán
                    </span>
                  </td>
                </tr>

                <tr className="hover:bg-stone-50">
                  <td className="py-3 px-3">
                    <div className="font-bold text-stone-900">Nguyễn Minh Anh</div>
                    <div className="text-[11px] text-stone-400">HV-MH-HP-001</div>
                  </td>
                  <td className="py-3 px-3">
                    <div className="font-medium text-stone-800">Kỹ thuật Spa Cơ bản</div>
                    <div className="text-[11px] text-stone-400">Chưa xếp lớp</div>
                  </td>
                  <td className="py-3 px-3">
                    <div className="font-bold text-stone-900">Đã thu 4.500.000đ</div>
                    <div className="text-[11px] text-stone-400">MH-HP-1001 · 01/10/2026</div>
                  </td>
                  <td className="py-3 px-3">
                    <span className="px-2 py-0.5 bg-stone-100 text-stone-700 rounded text-[10px] font-bold">
                      Chờ xếp lớp
                    </span>
                  </td>
                </tr>

                <tr className="hover:bg-stone-50">
                  <td className="py-3 px-3">
                    <div className="font-bold text-stone-900">Phạm Thanh Mai</div>
                    <div className="text-[11px] text-stone-400">HV-MH-003 · 09•••••• 503</div>
                  </td>
                  <td className="py-3 px-3">
                    <div className="font-medium text-stone-800">Chăm sóc da cơ bản</div>
                    <div className="text-[11px] text-stone-400">Quan tâm lịch cuối tuần</div>
                  </td>
                  <td className="py-3 px-3 text-stone-500">
                    Báo giá tham khảo<br />Chưa có hợp đồng
                  </td>
                  <td className="py-3 px-3">
                    <span className="px-2 py-0.5 bg-blue-50 text-blue-700 rounded text-[10px] font-bold">
                      Hồ sơ mới
                    </span>
                  </td>
                </tr>

                <tr className="hover:bg-stone-50">
                  <td className="py-3 px-3">
                    <div className="font-bold text-stone-900">Trần Ngọc Linh</div>
                    <div className="text-[11px] text-stone-400">HV-MH-004 · 09•••••• 214</div>
                  </td>
                  <td className="py-3 px-3">
                    <div className="font-medium text-stone-800">Kỹ thuật Spa Cơ bản</div>
                    <div className="text-[11px] text-stone-400">Chờ tư vấn khung giờ</div>
                  </td>
                  <td className="py-3 px-3 text-stone-500">
                    Chưa chốt học phí<br />Chưa phát sinh khoản thu
                  </td>
                  <td className="py-3 px-3">
                    <span className="px-2 py-0.5 bg-stone-100 text-stone-700 rounded text-[10px] font-bold">
                      Chờ tư vấn
                    </span>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>

          <div className="flex items-center justify-between pt-4 border-t border-stone-100 text-[11px] text-stone-400">
            <span>Hiển thị 4 / 4 bản ghi minh họa</span>
            <div className="flex items-center gap-1">
              <button className="p-1 rounded hover:bg-stone-100"><ChevronLeft className="w-3.5 h-3.5" /></button>
              <span className="px-2 py-0.5 rounded bg-[#F5EBE1] text-[#8B4513] font-bold">1</span>
              <button className="p-1 rounded hover:bg-stone-100"><ChevronRight className="w-3.5 h-3.5" /></button>
            </div>
          </div>
        </div>

        {/* Right: Selected Candidate (4 cols) */}
        <div className="lg:col-span-4 space-y-4">
          <div className="bg-white p-5 rounded-2xl border border-stone-200 shadow-sm space-y-3 text-xs">
            <div className="flex items-center justify-between">
              <h3 className="text-sm font-bold text-stone-900">Hồ sơ đang chọn</h3>
              <span className="text-[10px] font-bold px-2 py-0.5 rounded bg-[#F5EBE1] text-[#8B4513]">
                Chờ cọc tuyển sinh
              </span>
            </div>

            <div className="flex items-center gap-2.5 p-2 bg-stone-50 rounded-xl">
              <img
                src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150"
                alt="Avatar"
                className="w-8 h-8 rounded-full object-cover"
              />
              <div>
                <div className="font-bold text-stone-900">Nguyễn Minh Anh</div>
                <div className="text-[10px] text-stone-400">0912 345 678 · HV-DEMO-000256</div>
              </div>
            </div>

            <div className="space-y-2 pt-2">
              <div className="font-bold text-sm text-stone-900">Kỹ thuật Massage Chuyên Nghiệp</div>
              <div className="flex justify-between border-b border-stone-100 py-1">
                <span className="text-stone-400">Kinh nghiệm trước đó:</span>
                <span className="font-medium text-stone-800">Đã học cơ bản</span>
              </div>
              <div className="flex justify-between border-b border-stone-100 py-1">
                <span className="text-stone-400">Chi nhánh:</span>
                <span className="font-medium text-stone-800">Quận 3</span>
              </div>
              <div className="flex justify-between border-b border-stone-100 py-1">
                <span className="text-stone-400">Lớp dự kiến:</span>
                <span className="font-semibold text-stone-800">MCN-1026</span>
              </div>
              <div className="flex justify-between border-b border-stone-100 py-1">
                <span className="text-stone-400">Bắt đầu:</span>
                <span className="font-medium text-stone-800">23/10/2026</span>
              </div>
              <div className="flex justify-between border-b border-stone-100 py-1">
                <span className="text-stone-400">Lịch học:</span>
                <span className="font-medium text-stone-800">Thứ 6–7–CN (13:00–17:00)</span>
              </div>
              <div className="flex justify-between border-b border-stone-100 py-1">
                <span className="text-stone-400">Giảng viên:</span>
                <span className="font-semibold text-stone-800">Nguyễn Thanh Hương</span>
              </div>
              <div className="flex justify-between border-b border-stone-100 py-1">
                <span className="text-stone-400">Học phí hợp đồng:</span>
                <span className="font-bold text-stone-900">9.000.000đ</span>
              </div>
              <div className="flex justify-between border-b border-stone-100 py-1">
                <span className="text-stone-400">Cọc cần thu:</span>
                <span className="font-bold text-[#8B4513]">2.000.000đ</span>
              </div>
              <div className="flex justify-between border-b border-stone-100 py-1">
                <span className="text-stone-400">Còn lại trả sau:</span>
                <span className="font-bold text-stone-800">7.000.000đ</span>
              </div>
            </div>

            <button
              onClick={() => alert('Gửi thông tin lớp cho ứng viên (minh họa)')}
              className="w-full py-2.5 border border-stone-300 hover:border-stone-400 text-stone-800 font-semibold rounded-xl text-xs transition-all flex items-center justify-center gap-1.5"
            >
              <Send className="w-3.5 h-3.5" />
              <span>Gửi thông tin lớp</span>
            </button>
          </div>
        </div>
      </div>

      {/* Việc cần làm Notice */}
      <div className="bg-[#F5EBE1] p-5 rounded-2xl border border-[#E5D5C5] text-xs space-y-1">
        <h4 className="font-bold text-stone-900 flex items-center gap-1.5">
          <AlertCircle className="w-4 h-4 text-[#8B4513]" />
          Đối chiếu khoản cọc trước khi ghi danh lớp mới
        </h4>
        <p className="text-stone-600">
          HV-DEMO-000256: 2.000.000đ chưa thanh toán. Không tính cam kết 9.000.000đ vào doanh thu đã thu.
        </p>
      </div>
    </div>
  );
};
