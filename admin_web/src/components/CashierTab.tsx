import React, { useState } from 'react';
import {
  Search,
  ChevronDown,
  Clock,
  QrCode,
  CreditCard,
  Building,
} from 'lucide-react';

export const CashierTab: React.FC = () => {
  const [selectedMethod, setSelectedMethod] = useState<'store' | 'qr' | 'online'>('qr');

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-stone-900 tracking-tight">Thu ngân</h1>
          <p className="text-xs text-stone-500 mt-1">
            Đơn dịch vụ SPA-DEMO-000128 · Chờ thanh toán · Không phải biên nhận đã thu
          </p>
        </div>
        <button
          onClick={() => alert('Tra cứu mã đơn khác...')}
          className="flex items-center gap-1.5 px-4 py-2.5 bg-[#8B4513] hover:bg-[#72380F] text-white text-xs font-semibold rounded-xl shadow-sm transition-all self-start sm:self-auto"
        >
          <Search className="w-4 h-4" />
          <span>Tra cứu đơn dịch vụ</span>
        </button>
      </div>

      {/* Filter Row */}
      <div className="grid grid-cols-1 md:grid-cols-12 gap-3 bg-white p-3 rounded-2xl border border-stone-200 shadow-sm">
        <div className="md:col-span-5">
          <input
            type="text"
            defaultValue="Nguyễn Minh Anh / SPA-DEMO-000128"
            className="w-full px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] font-medium"
          />
        </div>
        <div className="md:col-span-2 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Dịch vụ lẻ</option>
            <option>Gói liệu trình</option>
            <option>Học phí</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
        <div className="md:col-span-3 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>Chờ thanh toán</option>
            <option>Đã thanh toán</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
        <div className="md:col-span-2 relative">
          <select className="w-full appearance-none px-3.5 py-2 text-xs bg-stone-50 border border-stone-200 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#8B4513] text-stone-700 cursor-pointer">
            <option>12/10/2026</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>
      </div>

      {/* Main 2-Column Section */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-6">
        {/* Left: Selected Service Details (7 cols) */}
        <div className="lg:col-span-7 bg-white p-5 rounded-2xl border border-stone-200 shadow-sm space-y-4">
          <div className="flex items-center justify-between">
            <h3 className="text-sm font-bold text-stone-900">Đơn dịch vụ đang chọn</h3>
            <span className="text-[10px] font-bold px-2 py-0.5 rounded bg-[#F5EBE1] text-[#8B4513]">
              Giữ chỗ minh họa
            </span>
          </div>

          <div className="relative rounded-2xl overflow-hidden h-40">
            <img
              src="https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=600"
              alt="Massage Spa"
              className="w-full h-full object-cover"
            />
          </div>

          <div className="space-y-2 text-xs">
            <div className="flex justify-between items-start">
              <div>
                <h4 className="text-base font-bold text-stone-900">Massage thư giãn toàn thân</h4>
                <div className="text-stone-500 text-[11px] mt-0.5">Thời lượng chăm sóc: 60 phút</div>
              </div>
              <span className="text-stone-800 font-bold text-sm">60 phút</span>
            </div>

            <div className="pt-2 border-t border-stone-100 space-y-1 text-stone-600">
              <div>Chi nhánh mẫu 01 — Quận 3</div>
              <div className="text-[11px] text-stone-400">123 Đường Mẫu, Phường Mẫu, TP. Hồ Chí Minh · Địa chỉ minh họa</div>
            </div>

            <div className="pt-2 border-t border-stone-100 grid grid-cols-2 gap-2 text-stone-700">
              <div>Ngày hẹn: <strong className="text-stone-900">12/10/2026</strong></div>
              <div>Giờ chăm sóc: <strong className="text-stone-900">14:00–15:00</strong></div>
              <div className="col-span-2 text-[11px] text-stone-400">
                Chuẩn bị / vệ sinh sau buổi: 15 phút. Chiếm dụng nguồn lực 14:00–15:15, không tính vào 60 phút chăm sóc.
              </div>
              <div>Chuyên viên: <strong className="text-stone-900">Trần Minh Phương</strong></div>
              <div>Khách hàng: <strong className="text-stone-900">Nguyễn Minh Anh</strong></div>
              <div className="col-span-2 text-stone-500">0912 345 678</div>
            </div>

            <div className="pt-2 border-t border-stone-100 text-[11px] text-stone-400">
              Phòng 01 · Nguồn lực giữ đến 15:15, bao gồm 15 phút vệ sinh.
            </div>
          </div>
        </div>

        {/* Right: Payment Summary (5 cols) */}
        <div className="lg:col-span-5 bg-white p-5 rounded-2xl border border-stone-200 shadow-sm space-y-4 flex flex-col justify-between">
          <div className="space-y-4">
            <h3 className="text-sm font-bold text-stone-900">Tổng hợp thanh toán</h3>

            <div className="bg-stone-50 p-4 rounded-xl space-y-2 text-xs">
              <div className="font-bold text-stone-900 text-sm mb-2">Chi phí minh họa</div>
              <div className="flex justify-between text-stone-600">
                <span>Tạm tính</span>
                <span className="font-semibold text-stone-800">450.000đ</span>
              </div>
              <div className="flex justify-between text-stone-600">
                <span>Ưu đãi</span>
                <span className="font-semibold text-stone-800">0đ</span>
              </div>
              <div className="flex justify-between text-stone-600">
                <span>Đã sử dụng gói liệu trình</span>
                <span className="font-semibold text-stone-800">0đ</span>
              </div>
              <div className="pt-2 border-t border-stone-200 flex justify-between font-bold text-stone-900 text-sm">
                <span>Tổng thanh toán</span>
                <span className="text-[#8B4513]">450.000đ</span>
              </div>
              <div className="flex justify-between text-stone-700 pt-1">
                <span>Cọc cần thu ngay</span>
                <span className="font-bold text-[#8B4513]">150.000đ</span>
              </div>
              <div className="flex justify-between text-stone-700">
                <span>Còn lại trả sau</span>
                <span className="font-semibold text-stone-800">300.000đ</span>
              </div>
            </div>

            <div className="flex items-center gap-2 p-2.5 rounded-xl bg-amber-50 text-amber-800 text-xs border border-amber-200">
              <Clock className="w-4 h-4" />
              <span>Chờ thanh toán · Chưa thu tiền</span>
            </div>

            <button
              onClick={() => alert('Xác nhận thu cọc 150.000đ cho đơn SPA-DEMO-000128 (minh họa)')}
              className="w-full py-3 bg-[#8B4513] hover:bg-[#72380F] text-white text-xs font-bold rounded-xl shadow-md transition-all text-center"
            >
              Ghi nhận thanh toán
            </button>

            <div className="bg-[#F5EBE1] p-3 rounded-xl border border-[#E5D5C5] text-xs">
              <div className="font-bold text-stone-900">Bản nháp — minh họa</div>
              <div className="text-[11px] text-stone-600 mt-1">
                SPA-DEMO-000128 · Tổng đơn 450.000đ<br />
                Cọc dự kiến 150.000đ · Chưa có biên nhận đã thu.
              </div>
            </div>
          </div>

          <div className="text-[10px] text-stone-400 italic pt-2">
            Chỉ ghi nhận sau đối chiếu hợp lệ. Nút minh họa không xử lý hoặc tạo biên nhận thực.
          </div>
        </div>
      </div>

      {/* 3 Payment Methods Selection */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        {/* Method 1 */}
        <div
          onClick={() => setSelectedMethod('store')}
          className={`p-4 rounded-2xl border cursor-pointer transition-all ${
            selectedMethod === 'store'
              ? 'bg-[#F5EBE1] border-[#8B4513]'
              : 'bg-white border-stone-200 hover:border-stone-300'
          }`}
        >
          <div className="flex items-center gap-2 text-xs font-bold text-stone-900">
            <Building className="w-4 h-4 text-[#8B4513]" />
            <span>Thanh toán tại cơ sở</span>
          </div>
          <p className="text-[11px] text-stone-600 mt-2">
            Quận 3 minh họa cho phép trả phần còn lại 300.000đ; vẫn yêu cầu cọc 150.000đ.
          </p>
        </div>

        {/* Method 2 */}
        <div
          onClick={() => setSelectedMethod('qr')}
          className={`p-4 rounded-2xl border cursor-pointer transition-all ${
            selectedMethod === 'qr'
              ? 'bg-[#F5EBE1] border-[#8B4513]'
              : 'bg-white border-stone-200 hover:border-stone-300'
          }`}
        >
          <div className="flex items-center gap-2 text-xs font-bold text-stone-900">
            <QrCode className="w-4 h-4 text-[#8B4513]" />
            <span>Chuyển khoản ngân hàng / QR</span>
          </div>
          <p className="text-[11px] text-stone-600 mt-2">
            Chưa có QR. Ngân hàng chưa cấu hình. Ô mẫu không chứa mã quét hoặc tài khoản hợp lệ.
          </p>
        </div>

        {/* Method 3 */}
        <div
          onClick={() => setSelectedMethod('online')}
          className={`p-4 rounded-2xl border cursor-pointer transition-all ${
            selectedMethod === 'online'
              ? 'bg-[#F5EBE1] border-[#8B4513]'
              : 'bg-white border-stone-200 hover:border-stone-300'
          }`}
        >
          <div className="flex items-center gap-2 text-xs font-bold text-stone-900">
            <CreditCard className="w-4 h-4 text-[#8B4513]" />
            <span>Thanh toán trực tuyến</span>
          </div>
          <p className="text-[11px] text-stone-600 mt-2">
            Chưa kết nối cổng thanh toán. Gói / voucher: chưa áp dụng · Không có phí ẩn.
          </p>
        </div>
      </div>
    </div>
  );
};
