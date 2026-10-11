class TreatmentPackageModel {
  final String id;
  final String title;
  final String branch;
  final int totalSessions;
  final int usedSessions;
  final int remainingSessions;
  final String status; // 'Đang sử dụng', 'Đã hoàn thành', 'Hết hạn'
  final String startDate;
  final String expiryDate;
  final String imageUrl;

  const TreatmentPackageModel({
    required this.id,
    required this.title,
    required this.branch,
    required this.totalSessions,
    required this.usedSessions,
    required this.remainingSessions,
    required this.status,
    required this.startDate,
    required this.expiryDate,
    required this.imageUrl,
  });

  double get progressPercentage => totalSessions > 0 ? (usedSessions / totalSessions) : 0.0;
}

class CareJournalEntry {
  final String id;
  final String sessionTitle;
  final String date;
  final String specialist;
  final String branch;
  final String note;
  final String tip;
  final bool isCompleted;

  const CareJournalEntry({
    required this.id,
    required this.sessionTitle,
    required this.date,
    required this.specialist,
    required this.branch,
    required this.note,
    required this.tip,
    this.isCompleted = true,
  });
}

class HomeCareArticle {
  final String id;
  final String category;
  final String readTime;
  final String title;
  final String subtitle;
  final String imageUrl;
  final List<String> keyPoints;

  const HomeCareArticle({
    required this.id,
    required this.category,
    required this.readTime,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.keyPoints,
  });
}
