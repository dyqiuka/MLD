import 'package:flutter/material.dart';
import 'package:prj/core/constants/app_constants.dart';
import 'package:prj/features/treatment_care/domain/models/medical_record_model.dart';

class TreatmentController extends ChangeNotifier {
  List<MedicalRecordModel> _records = [];
  List<ChatMessageModel> _chatMessages = [];
  bool _isDoctorTyping = false;

  List<MedicalRecordModel> get records => _records;
  List<ChatMessageModel> get chatMessages => _chatMessages;
  bool get isDoctorTyping => _isDoctorTyping;

  TreatmentController() {
    _initData();
  }

  void _initData() {
    _records = List.from(AppConstants.sampleMedicalRecords);
    _chatMessages = [
      ChatMessageModel(
        id: 'msg_01',
        text: 'Xin chào anh Tùng! Tôi là PGS. TS. Nguyễn Văn Hùng. Tôi đã xem qua kết quả xét nghiệm huyết áp và mỡ máu của anh.',
        sender: ChatSender.doctor,
        timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      ),
      ChatMessageModel(
        id: 'msg_02',
        text: 'Chỉ số huyết áp 142/88 mmHg ở mức độ 1. Anh nhớ uống đều đặn Amlodipine 5mg vào mỗi buổi sáng sau ăn nhé.',
        sender: ChatSender.doctor,
        timestamp: DateTime.now().subtract(const Duration(hours: 3, minutes: 55)),
        isPrescription: true,
      ),
      ChatMessageModel(
        id: 'msg_03',
        text: 'Dạ vâng thưa Bác sĩ, mấy hôm nay em đỡ đau gáy rồi ạ. Em có cần kiêng cữ gì thêm trong chế độ ăn không ạ?',
        sender: ChatSender.user,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      ChatMessageModel(
        id: 'msg_04',
        text: 'Anh nên giảm lượng muối dưới 5g/ngày (khoảng 1 thìa cà phê), hạn chế đồ chiên xào và tăng cường rau xanh giàu Kali. Nếu có cơn hồi hộp, hãy nhắn ngay cho tôi nhé!',
        sender: ChatSender.doctor,
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
      ),
    ];
    notifyListeners();
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
