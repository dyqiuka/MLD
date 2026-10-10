class DoctorModel {
  final String id;
  final String name;
  final String title; // BS. CKII, ThS. BS, etc.
  final String specialty;
  final String hospital;
  final double rating;
  final int reviewsCount;
  final int yearsOfExperience;
  final String avatarUrl;
  final String bio;
  final num consultationFee;
  final List<String> availableSlots;

  const DoctorModel({
    required this.id,
    required this.name,
    required this.title,
    required this.specialty,
    required this.hospital,
    required this.rating,
    required this.reviewsCount,
    required this.yearsOfExperience,
    required this.avatarUrl,
    required this.bio,
    required this.consultationFee,
    this.availableSlots = const [
      '08:00 - 08:30',
      '08:30 - 09:00',
      '09:00 - 09:30',
      '10:00 - 10:30',
      '14:00 - 14:30',
      '15:00 - 15:30',
      '16:00 - 16:30',
    ],
  });
}
