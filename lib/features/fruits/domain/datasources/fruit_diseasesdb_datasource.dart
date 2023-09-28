import 'package:fruit_fungal_diseases/features/fruits/domain/entities/fuit_diseases.dart';

abstract class FruitDiseasesDatasource {
  Future<List<FruitDiseases>> getFruitDiseases();
  Future<List<FruitDiseases>> searchFruitDisease(String query);
}
