
import 'package:fruit_fungal_diseases/features/fruits/domain/entities/fruit_diseases.dart';

abstract class LocalStorageRepository{
  Future<void> toggleFavorite(FruitDiseases fruitDiseases);
  Future<bool> isFruitDiseaseFavorite(String fruitDiseasesId);
  Future<List<FruitDiseases>> loadFruitDisease();
}