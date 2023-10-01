import 'package:fruit_fungal_diseases/features/fruits/domain/datasources/fruit_diseasesdb_datasource.dart';
import 'package:fruit_fungal_diseases/features/fruits/domain/entities/fruit_diseases.dart';
import 'package:fruit_fungal_diseases/features/fruits/domain/repositories/fruit_diseases_repository.dart';

class FruitDiseasesRepositoryImpl extends FruitDiseasesRepository {
  final FruitDiseasesDatasource fruitDiseasesDatasource;

  FruitDiseasesRepositoryImpl(this.fruitDiseasesDatasource);

  @override
  Future<List<FruitDiseases>> getFruitDiseases({int page = 1}) {
    return fruitDiseasesDatasource.getFruitDiseases();
  }

  @override
  Future<List<FruitDiseases>> searchFruitDisease(String query) {
    return fruitDiseasesDatasource.searchFruitDisease(query);
  }

  @override
  Future<FruitDiseases> getFruitDiseaseById(String id) {
    return fruitDiseasesDatasource.getFruitDiseaseById(id);
  }

  @override
  Future<List<FruitDiseases>> searchAvencedFruitDisease(
      String search, String fruit) {
    return fruitDiseasesDatasource.searchAvencedFruitDisease(search, fruit);
  }
}
