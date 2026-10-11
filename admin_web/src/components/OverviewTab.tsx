import React from 'react';
import {
  Wallet,
  Receipt,
  Calendar,
  Sparkles,
  GraduationCap,
  ChevronDown,
  ChevronLeft,
  ChevronRight,
} from 'lucide-react';

interface OverviewTabProps {
  onNavigateTab: (tab: string) => void;
}

export const OverviewTab: React.FC<OverviewTabProps> = ({ onNavigateTab }) => {
  return (
    <div className="space-y-6">
      {/* Page Header */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-stone-900 tracking-tight">Tổng quan vận hành</h1>
          <p className="text-xs text-stone-500 mt-1">
            Bức tranh vận hành chuỗi spa và học viện · 01/10/2026 – 08/10/2026
          </p>
        </div>
        <button
          onClick={() => onNavigateTab('revenue_report')}
          className="px-4 py-2.5 bg-[#8B4513] hover:bg-[#72380F] text-white text-xs font-semibold rounded-xl shadow-sm transition-all text-center self-start sm:self-auto"
        >
          Xem báo cáo doanh thu
        </button>
      </div>

      {/* Filter Row */}
      <div className="grid grid-cols-1 md:grid-cols-12 gap-3 bg-white p-3 rounded-2xl border border-stone-200 shadow-sm">
        <div className="md:col-span-6">
          <input
            type="text"
            placeholder="Tìm khách hàng, lịch hẹn, lớp học..."
            className="w-full px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513]"
          />
        </div>
        <div className="md:col-span-3 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>01/10/2026 – 08/10/2026</option>
            <option>Tháng 10/2026</option>
            <option>Hôm nay</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
        <div className="md:col-span-3 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Tất cả chi nhánh</option>
            <option>Chi nhánh mẫu 01 — Quận 3</option>
            <option>Chi nhánh mẫu 02 — Cầu Giấy</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
      </div>

      {/* 5 Stats Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-5 gap-3">
        {/* Card 1 */}
        <div className="bg-white p-4 rounded-2xl border border-stone-200 shadow-sm">
          <div className="flex items-center justify-between text-stone-500 text-xs font-medium">
            <span>Thực thu trong kỳ</span>
            <Wallet className="w-4 h-4 text-[#8B4513]" />
          </div>
          <div className="text-xl font-bold text-stone-900 mt-2">8.550.000đ</div>
          <div className="text-[11px] text-stone-400 mt-1">Chỉ 3 biên nhận đã hoàn tất</div>
        </div>

        {/* Card 2 */}
        <div className="bg-white p-4 rounded-2xl border border-stone-200 shadow-sm">
          <div className="flex items-center justify-between text-stone-500 text-xs font-medium">
            <span>Giao dịch đã thanh toán</span>
            <Receipt className="w-4 h-4 text-[#8B4513]" />
          </div>
          <div className="text-xl font-bold text-stone-900 mt-2">3</div>
          <div className="text-[11px] text-stone-400 mt-1">Hoàn tiền: 0đ</div>
        </div>

        {/* Card 3 */}
        <div
          onClick={() => onNavigateTab('staff_schedule')}
          className="bg-white p-4 rounded-2xl border border-stone-200 shadow-sm hover:border-[#8B4513] transition-colors cursor-pointer"
        >
          <div className="flex items-center justify-between text-stone-500 text-xs font-medium">
            <span>Lịch hẹn sắp tới</span>
            <Calendar className="w-4 h-4 text-[#8B4513]" />
          </div>
          <div className="text-xl font-bold text-stone-900 mt-2">2</div>
          <div className="text-[11px] text-stone-400 mt-1">Nguyễn Minh Anh · 1 chờ cọc</div>
        </div>

        {/* Card 4 */}
        <div
          onClick={() => onNavigateTab('treatments')}
          className="bg-white p-4 rounded-2xl border border-stone-200 shadow-sm hover:border-[#8B4513] transition-colors cursor-pointer"
        >
          <div className="flex items-center justify-between text-stone-500 text-xs font-medium">
            <span>Gói liệu trình đang dùng</span>
            <Sparkles className="w-4 h-4 text-[#8B4513]" />
          </div>
          <div className="text-xl font-bold text-stone-900 mt-2">2</div>
          <div className="text-[11px] text-stone-400 mt-1">Nguyễn Minh Anh · 11 buổi còn</div>
        </div>

        {/* Card 5 */}
        <div
          onClick={() => onNavigateTab('students')}
          className="bg-white p-4 rounded-2xl border border-stone-200 shadow-sm hover:border-[#8B4513] transition-colors cursor-pointer"
        >
          <div className="flex items-center justify-between text-stone-500 text-xs font-medium">
            <span>Khóa đã ghi danh</span>
            <GraduationCap className="w-4 h-4 text-[#8B4513]" />
          </div>
          <div className="text-xl font-bold text-stone-900 mt-2">3</div>
          <div className="text-[11px] text-stone-400 mt-1">Nguyễn Minh Anh · 1 đang học</div>
        </div>
      </div>

      {/* Charts & Breakdown Row */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-6">
        {/* Daily Revenue Bar Chart (7 cols) */}
        <div className="lg:col-span-8 bg-white p-5 rounded-2xl border border-stone-200 shadow-sm flex flex-col justify-between">
          <div>
            <h3 className="text-sm font-bold text-stone-900">Thực thu theo ngày</h3>
            <p className="text-[11px] text-stone-400 mt-0.5">
              Đơn vị: VND · Đã thu theo ngày, không gồm khoản chờ thanh toán
            </p>
          </div>

          <div className="mt-8 mb-4 h-56 flex items-end justify-between gap-3 px-2">
            {/* 01/10 */}
            <div className="flex-1 flex flex-col items-center">
              <span className="text-[10px] font-bold text-[#8B4513] mb-1">4.500.000đ</span>
              <div className="w-full bg-[#8B4513] rounded-t-lg h-44"></div>
              <span className="text-[10px] text-stone-400 mt-2">01/10/2026</span>
            </div>
            {/* 02/10 */}
            <div className="flex-1 flex flex-col items-center">
              <span className="text-[10px] text-stone-400 mb-1">0đ</span>
              <div className="w-full bg-stone-100 rounded-t-lg h-1"></div>
              <span className="text-[10px] text-stone-400 mt-2">02/10/2026</span>
            </div>
            {/* 03/10 */}
            <div className="flex-1 flex flex-col items-center">
              <span className="text-[10px] text-stone-400 mb-1">0đ</span>
              <div className="w-full bg-stone-100 rounded-t-lg h-1"></div>
              <span className="text-[10px] text-stone-400 mt-2">03/10/2026</span>
            </div>
            {/* 04/10 */}
            <div className="flex-1 flex flex-col items-center">
              <span className="text-[10px] text-stone-400 mb-1">0đ</span>
              <div className="w-full bg-stone-100 rounded-t-lg h-1"></div>
              <span className="text-[10px] text-stone-400 mt-2">04/10/2026</span>
            </div>
            {/* 05/10 */}
            <div className="flex-1 flex flex-col items-center">
              <span className="text-[10px] font-bold text-[#C88A4B] mb-1">3.600.000đ</span>
              <div className="w-full bg-[#C88A4B] rounded-t-lg h-36"></div>
              <span className="text-[10px] text-stone-400 mt-2">05/10/2026</span>
            </div>
            {/* 06/10 */}
            <div className="flex-1 flex flex-col items-center">
              <span className="text-[10px] text-stone-400 mb-1">0đ</span>
              <div className="w-full bg-stone-100 rounded-t-lg h-1"></div>
              <span className="text-[10px] text-stone-400 mt-2">06/10/2026</span>
            </div>
            {/* 07/10 */}
            <div className="flex-1 flex flex-col items-center">
              <span className="text-[10px] text-stone-400 mb-1">0đ</span>
              <div className="w-full bg-stone-100 rounded-t-lg h-1"></div>
              <span className="text-[10px] text-stone-400 mt-2">07/10/2026</span>
            </div>
            {/* 08/10 */}
            <div className="flex-1 flex flex-col items-center">
              <span className="text-[10px] font-bold text-[#C88A4B] mb-1">450.000đ</span>
              <div className="w-full bg-[#E5D5C5] rounded-t-lg h-10"></div>
              <span className="text-[10px] text-stone-400 mt-2">08/10/2026</span>
            </div>
          </div>
        </div>

        {/* Revenue Composition (4 cols) */}
        <div className="lg:col-span-4 bg-white p-5 rounded-2xl border border-stone-200 shadow-sm flex flex-col justify-between">
          <div>
            <h3 className="text-sm font-bold text-stone-900">Cơ cấu khoản đã thu</h3>
            <div className="mt-4 space-y-4">
              <div>
                <div className="flex justify-between text-xs font-semibold text-stone-700 mb-1">
                  <span>Dịch vụ</span>
                  <span>450.000đ · 5,26%</span>
                </div>
                <div className="w-full bg-stone-100 h-2.5 rounded-full overflow-hidden">
                  <div className="bg-[#E5D5C5] h-full rounded-full" style={{ width: '5.26%' }}></div>
                </div>
              </div>

              <div>
                <div className="flex justify-between text-xs font-semibold text-stone-700 mb-1">
                  <span>Liệu trình</span>
                  <span>3.600.000đ · 42,11%</span>
                </div>
                <div className="w-full bg-stone-100 h-2.5 rounded-full overflow-hidden">
                  <div className="bg-[#8B4513] h-full rounded-full" style={{ width: '42.11%' }}></div>
                </div>
              </div>

              <div>
                <div className="flex justify-between text-xs font-semibold text-stone-700 mb-1">
                  <span>Học phí</span>
                  <span>4.500.000đ · 52,63%</span>
                </div>
                <div className="w-full bg-stone-100 h-2.5 rounded-full overflow-hidden">
                  <div className="bg-[#C88A4B] h-full rounded-full" style={{ width: '52.63%' }}></div>
                </div>
              </div>
            </div>
          </div>

          <div className="pt-4 border-t border-stone-100 text-[11px] text-stone-500 leading-relaxed">
            Dịch vụ & liệu trình: <strong className="text-stone-700">4.050.000đ</strong> · Học viện: <strong className="text-stone-700">4.500.000đ</strong>.
          </div>
        </div>
      </div>

      {/* Bottom Row: Branch Reconciliation + Action Needed */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-6">
        {/* Branch Reconciliation Table (8 cols) */}
        <div className="lg:col-span-8 bg-white p-5 rounded-2xl border border-stone-200 shadow-sm">
          <div className="flex items-center justify-between mb-4">
            <h3 className="text-sm font-bold text-stone-900">Đối chiếu chi nhánh</h3>
            <span className="text-[11px] font-semibold text-[#8B4513] bg-[#F5EBE1] px-2.5 py-0.5 rounded-full">
              2 bản ghi mẫu
            </span>
          </div>

          <div className="overflow-x-auto">
            <table className="w-full text-left text-xs">
              <thead className="bg-[#F5EBE1] text-stone-700 font-semibold">
                <tr>
                  <th className="py-2.5 px-3 rounded-l-lg">Chi nhánh mẫu</th>
                  <th className="py-2.5 px-3">Biên nhận đã thu</th>
                  <th className="py-2.5 px-3 rounded-r-lg">Thực thu</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-stone-100">
                <tr className="hover:bg-stone-50">
                  <td className="py-3 px-3 font-medium text-stone-900">Chi nhánh mẫu 01 — Quận 3</td>
                  <td className="py-3 px-3 text-stone-600">3</td>
                  <td className="py-3 px-3 font-semibold text-[#8B4513]">8.550.000đ</td>
                </tr>
                <tr className="hover:bg-stone-50">
                  <td className="py-3 px-3 font-medium text-stone-900">Chi nhánh mẫu 02 — Cầu Giấy</td>
                  <td className="py-3 px-3 text-stone-600">0</td>
                  <td className="py-3 px-3 text-stone-500">0đ</td>
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

        {/* Action Needed Card (4 cols) */}
        <div className="lg:col-span-4 bg-[#F5EBE1] p-5 rounded-2xl border border-[#E5D5C5] shadow-sm flex flex-col justify-between">
          <div>
            <div className="flex items-center justify-between">
              <h3 className="text-sm font-bold text-stone-900">Cần xử lý</h3>
              <span className="text-[11px] font-semibold text-stone-600">
                Cần thu ngay · 2.150.000đ
              </span>
            </div>

            <div className="mt-4 space-y-3">
              <div className="bg-white/80 p-3 rounded-xl border border-[#E5D5C5]">
                <div className="text-xs font-bold text-stone-900">
                  1 khoản cọc dịch vụ chờ thanh toán
                </div>
                <div className="text-[11px] text-stone-600 mt-1">
                  SPA-DEMO-000128 · 150.000đ chưa thu. Giữ chỗ minh họa đến hết vùng đệm.
                </div>
              </div>

              <div className="bg-white/80 p-3 rounded-xl border border-[#E5D5C5]">
                <div className="text-xs font-bold text-stone-900">
                  1 hồ sơ tuyển sinh chờ cọc
                </div>
                <div className="text-[11px] text-stone-600 mt-1">
                  HV-DEMO-000256 · 2.000.000đ chưa thu. Không ghi nhận vào doanh thu.
                </div>
              </div>
            </div>
          </div>

          <div className="pt-4 mt-4 border-t border-[#E5D5C5] flex justify-between items-center text-xs">
            <span className="text-stone-600">Số dư trả sau</span>
            <span className="font-bold text-stone-900">7.300.000đ</span>
          </div>
        </div>
      </div>
    </div>
  );
};
