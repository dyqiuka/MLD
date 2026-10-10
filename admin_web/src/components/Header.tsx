import React from 'react';
import { Search, Bell, Activity, Plus } from 'lucide-react';

interface HeaderProps {
  title: string;
  subtitle: string;
  onQuickAction?: () => void;
  quickActionLabel?: string;
}

export const Header: React.FC<HeaderProps> = ({
  title,
  subtitle,
  onQuickAction,
  quickActionLabel,
}) => {
  return (
    <header className="h-16 bg-white border-b border-slate-200 px-8 flex items-center justify-between shrink-0 shadow-sm z-10">
      {/* Title & Subtitle */}
      <div>
        <h2 className="text-lg font-bold text-slate-800 leading-tight">{title}</h2>
        <p className="text-xs text-slate-500">{subtitle}</p>
      </div>

      {/* Center Search */}
      <div className="relative w-80">
        <Search className="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2" />
        <input
          type="text"
          placeholder="Tìm kiếm bệnh nhân, bác sĩ, đơn khám, mã vé..."
          className="w-full pl-9 pr-4 py-1.5 bg-slate-100 hover:bg-slate-200/70 focus:bg-white text-xs text-slate-800 rounded-lg border border-transparent focus:border-blue-500 focus:outline-none transition-all"
        />
      </div>

      {/* Right Actions */}
      <div className="flex items-center gap-4">
        {/* Live SLA Badge */}
        <div className="hidden lg:flex items-center gap-2 px-2.5 py-1 rounded-full bg-emerald-50 border border-emerald-200 text-emerald-700 text-[11px] font-semibold">
          <Activity className="w-3.5 h-3.5 text-emerald-600 animate-pulse" />
          <span>Hệ Thống Y Tế Ổn Định (99.99%)</span>
        </div>

        {/* Notifications */}
        <button
          onClick={() => alert('Thông báo mới: Có 3 lịch khám mới cần duyệt và 5 học viên hoàn thành quiz!')}
          className="relative p-2 rounded-lg text-slate-500 hover:text-slate-700 hover:bg-slate-100 transition-colors"
        >
          <Bell className="w-5 h-5" />
          <span className="absolute top-1.5 right-1.5 w-2 h-2 rounded-full bg-rose-500 ring-2 ring-white"></span>
        </button>

        {/* Quick Action Button */}
        {onQuickAction && quickActionLabel && (
          <button
            onClick={onQuickAction}
            className="flex items-center gap-1.5 px-3.5 py-2 rounded-lg bg-[#9A5B22] hover:bg-[#8A4A11] text-white text-xs font-bold shadow-md shadow-[#9A5B22]/20 transition-all"
          >
            <Plus className="w-4 h-4" />
            <span>{quickActionLabel}</span>
          </button>
        )}
      </div>
    </header>
  );
};
