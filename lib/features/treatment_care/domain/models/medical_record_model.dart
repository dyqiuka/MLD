class PrescriptionItemModel {
  final String medicineName;
  final String dosage; // e.g. "500mg"
  final String frequency; // e.g. "2 lần / ngày sau ăn"
  final int days; // 7 ngày
  final String notes;

  const PrescriptionItemModel({
    required this.medicineName,
    required this.dosage,
    required this.frequency,
    required this.days,
    this.notes = '',
  });
}

class MedicalRecordModel {
  final String id;
  final String recordCode; // e.g. EMR-88391
  final DateTime examinationDate;
  final String doctorName;
  final String doctorTitle;
  final String specialty;
  final String diagnosis; // Chẩn đoán chính
  final String clinicHospital;
  final List<String> symptomsReported;
  final List<PrescriptionItemModel> prescriptions;
  final List<String> labTestResults;
  final String treatmentRegimen; // Phác đồ điều trị
  final DateTime? followUpDate; // Lịch tái khám
  final String status; // 'Đang điều trị', 'Đã hoàn thành', 'Cần theo dõi'

  const MedicalRecordModel({
    required this.id,
    required this.recordCode,
    required this.examinationDate,
    required this.doctorName,
    required this.doctorTitle,
    required this.specialty,
    required this.diagnosis,
    required this.clinicHospital,
    required this.symptomsReported,
    required this.prescriptions,
    required this.labTestResults,
    required this.treatmentRegimen,
    this.followUpDate,
    this.status = 'Đang điều trị',
  });
}

enum ChatSender { user, doctor, system }

class ChatMessageModel {
  final String id;
  final String text;
  final ChatSender sender;
  final DateTime timestamp;
  final String? attachmentUrl;
  final bool isPrescription;

  const ChatMessageModel({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
    this.attachmentUrl,
    this.isPrescription = false,
  });
}
