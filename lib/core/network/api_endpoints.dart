/// API Endpoints centralized configuration
class ApiEndpoints {
  static const String baseUrl = 'https://api.medilearn.vn/v1';
  
  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh';
  static const String verifyOtp = '/auth/verify-otp';
  static const String forgotPassword = '/auth/forgot-password';
  static const String logout = '/auth/logout';
  
  // User / Profile
  static const String profile = '/users/me';
  static const String updateProfile = '/users/me';
  static const String uploadAvatar = '/users/me/avatar';
  
  // Services
  static const String services = '/services';
  static String serviceDetail(String id) => '/services/$id';
  
  // Doctors
  static const String doctors = '/doctors';
  static String doctorDetail(String id) => '/doctors/$id';
  static String doctorSlots(String id) => '/doctors/$id/slots';
  
  // Bookings
  static const String bookings = '/bookings';
  static String bookingDetail(String id) => '/bookings/$id';
  static String cancelBooking(String id) => '/bookings/$id/cancel';
  
  // Payment
  static const String payments = '/payments';
  static String paymentDetail(String id) => '/payments/$id';
  
  // Medical Records
  static const String medicalRecords = '/medical-records';
  static String medicalRecordDetail(String id) => '/medical-records/$id';
  
  // Courses (Vocational Training)
  static const String courses = '/courses';
  static String courseDetail(String id) => '/courses/$id';
  static String courseEnroll(String id) => '/courses/$id/enroll';
  static String courseLessons(String id) => '/courses/$id/lessons';
  static String courseQuiz(String id) => '/courses/$id/quiz';
  
  // Membership
  static const String membership = '/membership';
  static const String membershipPlans = '/membership/plans';
  static String membershipSubscribe(String planId) => '/membership/subscribe/$planId';
  
  // Notifications
  static const String notifications = '/notifications';
  static String markNotificationRead(String id) => '/notifications/$id/read';
  
  // Chat / Telehealth
  static const String chatRooms = '/chat/rooms';
  static String chatMessages(String roomId) => '/chat/rooms/$roomId/messages';
  
  // Upload
  static const String upload = '/upload';
}
