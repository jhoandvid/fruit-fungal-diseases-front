import 'package:fruit_fungal_diseases/features/fruits/domain/entities/fuit_diseases.dart';



class FruitDiseasesMapper {
  static  jsonToEntity(Map<String, dynamic> json) =>
      FruitDiseases(
       id: json["_id"],
        scientificName: json["scientific_name"],
        commonName: json["common_name"],
        description: json["description"],
        imageUrl: json["image_url"],
        hostPlants: List<String>.from(json["host_plants"].map((x) => x)),
        symptoms: json["symptoms"],
        preventionMethods: List<String>.from(json["prevention_methods"].map((x) => x)),
        management: json["management"],
        references: json["references"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),

      );
}

class Reference {
  final String title;
  final String url;

  Reference({
    required this.title,
    required this.url,
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
