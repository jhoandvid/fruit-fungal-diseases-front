import 'package:isar/isar.dart';

part 'fruit_diseases.g.dart';

@collection
class FruitDiseases {
  Id? isarId;
  final String id;
  final String scientificName;
  final String commonName;
  final String description;
  final String imageUrl;
  final List<String> hostPlants;
  final String symptoms;
  final List<String> preventionMethods;
  final String management;
  final List<Reference> references;
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

@embedded
class Reference {
  final String title;
  final String url;

  Reference({
    this.title = "",
    this.url = "",
  });

  factory Reference.fromJson(Map<dynamic, dynamic> json) => Reference(
        title: json["title"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "url": url,
      };
}
