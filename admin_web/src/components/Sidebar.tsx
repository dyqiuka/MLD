import React from 'react';
import {
  LayoutDashboard,
  Building2,
  CalendarDays,
  FileText,
  CreditCard,
  Users,
  UserPlus,
  GraduationCap,
  UserCheck,
  BookOpen,
  PieChart,
  Settings,
} from 'lucide-react';

interface SidebarProps {
  currentTab: string;
  onSelectTab: (tab: string) => void;
}

export const Sidebar: React.FC<SidebarProps> = ({ currentTab, onSelectTab }) => {
  const adminSections = [
    { id: 'overview', label: 'Tổng quan', icon: LayoutDashboard },
    { id: 'branches', label: 'Chi nhánh', icon: Building2 },
    { id: 'appointments', label: 'Lịch trình dịch vụ', icon: CalendarDays },
    { id: 'treatments', label: 'Liệu trình', icon: FileText },
    { id: 'cashier', label: 'Thu ngân', icon: CreditCard },
  ];

  const academySections = [
    { id: 'customers', label: 'Khách hàng', icon: Users },
    { id: 'enrollment', label: 'Tuyển sinh', icon: UserPlus },
    { id: 'teachers', label: 'Giảng viên', icon: GraduationCap },
    { id: 'students', label: 'Học viên', icon: UserCheck },
    { id: 'training', label: 'Vận hành đào tạo', icon: BookOpen },
  ];

  const analysisSections = [
    { id: 'reports', label: 'Báo cáo doanh thu', icon: PieChart },
  ];

  const renderNavItems = (items: typeof adminSections) => {
    return items.map((item) => {
      const Icon = item.icon;
      // Default to overview if tab not implemented, to avoid breaking App.tsx currently
      const isActive = currentTab === item.id || (currentTab === 'overview' && item.id === 'overview');
      return (
        <button
          key={item.id}
          onClick={() => onSelectTab(item.id)}
          className={`w-full flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium transition-all ${
            isActive
              ? 'bg-[#FDF6E9] text-[#9A5B22]'
              : 'text-gray-600 hover:bg-gray-100 hover:text-gray-900'
          }`}
        >
          <Icon className={`w-5 h-5 ${isActive ? 'text-[#9A5B22]' : 'text-gray-400'}`} />
          <span>{item.label}</span>
        </button>
      );
    });
  };

  return (
    <aside className="w-64 bg-white flex flex-col border-r border-gray-200 shrink-0">
      {/* Brand Header */}
      <div className="h-16 flex items-center px-6 border-b border-gray-100 gap-3">
        <div className="w-8 h-8 rounded bg-[#9A5B22] flex items-center justify-center text-white font-bold">
          MLD
        </div>
        <h1 className="font-bold text-gray-900 text-lg tracking-tight">Vietnam</h1>
      </div>

      {/* Navigation Links */}
      <nav className="flex-1 p-4 space-y-6 overflow-y-auto">
        
        <div>
          <div className="px-3 mb-2 text-xs font-bold tracking-wider text-gray-400 uppercase">
            KHÔNG GIAN QUẢN TRỊ
          </div>
          <div className="space-y-1">{renderNavItems(adminSections)}</div>
        </div>

        <div>
          <div className="px-3 mb-2 text-xs font-bold tracking-wider text-gray-400 uppercase">
            HỌC VIỆN
          </div>
          <div className="space-y-1">{renderNavItems(academySections)}</div>
        </div>

        <div>
          <div className="px-3 mb-2 text-xs font-bold tracking-wider text-gray-400 uppercase">
            PHÂN TÍCH
          </div>
          <div className="space-y-1">{renderNavItems(analysisSections)}</div>
        </div>

      </nav>

      {/* Footer Settings */}
      <div className="p-4 border-t border-gray-100">
        <button
          className="w-full flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-gray-600 hover:bg-gray-100 transition-all"
        >
          <Settings className="w-5 h-5 text-gray-400" />
          <span>Cài đặt</span>
        </button>
      </div>
    </aside>
  );
};
