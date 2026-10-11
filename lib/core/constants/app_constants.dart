import 'package:prj/features/auth/domain/models/user_model.dart';
import 'package:prj/features/home_service/domain/models/doctor_model.dart';
import 'package:prj/features/home_service/domain/models/service_model.dart';
import 'package:prj/features/vocational_training/domain/models/course_model.dart';
import 'package:prj/features/treatment_care/domain/models/medical_record_model.dart';
import 'package:prj/features/profile_membership/domain/models/membership_model.dart';

class AppConstants {
  static const String appName = 'MediLearn Healthcare';
  static const String appVersion = '1.0.0';

  // Seed Users
  static final UserModel defaultPatientUser = UserModel(
    id: 'usr_patient_01',
    name: 'Nguyễn Thanh Tùng',
    email: 'thanhtung.nguyen@email.vn',
    phone: '0988 123 456',
    avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
    role: UserRole.patient,
    membershipTier: 'Gold',
    loyaltyPoints: 1850,
  );

  static final UserModel defaultStudentUser = UserModel(
    id: 'usr_student_02',
    name: 'Lê Hoàng Yến Nhi',
    email: 'yennhi.le@medilearn.edu.vn',
    phone: '0977 889 911',
    avatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150',
    role: UserRole.student,
    membershipTier: 'Silver',
    loyaltyPoints: 920,
    studentId: 'MLD-K24-884',
    specialization: 'Điều dưỡng Quốc tế & Kaigo',
  );

  // Doctors
  static const List<DoctorModel> sampleDoctors = [
    DoctorModel(
      id: 'doc_01',
      name: 'PGS. TS. BS. Nguyễn Văn Hùng',
      title: 'Trưởng khoa Tim Mạch & Nội Tổng Quát',
      specialty: 'Tim Mạch & Nội Khoa',
      hospital: 'Bệnh viện Đa khoa Quốc tế MLD Central',
      rating: 4.9,
      reviewsCount: 384,
      yearsOfExperience: 22,
      avatarUrl: 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=200',
      bio: 'Hơn 22 năm kinh nghiệm trong chẩn đoán và điều trị bệnh lý tim mạch, từng tu nghiệp tại Bệnh viện Đại học Tokyo Nhật Bản.',
      consultationFee: 500000,
      availableSlots: [
        '08:00 - 08:30',
        '08:30 - 09:00',
        '09:30 - 10:00',
        '10:30 - 11:00',
        '14:00 - 14:30',
        '15:30 - 16:00',
      ],
    ),
    DoctorModel(
      id: 'doc_02',
      name: 'ThS. BS. Trần Thị Mai',
      title: 'Chuyên gia Da Liễu Thẩm Mỹ & Giảng viên Viện',
      specialty: 'Da Liễu & Thẩm Mỹ',
      hospital: 'Trung tâm Thẩm mỹ Y khoa MLD Derma',
      rating: 4.95,
      reviewsCount: 512,
      yearsOfExperience: 14,
      avatarUrl: 'https://images.unsplash.com/photo-1594824813590-b18bb3901b0b?w=200',
      bio: 'Chuyên gia phục hồi tổn thương da, trị liệu laser công nghệ cao và chủ nhiệm bộ môn Đào tạo Kỹ thuật viên Da liễu Y khoa.',
      consultationFee: 450000,
      availableSlots: [
        '09:00 - 09:30',
        '10:00 - 10:30',
        '11:00 - 11:30',
        '13:30 - 14:00',
        '14:30 - 15:00',
        '16:00 - 16:30',
      ],
    ),
    DoctorModel(
      id: 'doc_03',
      name: 'BS. CKII. Lê Hoàng Nam',
      title: 'Trưởng khoa Nha Khoa Kỹ Thuật Cao',
      specialty: 'Nha Khoa & Phục Hình',
      hospital: 'Viện Răng Hàm Mặt Quốc tế MLD Dental',
      rating: 4.88,
      reviewsCount: 290,
      yearsOfExperience: 16,
      avatarUrl: 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=200',
      bio: 'Chuyên sâu cấy ghép Implant kỹ thuật số, niềng răng trong suốt và thẩm mỹ nụ cười.',
      consultationFee: 400000,
      availableSlots: [
        '08:00 - 08:30',
        '09:30 - 10:00',
        '10:00 - 10:30',
        '14:00 - 14:30',
        '15:00 - 15:30',
      ],
    ),
    DoctorModel(
      id: 'doc_04',
      name: 'TS. BS. Vũ Thu Trang',
      title: 'Chuyên gia Nhi Khoa & Dinh Dưỡng Trẻ Em',
      specialty: 'Nhi Khoa',
      hospital: 'Bệnh viện Quốc tế Phụ Sản & Nhi Đồng MLD',
      rating: 4.92,
      reviewsCount: 420,
      yearsOfExperience: 18,
      avatarUrl: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=200',
      bio: 'Tận tâm, thấu hiểu tâm lý trẻ nhỏ. Cố vấn cấp cao cho chương trình Y tế học đường và chăm sóc sơ sinh.',
      consultationFee: 450000,
      availableSlots: [
        '08:30 - 09:00',
        '09:00 - 09:30',
        '10:30 - 11:00',
        '14:30 - 15:00',
        '16:00 - 16:30',
      ],
    ),
  ];

  // Medical Services
  static const List<ServiceModel> sampleServices = [
    ServiceModel(
      id: 'srv_01',
      name: 'Massage thư giãn toàn thân',
      category: 'Massage',
      imageUrl: 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=500',
      price: 450000,
      originalPrice: 600000,
      durationMinutes: 60,
      rating: 4.95,
      reviewsCount: 820,
      isPopular: true,
      description: 'Dành một khoảng lặng cho chính mình với trải nghiệm massage nhẹ nhàng. Nhịp chăm sóc được điều chỉnh theo nhu cầu thư giãn, trong không gian ấm áp và yên tĩnh.',
      highlights: [
        'Massage tinh dầu thảo mộc tự nhiên nhập khẩu',
        'Ấn huyệt giải tỏa căng cơ vùng lưng và vai',
        'Xông tinh dầu hương bưởi tự nhiên thư giãn thần kinh',
        'Thưởng thức trà thảo mộc dưỡng nhan sau liệu trình',
      ],
      preparations: [
        'Đến trước lịch hẹn 10 phút để thay trang phục',
        'Thông báo với kỹ thuật viên nếu có chấn thương cơ hoặc đang mang thai',
        'Tắt chuông điện thoại để tận hưởng không gian yên tĩnh',
      ],
      doctorIds: ['doc_01', 'doc_03'],
    ),
    ServiceModel(
      id: 'srv_02',
      name: 'Chăm sóc da chuyên sâu',
      category: 'Chăm sóc da',
      imageUrl: 'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?w=500',
      price: 550000,
      originalPrice: 700000,
      durationMinutes: 75,
      rating: 4.90,
      reviewsCount: 650,
      isPopular: true,
      description: 'Làm sạch sâu bã nhờn, tẩy tế bào chết và đắp mặt nạ thảo dược thiên nhiên kết hợp điện di tinh chất phục hồi cho làn da tươi sáng rạng ngời.',
      highlights: [
        'Soi da và phân tích độ ẩm tầng biểu bì',
        'Hút bã nhờn chân không công nghệ Hydro-peel',
        'Đắp mặt nạ collagen tươi hữu cơ',
        'Massage bấm huyệt nâng cơ mặt thon gọn',
      ],
      preparations: [
        'Hạn chế trang điểm đậm trước khi đến chăm sóc da',
        'Thông báo cho chuyên viên nếu da đang dị ứng mỹ phẩm',
      ],
      doctorIds: ['doc_02'],
    ),
    ServiceModel(
      id: 'srv_03',
      name: 'Trị liệu cổ vai gáy ấn huyệt',
      category: 'Chăm sóc cơ thể',
      imageUrl: 'https://images.unsplash.com/photo-1519823551278-64ac92734fb1?w=500',
      price: 380000,
      originalPrice: 500000,
      durationMinutes: 45,
      rating: 4.88,
      reviewsCount: 510,
      isPopular: true,
      description: 'Kỹ thuật viên lành nghề thực hiện xoa bóp, ấn huyệt chuyên sâu giải tỏa căng cứng cơ vùng cổ vai gáy, kích thích tuần hoàn máu và xua tan mệt mỏi văn phòng.',
      highlights: [
        'Chườm ngải cứu thảo mộc nóng vùng vai gáy',
        'Ấn các huyệt đạo Phong trì, Kiên tỉnh, Thiên tông',
        'Kéo giãn cơ cổ nhẹ nhàng theo phương pháp vật lý trị liệu',
      ],
      preparations: [
        'Mặc trang phục rộng rãi, thoải mái',
      ],
      doctorIds: ['doc_01'],
    ),
    ServiceModel(
      id: 'srv_04',
      name: 'Ngâm chân thảo dược & Massage bấm huyệt',
      category: 'Thư giãn',
      imageUrl: 'https://images.unsplash.com/photo-1519824145371-296894a0dc91?w=500',
      price: 320000,
      originalPrice: 420000,
      durationMinutes: 45,
      rating: 4.85,
      reviewsCount: 420,
      isPopular: false,
      description: 'Ngâm chân trong nước thảo mộc ấm với quế, gừng và ngải cứu, kết hợp kỹ thuật day bấm các huyệt đạo lòng bàn chân giúp đả thông kinh lạc và ngủ ngon.',
      highlights: [
        'Ngâm chân bồn gỗ thảo dược thuốc bắc gia truyền',
        'Tẩy da chết gót chân bằng muối khoáng hồng',
        'Massage bấm huyệt Dũng tuyền điều hòa huyết áp',
      ],
      preparations: [
        'Rửa sạch chân trước khi ngâm',
      ],
      doctorIds: ['doc_03'],
    ),
    ServiceModel(
      id: 'srv_05',
      name: 'Gói phục hồi năng lượng toàn diện VIP',
      category: 'Gói liệu trình',
      imageUrl: 'https://images.unsplash.com/photo-1600334129128-685c5582fd35?w=500',
      price: 890000,
      originalPrice: 1200000,
      durationMinutes: 90,
      rating: 4.98,
      reviewsCount: 930,
      isPopular: true,
      description: 'Liệu trình kết hợp đặc biệt gồm xông hơi đá muối Himalaya, massage body bằng đá nóng bazan và đắp mặt nạ ngọc trai cao cấp tái tạo sinh lực toàn thân.',
      highlights: [
        'Xông hơi đá muối Himalaya thải độc tố',
        'Massage đá nóng bazan giữ nhiệt giảm đau cơ',
        'Chăm sóc da mặt chuyên sâu dưỡng ẩm trắng sáng',
        'Phục vụ trà yến dưỡng sinh cao cấp',
      ],
      preparations: [
        'Không ăn quá no trước khi làm liệu trình 1 tiếng',
      ],
      doctorIds: ['doc_01', 'doc_02'],
    ),
  ];

  // Vocational Training Academy Courses (Group E)
  static final List<CourseModel> sampleCourses = [
    CourseModel(
      id: 'crs_01',
      title: 'Kỹ Thuật Viên Điều Dưỡng Chuyên Nghiệp Quốc Tế',
      category: 'Điều dưỡng',
      instructorName: 'PGS. TS. BS. Nguyễn Văn Hùng',
      instructorTitle: 'Chủ nhiệm Chương trình Đào tạo Y khoa MLD',
      instructorAvatar: 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=200',
      thumbnailUrl: 'https://images.unsplash.com/photo-1584515979956-d9f6e5d09982?w=500',
      tuitionFee: 6500000,
      originalTuitionFee: 8500000,
      rating: 4.94,
      studentsCount: 1420,
      totalLessons: 24,
      totalHours: 48,
      certificateTitle: 'Chứng chỉ Điều dưỡng Thực hành Lâm sàng Cấp bởi Viện Y Dược MLD',
      description: 'Chương trình đào tạo nghề chuẩn quốc tế cung cấp kiến thức nền tảng và kỹ năng lâm sàng thực chiến: theo dõi dấu hiệu sinh tồn, sơ cứu cấp cứu, vô trùng ngoại khoa, kỹ thuật truyền dịch và kỹ năng giao tiếp y khoa.',
      isEnrolled: true,
      progress: 0.65,
      modules: [
        CourseModuleModel(
          id: 'mod_01',
          title: 'Phần 1: Nền tảng Vô trùng & An toàn Y tế',
          lessons: [
            LessonModel(
              id: 'les_01',
              title: 'Bài 1: Nguyên tắc kiểm soát nhiễm khuẩn và kỹ thuật rửa tay ngoại khoa',
              durationMinutes: 25,
              videoUrl: 'https://www.w3schools.com/html/mov_bbb.mp4',
              isCompleted: true,
              summary: 'Nắm vững quy trình rửa tay 6 bước chuẩn Bộ Y tế, các tiêu chuẩn vô trùng trong phòng thủ thuật và phân loại rác thải y tế.',
            ),
            LessonModel(
              id: 'les_02',
              title: 'Bài 2: Kỹ thuật đo và đánh giá 4 dấu hiệu sinh tồn (Mạch, Nhiệt, Huyết áp, Nhịp thở)',
              durationMinutes: 32,
              videoUrl: 'https://www.w3schools.com/html/mov_bbb.mp4',
              isCompleted: true,
              summary: 'Hướng dẫn chuẩn xác vị trí bắt mạch, thao tác quấn băng đo huyết áp cơ học và nhận biết các dấu hiệu suy hô hấp sớm.',
            ),
            LessonModel(
              id: 'les_03',
              title: 'Bài 3: Kỹ thuật tiêm an toàn (Tiêm bắp, tiêm dưới da, tiêm trong da)',
              durationMinutes: 40,
              videoUrl: 'https://www.w3schools.com/html/mov_bbb.mp4',
              isCompleted: true,
              summary: 'Xác định chính xác góc kim, vị trí an toàn tránh dây thần kinh hông to và quy tắc 5 đúng trong sử dụng thuốc.',
            ),
          ],
        ),
        CourseModuleModel(
          id: 'mod_02',
          title: 'Phần 2: Kỹ năng Chăm sóc & Cấp cứu Ban đầu',
          lessons: [
            LessonModel(
              id: 'les_04',
              title: 'Bài 4: Kỹ thuật đặt catheter tĩnh mạch ngoại vi và truyền dịch',
              durationMinutes: 35,
              videoUrl: 'https://www.w3schools.com/html/mov_bbb.mp4',
              isCompleted: false,
              isPreview: true,
              summary: 'Quy trình chọn ven, cố định kim luồn và theo dõi tốc độ dịch truyền phòng ngừa sốc phản vệ.',
            ),
            LessonModel(
              id: 'les_05',
              title: 'Bài 5: Sơ cứu ngưng tim ngưng thở (CPR) và sử dụng máy khử rung tim tự động AED',
              durationMinutes: 45,
              videoUrl: 'https://www.w3schools.com/html/mov_bbb.mp4',
              isCompleted: false,
              summary: 'Quy trình CAB chuẩn Hội Tim mạch Hoa Kỳ AHA, tần số ép tim và kiểm soát đường thở.',
            ),
          ],
        ),
      ],
    ),
    CourseModel(
      id: 'crs_02',
      title: 'Chứng Chỉ Chăm Sóc Người Cao Tuổi Chuẩn Kaigo Nhật Bản',
      category: 'Chăm sóc cao tuổi',
      instructorName: 'ThS. BS. Đặng Thùy Dung',
      instructorTitle: 'Chuyên gia Lão khoa & Trưởng ban Huấn luyện Kaigo',
      instructorAvatar: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=200',
      thumbnailUrl: 'https://images.unsplash.com/photo-1576765608535-5f04d1e3f289?w=500',
      tuitionFee: 5800000,
      originalTuitionFee: 7200000,
      rating: 4.96,
      studentsCount: 980,
      totalLessons: 18,
      totalHours: 36,
      certificateTitle: 'Chứng chỉ Nghề Kaigo Tiêu chuẩn Hiệp hội Y tế Nhật Bản',
      description: 'Chương trình huấn luyện điều dưỡng viên chuyên sâu chăm sóc người cao tuổi, người sau tai biến, phục hồi chức năng và tâm lý học lão khoa với cơ hội làm việc tại Nhật Bản và các viện dưỡng lão quốc tế.',
      isEnrolled: false,
      progress: 0.0,
      modules: [
        CourseModuleModel(
          id: 'mod_k1',
          title: 'Phần 1: Tâm lý học & Giao tiếp hỗ trợ người cao tuổi',
          lessons: [
            LessonModel(
              id: 'les_k1',
              title: 'Bài 1: Nguyên tắc tôn trọng nhân phẩm và tự chủ của người cao tuổi',
              durationMinutes: 30,
              videoUrl: 'https://www.w3schools.com/html/mov_bbb.mp4',
              isPreview: true,
              summary: 'Văn hóa Omotenashi và triết lý Kaigo Nhật Bản trong hỗ trợ người suy giảm vận động.',
            ),
          ],
        ),
      ],
    ),
    CourseModel(
      id: 'crs_03',
      title: 'Kỹ Thuật Viên Thẩm Mỹ Da Liễu Y Khoa Chuyên Nghiệp',
      category: 'Thẩm mỹ y khoa',
      instructorName: 'ThS. BS. Trần Thị Mai',
      instructorTitle: 'Chuyên gia Da Liễu Thẩm Mỹ',
      instructorAvatar: 'https://images.unsplash.com/photo-1594824813590-b18bb3901b0b?w=200',
      thumbnailUrl: 'https://images.unsplash.com/photo-1512290900672-1f49615a9757?w=500',
      tuitionFee: 8900000,
      originalTuitionFee: 11500000,
      rating: 4.92,
      studentsCount: 2150,
      totalLessons: 30,
      totalHours: 60,
      certificateTitle: 'Chứng nhận Kỹ thuật viên Da liễu & Laser Thẩm mỹ Y khoa',
      description: 'Đào tạo kỹ thuật viên Spa y khoa chuyên sâu: soi da vi thể, quy trình nặn mụn chuẩn y khoa không thâm sẹo, kỹ thuật peel da hóa học an toàn, và vận hành thiết bị laser y tế.',
      isEnrolled: false,
      progress: 0.0,
      modules: [
        CourseModuleModel(
          id: 'mod_d1',
          title: 'Phần 1: Giải phẫu học da và sinh lý mụn - nám',
          lessons: [
            LessonModel(
              id: 'les_d1',
              title: 'Bài 1: Cấu trúc mô học biểu bì, trung bì và hàng rào bảo vệ Ceramide',
              durationMinutes: 28,
              videoUrl: 'https://www.w3schools.com/html/mov_bbb.mp4',
              isPreview: true,
              summary: 'Hiểu rõ chu kỳ tái tạo tế bào sừng để điều chỉnh liệu trình can thiệp.',
            ),
          ],
        ),
      ],
    ),
  ];

  // Quiz Questions for Academy Assessment
  static const List<QuizQuestionModel> sampleQuizQuestions = [
    QuizQuestionModel(
      id: 'q_01',
      question: 'Khi thực hiện kỹ thuật đo huyết áp cho người bệnh, mép dưới của băng quấn huyết áp nên cách nếp gấp khuỷu tay bao nhiêu cm?',
      options: [
        '1 - 2 cm',
        '2.5 - 3 cm',
        '4 - 5 cm',
        'Ngay sát nếp gấp khuỷu tay',
      ],
      correctOptionIndex: 1,
      explanation: 'Theo chuẩn quy trình điều dưỡng lâm sàng, mép dưới băng quấn phải cách nếp gấp khuỷu tay từ 2.5 đến 3 cm để đặt ống nghe chính xác vào động mạch cánh tay.',
    ),
    QuizQuestionModel(
      id: 'q_02',
      question: 'Nguyên tắc "5 Đúng" trong an toàn dùng thuốc của Điều dưỡng bao gồm những yếu tố nào sau đây?',
      options: [
        'Đúng người bệnh, đúng thuốc, đúng liều lượng, đúng đường dùng, đúng thời gian',
        'Đúng bác sĩ, đúng bệnh viện, đúng giá tiền, đúng thuốc, đúng liều',
        'Đúng thời điểm, đúng nhiệt độ, đúng hạn dùng, đúng giường bệnh, đúng sổ y bạ',
        'Đúng y tá, đúng bệnh nhân, đúng hóa đơn, đúng thuốc, đúng giờ',
      ],
      correctOptionIndex: 0,
      explanation: 'Quy tắc 5 Đúng kinh điển: Đúng Người bệnh, Đúng Thuốc, Đúng Liều, Đúng Đường dùng và Đúng Thời gian.',
    ),
    QuizQuestionModel(
      id: 'q_03',
      question: 'Góc nghiêng chuẩn khi thực hiện kỹ thuật tiêm bắp sâu (Intramuscular) là bao nhiêu độ?',
      options: [
        '15 độ',
        '45 độ',
        '60 độ',
        '90 độ',
      ],
      correctOptionIndex: 3,
      explanation: 'Kỹ thuật tiêm bắp yêu cầu đâm kim vuông góc 90 độ so với mặt da để thuốc tiếp cận đúng khối cơ.',
    ),
  ];

  // Medical Records (Group D)
  static final List<MedicalRecordModel> sampleMedicalRecords = [
    MedicalRecordModel(
      id: 'emr_01',
      recordCode: 'EMR-2026-8819',
      examinationDate: DateTime.now().subtract(const Duration(days: 4)),
      doctorName: 'PGS. TS. BS. Nguyễn Văn Hùng',
      doctorTitle: 'Trưởng khoa Tim Mạch & Nội Khoa',
      specialty: 'Nội Tim Mạch',
      diagnosis: 'Tăng huyết áp độ 1 - Rối loạn lipid máu nhẹ',
      clinicHospital: 'Bệnh viện Đa khoa Quốc tế MLD Central',
      symptomsReported: [
        'Đau đầu vùng gáy về chiều',
        'Hồi hộp khi leo cầu thang',
        'Chóng mặt nhẹ khi thay đổi tư thế',
      ],
      labTestResults: [
        'Huyết áp đo tại phòng khám: 142/88 mmHg',
        'Cholesterol toàn phần: 5.6 mmol/L (Hơi cao)',
        'Điện tim ECG: Nhịp xoang đều 78ck/p, không biến đổi thiếu máu cục bộ',
      ],
      treatmentRegimen: 'Dùng thuốc kiểm soát huyết áp kết hợp giảm muối, duy trì đi bộ nhẹ 30 phút/ngày.',
      followUpDate: DateTime.now().add(const Duration(days: 26)),
      status: 'Đang điều trị',
      prescriptions: const [
        PrescriptionItemModel(
          medicineName: 'Amlodipine 5mg',
          dosage: '1 viên / ngày',
          frequency: 'Uống buổi sáng sau ăn',
          days: 30,
          notes: 'Uống cố định một khung giờ trong ngày',
        ),
        PrescriptionItemModel(
          medicineName: 'Atorvastatin 10mg',
          dosage: '1 viên / ngày',
          frequency: 'Uống buổi tối trước khi đi ngủ',
          days: 30,
          notes: 'Hạn chế thức ăn chiên xào nhiều dầu mỡ',
        ),
      ],
    ),
  ];

  // Vouchers (Group F)
  static final List<VoucherModel> sampleVouchers = [
    VoucherModel(
      id: 'vch_01',
      code: 'MEDIVIP200',
      title: 'Giảm 200.000₫ Gói Khám Chuyên Sâu',
      description: 'Áp dụng cho mọi dịch vụ khám chuyên khoa và tầm soát sức khỏe.',
      discountAmount: 200000,
      minSpend: 1000000,
      expiryDate: DateTime.now().add(const Duration(days: 30)),
      category: 'Medical',
    ),
    VoucherModel(
      id: 'vch_02',
      code: 'ACADEMY500',
      title: 'Học bổng 500.000₫ Khóa Đào Tạo Nghề',
      description: 'Giảm ngay vào học phí các khóa Điều dưỡng và Thẩm mỹ Y khoa.',
      discountAmount: 500000,
      minSpend: 4000000,
      expiryDate: DateTime.now().add(const Duration(days: 45)),
      category: 'Academy',
    ),
  ];
}
