import React, { useState } from 'react';
import {
  Plus,
  Search,
  BookOpen,
  Clock,
  Users,
  Trash2,
  FileText,
} from 'lucide-react';
import { AdminCourse } from '../types';

interface CoursesTabProps {
  courses: AdminCourse[];
  onAddCourse: (course: Omit<AdminCourse, 'id'>) => void;
  onToggleStatus: (id: string) => void;
  onDeleteCourse: (id: string) => void;
}

export const CoursesTab: React.FC<CoursesTabProps> = ({
  courses,
  onAddCourse,
  onToggleStatus,
  onDeleteCourse,
}) => {
  const [searchQuery, setSearchQuery] = useState('');
  const [showAddModal, setShowAddModal] = useState(false);

  // Form states
  const [title, setTitle] = useState('');
  const [category, setCategory] = useState('Điều dưỡng');
  const [instructor, setInstructor] = useState('PGS. TS. BS. Nguyễn Văn Hùng');
  const [tuitionFee, setTuitionFee] = useState(6500000);
  const [totalLessons, setTotalLessons] = useState(24);
  const [totalHours, setTotalHours] = useState(48);

  const filteredCourses = courses.filter(
    (c) =>
      c.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
      c.instructor.toLowerCase().includes(searchQuery.toLowerCase()) ||
      c.category.toLowerCase().includes(searchQuery.toLowerCase())
  );

  const handleAdd = (e: React.FormEvent) => {
    e.preventDefault();
    if (!title) return;

    onAddCourse({
      title,
      category,
      instructor,
      tuitionFee,
      studentsCount: 0,
      totalLessons,
      totalHours,
      status: 'published',
    });

    setTitle('');
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
            placeholder="Tìm theo tên khóa học, giảng viên..."
            className="w-full pl-9 pr-4 py-2 bg-slate-50 text-xs rounded-xl border border-slate-200 focus:outline-none focus:border-blue-500"
          />
        </div>

        <button
          onClick={() => setShowAddModal(true)}
          className="flex items-center gap-1.5 px-4 py-2 rounded-xl bg-teal-600 hover:bg-teal-700 text-white text-xs font-bold shadow-md shadow-teal-600/20 transition-all shrink-0"
        >
          <Plus className="w-4 h-4" />
          <span>Tạo Khóa Đào Tạo Mới</span>
        </button>
      </div>

      {/* Courses List */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
        {filteredCourses.map((course) => (
          <div
            key={course.id}
            className="bg-white rounded-2xl border border-slate-200/80 shadow-sm p-5 flex flex-col justify-between hover:shadow-md transition-shadow"
          >
            <div>
              <div className="flex items-center justify-between mb-3">
                <span className="px-2.5 py-0.5 rounded-full text-[10px] font-bold bg-amber-50 text-amber-800 border border-amber-200/60">
                  {course.category}
                </span>
                <span
                  className={`text-[10px] font-bold px-2 py-0.5 rounded-full ${
                    course.status === 'published'
                      ? 'bg-emerald-100 text-emerald-800'
                      : 'bg-slate-100 text-slate-500'
                  }`}
                >
                  {course.status === 'published' ? 'Đã xuất bản' : 'Bản nháp'}
                </span>
              </div>

              <h4 className="font-bold text-slate-900 text-sm mb-2 leading-snug">
                {course.title}
              </h4>

              <div className="text-xs text-slate-500 mb-3">
                Giảng viên: <span className="font-semibold text-slate-800">{course.instructor}</span>
              </div>

              <div className="flex items-center gap-4 text-slate-500 text-xs mb-4">
                <div className="flex items-center gap-1">
                  <Clock className="w-3.5 h-3.5 text-teal-500" />
                  <span>{course.totalHours}h</span>
                </div>
                <div className="flex items-center gap-1">
                  <BookOpen className="w-3.5 h-3.5 text-blue-500" />
                  <span>{course.totalLessons} bài học</span>
                </div>
                <div className="flex items-center gap-1">
                  <Users className="w-3.5 h-3.5 text-purple-500" />
                  <span>{course.studentsCount} học viên</span>
                </div>
              </div>
            </div>

            <div className="pt-4 border-t border-slate-100 flex items-center justify-between">
              <div className="text-base font-black text-teal-600">
                {course.tuitionFee.toLocaleString('vi-VN')} ₫
              </div>
              <div className="flex items-center gap-2">
                <button
                  onClick={() => onToggleStatus(course.id)}
                  title="Chuyển trạng thái xuất bản / nháp"
                  className="p-1.5 rounded-lg border border-slate-200 text-slate-400 hover:text-blue-600 hover:bg-blue-50 transition-colors"
                >
                  <FileText className="w-3.5 h-3.5" />
                </button>
                <button
                  onClick={() => onDeleteCourse(course.id)}
                  title="Xóa khóa học"
                  className="p-1.5 rounded-lg border border-slate-200 text-slate-400 hover:text-rose-600 hover:bg-rose-50 transition-colors"
                >
                  <Trash2 className="w-3.5 h-3.5" />
                </button>
              </div>
            </div>
          </div>
        ))}
      </div>

      {/* Add Course Modal */}
      {showAddModal && (
        <div className="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl w-full max-w-md p-6 shadow-2xl border border-slate-200">
            <h3 className="text-base font-bold text-slate-900 mb-1">Thêm Khóa Đào Tạo Nghề Y Dược</h3>
            <p className="text-xs text-slate-500 mb-5">Học phần lý thuyết tương tác & thực hành lâm sàng bệnh viện</p>

            <form onSubmit={handleAdd} className="space-y-4">
              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1">Tên chương trình học</label>
                <input
                  type="text"
                  required
                  value={title}
                  onChange={(e) => setTitle(e.target.value)}
                  placeholder="VD: Kỹ Thuật Viên Phục Hồi Chức Năng Y Khoa"
                  className="w-full px-3 py-2 text-xs rounded-xl border border-slate-300 focus:outline-none focus:border-teal-500"
                />
              </div>

              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1">Chuyên ngành đào tạo</label>
                <select
                  value={category}
                  onChange={(e) => setCategory(e.target.value)}
                  className="w-full px-3 py-2 text-xs rounded-xl border border-slate-300 focus:outline-none focus:border-teal-500"
                >
                  <option value="Điều dưỡng">Điều dưỡng</option>
                  <option value="Chăm sóc cao tuổi">Chăm sóc cao tuổi (Kaigo)</option>
                  <option value="Thẩm mỹ y khoa">Thẩm mỹ y khoa</option>
                  <option value="Xét nghiệm y học">Xét nghiệm y học</option>
                </select>
              </div>

              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1">Giảng viên / Bác sĩ chủ nhiệm</label>
                <input
                  type="text"
                  required
                  value={instructor}
                  onChange={(e) => setInstructor(e.target.value)}
                  className="w-full px-3 py-2 text-xs rounded-xl border border-slate-300 focus:outline-none focus:border-teal-500"
                />
              </div>

              <div className="grid grid-cols-3 gap-3">
                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">Học phí (₫)</label>
                  <input
                    type="number"
                    required
                    value={tuitionFee}
                    onChange={(e) => setTuitionFee(Number(e.target.value))}
                    className="w-full px-3 py-2 text-xs rounded-xl border border-slate-300 focus:outline-none focus:border-teal-500"
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">Số bài học</label>
                  <input
                    type="number"
                    required
                    value={totalLessons}
                    onChange={(e) => setTotalLessons(Number(e.target.value))}
                    className="w-full px-3 py-2 text-xs rounded-xl border border-slate-300 focus:outline-none focus:border-teal-500"
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">Tổng giờ</label>
                  <input
                    type="number"
                    required
                    value={totalHours}
                    onChange={(e) => setTotalHours(Number(e.target.value))}
                    className="w-full px-3 py-2 text-xs rounded-xl border border-slate-300 focus:outline-none focus:border-teal-500"
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
                  className="px-5 py-2 rounded-xl text-xs font-bold bg-teal-600 hover:bg-teal-700 text-white shadow-md shadow-teal-600/20 transition-all"
                >
                  Lưu & Xuất Bản Khóa Học
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
};
