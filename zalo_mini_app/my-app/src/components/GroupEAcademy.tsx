import React, { useEffect, useState } from 'react';
import { Box, Text } from 'zmp-ui';
import { apiClient } from '@/api/client';
import { Course, CourseEnrollment } from '../../../../backend/src/data/database';
import {
  NavAcademyIcon,
  SearchIcon,
  ClockIcon,
  StarIcon,
  CheckIcon,
  ArrowRightIcon,
  ArrowLeftIcon,
  CloseIcon,
  CalendarIcon,
  TrophyIcon,
  ShieldIcon,
  PlayCircleIcon,
  FileTextIcon,
  UserCheckIcon,
} from './Icons';

interface GroupEAcademyProps {
  courses: Course[];
  onOpenBooking?: () => void;
}

export const GroupEAcademy: React.FC<GroupEAcademyProps> = ({ courses }) => {
  const [activeTab, setActiveTab] = useState<'catalog' | 'my_courses' | 'schedule' | 'exam'>('catalog');
  const [catalogPage, setCatalogPage] = useState<'home' | 'explore'>('home');
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedCategory, setSelectedCategory] = useState('Tất cả');
  const [selectedCourse, setSelectedCourse] = useState<any | null>(null);
  const [selectedInstructor, setSelectedInstructor] = useState<any | null>(null);

  // Registration modal states
  const [isRegisterModalOpen, setIsRegisterModalOpen] = useState(false);
  const [isPaymentModalOpen, setIsPaymentModalOpen] = useState(false);
  const [studentName, setStudentName] = useState('Nguyễn Minh Anh');
  const [studentPhone, setStudentPhone] = useState('0912345678');
  const [studentEmail, setStudentEmail] = useState('minh.anh@example.com');
  const [enrollments, setEnrollments] = useState<CourseEnrollment[]>([]);
  const [enrollmentError, setEnrollmentError] = useState('');
  const [enrolling, setEnrolling] = useState(false);

  // Course study & video player states
  const [activeLessonModal, setActiveLessonModal] = useState<any | null>(null);
  const [isClassDetailOpen, setIsClassDetailOpen] = useState(false);
  const [videoPlaying, setVideoPlaying] = useState(false);

  // Quiz / Exam state (Figma E10)
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(2); // Câu 3 / 20
  const [quizTimer, setQuizTimer] = useState(1125); // 18:45
  const [selectedQuizAnswer, setSelectedQuizAnswer] = useState<number | null>(0);
  const [isCertificateModalOpen, setIsCertificateModalOpen] = useState(false);

  // Filter states (Figma E02)
  const [levelFilter, setLevelFilter] = useState('Tất cả');
  const [durationFilter, setDurationFilter] = useState('6–12 tuần');
  const [priceFilter, setPriceFilter] = useState('4–9 triệu đồng');

  const coursesList = courses.map((course, index) => ({
    ...course,
    totalHours: index === 0 ? '144 giờ đào tạo' : '96 giờ đào tạo',
    theoryHours: index === 0 ? '48 giờ lý thuyết' : '32 giờ lý thuyết',
    practicalHours: index === 0 ? '96 giờ thực hành' : '64 giờ thực hành',
    format: 'Học trực tiếp',
    tuition: `${course.price.toLocaleString('vi-VN')}đ`,
    deposit: `${Math.min(2_000_000, course.price).toLocaleString('vi-VN')}đ`,
    code: `MLD-${course.id.toUpperCase()}`,
    progress: enrollments.some((item) => item.courseId === course.id && item.status === 'confirmed') ? 20 : 0,
  }));

  useEffect(() => {
    apiClient.getCourseEnrollments().then((response) => {
      if (response?.enrollments) setEnrollments(response.enrollments);
    });
  }, []);

  const submitEnrollment = async () => {
    if (!selectedCourse || enrolling) return;
    if (!studentName.trim() || !studentPhone.trim()) {
      setEnrollmentError('Vui lòng nhập đầy đủ họ tên và số điện thoại học viên.');
      setIsPaymentModalOpen(false);
      setIsRegisterModalOpen(true);
      return;
    }
    setEnrolling(true);
    setEnrollmentError('');
    const response = await apiClient.enrollCourse({ courseId: selectedCourse.id, studentName, phone: studentPhone, email: studentEmail });
    setEnrolling(false);
    if (response?.enrollment) {
      setEnrollments((current) => [response.enrollment, ...current.filter((item) => item.courseId !== response.enrollment.courseId)]);
      setIsPaymentModalOpen(false);
      setSelectedCourse(null);
      setActiveTab('my_courses');
      return;
    }
    setEnrollmentError(response?.error || 'Không thể đăng ký khóa học. Vui lòng thử lại.');
  };

  const instructorData = {
    name: 'Nguyễn Thanh Hương',
    role: 'Giảng viên kỹ thuật Spa',
    specialties: 'Massage • Chăm sóc cơ thể • Quy trình dịch vụ',
    bio: 'Cô Hương đồng hành cùng học viên từ thao tác nền tảng đến thực hành quy trình hoàn chỉnh. Phương pháp hướng dẫn chú trọng vệ sinh, giao tiếp và điều chỉnh thao tác theo phản hồi của khách hàng.',
    image: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=600&auto=format&fit=crop&q=80',
  };

  const currentQuizQuestion = {
    number: '3 / 20',
    question: 'Yếu tố nào cần được ưu tiên trước khi thực hiện dịch vụ chăm sóc khách hàng?',
    options: [
      'A. Kiểm tra thông tin và nhu cầu khách hàng.',
      'B. Chuẩn bị chương trình ưu đãi.',
      'C. Giới thiệu thêm sản phẩm.',
      'D. Hướng dẫn khách tự làm thủ tục.',
    ],
  };

  return (
    <div className="space-y-3 px-3 pt-3 pb-20">
      {/* Group E Header Subnav (Figma 05) */}
      <div className="hidden">
        {[
          { id: 'catalog', label: 'Khám phá khóa học' },
          { id: 'my_courses', label: 'Khóa học của tôi' },
          { id: 'exam', label: 'Đánh giá & Trắc nghiệm' },
          { id: 'schedule', label: 'Lịch học & Điểm danh' },
        ].map((tab) => (
          <button
            key={tab.id}
            onClick={() => setActiveTab(tab.id as any)}
            className={`px-3 py-1.5 rounded-full text-xs font-semibold whitespace-nowrap transition active:scale-95 ${
              activeTab === tab.id
                ? 'bg-[#98501B] text-white shadow-sm shadow-[#98501B]/20'
                : 'bg-white text-[#7A685D] border border-[#EADECF] hover:bg-[#FAF6F0]'
            }`}
          >
            {tab.label}
          </button>
        ))}
      </div>

      {/* =========================================================================
          TAB 1: E01 & E02 KHÁM PHÁ KHÓA HỌC
      ========================================================================= */}
      {activeTab === 'catalog' && (
        <div className="space-y-4 animate-fade-in">
          {catalogPage === 'home' && (
            <>
          {/* Header Title (Figma E01) */}
          <div>
            <div className="flex items-center justify-between"><span className="text-[9px] font-semibold text-[#A65317]">HỌC VIỆN ĐÀO TẠO</span><span className="text-[9px] text-[#8A7D74]">Dữ liệu minh họa</span></div>
            <h1 className="text-[21px] font-bold text-[#6F452C] mt-1">Học viện đào tạo</h1>
            <p className="text-[11px] text-[#7A685D] mt-1">Kiến tạo kỹ năng – Phát triển nghề nghiệp</p>
          </div>

          <div className="flex items-center justify-between">
            <div className="flex items-center gap-2">
              <div className="flex h-8 w-8 items-center justify-center rounded-full bg-[#F3E2CE] text-[10px] font-bold text-[#A65317]">MA</div>
              <div>
                <p className="text-[10px] font-bold text-[#40352F]">Xin chào, Minh Anh!</p>
                <p className="text-[8px] text-[#7A685D]">Sẵn sàng nâng cao kỹ năng hôm nay?</p>
              </div>
            </div>
            <button className="flex h-8 w-8 items-center justify-center rounded-[8px] border border-[#E7DDD3] bg-white text-[#A65317]">●</button>
          </div>

          <select className="h-10 w-full rounded-[8px] border border-[#E7DDD3] bg-white px-3 text-[10px] text-[#40352F] outline-none">
            <option>Chi nhánh mẫu 01 – Quận 3</option>
          </select>

          {/* Hero Banner (Figma E01) */}
          <div className="rounded-[10px] overflow-hidden bg-[#F3E2CE] border border-[#E5D3C1]">
            <img src="https://images.unsplash.com/photo-1523240795612-9a054b0db644?w=800&auto=format&fit=crop&q=85" alt="Học viên đào tạo nghề" className="w-full h-[165px] object-cover" />
            <div className="p-3 space-y-2">
              <span className="text-[9px] font-semibold text-[#A65317]">HỌC VIỆN ĐÀO TẠO NGHỀ</span>
              <h2 className="text-[16px] font-bold text-[#6F452C] leading-tight">
                Khởi đầu sự nghiệp cùng nghề Spa
              </h2>
              <p className="text-[10px] text-[#6F625B]">
                Đào tạo thực hành, phát triển kỹ năng và nâng cao năng lực nghề nghiệp.
              </p>
              <button
                onClick={() => setCatalogPage('explore')}
                className="w-full h-10 rounded-[8px] bg-white text-[#A65317] text-[11px] font-bold border border-[#A65317]"
              >
                Khám phá khóa học
              </button>
            </div>
          </div>
            </>
          )}

          {catalogPage === 'explore' && (
            <>
          <div>
            <div className="flex items-center justify-between">
              <button onClick={() => setCatalogPage('home')} className="flex h-8 w-8 items-center justify-center rounded-[8px] border border-[#E7DDD3] bg-white">
                <ArrowLeftIcon size={16} color="#40352F" />
              </button>
              <span className="text-[8px] text-[#8A7D74]">Dữ liệu minh họa</span>
            </div>
            <h1 className="mt-2 text-[21px] font-bold leading-tight text-[#6F452C]">Khám phá khóa học</h1>
            <p className="mt-1 text-[10px] text-[#7A685D]">Chọn chương trình đào tạo phù hợp với mục tiêu nghề nghiệp của bạn.</p>
          </div>

          {/* Search bar */}
          <div className="relative flex items-center">
            <SearchIcon size={16} className="absolute left-3.5 text-[#98501B]" />
            <input
              type="text"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              placeholder="Tìm khóa học, kỹ năng hoặc chuyên ngành..."
              className="w-full pl-10 pr-4 py-2.5 rounded-[8px] bg-white border border-[#EADECF] text-xs text-[#40352F] placeholder-[#A09085] focus:outline-none focus:border-[#98501B]"
            />
          </div>

          {/* Category Chips (Figma E02) */}
          <div className="flex space-x-1.5 overflow-x-auto no-scrollbar">
            {['Tất cả', 'Massage', 'Chăm sóc da', 'Kỹ thuật MLD', 'Quản lý Spa'].map((cat) => (
              <button
                key={cat}
                onClick={() => setSelectedCategory(cat)}
                className={`px-3 py-1.5 rounded-full text-xs font-semibold whitespace-nowrap transition ${
                  selectedCategory === cat
                    ? 'bg-[#98501B] text-white shadow-xs'
                    : 'bg-white text-[#7A685D] border border-[#EADECF]'
                }`}
              >
                {cat}
              </button>
            ))}
          </div>

          {/* Filters Row (Figma E02) */}
          <div className="grid grid-cols-2 gap-2 bg-white rounded-[10px] p-3 border border-[#EADECF]">
            <div>
              <label className="text-[10px] font-semibold text-[#7A685D]">Thời lượng:</label>
              <select
                value={durationFilter}
                onChange={(e) => setDurationFilter(e.target.value)}
                className="w-full mt-0.5 p-1.5 rounded-lg bg-[#FAF6F0] border border-[#EADECF] text-xs text-[#40352F] font-medium"
              >
                <option>6–12 tuần</option>
                <option>Dưới 6 tuần</option>
                <option>Trên 12 tuần</option>
              </select>
            </div>
            <div>
              <label className="text-[10px] font-semibold text-[#7A685D]">Học phí:</label>
              <select
                value={priceFilter}
                onChange={(e) => setPriceFilter(e.target.value)}
                className="w-full mt-0.5 p-1.5 rounded-lg bg-[#FAF6F0] border border-[#EADECF] text-xs text-[#40352F] font-medium"
              >
                <option>4–9 triệu đồng</option>
                <option>Dưới 4 triệu</option>
                <option>Trên 9 triệu</option>
              </select>
            </div>
          </div>

          {/* Courses List */}
          <div className="space-y-3">
            <div className="flex items-center justify-between text-xs px-1 text-[#7A685D]">
              <span>Các chương trình đào tạo ({coursesList.length})</span>
              <span className="text-[#98501B] font-bold">Khóa tuyển sinh mới</span>
            </div>

            {coursesList.map((course) => (
              <div
                key={course.id}
                onClick={() => setSelectedCourse(course)}
                className="bg-white rounded-[10px] border border-[#EFEAE3] p-3 shadow-[0_2px_8px_rgba(0,0,0,0.04)] space-y-3 cursor-pointer hover:border-[#98501B] transition active:scale-[0.99]"
              >
                <div className="flex space-x-3 items-start">
                  <img
                    src={course.image}
                    alt={course.title}
                    className="w-24 h-24 rounded-xl object-cover border border-[#EADECF] shrink-0"
                  />
                  <div className="flex-1 min-w-0 space-y-1">
                    <span className="text-[9px] font-bold uppercase px-2 py-0.5 rounded bg-[#FAF6F0] text-[#98501B] border border-[#EADECF]">
                      {course.category}
                    </span>
                    <h3 className="text-xs font-bold text-[#40352F] line-clamp-2">{course.title}</h3>
                    <p className="text-[11px] text-[#7A685D]">{course.duration} • {course.format}</p>
                    <p className="text-xs font-extrabold text-[#98501B]">{course.tuition}</p>
                  </div>
                </div>

                <div className="flex items-center justify-between pt-1 border-t border-[#FAF6F0]">
                  <span className="text-[10px] text-[#7A685D]">Giảng viên: {course.instructor}</span>
                  <button className="px-3 py-1.5 rounded-xl bg-[#FAF6F0] hover:bg-[#98501B] text-[#98501B] hover:text-white text-xs font-bold transition">
                    Xem chi tiết
                  </button>
                </div>
              </div>
            ))}
          </div>
            </>
          )}
        </div>
      )}

      {/* =========================================================================
          TAB 2: E07 KHÓA HỌC CỦA TÔI
      ========================================================================= */}
      {activeTab === 'my_courses' && (
        <div className="space-y-3 animate-fade-in">
          <div>
            <div className="flex justify-between"><span className="text-[8px] font-semibold text-[#A65317]">HỌC VIỆN ĐÀO TẠO</span><span className="text-[8px] text-[#8A7D74]">Đồng bộ hệ thống</span></div>
            <h1 className="mt-1 text-[21px] font-bold text-[#6F452C]">Khóa học của tôi</h1>
            <p className="text-xs text-[#7A685D]">Theo dõi quá trình học tập và phát triển kỹ năng.</p>
          </div>

          {/* Student stats card (Figma E07) */}
          <div className="bg-[#F3E2CE] rounded-[10px] p-3 grid grid-cols-3 gap-2 text-left">
            <div>
              <div className="text-base font-extrabold text-[#98501B]">{enrollments.length}</div>
              <div className="text-[10px] text-[#7A685D]">Đã ghi danh</div>
            </div>
            <div>
              <div className="text-base font-extrabold text-[#40352F]">{enrollments.filter((item) => item.status === 'confirmed').length}</div>
              <div className="text-[10px] text-[#7A685D]">Đang học</div>
            </div>
            <div>
              <div className="text-base font-extrabold text-emerald-600">{enrollments.filter((item) => item.status === 'completed').length}</div>
              <div className="text-[10px] text-[#7A685D]">Hoàn thành</div>
            </div>
          </div>

          {enrollments.length === 0 ? <div className="rounded-[10px] border border-[#EADECF] bg-white p-5 text-center"><p className="text-xs font-bold text-[#40352F]">Bạn chưa đăng ký khóa học nào</p><button onClick={() => setActiveTab('catalog')} className="mt-3 h-10 rounded-[8px] bg-[#A65317] px-5 text-[10px] font-bold text-white">Khám phá khóa học</button></div> : enrollments.map((enrollment) => <div key={enrollment.id} className="bg-white rounded-[10px] border border-[#EADECF] p-3 shadow-[0_2px_8px_rgba(0,0,0,0.04)] space-y-3">
            <div className="flex items-center justify-between">
              <span className="text-[10px] font-bold px-2 py-0.5 rounded-full bg-amber-50 text-amber-800 border border-amber-200">
                {enrollment.status === 'pending' ? 'Chờ xác nhận' : enrollment.status === 'confirmed' ? 'Đang học' : enrollment.status} • {enrollment.code}
              </span>
              <span className="text-xs font-bold text-[#98501B]">{enrollment.status === 'confirmed' ? '20% hoàn thành' : 'Đã ghi nhận'}</span>
            </div>

            <div>
              <h3 className="text-sm font-bold text-[#40352F]">{enrollment.courseTitle}</h3>
              <p className="text-xs text-[#7A685D]">Học viên: {enrollment.studentName}</p>
            </div>

            <div className="w-full h-2 rounded-full bg-[#FAF6F0] overflow-hidden">
              <div className="h-full bg-[#98501B] rounded-full" style={{ width: '20%' }} />
            </div>

            <div className="p-3 rounded-xl bg-[#FAF6F0] text-xs space-y-1">
              <p className="font-semibold text-[#40352F]">Bài tiếp theo:</p>
              <p className="text-[#7A685D]">Bài 05 — Kỹ thuật Massage cơ bản (18 phút)</p>
            </div>

            <button
              onClick={() => setIsClassDetailOpen(true)}
              className="w-full py-2.5 rounded-xl bg-[#98501B] text-white text-xs font-bold hover:bg-[#804215] transition active:scale-95 flex items-center justify-center space-x-1.5"
            >
              <PlayCircleIcon size={14} />
              <span>Xem chi tiết lớp học</span>
            </button>
          </div>)}
        </div>
      )}

      {/* =========================================================================
          TAB 3: E10 BÀI KIỂM TRA & ĐÁNH GIÁ TRÌNH ĐỘ
      ========================================================================= */}
      {activeTab === 'exam' && (
        <div className="space-y-3 animate-fade-in">
          <div>
            <h1 className="text-[21px] font-bold text-[#6F452C]">Kiểm tra kiến thức</h1>
            <p className="text-xs text-[#7A685D]">Bài kiểm tra đánh giá năng lực nghề nghiệp</p>
          </div>

          <div className="space-y-4">
            <div className="flex items-center justify-between border-b border-[#FAF6F0] pb-2">
              <div>
                <span className="text-[10px] text-[#7A685D] uppercase font-bold">Kỹ thuật Massage Chuyên Nghiệp</span>
                <h3 className="text-xs font-bold text-[#40352F]">Bài kiểm tra: Kiến thức Spa cơ bản</h3>
              </div>
              <div className="text-right">
                <span className="text-xs font-extrabold text-[#98501B]">⏱ 18:45</span>
                <p className="text-[9px] text-[#A09085]">Thời gian tính</p>
              </div>
            </div>

            <div className="space-y-2">
              <span className="text-xs font-bold text-[#98501B]">Câu {currentQuizQuestion.number}</span>
              <p className="text-xs font-bold text-[#40352F] leading-relaxed">
                {currentQuizQuestion.question}
              </p>
            </div>

            {/* Multiple choice options (Figma E10) */}
            <div className="space-y-2">
              {currentQuizQuestion.options.map((opt, idx) => (
                <div
                  key={idx}
                  onClick={() => setSelectedQuizAnswer(idx)}
                  className={`p-3 rounded-[10px] border text-xs cursor-pointer transition flex items-center justify-between ${
                    selectedQuizAnswer === idx
                      ? 'border-[#98501B] bg-[#FAF6F0] text-[#98501B] font-bold'
                      : 'border-[#EADECF] text-[#40352F] hover:bg-stone-50'
                  }`}
                >
                  <span>{opt}</span>
                  {selectedQuizAnswer === idx && <CheckIcon size={14} className="text-[#98501B]" />}
                </div>
              ))}
            </div>

            <div className="flex space-x-2 pt-2">
              <button
                onClick={() => setIsCertificateModalOpen(true)}
                className="flex-1 py-2.5 rounded-xl bg-[#98501B] text-white text-xs font-bold hover:bg-[#804215] transition"
              >
                Nộp bài & Xem đánh giá
              </button>
            </div>
          </div>
        </div>
      )}

      {/* =========================================================================
          TAB 4: E11 LỊCH HỌC & ĐIỂM DANH
      ========================================================================= */}
      {activeTab === 'schedule' && (
        <div className="space-y-3 animate-fade-in">
          <div>
            <h1 className="text-[21px] font-bold text-[#6F452C]">Lịch học & điểm danh</h1>
            <p className="text-xs text-[#7A685D]">Chủ động theo dõi lịch đào tạo và các buổi thực hành.</p>
          </div>

          <div className="bg-white rounded-[10px] p-3 border border-[#EADECF] space-y-3">
            <div className="flex items-center justify-between">
              <h3 className="text-xs font-bold text-[#40352F]">Tháng 10, 2026</h3>
              <span className="text-[10px] text-[#98501B] font-bold">● Lịch mẫu</span>
            </div>

            {/* Upcoming class session */}
            <div className="p-3 rounded-[10px] bg-[#F3E2CE] space-y-1">
              <div className="flex justify-between items-center">
                <span className="text-xs font-bold text-[#40352F]">Thứ 6 • 16/10/2026</span>
                <span className="text-[10px] font-bold text-emerald-700 bg-emerald-100 px-2 py-0.5 rounded-full">
                  Thực hành tại lớp
                </span>
              </div>
              <p className="text-xs text-[#7A685D]">13:00 — 17:00 (4 tiếng)</p>
              <p className="text-[11px] text-[#40352F]">Chủ đề: Thao tác massage vùng cổ gáy trên mô hình thật</p>
              <p className="text-[10px] text-[#A09085]">Địa điểm: Phòng thực hành 02 — Chi nhánh Quận 3</p>
            </div>
          </div>
        </div>
      )}

      {/* =========================================================================
          DEDICATED FULL PAGE: E03 CHI TIẾT KHÓA HỌC
      ========================================================================= */}
      {selectedCourse && !isRegisterModalOpen && !isPaymentModalOpen && (
        <div className="absolute inset-0 z-50 bg-[#FAF6F0] flex flex-col overflow-hidden animate-fade-in text-stone-800">
          <div className="px-3 pt-3 pb-2 shrink-0">
            <div className="flex items-center justify-between">
              <button
                onClick={() => setSelectedCourse(null)}
                className="w-8 h-8 rounded-[8px] bg-white border border-[#E7DDD3] flex items-center justify-center text-[#40352F] active:scale-95"
              >
                <ArrowLeftIcon size={16} color="#40352F" />
              </button>
              <span className="text-[8px] text-[#8A7D74]">Dữ liệu minh họa</span>
            </div>
            <h1 className="mt-2 max-w-[280px] text-[21px] leading-[1.08] font-bold text-[#6F452C]">{selectedCourse.title}</h1>
          </div>

          <div className="flex-1 overflow-y-auto px-3 space-y-3 pb-24">
            <div className="rounded-[10px] overflow-hidden border border-[#EADECF]">
              <img
                src={selectedCourse.image}
                alt={selectedCourse.title}
                className="w-full h-[178px] object-cover"
              />
              <div className="hidden">
                <span className="text-[9px] font-bold uppercase px-2 py-0.5 rounded bg-[#FAF6F0] text-[#98501B] border border-[#EADECF]">
                  {selectedCourse.category}
                </span>
                <h3 className="text-base font-bold text-[#40352F] mt-1.5">{selectedCourse.title}</h3>
              </div>
            </div>

            {/* Metrics cards (Figma E03) */}
            <div className="bg-[#F3E2CE] p-3 rounded-[10px] text-left">
              <p className="mb-3 text-[8px] font-medium text-[#A65317]">Thực hành chuyên nghiệp · Minh họa</p>
              <div className="grid grid-cols-2 gap-2">
              <div>
                <div className="text-xl font-black text-[#98501B]">12</div>
                <div className="text-[10px] text-[#7A685D] font-semibold">tuần học</div>
                <div className="text-[9px] text-[#A09085]">48 giờ lý thuyết</div>
              </div>
              <div>
                <div className="text-xl font-black text-[#40352F]">144</div>
                <div className="text-[10px] text-[#7A685D] font-semibold">giờ đào tạo</div>
                <div className="text-[9px] text-[#A09085]">96 giờ thực hành</div>
              </div>
              </div>
              <p className="mt-2 text-[9px] text-[#6F625B]">48 giờ lý thuyết · 96 giờ thực hành</p>
              <p className="mt-2 text-[9px] text-[#6F625B]">Học trực tiếp · Học phí 9.000.000đ</p>
            </div>

            <div className="space-y-2">
              <h4 className="text-[13px] font-bold text-[#6F452C]">Giới thiệu khóa học</h4>
              <p className="text-xs text-[#7A685D] leading-relaxed">{selectedCourse.description}</p>
            </div>

            {/* Instructor teaser (Figma E04) */}
            <div
              onClick={() => setSelectedInstructor(instructorData)}
              className="flex items-center justify-between p-3 rounded-[10px] bg-white border border-[#EADECF] cursor-pointer"
            >
              <div className="flex items-center space-x-3">
                <img
                  src={instructorData.image}
                  alt={instructorData.name}
                  className="w-11 h-11 rounded-full object-cover border border-[#EADECF]"
                />
                <div>
                  <p className="text-xs font-bold text-[#40352F]">{instructorData.name}</p>
                  <p className="text-[10px] text-[#7A685D]">{instructorData.role}</p>
                </div>
              </div>
              <span className="text-xs text-[#98501B] font-bold">Hồ sơ &gt;</span>
            </div>
          </div>

          <div className="p-3 bg-white border-t border-[#EADECF] shrink-0">
            <div className="mb-2">
              <span className="text-[10px] text-[#7A685D]">Học phí trọn gói:</span>
              <p className="text-base font-extrabold text-[#98501B]">{selectedCourse.tuition}</p>
            </div>
            <button
              onClick={() => {
                setIsRegisterModalOpen(true);
              }}
              className="w-full h-11 rounded-[8px] bg-[#A65317] text-white text-[11px] font-bold active:scale-95"
            >
              Đăng ký khóa học
            </button>
          </div>
        </div>
      )}

      {/* =========================================================================
          DEDICATED FULL PAGE: E04 THÔNG TIN GIẢNG VIÊN
      ========================================================================= */}
      {selectedInstructor && (
        <div className="absolute inset-0 z-50 bg-[#FAF6F0] flex flex-col overflow-hidden animate-fade-in text-stone-800">
          <div className="px-3 pt-3 pb-2 shrink-0">
            <div className="flex items-center justify-between">
              <button
                onClick={() => setSelectedInstructor(null)}
                className="w-8 h-8 rounded-[8px] bg-white border border-[#E7DDD3] flex items-center justify-center text-[#40352F] active:scale-95"
              >
                <ArrowLeftIcon size={16} color="#40352F" />
              </button>
              <span className="text-[8px] text-[#8A7D74]">Dữ liệu minh họa</span>
            </div>
            <h1 className="mt-2 text-[21px] font-bold text-[#6F452C]">Thông tin giảng viên</h1>
          </div>

          <div className="flex-1 overflow-y-auto px-3 space-y-3 pb-24">
            <div className="rounded-[10px] overflow-hidden bg-white">
              <img
                src={selectedInstructor.image}
                alt={selectedInstructor.name}
                className="w-full h-[230px] object-cover"
              />
              <div className="p-4">
                <h4 className="text-base font-bold text-[#40352F]">{selectedInstructor.name}</h4>
                <p className="text-xs text-[#98501B] font-bold mt-0.5">{selectedInstructor.role}</p>
                <p className="text-[11px] text-[#7A685D] mt-1">{selectedInstructor.specialties}</p>
              </div>
            </div>

            <div className="space-y-2">
              <h5 className="text-[15px] font-bold text-[#6F452C]">Giới thiệu</h5>
              <p className="text-xs text-[#7A685D] leading-relaxed">{selectedInstructor.bio}</p>
            </div>
          </div>

          <div className="p-3 bg-white border-t border-[#EADECF] shrink-0">
            <button
              onClick={() => setSelectedInstructor(null)}
              className="w-full h-11 rounded-[8px] bg-[#A65317] text-white text-[11px] font-bold"
            >
              Xem khóa học của giảng viên
            </button>
          </div>
        </div>
      )}

      {/* =========================================================================
          DEDICATED FULL PAGE: E05 ĐĂNG KÝ KHÓA HỌC
      ========================================================================= */}
      {isRegisterModalOpen && selectedCourse && (
        <div className="absolute inset-0 z-50 bg-[#FAF6F0] flex flex-col overflow-hidden animate-fade-in text-stone-800">
          <div className="px-3 pt-3 pb-2 flex items-start justify-between shrink-0">
            <div className="flex items-center space-x-2.5">
              <button
                onClick={() => setIsRegisterModalOpen(false)}
                className="w-8 h-8 rounded-full bg-[#FAF6F0] flex items-center justify-center text-[#40352F] hover:bg-[#EADECF] transition active:scale-95"
              >
                <ArrowLeftIcon size={16} color="#40352F" />
              </button>
              <h3 className="text-[20px] font-bold text-[#6F452C]">Đăng ký khóa học</h3>
            </div>
            <button
              onClick={() => setIsRegisterModalOpen(false)}
              className="text-xs text-[#98501B] font-bold"
            >
              Dữ liệu minh họa
            </button>
          </div>

          <div className="flex-1 overflow-y-auto px-3 space-y-3 pb-24">
            <div className="p-3 rounded-[10px] bg-[#F3E2CE] flex items-center space-x-3">
              <img
                src={selectedCourse.image}
                alt="Course"
                className="w-16 h-16 rounded-xl object-cover"
              />
              <div>
                <p className="text-xs font-bold text-[#40352F]">{selectedCourse.title}</p>
                <p className="text-[11px] text-[#7A685D] mt-0.5">{selectedCourse.duration}</p>
                <p className="text-xs font-bold text-[#98501B] mt-0.5">{selectedCourse.tuition}</p>
              </div>
            </div>

            <div className="space-y-3">
              <h4 className="text-xs font-bold text-[#40352F]">Thông tin học viên:</h4>
              <div>
                <label className="text-[10px] text-[#7A685D] font-bold block mb-1">Họ và tên *</label>
                <input
                  type="text"
                  value={studentName}
                  onChange={(e) => setStudentName(e.target.value)}
                  className="w-full p-3 rounded-[8px] border border-[#EADECF] bg-white text-xs font-medium focus:outline-none focus:border-[#98501B]"
                />
              </div>
              <div>
                <label className="text-[10px] text-[#7A685D] font-bold block mb-1">Số điện thoại *</label>
                <input
                  type="text"
                  value={studentPhone}
                  onChange={(e) => setStudentPhone(e.target.value)}
                  className="w-full p-3 rounded-[8px] border border-[#EADECF] bg-white text-xs font-medium focus:outline-none focus:border-[#98501B]"
                />
              </div>
              <div>
                <label className="text-[10px] text-[#7A685D] font-bold block mb-1">Email liên hệ</label>
                <input
                  type="email"
                  value={studentEmail}
                  onChange={(e) => setStudentEmail(e.target.value)}
                  className="w-full p-3 rounded-[8px] border border-[#EADECF] bg-white text-xs font-medium focus:outline-none focus:border-[#98501B]"
                />
              </div>
            </div>

            {enrollmentError && <div role="alert" className="rounded-[8px] border border-red-200 bg-red-50 p-3 text-[10px] font-semibold text-red-700">{enrollmentError}</div>}

            <div className="p-3 rounded-[10px] bg-[#F3E2CE] text-xs space-y-1.5">
              <div className="flex justify-between">
                <span>Học phí khóa học:</span>
                <span className="font-bold">{selectedCourse.tuition}</span>
              </div>
              <div className="flex justify-between text-[#98501B] font-bold">
                <span>Đặt cọc giữ chỗ:</span>
                <span>{selectedCourse.deposit}</span>
              </div>
            </div>
          </div>

          <div className="p-3 bg-white border-t border-[#EADECF] shrink-0">
            <button
              onClick={() => {
                if (!studentName.trim() || !studentPhone.trim()) {
                  setEnrollmentError('Vui lòng nhập đầy đủ họ tên và số điện thoại học viên.');
                  return;
                }
                setEnrollmentError('');
                setIsRegisterModalOpen(false);
                setIsPaymentModalOpen(true);
              }}
              className="w-full h-11 rounded-[8px] bg-[#A65317] text-white text-[11px] font-bold"
            >
              Tiếp tục thanh toán
            </button>
          </div>
        </div>
      )}

      {/* =========================================================================
          DEDICATED FULL PAGE: E06 XÁC NHẬN THANH TOÁN HỌC PHÍ
      ========================================================================= */}
      {isPaymentModalOpen && selectedCourse && (
        <div className="absolute inset-0 z-50 bg-[#FAF6F0] flex flex-col overflow-hidden animate-fade-in text-stone-800">
          <div className="shrink-0 px-3 pb-2 pt-3">
            <div className="flex items-center justify-between">
              <button
                onClick={() => setIsPaymentModalOpen(false)}
                className="flex h-8 w-8 items-center justify-center rounded-[8px] border border-[#E7DDD3] bg-white text-[#40352F] active:scale-95"
              >
                <ArrowLeftIcon size={16} color="#40352F" />
              </button>
              <span className="text-[8px] text-[#8A7D74]">Dữ liệu minh họa</span>
            </div>
            <h1 className="mt-2 text-[21px] font-bold leading-tight text-[#6F452C]">Thanh toán học phí</h1>
            <p className="mt-1 text-[10px] leading-relaxed text-[#7A685D]">Kiểm tra học phí và lựa chọn phương thức thanh toán.</p>
          </div>

          <div className="flex-1 overflow-y-auto px-3 space-y-3 pb-24">
            <div className="p-3 rounded-[10px] bg-[#F3E2CE] space-y-1">
              <p className="text-[11px] text-[#A65317] font-bold">◷ Chờ thanh toán — minh họa</p>
              <p className="text-[9px] text-[#6F625B]">Chưa ghi danh · Không thực hiện thanh toán bằng mẫu này.</p>
            </div>

            <div className="bg-[#F3E2CE] p-3 rounded-[10px] space-y-2 text-xs">
              <p className="font-bold text-[12px] text-[#40352F]">{selectedCourse.title}</p>
              <p className="text-[9px] text-[#6F625B]">{studentName} · MCN-1026</p>
              <p className="text-[9px] text-[#6F625B]">Khai giảng 23/10/2026 · Học trực tiếp</p>
              <p className="text-[9px] text-[#6F625B]">Chi nhánh mẫu 01 – Quận 3</p>
              <p className="text-[9px] text-[#6F625B]">Thứ 6–7–Chủ nhật · 13:00–17:00</p>
            </div>

            <div className="bg-white p-3 rounded-[10px] border border-[#EADECF] space-y-2">
              <h2 className="text-[15px] font-bold text-[#6F452C]">Học phí minh họa</h2>
              <div className="space-y-2 text-[10px] text-[#6F625B]">
                <div className="flex justify-between"><span>Học phí</span><span>9.000.000đ</span></div>
                <div className="flex justify-between"><span>Giảm giá</span><span>0đ</span></div>
                <div className="flex justify-between"><span>Phí đăng ký</span><span>0đ</span></div>
                <div className="flex justify-between border-t border-[#EFEAE3] pt-2 font-bold text-[#40352F]"><span>Tổng cộng</span><span>9.000.000đ</span></div>
              </div>
            </div>
          </div>

          <div className="p-3 bg-white border-t border-[#EADECF] shrink-0">
            <p className="mb-2 text-[8px] text-[#A65317]">Chờ thanh toán · Trả ngay 2.000.000đ (minh họa)</p>
            <button
              onClick={submitEnrollment}
              disabled={enrolling}
              className="w-full h-11 rounded-[8px] bg-[#A65317] text-white text-[11px] font-bold"
            >
              {enrolling ? 'Đang ghi nhận đăng ký...' : 'Xác nhận đăng ký'}
            </button>
          </div>
        </div>
      )}

      {/* E08: CHI TIẾT LỚP HỌC */}
      {isClassDetailOpen && !activeLessonModal && (
        <div className="absolute inset-0 z-50 flex flex-col overflow-hidden bg-[#FAF8F5] text-stone-800">
          <div className="shrink-0 px-3 pb-2 pt-3">
            <div className="flex items-center justify-between">
              <button onClick={() => setIsClassDetailOpen(false)} className="flex h-8 w-8 items-center justify-center rounded-[8px] border border-[#E7DDD3] bg-white">
                <ArrowLeftIcon size={16} color="#40352F" />
              </button>
              <span className="text-[8px] text-[#8A7D74]">Dữ liệu minh họa</span>
            </div>
            <h2 className="mt-2 text-[21px] font-bold text-[#6F452C]">Chi tiết lớp học</h2>
          </div>
          <div className="flex-1 space-y-3 overflow-y-auto px-3 pb-24">
            <div className="rounded-[10px] bg-[#F3E2CE] p-3">
              <p className="text-[8px] font-semibold text-[#A65317]">Đang học · MCN-0926</p>
              <h3 className="mt-3 text-[16px] font-bold leading-tight text-[#6F452C]">Kỹ thuật Massage Chuyên Nghiệp</h3>
              <div className="mt-3 space-y-2 text-[9px] text-[#6F625B]">
                <p>Giảng viên Nguyễn Thanh Hương</p><p>Chi nhánh mẫu 01 – Quận 3</p><p>Thứ 6–7–Chủ nhật · 13:00–17:00</p>
              </div>
              <div className="mt-3 flex justify-between text-[9px]"><span>4 / 20 bài học đã hoàn thành</span><b className="text-[#A65317]">20%</b></div>
              <div className="mt-2 h-1 rounded-full bg-[#DFC8B4]"><div className="h-full w-1/5 rounded-full bg-[#A65317]" /></div>
            </div>
            <div className="grid grid-cols-3 border-b border-[#DCC8B6] text-center text-[9px] text-[#7A685D]">
              <span className="border-b-2 border-[#A65317] py-2 font-semibold text-[#A65317]">Nội dung học</span><span className="py-2">Lịch học</span><span className="py-2">Tài liệu</span>
            </div>
            <div className="rounded-[10px] bg-white p-3 shadow-[0_2px_8px_rgba(0,0,0,0.04)]">
              <div className="flex justify-between"><b className="text-[11px] text-[#40352F]">Chương 1: Giới thiệu nghề Spa</b><span>⌃</span></div>
              <p className="mt-1 text-[8px] text-[#8A7D74]">3 bài học · Đã hoàn thành</p>
              <button onClick={() => setActiveLessonModal({ title: 'Bài 05: Kỹ thuật Massage cơ bản' })} className="mt-3 flex w-full items-center gap-2 border-t border-[#EFEAE3] pt-3 text-left text-[9px] text-[#6F452C]">
                <PlayCircleIcon size={16} className="text-[#A65317]" /><span>Bài 1: Tổng quan ngành Spa<br/><small>Video · 12 phút · Đã hoàn thành</small></span>
              </button>
            </div>
          </div>
          <div className="shrink-0 border-t border-[#EADECF] bg-white p-3">
            <button onClick={() => setActiveLessonModal({ title: 'Bài 05: Kỹ thuật Massage cơ bản' })} className="h-11 w-full rounded-[8px] bg-[#A65317] text-[11px] font-bold text-white">Tiếp tục bài học</button>
          </div>
        </div>
      )}

      {/* =========================================================================
          DEDICATED FULL PAGE: E09 BÀI HỌC VIDEO PLAYER
      ========================================================================= */}
      {activeLessonModal && (
        <div className="absolute inset-0 z-50 bg-[#FAF6F0] flex flex-col overflow-hidden animate-fade-in text-stone-800">
          <div className="px-3 pt-3 pb-2 flex items-start justify-between shrink-0">
            <div className="flex items-center space-x-2.5">
              <button
                onClick={() => setActiveLessonModal(null)}
                className="w-8 h-8 rounded-full bg-[#FAF6F0] flex items-center justify-center text-[#40352F] hover:bg-[#EADECF] transition active:scale-95"
              >
                <ArrowLeftIcon size={16} color="#40352F" />
              </button>
              <h3 className="text-[20px] font-bold text-[#6F452C]">Bài học</h3>
            </div>
            <button
              onClick={() => setActiveLessonModal(null)}
              className="text-xs text-[#98501B] font-bold"
            >
              Video minh họa
            </button>
          </div>

          <div className="flex-1 overflow-y-auto px-3 space-y-3 pb-24">
            {/* Video container */}
            <div className="relative rounded-[10px] bg-black overflow-hidden h-48 flex items-center justify-center">
              <img
                src="https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=600&auto=format&fit=crop&q=80"
                alt="Video"
                className="w-full h-full object-cover opacity-60"
              />
              <button
                onClick={() => setVideoPlaying(!videoPlaying)}
                className="absolute w-14 h-14 rounded-full bg-[#98501B] text-white flex items-center justify-center shadow-xl active:scale-90 transition"
              >
                <PlayCircleIcon size={28} />
              </button>
              <span className="absolute bottom-2 right-2 px-2.5 py-1 rounded-full bg-black/75 text-white text-[10px] font-mono">
                03:20 / 18:00
              </span>
            </div>

            <div className="space-y-2">
              <p className="text-[9px] text-[#A65317]">Chương 2 · Video 18 phút</p>
              <h4 className="text-[15px] font-bold text-[#6F452C]">Bài 05: Kỹ thuật Massage cơ bản</h4>
              <h4 className="text-xs font-bold text-[#40352F]">Nội dung trọng tâm bài học:</h4>
              <p className="text-xs text-[#7A685D] leading-relaxed">
                1. Kỹ thuật miết nhẹ dẫn lưu mạch máu ngoại vi.<br />
                2. Lực ép lòng bàn tay và nhịp thở đồng điệu.<br />
                3. Điều chỉnh tư thế ngồi tránh mỏi cơ cho kỹ thuật viên.
              </p>
            </div>
          </div>

          <div className="p-3 bg-white border-t border-[#EADECF] shrink-0 space-y-2">
            <button
              onClick={() => setActiveLessonModal(null)}
              className="w-full h-11 rounded-[8px] bg-[#A65317] text-white text-[11px] font-bold"
            >
              Hoàn thành bài học
            </button>
            <button className="w-full h-11 rounded-[8px] border border-[#A65317] bg-white text-[#A65317] text-[11px] font-bold">Bài tiếp theo</button>
          </div>
        </div>
      )}

      {/* =========================================================================
          DEDICATED FULL PAGE: E12 KẾT QUẢ HỌC TẬP & CHỨNG CHỈ
      ========================================================================= */}
      {isCertificateModalOpen && (
        <div className="absolute inset-0 z-50 bg-[#FAF6F0] flex flex-col overflow-hidden animate-fade-in text-stone-800">
          <div className="px-3 pt-3 pb-2 flex items-start justify-between shrink-0">
            <div className="flex items-center space-x-2.5">
              <button
                onClick={() => setIsCertificateModalOpen(false)}
                className="w-8 h-8 rounded-full bg-[#FAF6F0] flex items-center justify-center text-[#40352F] hover:bg-[#EADECF] transition active:scale-95"
              >
                <ArrowLeftIcon size={16} color="#40352F" />
              </button>
              <h3 className="text-[20px] font-bold text-[#6F452C]">Kết quả học tập</h3>
            </div>
            <button
              onClick={() => setIsCertificateModalOpen(false)}
              className="text-xs text-[#98501B] font-bold"
            >
              Dữ liệu minh họa
            </button>
          </div>

          <div className="flex-1 overflow-y-auto px-3 space-y-3 pb-24">
            <div className="space-y-2 py-2">
              <div className="w-16 h-16 mx-auto rounded-full bg-emerald-100 text-emerald-600 flex items-center justify-center shadow-xs">
                <TrophyIcon size={32} />
              </div>
              <h4 className="text-base font-extrabold text-[#40352F]">Chúc Mừng Tốt Nghiệp!</h4>
              <p className="text-xs text-[#7A685D] px-4">
                Học viên <strong>Nguyễn Minh Anh</strong> đã hoàn thành xuất sắc toàn bộ khóa đào tạo chuyên sâu.
              </p>
            </div>

            {/* Scores (Figma E12) */}
            <div className="grid grid-cols-2 gap-2 bg-transparent text-left">
              <div>
                <div className="text-xl font-black text-[#98501B]">8.5 / 10</div>
                <div className="text-[10px] text-[#7A685D] font-bold">Lý thuyết y khoa</div>
              </div>
              <div>
                <div className="text-xl font-black text-emerald-600">9.0 / 10</div>
                <div className="text-[10px] text-[#7A685D] font-bold">Thực hành lâm sàng</div>
              </div>
            </div>

            <div className="p-4 rounded-2xl border border-amber-300 bg-amber-50 text-center space-y-1">
              <span className="text-[10px] uppercase font-bold text-amber-900 tracking-wider">Mã chứng nhận điện tử</span>
              <p className="font-mono text-sm font-black text-amber-950">MLD-CERT-VN-2026-8899</p>
            </div>
          </div>

          <div className="p-3 bg-white border-t border-[#EADECF] shrink-0">
            <button
              onClick={() => setIsCertificateModalOpen(false)}
              className="w-full py-3 rounded-xl bg-[#98501B] text-white text-xs font-bold hover:bg-[#804215] transition shadow-md"
            >
              Lưu chứng nhận vào hồ sơ cá nhân
            </button>
          </div>
        </div>
      )}
    </div>
  );
};
