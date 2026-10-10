import 'package:flutter/material.dart';
import 'package:prj/core/constants/app_constants.dart';
import 'package:prj/features/vocational_training/domain/models/course_model.dart';

class CourseController extends ChangeNotifier {
  List<CourseModel> _courses = [];
  CourseModel? _selectedCourse;
  LessonModel? _currentLesson;
  double _playbackSpeed = 1.0;
  bool _isPlaying = true;
  double _currentPositionSeconds = 120.0;
  double _totalDurationSeconds = 1500.0;

  // Quiz state
  int _currentQuizQuestionIndex = 0;
  final Map<int, int> _userSelectedAnswers = {};
  bool _isQuizSubmitted = false;
  int _quizScore = 0;

  List<CourseModel> get courses => _courses;
  CourseModel? get selectedCourse => _selectedCourse;
  LessonModel? get currentLesson => _currentLesson;
  double get playbackSpeed => _playbackSpeed;
  bool get isPlaying => _isPlaying;
  double get currentPositionSeconds => _currentPositionSeconds;
  double get totalDurationSeconds => _totalDurationSeconds;

  int get currentQuizQuestionIndex => _currentQuizQuestionIndex;
  Map<int, int> get userSelectedAnswers => _userSelectedAnswers;
  bool get isQuizSubmitted => _isQuizSubmitted;
  int get quizScore => _quizScore;

  CourseController() {
    _courses = List.from(AppConstants.sampleCourses);
    if (_courses.isNotEmpty) {
      _selectedCourse = _courses.first;
      if (_selectedCourse!.modules.isNotEmpty && _selectedCourse!.modules.first.lessons.isNotEmpty) {
        _currentLesson = _selectedCourse!.modules.first.lessons.first;
      }
    }
  }

  void selectCourse(CourseModel course) {
    _selectedCourse = course;
    if (course.modules.isNotEmpty && course.modules.first.lessons.isNotEmpty) {
      _currentLesson = course.modules.first.lessons.first;
    }
    notifyListeners();
  }

  void selectLesson(LessonModel lesson) {
    _currentLesson = lesson;
    _currentPositionSeconds = 0.0;
    _totalDurationSeconds = lesson.durationMinutes * 60.0;
    _isPlaying = true;
    notifyListeners();
  }

  void togglePlayPause() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void setPlaybackSpeed(double speed) {
    _playbackSpeed = speed;
    notifyListeners();
  }

  void seekTo(double seconds) {
    _currentPositionSeconds = seconds.clamp(0.0, _totalDurationSeconds);
    notifyListeners();
  }

  void markLessonCompleted(String lessonId) {
    if (_selectedCourse == null) return;

    final updatedModules = _selectedCourse!.modules.map((mod) {
      final updatedLessons = mod.lessons.map((les) {
        if (les.id == lessonId) {
          return les.copyWith(isCompleted: true);
        }
        return les;
      }).toList();
      return CourseModuleModel(id: mod.id, title: mod.title, lessons: updatedLessons);
    }).toList();

    int total = 0;
    int completed = 0;
    for (var m in updatedModules) {
      for (var l in m.lessons) {
        total++;
        if (l.isCompleted) completed++;
      }
    }

    final newProgress = total > 0 ? (completed / total) : 0.0;
    _selectedCourse = _selectedCourse!.copyWith(
      modules: updatedModules,
      progress: newProgress,
      isEnrolled: true,
    );

    final idx = _courses.indexWhere((c) => c.id == _selectedCourse?.id);
    if (idx != -1) {
      _courses[idx] = _selectedCourse!;
    }

    notifyListeners();
  }

  // Quiz Methods
  void selectQuizAnswer(int questionIndex, int optionIndex) {
    _userSelectedAnswers[questionIndex] = optionIndex;
    notifyListeners();
  }

  void nextQuizQuestion() {
    if (_currentQuizQuestionIndex < AppConstants.sampleQuizQuestions.length - 1) {
      _currentQuizQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuizQuestion() {
    if (_currentQuizQuestionIndex > 0) {
      _currentQuizQuestionIndex--;
      notifyListeners();
    }
  }

  void submitQuiz() {
    int correctCount = 0;
    for (int i = 0; i < AppConstants.sampleQuizQuestions.length; i++) {
      if (_userSelectedAnswers[i] == AppConstants.sampleQuizQuestions[i].correctOptionIndex) {
        correctCount++;
      }
    }
    _quizScore = ((correctCount / AppConstants.sampleQuizQuestions.length) * 100).toInt();
    _isQuizSubmitted = true;
    notifyListeners();
  }

  void resetQuiz() {
    _currentQuizQuestionIndex = 0;
    _userSelectedAnswers.clear();
    _isQuizSubmitted = false;
    _quizScore = 0;
    notifyListeners();
  }
}
