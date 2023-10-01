import 'package:fruit_fungal_diseases/features/fruits/domain/entities/fruit_diseases.dart';

abstract class FruitDiseasesDatasource {
  Future<List<FruitDiseases>> getFruitDiseases();
  Future<List<FruitDiseases>> searchFruitDisease(String query);
  Future<FruitDiseases> getFruitDiseaseById(String id);
  Future<List<FruitDiseases>> searchAvencedFruitDisease(String search, String fruit);
}
