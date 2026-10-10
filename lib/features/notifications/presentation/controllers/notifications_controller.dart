import 'package:flutter/material.dart';
import 'package:prj/features/notifications/domain/models/notification_model.dart';

class NotificationsController extends ChangeNotifier {
  List<NotificationModel> _notifications = [];
  bool _isLoading = false;

  List<NotificationModel> get notifications => _notifications;
  bool get isLoading => _isLoading;
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  NotificationsController() {
    _loadData();
  }

  void _loadData() async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    _notifications = [
      NotificationModel(
        id: '1',
        title: 'Lịch khám sắp tới',
        message: 'Bạn có lịch khám Tổng quát vào lúc 09:00 ngày 11/10/2026',
        type: 'reminder',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      NotificationModel(
        id: '2',
        title: 'Thanh toán thành công',
        message: 'Gói khám Tổng quát Toàn diện VIP đã được thanh toán.',
        type: 'success',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index] = NotificationModel(
        id: _notifications[index].id,
        title: _notifications[index].title,
        message: _notifications[index].message,
        type: _notifications[index].type,
        createdAt: _notifications[index].createdAt,
        isRead: true,
      );
      notifyListeners();
    }
  }

  void markAllAsRead() {
    _notifications = _notifications.map((n) => NotificationModel(
      id: n.id,
      title: n.title,
      message: n.message,
      type: n.type,
      createdAt: n.createdAt,
      isRead: true,
    )).toList();
    notifyListeners();
  }
}
