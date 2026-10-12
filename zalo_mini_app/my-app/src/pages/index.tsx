import React, { useState } from "react";
import {
  Page,
  Box,
  Text,
  Button,
  Icon,
  Modal,
  Input,
  Select,
  useSnackbar,
} from "zmp-ui";

// Mock data: Services & Courses
interface ServiceItem {
  id: string;
  type: "service" | "course";
  title: string;
  category: string;
  price: string;
  duration: string;
  rating: number;
  reviewsCount: number;
  instructor?: string;
  badge?: string;
  description: string;
}

const mockServices: ServiceItem[] = [
  {
    id: "s1",
    type: "service",
    title: "Khám Tổng Quát & Tư Vấn Bác Sĩ",
    category: "Y tế Gia Đình",
    price: "450.000 đ",
    duration: "45 phút",
    rating: 4.9,
    reviewsCount: 128,
    badge: "Phổ biến",
    description: "Thăm khám lâm sàng, đo chỉ số sinh tồn và tư vấn phác đồ điều trị cá nhân hóa.",
  },
  {
    id: "s2",
    type: "service",
    title: "Chăm Sóc & Phục Hồi Chức Năng Tại Nhà",
    category: "Phục Hồi Chức Năng",
    price: "600.000 đ",
    duration: "60 phút",
    rating: 5.0,
    reviewsCount: 94,
    badge: "Yêu thích",
    description: "Kỹ thuật viên y tế đến tận nhà hỗ trợ tập vận động, xoa bóp trị liệu chuyên sâu.",
  },
  {
    id: "s3",
    type: "service",
    title: "Xét Nghiệm Tổng Quát Tận Nơi",
    category: "Xét Nghiệm",
    price: "850.000 đ",
    duration: "30 phút",
    rating: 4.8,
    reviewsCount: 76,
    description: "Lấy mẫu máu tại nhà, trả kết quả và hồ sơ bệnh án trực tuyến qua Zalo trong 4 giờ.",
  },
  {
    id: "s4",
    type: "service",
    title: "Chăm Sóc Toàn Diện Người Cao Tuổi",
    category: "Chăm Sóc Y Tế",
    price: "950.000 đ",
    duration: "Theo ngày",
    rating: 4.9,
    reviewsCount: 110,
    badge: "Chuẩn Quốc Tế",
    description: "Điều dưỡng viên túc trực hỗ trợ sinh hoạt, theo dõi thuốc và dinh dưỡng chuẩn y khoa.",
  },
];

const mockCourses: ServiceItem[] = [
  {
    id: "c1",
    type: "course",
    title: "Kỹ Thuật Viên Phục Hồi Chức Năng Cơ Bản",
    category: "Đào Tạo Nghề Y",
    price: "4.800.000 đ",
    duration: "3 tháng",
    rating: 4.9,
    reviewsCount: 85,
    instructor: "ThS.BS Trần Mai",
    badge: "Cấp Chứng Chỉ",
    description: "Đào tạo thực hành bài bản, cấp chứng chỉ hành nghề chuẩn Bộ Y Tế, cam kết việc làm.",
  },
  {
    id: "c2",
    type: "course",
    title: "Chăm Sóc Người Cao Tuổi Chuẩn Nhật Bản",
    category: "Đào Tạo Kaigo",
    price: "5.500.000 đ",
    duration: "2 tháng",
    rating: 5.0,
    reviewsCount: 62,
    instructor: "Chuyên gia Lê Hoàng",
    badge: "Hot",
    description: "Kỹ năng chăm sóc người già chuẩn điều dưỡng quốc tế, cơ hội làm việc tại Nhật Bản.",
  },
  {
    id: "c3",
    type: "course",
    title: "Kỹ Thuật Xoa Bóp & Bấm Huyệt Trị Liệu",
    category: "Y Học Cổ Truyền",
    price: "3.200.000 đ",
    duration: "6 tuần",
    rating: 4.8,
    reviewsCount: 140,
    instructor: "BS.CKI Nguyễn Vũ",
    description: "Nắm vững 12 đường kinh lạc, thủ thuật xoa bóp giải phóng chèn ép cơ xương khớp.",
  },
];

const doctors = [
  {
    name: "BS. CKI Trần Hoàng Mai",
    role: "Trưởng khoa Phục Hồi Chức Năng",
    exp: "15 năm kinh nghiệm",
    hospital: "BV ĐH Y Dược",
    avatar: "https://images.unsplash.com/photo-1594824813639-509930438d15?w=150&auto=format&fit=crop&q=80",
  },
  {
    name: "ThS. BS Nguyễn Văn An",
    role: "Chuyên gia Y Tế Gia Đình",
    exp: "12 năm kinh nghiệm",
    hospital: "BV Bạch Mai",
    avatar: "https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=150&auto=format&fit=crop&q=80",
  },
];

const branchList = [
  "Chi nhánh Hà Nội - Cầu Giấy",
  "Chi nhánh Hà Nội - Hoàn Kiếm",
  "Chi nhánh TP.HCM - Quận 1",
  "Chi nhánh TP.HCM - Bình Thạnh",
  "Chi nhánh Đà Nẵng - Hải Châu",
  "Chi nhánh Cần Thơ - Ninh Kiều",
];

function HomePage() {
  const { openSnackbar } = useSnackbar();

  // Navigation tab: 'home' | 'services' | 'courses' | 'bookings'
  const [activeTab, setActiveTab] = useState<"home" | "services" | "courses" | "bookings">("home");
  
  // Filter category on home
  const [filterType, setFilterType] = useState<"all" | "service" | "course">("all");

  // Booking Modal State
  const [isBookingOpen, setIsBookingOpen] = useState(false);
  const [selectedItem, setSelectedItem] = useState<ServiceItem | null>(null);
  const [customerName, setCustomerName] = useState("Nguyễn Văn A");
  const [customerPhone, setCustomerPhone] = useState("0912 345 678");
  const [bookingDate, setBookingDate] = useState("2026-10-15");
  const [selectedBranch, setSelectedBranch] = useState(branchList[0]);
  const [bookingNotes, setBookingNotes] = useState("");

  // Stored Bookings
  const [myBookings, setMyBookings] = useState([
    {
      id: "BK-8842",
      title: "Khám Tổng Quát & Tư Vấn Bác Sĩ",
      date: "14:30 - 15/10/2026",
      branch: "Chi nhánh Hà Nội - Cầu Giấy",
      status: "Đã xác nhận",
      price: "450.000 đ",
    },
  ]);

  const handleOpenBooking = (item: ServiceItem) => {
    setSelectedItem(item);
    setIsBookingOpen(true);
  };

  const handleConfirmBooking = () => {
    if (!customerName.trim() || !customerPhone.trim()) {
      openSnackbar({
        text: "Vui lòng nhập đầy đủ tên và số điện thoại!",
        type: "error",
      });
      return;
    }

    const newBooking = {
      id: `BK-${Math.floor(1000 + Math.random() * 9000)}`,
      title: selectedItem ? selectedItem.title : "Khám sức khỏe",
      date: `09:00 - ${bookingDate}`,
      branch: selectedBranch,
      status: "Đã xác nhận",
      price: selectedItem ? selectedItem.price : "450.000 đ",
    };

    setMyBookings([newBooking, ...myBookings]);
    setIsBookingOpen(false);

    openSnackbar({
      text: "Đặt lịch thành công! Nhân viên MLD sẽ gọi xác nhận qua Zalo.",
      type: "success",
      duration: 3500,
    });
  };

  const filteredItems = [
    ...(filterType === "all" || filterType === "service" ? mockServices : []),
    ...(filterType === "all" || filterType === "course" ? mockCourses : []),
  ];

  return (
    <Page className="bg-slate-50 text-slate-800 min-h-screen pb-20 select-none">
      {/* 1. TOP HEADER */}
      <Box className="gradient-header text-white px-4 pt-6 pb-6 rounded-b-3xl shadow-md">
        <Box className="flex items-center justify-between mb-4">
          <Box className="flex items-center space-x-3">
            <Box className="w-10 h-10 rounded-2xl bg-white/20 backdrop-blur-md flex items-center justify-center font-bold text-white text-lg border border-white/30">
              MLD
            </Box>
            <Box>
              <Box className="flex items-center space-x-1">
                <Text className="font-bold text-base text-white tracking-wide">
                  MLD VIỆT NAM
                </Text>
                <Icon icon="zi-check-circle-solid" className="text-emerald-300 text-sm" />
              </Box>
              <Text className="text-xs text-sky-100 font-light">
                Y Tế Chuyên Sâu & Đào Tạo Nghề
              </Text>
            </Box>
          </Box>
          <Box className="flex items-center space-x-2">
            <button
              onClick={() => {
                openSnackbar({
                  text: "Tổng đài hỗ trợ 24/7: 1900 8866 (Miễn phí qua Zalo)",
                  type: "info",
                });
              }}
              className="px-3 py-1.5 rounded-full bg-white/15 backdrop-blur-md border border-white/25 text-xs text-white font-medium flex items-center space-x-1 active:scale-95 transition"
            >
              <Icon icon="zi-call" className="text-xs" />
              <span>1900 8866</span>
            </button>
          </Box>
        </Box>

        {/* User Card Welcome */}
        <Box className="bg-white/15 backdrop-blur-md rounded-2xl p-3 border border-white/20 flex items-center justify-between">
          <Box className="flex items-center space-x-2.5">
            <Box className="w-9 h-9 rounded-full bg-sky-200 text-sky-900 font-bold flex items-center justify-center text-sm shadow">
              KH
            </Box>
            <Box>
              <Text className="text-xs text-sky-100">Khách hàng thành viên</Text>
              <Text className="text-sm font-semibold text-white">
                Xin chào, {customerName} 👋
              </Text>
            </Box>
          </Box>
          <Box className="px-2.5 py-1 rounded-lg bg-emerald-500/80 text-white text-[11px] font-semibold flex items-center space-x-1">
            <span>Zalo Mini App</span>
          </Box>
        </Box>
      </Box>

      {/* 2. BODY CONTENT BASED ON ACTIVE TAB */}
      <Box className="px-4 -mt-3">
        {activeTab === "home" && (
          <Box className="space-y-4">
            {/* Quick Action Grid */}
            <Box className="bg-white rounded-2xl p-4 card-shadow grid grid-cols-4 gap-2 text-center border border-slate-100">
              <Box
                onClick={() => {
                  setActiveTab("services");
                }}
                className="flex flex-col items-center p-2 rounded-xl active:bg-sky-50 transition cursor-pointer"
              >
                <Box className="w-11 h-11 rounded-2xl bg-sky-100 text-sky-700 flex items-center justify-center text-xl mb-1 shadow-sm">
                  🩺
                </Box>
                <Text className="text-[11px] font-medium text-slate-700">Khám Bệnh</Text>
              </Box>

              <Box
                onClick={() => {
                  setActiveTab("courses");
                }}
                className="flex flex-col items-center p-2 rounded-xl active:bg-emerald-50 transition cursor-pointer"
              >
                <Box className="w-11 h-11 rounded-2xl bg-emerald-100 text-emerald-700 flex items-center justify-center text-xl mb-1 shadow-sm">
                  🎓
                </Box>
                <Text className="text-[11px] font-medium text-slate-700">Khóa Học</Text>
              </Box>

              <Box
                onClick={() => {
                  setActiveTab("bookings");
                }}
                className="flex flex-col items-center p-2 rounded-xl active:bg-amber-50 transition cursor-pointer"
              >
                <Box className="w-11 h-11 rounded-2xl bg-amber-100 text-amber-700 flex items-center justify-center text-xl mb-1 shadow-sm">
                  📅
                </Box>
                <Text className="text-[11px] font-medium text-slate-700">Lịch Hẹn</Text>
              </Box>

              <Box
                onClick={() => {
                  openSnackbar({
                    text: "Đang kết nối đến Bác sĩ tư vấn qua Zalo OA...",
                    type: "info",
                  });
                }}
                className="flex flex-col items-center p-2 rounded-xl active:bg-indigo-50 transition cursor-pointer"
              >
                <Box className="w-11 h-11 rounded-2xl bg-indigo-100 text-indigo-700 flex items-center justify-center text-xl mb-1 shadow-sm">
                  💬
                </Box>
                <Text className="text-[11px] font-medium text-slate-700">Tư Vấn</Text>
              </Box>
            </Box>

            {/* Featured Banner */}
            <Box className="gradient-banner rounded-2xl p-4 text-white shadow-sm relative overflow-hidden">
              <Box className="relative z-10 space-y-1">
                <Box className="inline-block px-2 py-0.5 rounded-full bg-white/20 text-[10px] font-semibold text-white uppercase tracking-wider mb-1">
                  Ưu đãi độc quyền Zalo
                </Box>
                <Text className="text-base font-bold leading-snug">
                  Gói Chăm Sóc Sức Khỏe Gia Đình 2026
                </Text>
                <Text className="text-xs text-sky-100 font-light">
                  Giảm 30% khi đặt lịch trực tiếp trên Zalo Mini App
                </Text>
                <Box className="pt-2">
                  <button
                    onClick={() => handleOpenBooking(mockServices[0])}
                    className="px-4 py-1.5 rounded-xl bg-white text-sky-700 text-xs font-bold shadow active:scale-95 transition"
                  >
                    Đặt Lịch Ngay
                  </button>
                </Box>
              </Box>
            </Box>

            {/* Filter Pills */}
            <Box className="flex items-center space-x-2 pt-1 overflow-x-auto no-scrollbar">
              <button
                onClick={() => setFilterType("all")}
                className={`px-3.5 py-1.5 rounded-full text-xs font-medium transition ${
                  filterType === "all"
                    ? "bg-sky-600 text-white shadow-sm"
                    : "bg-white text-slate-600 border border-slate-200"
                }`}
              >
                Tất Cả ({mockServices.length + mockCourses.length})
              </button>
              <button
                onClick={() => setFilterType("service")}
                className={`px-3.5 py-1.5 rounded-full text-xs font-medium transition ${
                  filterType === "service"
                    ? "bg-sky-600 text-white shadow-sm"
                    : "bg-white text-slate-600 border border-slate-200"
                }`}
              >
                Dịch Vụ Y Tế ({mockServices.length})
              </button>
              <button
                onClick={() => setFilterType("course")}
                className={`px-3.5 py-1.5 rounded-full text-xs font-medium transition ${
                  filterType === "course"
                    ? "bg-sky-600 text-white shadow-sm"
                    : "bg-white text-slate-600 border border-slate-200"
                }`}
              >
                Khóa Đào Tạo ({mockCourses.length})
              </button>
            </Box>

            {/* Cards List */}
            <Box className="space-y-3">
              {filteredItems.map((item) => (
                <Box
                  key={item.id}
                  className="bg-white rounded-2xl p-4 card-shadow border border-slate-100 flex flex-col justify-between space-y-3"
                >
                  <Box className="flex items-start justify-between">
                    <Box className="space-y-1 pr-2">
                      <Box className="flex items-center space-x-2">
                        <span className="text-[10px] font-bold px-2 py-0.5 rounded bg-sky-50 text-sky-700 uppercase">
                          {item.category}
                        </span>
                        {item.badge && (
                          <span className="text-[10px] font-bold px-2 py-0.5 rounded bg-amber-50 text-amber-700">
                            ★ {item.badge}
                          </span>
                        )}
                      </Box>
                      <Text className="text-sm font-bold text-slate-800 leading-tight">
                        {item.title}
                      </Text>
                      <Text className="text-xs text-slate-500 line-clamp-2">
                        {item.description}
                      </Text>
                    </Box>
                  </Box>

                  <Box className="pt-2 border-t border-slate-100 flex items-center justify-between">
                    <Box>
                      <Text className="text-xs text-slate-400">Chi phí dự kiến</Text>
                      <Text className="text-sm font-bold text-sky-700">{item.price}</Text>
                    </Box>
                    <button
                      onClick={() => handleOpenBooking(item)}
                      className="px-3.5 py-1.5 rounded-xl bg-sky-600 text-white text-xs font-semibold shadow-sm active:scale-95 transition flex items-center space-x-1"
                    >
                      <span>{item.type === "service" ? "Đặt Hẹn" : "Đăng Ký"}</span>
                      <Icon icon="zi-chevron-right" className="text-xs" />
                    </button>
                  </Box>
                </Box>
              ))}
            </Box>

            {/* Featured Doctors Section */}
            <Box className="space-y-2 pt-2">
              <Box className="flex items-center justify-between">
                <Text className="font-bold text-sm text-slate-800">
                  Đội Ngũ Bác Sĩ & Chuyên Gia MLD
                </Text>
                <Text className="text-xs text-sky-600 font-medium">Xem tất cả</Text>
              </Box>
              <Box className="grid grid-cols-2 gap-2.5">
                {doctors.map((doc, idx) => (
                  <Box
                    key={idx}
                    className="bg-white rounded-2xl p-3 border border-slate-100 card-shadow flex flex-col items-center text-center space-y-1.5"
                  >
                    <img
                      src={doc.avatar}
                      alt={doc.name}
                      className="w-14 h-14 rounded-full object-cover shadow-sm border border-slate-100"
                    />
                    <Text className="font-bold text-xs text-slate-800 line-clamp-1">
                      {doc.name}
                    </Text>
                    <Text className="text-[10px] text-sky-600 font-medium line-clamp-1">
                      {doc.role}
                    </Text>
                    <Text className="text-[10px] text-slate-400">{doc.exp}</Text>
                    <button
                      onClick={() =>
                        handleOpenBooking({
                          id: `doc-${idx}`,
                          type: "service",
                          title: `Tư vấn cùng ${doc.name}`,
                          category: "Bác Sĩ Chuyên Khoa",
                          price: "350.000 đ",
                          duration: "30 phút",
                          rating: 5.0,
                          reviewsCount: 40,
                          description: doc.role,
                        })
                      }
                      className="w-full mt-1 py-1 rounded-lg bg-sky-50 text-sky-700 text-[11px] font-semibold active:bg-sky-100 transition"
                    >
                      Đặt Hẹn Khám
                    </button>
                  </Box>
                ))}
              </Box>
            </Box>
          </Box>
        )}

        {/* SERVICES TAB */}
        {activeTab === "services" && (
          <Box className="space-y-3 pt-2">
            <Box className="bg-white rounded-2xl p-3 border border-slate-100 shadow-sm flex items-center space-x-2">
              <Icon icon="zi-search" className="text-slate-400" />
              <input
                type="text"
                placeholder="Tìm dịch vụ y tế, khám tại nhà..."
                className="w-full text-xs outline-none bg-transparent"
              />
            </Box>
            {mockServices.map((item) => (
              <Box
                key={item.id}
                className="bg-white rounded-2xl p-4 card-shadow border border-slate-100 space-y-2.5"
              >
                <Box className="flex justify-between items-start">
                  <Box className="space-y-1">
                    <span className="text-[10px] font-bold px-2 py-0.5 rounded bg-sky-50 text-sky-700 uppercase">
                      {item.category}
                    </span>
                    <Text className="font-bold text-sm text-slate-800">{item.title}</Text>
                    <Text className="text-xs text-slate-500">{item.description}</Text>
                  </Box>
                </Box>
                <Box className="flex items-center justify-between pt-2 border-t border-slate-100">
                  <Text className="font-bold text-sm text-sky-700">{item.price}</Text>
                  <button
                    onClick={() => handleOpenBooking(item)}
                    className="px-4 py-1.5 rounded-xl bg-sky-600 text-white text-xs font-semibold active:scale-95 transition"
                  >
                    Đặt Lịch Khám
                  </button>
                </Box>
              </Box>
            ))}
          </Box>
        )}

        {/* COURSES TAB */}
        {activeTab === "courses" && (
          <Box className="space-y-3 pt-2">
            <Box className="bg-white rounded-2xl p-3 border border-slate-100 shadow-sm flex items-center space-x-2">
              <Icon icon="zi-search" className="text-slate-400" />
              <input
                type="text"
                placeholder="Tìm khóa học, chứng chỉ nghề..."
                className="w-full text-xs outline-none bg-transparent"
              />
            </Box>
            {mockCourses.map((item) => (
              <Box
                key={item.id}
                className="bg-white rounded-2xl p-4 card-shadow border border-slate-100 space-y-2.5"
              >
                <Box className="flex justify-between items-start">
                  <Box className="space-y-1">
                    <span className="text-[10px] font-bold px-2 py-0.5 rounded bg-emerald-50 text-emerald-700 uppercase">
                      {item.category}
                    </span>
                    <Text className="font-bold text-sm text-slate-800">{item.title}</Text>
                    <Text className="text-xs text-slate-500">{item.description}</Text>
                    <Text className="text-[11px] text-slate-400">
                      Thời lượng: {item.duration} | Giảng viên: {item.instructor}
                    </Text>
                  </Box>
                </Box>
                <Box className="flex items-center justify-between pt-2 border-t border-slate-100">
                  <Text className="font-bold text-sm text-emerald-700">{item.price}</Text>
                  <button
                    onClick={() => handleOpenBooking(item)}
                    className="px-4 py-1.5 rounded-xl bg-emerald-600 text-white text-xs font-semibold active:scale-95 transition"
                  >
                    Đăng Ký Học
                  </button>
                </Box>
              </Box>
            ))}
          </Box>
        )}

        {/* BOOKINGS TAB */}
        {activeTab === "bookings" && (
          <Box className="space-y-3 pt-2">
            <Text className="font-bold text-sm text-slate-800">
              Lịch Hẹn Của Bạn ({myBookings.length})
            </Text>
            {myBookings.map((b) => (
              <Box
                key={b.id}
                className="bg-white rounded-2xl p-4 card-shadow border border-slate-100 space-y-2"
              >
                <Box className="flex items-center justify-between">
                  <span className="text-[11px] font-bold text-sky-700 bg-sky-50 px-2 py-0.5 rounded">
                    Mã: {b.id}
                  </span>
                  <span className="text-[11px] font-semibold text-emerald-700 bg-emerald-50 px-2 py-0.5 rounded-full">
                    {b.status}
                  </span>
                </Box>
                <Text className="font-bold text-sm text-slate-800">{b.title}</Text>
                <Box className="text-xs text-slate-500 space-y-0.5">
                  <Box className="flex items-center space-x-1">
                    <Icon icon="zi-calendar" className="text-xs text-slate-400" />
                    <span>{b.date}</span>
                  </Box>
                  <Box className="flex items-center space-x-1">
                    <Icon icon="zi-location-solid" className="text-xs text-slate-400" />
                    <span>{b.branch}</span>
                  </Box>
                </Box>
                <Box className="pt-2 border-t border-slate-100 flex items-center justify-between">
                  <Text className="text-xs font-bold text-sky-700">{b.price}</Text>
                  <button
                    onClick={() => {
                      openSnackbar({
                        text: "Đang mở tin nhắn tư vấn Zalo hỗ trợ lịch hẹn...",
                        type: "info",
                      });
                    }}
                    className="px-3 py-1 rounded-lg bg-sky-50 text-sky-700 text-xs font-medium active:bg-sky-100 transition"
                  >
                    Hỗ Trợ Zalo
                  </button>
                </Box>
              </Box>
            ))}
          </Box>
        )}
      </Box>

      {/* 3. MODAL ĐẶT LỊCH / ĐĂNG KÝ (QUICK BOOKING SHEET) */}
      <Modal
        visible={isBookingOpen}
        onClose={() => setIsBookingOpen(false)}
        title={selectedItem?.type === "course" ? "Đăng Ký Khóa Học" : "Đặt Lịch Khám & Chăm Sóc"}
        mask
      >
        <Box className="space-y-3 pt-2 text-left">
          <Box className="p-2.5 rounded-xl bg-sky-50 border border-sky-100">
            <Text className="font-bold text-xs text-sky-900">{selectedItem?.title}</Text>
            <Text className="text-[11px] text-sky-700 font-semibold mt-0.5">
              Chi phí: {selectedItem?.price}
            </Text>
          </Box>

          <Box className="space-y-1">
            <Text className="text-xs font-semibold text-slate-700">Họ và tên của bạn</Text>
            <Input
              type="text"
              placeholder="Nhập họ và tên"
              value={customerName}
              onChange={(e) => setCustomerName(e.target.value)}
            />
          </Box>

          <Box className="space-y-1">
            <Text className="text-xs font-semibold text-slate-700">Số điện thoại liên hệ</Text>
            <Input
              type="text"
              placeholder="Nhập số điện thoại"
              value={customerPhone}
              onChange={(e) => setCustomerPhone(e.target.value)}
            />
          </Box>

          <Box className="space-y-1">
            <Text className="text-xs font-semibold text-slate-700">Chọn chi nhánh MLD</Text>
            <Select
              placeholder="Chọn chi nhánh"
              value={selectedBranch}
              onChange={(val) => setSelectedBranch(val as string)}
            >
              {branchList.map((branch, idx) => (
                <Select.Option key={idx} value={branch} title={branch} />
              ))}
            </Select>
          </Box>

          <Box className="space-y-1">
            <Text className="text-xs font-semibold text-slate-700">Ngày hẹn mong muốn</Text>
            <Input
              type="date"
              value={bookingDate}
              onChange={(e) => setBookingDate(e.target.value)}
            />
          </Box>

          <Box className="space-y-1">
            <Text className="text-xs font-semibold text-slate-700">Ghi chú thêm (nếu có)</Text>
            <Input
              type="text"
              placeholder="Nhu cầu hoặc triệu chứng..."
              value={bookingNotes}
              onChange={(e) => setBookingNotes(e.target.value)}
            />
          </Box>

          <Box className="pt-2 flex items-center space-x-2">
            <Button
              variant="secondary"
              fullWidth
              onClick={() => setIsBookingOpen(false)}
            >
              Hủy
            </Button>
            <Button
              variant="primary"
              fullWidth
              onClick={handleConfirmBooking}
            >
              Xác Nhận Đặt
            </Button>
          </Box>
        </Box>
      </Modal>

      {/* 4. BOTTOM NAVIGATION BAR */}
      <Box className="fixed bottom-0 left-0 right-0 bg-white border-t border-slate-200 py-2 px-6 flex items-center justify-between z-30 card-shadow">
        <button
          onClick={() => setActiveTab("home")}
          className={`flex flex-col items-center space-y-0.5 transition ${
            activeTab === "home" ? "text-sky-600 font-bold" : "text-slate-400"
          }`}
        >
          <Icon icon="zi-home" className="text-lg" />
          <span className="text-[10px]">Trang chủ</span>
        </button>

        <button
          onClick={() => setActiveTab("services")}
          className={`flex flex-col items-center space-y-0.5 transition ${
            activeTab === "services" ? "text-sky-600 font-bold" : "text-slate-400"
          }`}
        >
          <span className="text-base leading-none">🩺</span>
          <span className="text-[10px]">Dịch vụ</span>
        </button>

        <button
          onClick={() => setActiveTab("courses")}
          className={`flex flex-col items-center space-y-0.5 transition ${
            activeTab === "courses" ? "text-sky-600 font-bold" : "text-slate-400"
          }`}
        >
          <span className="text-base leading-none">🎓</span>
          <span className="text-[10px]">Đào tạo</span>
        </button>

        <button
          onClick={() => setActiveTab("bookings")}
          className={`flex flex-col items-center space-y-0.5 transition ${
            activeTab === "bookings" ? "text-sky-600 font-bold" : "text-slate-400"
          }`}
        >
          <Icon icon="zi-calendar" className="text-lg" />
          <span className="text-[10px]">Lịch hẹn</span>
        </button>
      </Box>
    </Page>
  );
}

export default HomePage;
