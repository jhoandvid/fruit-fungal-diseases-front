import 'package:fruit_fungal_diseases/features/fruits/domain/entities/fruit_diseases.dart';


class FruitDiseasesMapper {
  static jsonToEntity(Map<String, dynamic> json) => FruitDiseases(
        id: json["_id"],
        scientificName: json["scientific_name"],
        commonName: json["common_name"],
        description: json["description"],
        imageUrl: json["image_url"],
        hostPlants: List<String>.from(json["host_plants"].map((x) => x)),
        symptoms: json["symptoms"],
        preventionMethods:
            List<String>.from(json["prevention_methods"].map((x) => x)),
        management: json["management"],
        references: List<Reference>.from(
            json["references"].map((x) => Reference.fromJson(x))),
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}


