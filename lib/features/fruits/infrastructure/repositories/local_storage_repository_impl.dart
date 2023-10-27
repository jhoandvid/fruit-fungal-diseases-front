import 'package:fruit_fungal_diseases/features/fruits/domain/datasources/local_storage_datasource.dart';
import 'package:fruit_fungal_diseases/features/fruits/domain/entities/fruit_diseases.dart';
import 'package:fruit_fungal_diseases/features/fruits/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDataSource dataSource;

  LocalStorageRepositoryImpl( this.dataSource);

  @override
  Future<bool> isFruitDiseaseFavorite(String fruitDiseasesId) {
    return dataSource.isFruitDiseaseFavorite(fruitDiseasesId);
  }

  @override
  Future<List<FruitDiseases>> loadFruitDisease() {
    return dataSource.loadFruitDisease();
  }

  @override
  Future<void> toggleFavorite(FruitDiseases fruitDiseases) {
    return dataSource.toggleFavorite(fruitDiseases);
  }
}
