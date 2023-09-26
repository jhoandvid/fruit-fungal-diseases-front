class FruitDiseases {
  final String id;
  final String scientificName;
  final String commonName;
  final String description;
  final String imageUrl;
  final List<String> hostPlants;
  final String symptoms;
  final List<String> preventionMethods;
  final String management;
  final List<dynamic> references;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  FruitDiseases({
    required this.id,
    required this.scientificName,
    required this.commonName,
    required this.description,
    required this.imageUrl,
    required this.hostPlants,
    required this.symptoms,
    required this.preventionMethods,
    required this.management,
    required this.references,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });
}

