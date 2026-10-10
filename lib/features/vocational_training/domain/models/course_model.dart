class LessonModel {
  final String id;
  final String title;
  final int durationMinutes;
  final String videoUrl;
  final bool isCompleted;
  final bool isPreview;
  final String summary;

  const LessonModel({
    required this.id,
    required this.title,
    required this.durationMinutes,
    required this.videoUrl,
    this.isCompleted = false,
    this.isPreview = false,
    this.summary = '',
  });

  LessonModel copyWith({
    bool? isCompleted,
  }) {
    return LessonModel(
      id: id,
      title: title,
      durationMinutes: durationMinutes,
      videoUrl: videoUrl,
      isCompleted: isCompleted ?? this.isCompleted,
      isPreview: isPreview,
      summary: summary,
    );
  }
}

class CourseModuleModel {
  final String id;
  final String title;
  final List<LessonModel> lessons;

  const CourseModuleModel({
    required this.id,
    required this.title,
    required this.lessons,
  });
}

class CourseModel {
  final String id;
  final String title;
  final String category; // 'Điều dưỡng', 'Chăm sóc cao tuổi', 'Kỹ thuật viên xét nghiệm', 'Trợ thủ nha khoa', 'Thẩm mỹ y khoa'
  final String instructorName;
  final String instructorTitle;
  final String instructorAvatar;
  final String thumbnailUrl;
  final num tuitionFee;
  final num? originalTuitionFee;
  final double rating;
  final int studentsCount;
  final int totalLessons;
  final int totalHours;
  final String certificateTitle;
  final String description;
  final List<CourseModuleModel> modules;
  final double progress; // 0.0 to 1.0
  final bool isEnrolled;

  const CourseModel({
    required this.id,
    required this.title,
    required this.category,
    required this.instructorName,
    required this.instructorTitle,
    required this.instructorAvatar,
    required this.thumbnailUrl,
    required this.tuitionFee,
    this.originalTuitionFee,
    required this.rating,
    required this.studentsCount,
    required this.totalLessons,
    required this.totalHours,
    required this.certificateTitle,
    required this.description,
    required this.modules,
    this.progress = 0.0,
    this.isEnrolled = false,
  });

  CourseModel copyWith({
    double? progress,
    bool? isEnrolled,
    List<CourseModuleModel>? modules,
  }) {
    return CourseModel(
      id: id,
      title: title,
      category: category,
      instructorName: instructorName,
      instructorTitle: instructorTitle,
      instructorAvatar: instructorAvatar,
      thumbnailUrl: thumbnailUrl,
      tuitionFee: tuitionFee,
      originalTuitionFee: originalTuitionFee,
      rating: rating,
      studentsCount: studentsCount,
      totalLessons: totalLessons,
      totalHours: totalHours,
      certificateTitle: certificateTitle,
      description: description,
      modules: modules ?? this.modules,
      progress: progress ?? this.progress,
      isEnrolled: isEnrolled ?? this.isEnrolled,
    );
  }
}

class QuizQuestionModel {
  final String id;
  final String question;
  final List<String> options;
  final int correctOptionIndex;
  final String explanation;

  const QuizQuestionModel({
    required this.id,
    required this.question,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
  });
}
