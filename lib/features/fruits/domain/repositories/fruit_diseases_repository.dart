import 'package:fruit_fungal_diseases/features/fruits/domain/entities/fuit_diseases.dart';


abstract class FruitDiseasesRepository {
  Future<List<FruitDiseases>> getFruitDiseases({int page=1}); 
  Future<List<FruitDiseases>> searchFruitDisease(String query);
  Future<FruitDiseases> getFruitDiseaseById(String id);
  Future<List<FruitDiseases>> searchAvencedFruitDisease(String search, String fruit);
}