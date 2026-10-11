import 'package:flutter/material.dart';
import 'package:prj/core/constants/app_constants.dart';
import 'package:prj/features/treatment_care/domain/models/medical_record_model.dart';
import 'package:prj/features/treatment_care/domain/models/treatment_models.dart';

class TreatmentController extends ChangeNotifier {
  List<MedicalRecordModel> _records = [];
  List<ChatMessageModel> _chatMessages = [];
  bool _isDoctorTyping = false;

  // Group D: Treatment Packages
  List<TreatmentPackageModel> _packages = [];
  List<CareJournalEntry> _journalEntries = [];
  HomeCareArticle? _featuredArticle;
  
  // Intake data
  final List<String> _selectedIntakeGoals = ['Thư giãn cơ thể.', 'Giảm cảm giác căng thẳng.'];
  
  // Ratings data
  int _overallRating = 5;
  int _serviceQualityRating = 5;
  int _specialistAttitudeRating = 5;
  bool _isRatingSubmitted = false;

  // Consultation Chat (D07)
  List<Map<String, String>> _consultationChat = [];

  List<MedicalRecordModel> get records => _records;
  List<ChatMessageModel> get chatMessages => _chatMessages;
  bool get isDoctorTyping => _isDoctorTyping;

  List<TreatmentPackageModel> get packages => _packages;
  List<CareJournalEntry> get journalEntries => _journalEntries;
  HomeCareArticle? get featuredArticle => _featuredArticle;
  List<String> get selectedIntakeGoals => _selectedIntakeGoals;
  int get overallRating => _overallRating;
  int get serviceQualityRating => _serviceQualityRating;
  int get specialistAttitudeRating => _specialistAttitudeRating;
  bool get isRatingSubmitted => _isRatingSubmitted;
  List<Map<String, String>> get consultationChat => _consultationChat;

  TreatmentController() {
    _initData();
  }

  void _initData() {
    _records = List.from(AppConstants.sampleMedicalRecords);
    
    // Group D Packages Seed
    _packages = [
      const TreatmentPackageModel(
        id: 'pkg_01',
        title: 'Gói Massage Thư Giãn 10 Buổi',
        branch: 'Chi nhánh mẫu 01 — Quận 3',
        totalSessions: 10,
        usedSessions: 4,
        remainingSessions: 6,
        status: 'Đang sử dụng',
        startDate: '01/09/2026',
        expiryDate: '31/12/2026',
        imageUrl: 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=800',
      ),
      const TreatmentPackageModel(
        id: 'pkg_02',
        title: 'Gói Chăm Sóc Da Chuyên Sâu 5 Buổi',
        branch: 'Chi nhánh mẫu 02 — Bình Thạnh',
        totalSessions: 5,
        usedSessions: 5,
        remainingSessions: 0,
        status: 'Đã hoàn thành',
        startDate: '01/06/2026',
        expiryDate: '01/09/2026',
        imageUrl: 'https://images.unsplash.com/photo-1512290900672-1f41443d3b7d?w=800',
      ),
    ];

    // Group D Journal Seed
    _journalEntries = [
      const CareJournalEntry(
        id: 'jrn_04',
        sessionTitle: 'Buổi 04 — Massage thư giãn toàn thân',
        date: 'Ngày 08/10/2026',
        specialist: 'Trần Minh Phương',
        branch: 'Chi nhánh mẫu 01 — Quận 3',
        note: 'Khách hàng hoàn thành buổi chăm sóc theo lịch trình.',
        tip: 'Dành thời gian nghỉ ngơi thoải mái sau buổi massage.',
        isCompleted: true,
      ),
      const CareJournalEntry(
        id: 'jrn_03',
        sessionTitle: 'Buổi 03 — Liệu trình tinh dầu phục hồi',
        date: 'Ngày 24/09/2026',
        specialist: 'Trần Minh Phương',
        branch: 'Chi nhánh mẫu 01 — Quận 3',
        note: 'Giảm căng cơ vùng vai gáy hiệu quả.',
        tip: 'Uống đủ 2 lít nước ấm sau buổi trị liệu.',
        isCompleted: true,
      ),
      const CareJournalEntry(
        id: 'jrn_02',
        sessionTitle: 'Buổi 02 — Thư giãn toàn thân chuyên sâu',
        date: 'Ngày 10/09/2026',
        specialist: 'Lê Hoàng Yến',
        branch: 'Chi nhánh mẫu 01 — Quận 3',
        note: 'Cải thiện tuần hoàn máu và giấc ngủ tốt hơn.',
        tip: 'Tránh vận động quá sức trong vòng 12 giờ.',
        isCompleted: true,
      ),
      const CareJournalEntry(
        id: 'jrn_01',
        sessionTitle: 'Buổi 01 — Khởi động liệu trình & thư giãn',
        date: 'Ngày 01/09/2026',
        specialist: 'Trần Minh Phương',
        branch: 'Chi nhánh mẫu 01 — Quận 3',
        note: 'Ghi nhận cơ thể thích ứng tốt với liệu trình ban đầu.',
        tip: 'Giữ ấm cơ thể và ngủ đủ giấc.',
        isCompleted: true,
      ),
    ];

    // Featured Article (D06)
    _featuredArticle = const HomeCareArticle(
      id: 'art_01',
      category: 'CHĂM SÓC CƠ THỂ',
      readTime: '4 phút',
      title: 'Chăm sóc cơ thể sau buổi massage',
      subtitle: 'Nghỉ ngơi thoải mái, vận động nhẹ và giữ nhịp sinh hoạt phù hợp.',
      imageUrl: 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=800',
      keyPoints: [
        'Uống một ly nước ấm ngay sau buổi liệu trình để thanh lọc cơ thể.',
        'Nghỉ ngơi thư giãn ít nhất 30 phút, tránh tắm nước lạnh ngay sau khi massage.',
        'Thực hiện các động tác giãn cơ nhẹ nhàng trước khi ngủ.',
        'Duy trì chế độ ăn thanh đạm, hạn chế caffein và chất kích thích.',
      ],
    );

    // Consultation Chat (D07)
    _consultationChat = [
      {
        'sender': 'user',
        'text': 'Tôi muốn đặt lịch buổi tiếp theo của gói massage.',
        'time': '09:42',
      },
      {
        'sender': 'support',
        'text': 'Xin chào! Anh/chị có thể chọn lịch hẹn phù hợp trong phần quản lý liệu trình.',
        'time': '09:43',
      },
    ];

    _chatMessages = [
      ChatMessageModel(
        id: 'msg_01',
        text: 'Xin chào anh Tùng! Tôi là PGS. TS. Nguyễn Văn Hùng. Tôi đã xem qua kết quả xét nghiệm huyết áp và mỡ máu của anh.',
        sender: ChatSender.doctor,
        timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      ),
    ];
    notifyListeners();
  }

  // Toggle intake goal
  void toggleIntakeGoal(String goal) {
    if (_selectedIntakeGoals.contains(goal)) {
      _selectedIntakeGoals.remove(goal);
    } else {
      _selectedIntakeGoals.add(goal);
    }
    notifyListeners();
  }

  // Set ratings
  void setRatings({required int overall, required int quality, required int attitude}) {
    _overallRating = overall;
    _serviceQualityRating = quality;
    _specialistAttitudeRating = attitude;
    notifyListeners();
  }

  void submitRating() {
    _isRatingSubmitted = true;
    notifyListeners();
  }

  // Send consultation message
  void sendConsultationMessage(String message) {
    if (message.trim().isEmpty) return;
    _consultationChat.add({
      'sender': 'user',
      'text': message.trim(),
      'time': '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}',
    });
    notifyListeners();

    // Auto simulated reply
    Future.delayed(const Duration(milliseconds: 1000), () {
      _consultationChat.add({
        'sender': 'support',
        'text': 'Cảm ơn anh/chị đã liên hệ! Chuyên viên chăm sóc khách hàng của chi nhánh sẽ phản hồi ngay ạ.',
        'time': '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}',
      });
      notifyListeners();
    });
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMsg = ChatMessageModel(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      text: text.trim(),
      sender: ChatSender.user,
      timestamp: DateTime.now(),
    );
    _chatMessages.add(userMsg);
    notifyListeners();

    _isDoctorTyping = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1400));
    _isDoctorTyping = false;

    String doctorReply = 'Bác sĩ đã ghi nhận thông tin của bạn. Chúng tôi sẽ theo dõi sát sao tiến triển điều trị!';
    if (text.toLowerCase().contains('thuốc') || text.toLowerCase().contains('uống')) {
      doctorReply = 'Về liều lượng thuốc, bạn hãy tiếp tục duy trì đúng đơn thuốc điện tử trên ứng dụng. Đừng tự ý ngừng thuốc nhé!';
    } else if (text.toLowerCase().contains('đau') || text.toLowerCase().contains('mệt')) {
      doctorReply = 'Nếu bạn thấy mệt nhiều hoặc huyết áp đo tại nhà trên 150 mmHg, vui lòng nghỉ ngơi ngay và gọi hotline cấp cứu 1900 8899.';
    }

    _chatMessages.add(
      ChatMessageModel(
        id: 'msg_${DateTime.now().millisecondsSinceEpoch + 1}',
        text: doctorReply,
        sender: ChatSender.doctor,
        timestamp: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
