import React, { useState } from 'react';
import { Sidebar } from './components/Sidebar';
import { Header } from './components/Header';
import { OverviewTab } from './components/OverviewTab';
import { BranchesTab } from './components/BranchesTab';
import { CustomersTab } from './components/CustomersTab';
import { StaffScheduleTab } from './components/StaffScheduleTab';
import { TreatmentsTab } from './components/TreatmentsTab';
import { CashierTab } from './components/CashierTab';
import { AdmissionsTab } from './components/AdmissionsTab';
import { InstructorsTab } from './components/InstructorsTab';
import { StudentsTab } from './components/StudentsTab';
import { TrainingOpsTab } from './components/TrainingOpsTab';
import { RevenueReportTab } from './components/RevenueReportTab';

export const App: React.FC = () => {
  const [currentTab, setCurrentTab] = useState<string>('overview');
  const [selectedBranch, setSelectedBranch] = useState<string>('all');
  const [searchQuery, setSearchQuery] = useState<string>('');

  const getBreadcrumb = (tab: string) => {
    switch (tab) {
      case 'overview':
        return 'Quản trị / Tổng quan vận hành';
      case 'branches':
        return 'Quản trị / Quản lý chi nhánh';
      case 'customers':
        return 'Quản trị / Khách hàng';
      case 'staff_schedule':
        return 'Quản trị / Lịch kỹ thuật viên';
      case 'treatments':
        return 'Quản trị / Quản lý liệu trình';
      case 'cashier':
        return 'Quản trị / Thu ngân';
      case 'admissions':
        return 'Quản trị / Tuyển sinh';
      case 'instructors':
        return 'Quản trị / Giảng viên';
      case 'students':
        return 'Quản trị / Học viên';
      case 'training_ops':
        return 'Quản trị / Vận hành đào tạo';
      case 'revenue_report':
        return 'Quản trị / Báo cáo doanh thu';
      default:
        return 'Quản trị / Tổng quan vận hành';
    }
  };

  const renderContent = () => {
    switch (currentTab) {
      case 'overview':
        return <OverviewTab onNavigateTab={setCurrentTab} />;
      case 'branches':
        return <BranchesTab />;
      case 'customers':
        return <CustomersTab />;
      case 'staff_schedule':
        return <StaffScheduleTab onNavigateTab={setCurrentTab} />;
      case 'treatments':
        return <TreatmentsTab />;
      case 'cashier':
        return <CashierTab />;
      case 'admissions':
        return <AdmissionsTab />;
      case 'instructors':
        return <InstructorsTab />;
      case 'students':
        return <StudentsTab />;
      case 'training_ops':
        return <TrainingOpsTab />;
      case 'revenue_report':
        return <RevenueReportTab />;
      default:
        return <OverviewTab onNavigateTab={setCurrentTab} />;
    }
  };

  return (
    <div className="flex h-screen bg-[#FBF9F7] text-stone-900 overflow-hidden font-sans antialiased">
      {/* Sidebar Navigation */}
      <Sidebar currentTab={currentTab} onSelectTab={setCurrentTab} />

      {/* Main Content Area */}
      <div className="flex-1 flex flex-col min-w-0 overflow-hidden">
        {/* Top Header */}
        <Header
          breadcrumb={getBreadcrumb(currentTab)}
          selectedBranch={selectedBranch}
          onBranchChange={setSelectedBranch}
          searchQuery={searchQuery}
          onSearchChange={setSearchQuery}
        />

        {/* Scrollable Page Body */}
        <main className="flex-1 overflow-y-auto p-6 md:p-8">
          <div className="max-w-7xl mx-auto">
            {renderContent()}
          </div>
        </main>
      </div>
    </div>
  );
};
