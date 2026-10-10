class ServiceModel {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final num price;
  final num? originalPrice;
  final int durationMinutes;
  final double rating;
  final int reviewsCount;
  final String description;
  final List<String> highlights;
  final List<String> preparations;
  final List<String> doctorIds;
  final bool isPopular;

  const ServiceModel({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    this.originalPrice,
    required this.durationMinutes,
    required this.rating,
    required this.reviewsCount,
    required this.description,
    required this.highlights,
    required this.preparations,
    required this.doctorIds,
    this.isPopular = false,
  });
}
