import React from 'react';
import {
  Download,
  Receipt,
  RotateCcw,
  Wallet,
  Clock,
  ChevronDown,
} from 'lucide-react';

export const RevenueReportTab: React.FC = () => {
  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-stone-900 tracking-tight">Báo cáo doanh thu</h1>
          <p className="text-xs text-stone-500 mt-1">
            01/10/2026 – 08/10/2026 · Tất cả chi nhánh · Chỉ tính biên nhận hoàn tất
          </p>
        </div>
        <button
          onClick={() => alert('Xuất báo cáo doanh thu Excel/PDF (minh họa)')}
          className="flex items-center gap-1.5 px-4 py-2.5 bg-[#8B4513] hover:bg-[#72380F] text-white text-xs font-semibold rounded-xl shadow-sm transition-all self-start sm:self-auto"
        >
          <Download className="w-4 h-4" />
          <span>Xuất báo cáo</span>
        </button>
      </div>

      {/* Filter Row */}
      <div className="grid grid-cols-1 md:grid-cols-12 gap-3 bg-white p-3 rounded-2xl border border-stone-200 shadow-sm">
        <div className="md:col-span-5 relative">
          <input
            type="text"
            defaultValue="01/10/2026 – 08/10/2026"
            className="w-full px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513]"
          />
        </div>
        <div className="md:col-span-3 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Dịch vụ / gói / học phí</option>
            <option>Chỉ dịch vụ</option>
            <option>Chỉ học phí</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
        <div className="md:col-span-2 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Tất cả phương thức</option>
            <option>Tiền mặt</option>
            <option>Chuyển khoản</option>
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

      {/* 4 Stats Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        <div className="bg-white p-4 rounded-2xl border border-stone-200 shadow-sm">
          <div className="flex items-center justify-between text-stone-500 text-xs font-medium">
            <span>Đã thu</span>
            <Receipt className="w-4 h-4 text-[#8B4513]" />
          </div>
          <div className="text-2xl font-bold text-stone-900 mt-2">8.550.000đ</div>
          <div className="text-[11px] text-stone-400 mt-0.5">3 biên nhận minh họa</div>
        </div>

        <div className="bg-white p-4 rounded-2xl border border-stone-200 shadow-sm">
          <div className="flex items-center justify-between text-stone-500 text-xs font-medium">
            <span>Hoàn tiền</span>
            <RotateCcw className="w-4 h-4 text-stone-400" />
          </div>
          <div className="text-2xl font-bold text-stone-900 mt-2">0đ</div>
          <div className="text-[11px] text-stone-400 mt-0.5">Không có khoản hoàn trong kỳ</div>
        </div>

        <div className="bg-white p-4 rounded-2xl border border-stone-200 shadow-sm">
          <div className="flex items-center justify-between text-stone-500 text-xs font-medium">
            <span>Thực thu</span>
            <Wallet className="w-4 h-4 text-[#8B4513]" />
          </div>
          <div className="text-2xl font-bold text-[#8B4513] mt-2">8.550.000đ</div>
          <div className="text-[11px] text-stone-400 mt-0.5">Đã thu trừ hoàn tiền</div>
        </div>

        <div className="bg-white p-4 rounded-2xl border border-stone-200 shadow-sm">
          <div className="flex items-center justify-between text-stone-500 text-xs font-medium">
            <span>Cần thu ngay</span>
            <Clock className="w-4 h-4 text-amber-600" />
          </div>
          <div className="text-2xl font-bold text-stone-900 mt-2">2.150.000đ</div>
          <div className="text-[11px] text-stone-400 mt-0.5">Cọc chưa thu · Không là doanh thu</div>
        </div>
      </div>

      {/* Chart & Breakdowns */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-6">
        {/* Daily Revenue (8 cols) */}
        <div className="lg:col-span-8 bg-white p-5 rounded-2xl border border-stone-200 shadow-sm flex flex-col justify-between">
          <div>
            <h3 className="text-sm font-bold text-stone-900">Thực thu từng ngày</h3>
            <p className="text-[11px] text-stone-400 mt-0.5">
              Đơn vị: VND · Đã thu theo ngày, không gồm khoản chờ thanh toán
            </p>
          </div>

          <div className="mt-8 mb-4 h-56 flex items-end justify-between gap-3 px-2">
            <div className="flex-1 flex flex-col items-center">
              <span className="text-[10px] font-bold text-[#8B4513] mb-1">4.500.000đ</span>
              <div className="w-full bg-[#8B4513] rounded-t-lg h-44"></div>
              <span className="text-[10px] text-stone-400 mt-2">01/10/2026</span>
            </div>
            <div className="flex-1 flex flex-col items-center">
              <span className="text-[10px] text-stone-400 mb-1">0đ</span>
              <div className="w-full bg-stone-100 rounded-t-lg h-1"></div>
              <span className="text-[10px] text-stone-400 mt-2">02/10/2026</span>
            </div>
            <div className="flex-1 flex flex-col items-center">
              <span className="text-[10px] text-stone-400 mb-1">0đ</span>
              <div className="w-full bg-stone-100 rounded-t-lg h-1"></div>
              <span className="text-[10px] text-stone-400 mt-2">03/10/2026</span>
            </div>
            <div className="flex-1 flex flex-col items-center">
              <span className="text-[10px] text-stone-400 mb-1">0đ</span>
              <div className="w-full bg-stone-100 rounded-t-lg h-1"></div>
              <span className="text-[10px] text-stone-400 mt-2">04/10/2026</span>
            </div>
            <div className="flex-1 flex flex-col items-center">
              <span className="text-[10px] font-bold text-[#C88A4B] mb-1">3.600.000đ</span>
              <div className="w-full bg-[#C88A4B] rounded-t-lg h-36"></div>
              <span className="text-[10px] text-stone-400 mt-2">05/10/2026</span>
            </div>
            <div className="flex-1 flex flex-col items-center">
              <span className="text-[10px] text-stone-400 mb-1">0đ</span>
              <div className="w-full bg-stone-100 rounded-t-lg h-1"></div>
              <span className="text-[10px] text-stone-400 mt-2">06/10/2026</span>
            </div>
            <div className="flex-1 flex flex-col items-center">
              <span className="text-[10px] text-stone-400 mb-1">0đ</span>
              <div className="w-full bg-stone-100 rounded-t-lg h-1"></div>
              <span className="text-[10px] text-stone-400 mt-2">07/10/2026</span>
            </div>
            <div className="flex-1 flex flex-col items-center">
              <span className="text-[10px] font-bold text-[#C88A4B] mb-1">450.000đ</span>
              <div className="w-full bg-[#E5D5C5] rounded-t-lg h-10"></div>
              <span className="text-[10px] text-stone-400 mt-2">08/10/2026</span>
            </div>
          </div>
        </div>

        {/* Right Breakdowns (4 cols) */}
        <div className="lg:col-span-4 space-y-4">
          {/* Composition */}
          <div className="bg-white p-5 rounded-2xl border border-stone-200 shadow-sm space-y-3">
            <h3 className="text-sm font-bold text-stone-900">Cơ cấu khoản đã thu</h3>
            <div className="space-y-3 text-xs">
              <div>
                <div className="flex justify-between font-medium text-stone-700 mb-1">
                  <span>Dịch vụ</span>
                  <span>450.000đ · 5,26%</span>
                </div>
                <div className="w-full bg-stone-100 h-2 rounded-full overflow-hidden">
                  <div className="bg-[#E5D5C5] h-full" style={{ width: '5.26%' }}></div>
                </div>
              </div>
              <div>
                <div className="flex justify-between font-medium text-stone-700 mb-1">
                  <span>Liệu trình</span>
                  <span>3.600.000đ · 42,11%</span>
                </div>
                <div className="w-full bg-stone-100 h-2 rounded-full overflow-hidden">
                  <div className="bg-[#8B4513] h-full" style={{ width: '42.11%' }}></div>
                </div>
              </div>
              <div>
                <div className="flex justify-between font-medium text-stone-700 mb-1">
                  <span>Học phí</span>
                  <span>4.500.000đ · 52,63%</span>
                </div>
                <div className="w-full bg-stone-100 h-2 rounded-full overflow-hidden">
                  <div className="bg-[#C88A4B] h-full" style={{ width: '52.63%' }}></div>
                </div>
              </div>
            </div>
          </div>

          {/* Branch Comparison */}
          <div className="bg-white p-5 rounded-2xl border border-stone-200 shadow-sm space-y-2 text-xs">
            <h3 className="text-sm font-bold text-stone-900">So sánh chi nhánh</h3>
            <div className="flex justify-between py-1.5 border-b border-stone-100">
              <span className="text-stone-700 font-medium">Quận 3 · 3 biên nhận</span>
              <span className="font-bold text-[#8B4513]">8.550.000đ</span>
            </div>
            <div className="flex justify-between py-1.5">
              <span className="text-stone-700 font-medium">Cầu Giấy · 0 biên nhận</span>
              <span className="font-semibold text-stone-400">0đ</span>
            </div>
            <div className="text-[10px] text-stone-400 italic pt-1">
              Cầu Giấy chưa có biên nhận đã ghi trong tập mẫu, không phải đánh giá hiệu quả kinh doanh.
            </div>
          </div>
        </div>
      </div>

      {/* Payment Method Reconciliation */}
      <div className="bg-white p-5 rounded-2xl border border-stone-200 shadow-sm space-y-3">
        <h3 className="text-sm font-bold text-stone-900">Đối chiếu phương thức</h3>
        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-4 text-xs">
          <div className="p-3 bg-stone-50 rounded-xl">
            <div className="text-stone-400">Tại cơ sở / tiền mặt mẫu:</div>
            <div className="font-bold text-stone-900 text-sm mt-1">450.000đ</div>
          </div>
          <div className="p-3 bg-stone-50 rounded-xl">
            <div className="text-stone-400">Chuyển khoản mẫu:</div>
            <div className="font-bold text-stone-900 text-sm mt-1">4.500.000đ</div>
          </div>
          <div className="p-3 bg-stone-50 rounded-xl">
            <div className="text-stone-400">Cổng trực tuyến mẫu:</div>
            <div className="font-bold text-stone-900 text-sm mt-1">3.600.000đ</div>
          </div>
          <div className="p-3 bg-[#F5EBE1] border border-[#E5D5C5] rounded-xl">
            <div className="text-[#8B4513] font-semibold">Tổng thực thu:</div>
            <div className="font-black text-[#8B4513] text-sm mt-1">8.550.000đ</div>
          </div>
        </div>
      </div>

      {/* 3 Completed Receipts Table */}
      <div className="bg-white p-5 rounded-2xl border border-stone-200 shadow-sm">
        <div className="flex items-center justify-between mb-4">
          <h3 className="text-sm font-bold text-stone-900">
            3 biên nhận đã hoàn tất · Nguyễn Minh Anh · Quận 3
          </h3>
          <span className="text-[11px] font-semibold text-[#8B4513] bg-[#F5EBE1] px-2.5 py-0.5 rounded-full">
            3 bản ghi mẫu
          </span>
        </div>

        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs">
            <thead className="bg-[#F5EBE1] text-stone-700 font-semibold">
              <tr>
                <th className="py-2.5 px-3 rounded-l-lg">Biên nhận / ngày</th>
                <th className="py-2.5 px-3">Nội dung khoản thu</th>
                <th className="py-2.5 px-3">Phương thức</th>
                <th className="py-2.5 px-3">Số tiền</th>
                <th className="py-2.5 px-3 rounded-r-lg">Trạng thái</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-stone-100">
              <tr className="hover:bg-stone-50">
                <td className="py-3 px-3">
                  <div className="font-bold text-stone-900">MH-DV-1008</div>
                  <div className="text-[11px] text-stone-400">08/10/2026</div>
                </td>
                <td className="py-3 px-3 font-medium text-stone-800">
                  Massage thư giãn toàn thân · 60 phút
                </td>
                <td className="py-3 px-3 text-stone-600">Tại cơ sở / Tiền mặt mẫu</td>
                <td className="py-3 px-3 font-bold text-[#8B4513]">450.000đ</td>
                <td className="py-3 px-3">
                  <span className="px-2 py-0.5 bg-emerald-100 text-emerald-800 text-[10px] font-bold rounded">
                    Đã thu
                  </span>
                </td>
              </tr>

              <tr className="hover:bg-stone-50">
                <td className="py-3 px-3">
                  <div className="font-bold text-stone-900">MH-PKG-1005</div>
                  <div className="text-[11px] text-stone-400">05/10/2026</div>
                </td>
                <td className="py-3 px-3 font-medium text-stone-800">
                  Gói Chăm sóc da 8 buổi
                </td>
                <td className="py-3 px-3 text-stone-600">Cổng trực tuyến mẫu</td>
                <td className="py-3 px-3 font-bold text-[#8B4513]">3.600.000đ</td>
                <td className="py-3 px-3">
                  <span className="px-2 py-0.5 bg-emerald-100 text-emerald-800 text-[10px] font-bold rounded">
                    Đã thu
                  </span>
                </td>
              </tr>

              <tr className="hover:bg-stone-50">
                <td className="py-3 px-3">
                  <div className="font-bold text-stone-900">MH-HP-1001</div>
                  <div className="text-[11px] text-stone-400">01/10/2026</div>
                </td>
                <td className="py-3 px-3 font-medium text-stone-800">
                  Học phí Kỹ thuật Spa Cơ bản
                </td>
                <td className="py-3 px-3 text-stone-600">Chuyển khoản mẫu</td>
                <td className="py-3 px-3 font-bold text-[#8B4513]">4.500.000đ</td>
                <td className="py-3 px-3">
                  <span className="px-2 py-0.5 bg-emerald-100 text-emerald-800 text-[10px] font-bold rounded">
                    Đã thu
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
