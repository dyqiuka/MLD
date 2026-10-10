enum UserRole {
  patient,
  student,
  doctor,
  admin,
}

extension UserRoleExtension on UserRole {
  String get displayName {
    switch (this) {
      case UserRole.patient:
        return 'Bệnh nhân / Khách hàng';
      case UserRole.student:
        return 'Học viên Đào tạo Nghề';
      case UserRole.doctor:
        return 'Bác sĩ / Chuyên gia';
      case UserRole.admin:
        return 'Quản trị viên';
    }
  }

  String get shortCode {
    switch (this) {
      case UserRole.patient:
        return 'PATIENT';
      case UserRole.student:
        return 'STUDENT';
      case UserRole.doctor:
        return 'DOCTOR';
      case UserRole.admin:
        return 'ADMIN';
    }
  }
}

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String avatarUrl;
  final UserRole role;
  final String membershipTier; // 'Silver', 'Gold', 'Platinum', 'Diamond'
  final int loyaltyPoints;
  final String? studentId; // If student
  final String? specialization; // If doctor or student course

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    required this.role,
    this.membershipTier = 'Gold',
    this.loyaltyPoints = 1450,
    this.studentId,
    this.specialization,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? avatarUrl,
    UserRole? role,
    String? membershipTier,
    int? loyaltyPoints,
    String? studentId,
    String? specialization,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
      membershipTier: membershipTier ?? this.membershipTier,
      loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
      studentId: studentId ?? this.studentId,
      specialization: specialization ?? this.specialization,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatarUrl': avatarUrl,
      'role': role.name,
      'membershipTier': membershipTier,
      'loyaltyPoints': loyaltyPoints,
      'studentId': studentId,
      'specialization': specialization,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      role: UserRole.values.firstWhere(
        (e) => e.name == json['role'],
        orElse: () => UserRole.patient,
      ),
      membershipTier: json['membershipTier'] ?? 'Silver',
      loyaltyPoints: json['loyaltyPoints'] ?? 0,
      studentId: json['studentId'],
      specialization: json['specialization'],
    );
  }
}
