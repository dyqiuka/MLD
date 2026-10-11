import React from 'react';
import { Search, Bell, ChevronDown } from 'lucide-react';

interface HeaderProps {
  breadcrumb: string;
  selectedBranch: string;
  onBranchChange: (branch: string) => void;
  searchQuery: string;
  onSearchChange: (query: string) => void;
}

export const Header: React.FC<HeaderProps> = ({
  breadcrumb,
  selectedBranch,
  onBranchChange,
  searchQuery,
  onSearchChange,
}) => {
  return (
    <header className="h-16 bg-white border-b border-stone-200 px-6 flex items-center justify-between shrink-0 z-10">
      {/* Breadcrumb & Demo Badge */}
      <div className="flex items-center gap-3">
        <span className="text-sm font-medium text-stone-600">{breadcrumb}</span>
        <span className="px-2.5 py-0.5 rounded-full text-[11px] font-semibold bg-[#F5EBE1] text-[#8B4513]">
          Dữ liệu minh họa
        </span>
      </div>

      {/* Right Controls */}
      <div className="flex items-center gap-3">
        {/* Branch Filter Dropdown */}
        <div className="relative">
          <select
            value={selectedBranch}
            onChange={(e) => onBranchChange(e.target.value)}
            className="appearance-none pl-3.5 pr-8 py-1.5 text-xs font-medium text-stone-700 bg-stone-50 border border-stone-200 rounded-lg hover:border-stone-300 focus:outline-none focus:ring-1 focus:ring-[#8B4513] cursor-pointer"
          >
            <option value="all">Tất cả chi nhánh</option>
            <option value="branch_01">Chi nhánh mẫu 01 — Quận 3</option>
            <option value="branch_02">Chi nhánh mẫu 02 — Cầu Giấy</option>
          </select>
          <ChevronDown className="w-3.5 h-3.5 text-stone-500 absolute right-2.5 top-1/2 -translate-y-1/2 pointer-events-none" />
        </div>

        {/* Global Search */}
        <div className="relative w-56">
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => onSearchChange(e.target.value)}
            placeholder="Tìm kiếm..."
            className="w-full pl-3 pr-8 py-1.5 bg-stone-50 text-xs text-stone-800 placeholder-stone-400 rounded-lg border border-stone-200 focus:outline-none focus:ring-1 focus:ring-[#8B4513] transition-all"
          />
          <Search className="w-3.5 h-3.5 text-stone-400 absolute right-2.5 top-1/2 -translate-y-1/2" />
        </div>

        {/* Notifications */}
        <button
          onClick={() => alert('Thông báo mới: Có 2 lịch hẹn sắp tới tại Quận 3 và 1 khoản cọc dịch vụ chờ xác nhận.')}
          className="relative p-2 rounded-lg text-stone-600 hover:bg-stone-100 transition-colors"
          title="Thông báo"
        >
          <Bell className="w-4 h-4" />
          <span className="absolute top-1.5 right-1.5 w-2 h-2 rounded-full bg-[#8B4513]"></span>
        </button>

        {/* Admin User Chip */}
        <div className="flex items-center gap-2 pl-2 border-l border-stone-200">
          <div className="w-8 h-8 rounded-full bg-[#F5EBE1] text-[#8B4513] font-bold text-xs flex items-center justify-center">
            QT
          </div>
          <div className="text-left hidden md:block">
            <div className="text-xs font-bold text-stone-800 leading-tight">Quản lý hệ thống</div>
            <div className="text-[10px] text-stone-400 leading-tight">Tài khoản minh họa</div>
          </div>
        </div>
      </div>
    </header>
  );
};
