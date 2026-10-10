import React, { useState } from 'react';
import {
  Plus,
  Search,
  Clock,
  Star,
  Users,
  Trash2,
  Power,
} from 'lucide-react';
import { AdminService } from '../types';

interface ServicesTabProps {
  services: AdminService[];
  onAddService: (service: Omit<AdminService, 'id'>) => void;
  onToggleStatus: (id: string) => void;
  onDeleteService: (id: string) => void;
}

export const ServicesTab: React.FC<ServicesTabProps> = ({
  services,
  onAddService,
  onToggleStatus,
  onDeleteService,
}) => {
  const [searchQuery, setSearchQuery] = useState('');
  const [showAddModal, setShowAddModal] = useState(false);

  // Form inputs
  const [name, setName] = useState('');
  const [category, setCategory] = useState('Khám Tổng Quát');
  const [price, setPrice] = useState(1500000);
  const [durationMinutes, setDurationMinutes] = useState(60);

  const filteredServices = services.filter(
    (s) =>
      s.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      s.category.toLowerCase().includes(searchQuery.toLowerCase())
  );

  const handleAdd = (e: React.FormEvent) => {
    e.preventDefault();
    if (!name) return;

    onAddService({
      name,
      category,
      price,
      durationMinutes,
      rating: 5.0,
      doctorCount: 2,
      status: 'active',
    });

    setName('');
    setShowAddModal(false);
  };

  return (
    <div className="space-y-6">
      {/* Top Bar */}
      <div className="bg-white p-4 rounded-2xl border border-slate-200/80 shadow-sm flex flex-col sm:flex-row items-center justify-between gap-4">
        <div className="relative w-full sm:w-80">
          <Search className="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2" />
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder="Tìm theo tên dịch vụ, chuyên khoa..."
            className="w-full pl-9 pr-4 py-2 bg-slate-50 text-xs rounded-xl border border-slate-200 focus:outline-none focus:border-blue-500"
          />
        </div>

        <button
          onClick={() => setShowAddModal(true)}
          className="flex items-center gap-1.5 px-4 py-2 rounded-xl bg-blue-600 hover:bg-blue-700 text-white text-xs font-bold shadow-md shadow-blue-600/20 transition-all shrink-0"
        >
          <Plus className="w-4 h-4" />
          <span>Thêm Dịch Vụ Mới</span>
        </button>
      </div>

      {/* Services Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
        {filteredServices.map((service) => (
          <div
            key={service.id}
            className="bg-white rounded-2xl border border-slate-200/80 shadow-sm p-5 flex flex-col justify-between hover:shadow-md transition-shadow"
          >
            <div>
              <div className="flex items-center justify-between mb-3">
                <span className="px-2.5 py-0.5 rounded-full text-[10px] font-bold bg-blue-50 text-blue-700 border border-blue-200/60">
                  {service.category}
                </span>
                <span
                  className={`text-[10px] font-bold px-2 py-0.5 rounded-full ${
                    service.status === 'active'
                      ? 'bg-emerald-100 text-emerald-800'
                      : 'bg-slate-100 text-slate-500'
                  }`}
                >
                  {service.status === 'active' ? 'Đang phục vụ' : 'Tạm dừng'}
                </span>
              </div>

              <h4 className="font-bold text-slate-900 text-sm mb-2 leading-snug">
                {service.name}
              </h4>

              <div className="flex items-center gap-4 text-slate-500 text-xs mb-4">
                <div className="flex items-center gap-1">
                  <Clock className="w-3.5 h-3.5 text-blue-500" />
                  <span>{service.durationMinutes} phút</span>
                </div>
                <div className="flex items-center gap-1">
                  <Star className="w-3.5 h-3.5 text-amber-500 fill-amber-500" />
                  <span className="font-semibold text-slate-700">{service.rating}</span>
                </div>
                <div className="flex items-center gap-1">
                  <Users className="w-3.5 h-3.5 text-teal-500" />
                  <span>{service.doctorCount} bác sĩ</span>
                </div>
              </div>
            </div>

            <div className="pt-4 border-t border-slate-100 flex items-center justify-between">
              <div className="text-base font-black text-blue-600">
                {service.price.toLocaleString('vi-VN')} ₫
              </div>
              <div className="flex items-center gap-2">
                <button
                  onClick={() => onToggleStatus(service.id)}
                  title={service.status === 'active' ? 'Ẩn dịch vụ' : 'Hiện dịch vụ'}
                  className={`p-1.5 rounded-lg border transition-colors ${
                    service.status === 'active'
                      ? 'border-slate-200 text-slate-400 hover:text-amber-600 hover:bg-amber-50'
                      : 'border-emerald-200 text-emerald-600 bg-emerald-50'
                  }`}
                >
                  <Power className="w-3.5 h-3.5" />
                </button>
                <button
                  onClick={() => onDeleteService(service.id)}
                  title="Xóa dịch vụ"
                  className="p-1.5 rounded-lg border border-slate-200 text-slate-400 hover:text-rose-600 hover:bg-rose-50 transition-colors"
                >
                  <Trash2 className="w-3.5 h-3.5" />
                </button>
              </div>
            </div>
          </div>
        ))}
      </div>

      {/* Add Service Modal */}
      {showAddModal && (
        <div className="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl w-full max-w-md p-6 shadow-2xl border border-slate-200">
            <h3 className="text-base font-bold text-slate-900 mb-1">Thêm Dịch Vụ Khám Chữa Bệnh Mới</h3>
            <p className="text-xs text-slate-500 mb-5">Đồng bộ trực tiếp lên giao diện ứng dụng di động cho bệnh nhân</p>

            <form onSubmit={handleAdd} className="space-y-4">
              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1">Tên dịch vụ</label>
                <input
                  type="text"
                  required
                  value={name}
                  onChange={(e) => setName(e.target.value)}
                  placeholder="VD: Tầm Soát Ung Thư Vú Kỹ Thuật Cao"
                  className="w-full px-3 py-2 text-xs rounded-xl border border-slate-300 focus:outline-none focus:border-blue-500"
                />
              </div>

              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1">Chuyên khoa</label>
                <select
                  value={category}
                  onChange={(e) => setCategory(e.target.value)}
                  className="w-full px-3 py-2 text-xs rounded-xl border border-slate-300 focus:outline-none focus:border-blue-500"
                >
                  <option value="Khám Tổng Quát">Khám Tổng Quát</option>
                  <option value="Tim Mạch">Tim Mạch</option>
                  <option value="Da Liễu">Da Liễu</option>
                  <option value="Nha Khoa">Nha Khoa</option>
                  <option value="Nhi Khoa">Nhi Khoa</option>
                </select>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">Đơn giá (₫)</label>
                  <input
                    type="number"
                    required
                    value={price}
                    onChange={(e) => setPrice(Number(e.target.value))}
                    className="w-full px-3 py-2 text-xs rounded-xl border border-slate-300 focus:outline-none focus:border-blue-500"
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">Thời lượng (phút)</label>
                  <input
                    type="number"
                    required
                    value={durationMinutes}
                    onChange={(e) => setDurationMinutes(Number(e.target.value))}
                    className="w-full px-3 py-2 text-xs rounded-xl border border-slate-300 focus:outline-none focus:border-blue-500"
                  />
                </div>
              </div>

              <div className="flex items-center justify-end gap-3 pt-3">
                <button
                  type="button"
                  onClick={() => setShowAddModal(false)}
                  className="px-4 py-2 rounded-xl text-xs font-semibold text-slate-600 hover:bg-slate-100 transition-colors"
                >
                  Hủy bỏ
                </button>
                <button
                  type="submit"
                  className="px-5 py-2 rounded-xl text-xs font-bold bg-blue-600 hover:bg-blue-700 text-white shadow-md shadow-blue-600/20 transition-all"
                >
                  Lưu & Xuất Bản
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
};
