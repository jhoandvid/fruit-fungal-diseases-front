import 'package:fruit_fungal_diseases/features/fruits/domain/datasources/local_storage_datasource.dart';
import 'package:fruit_fungal_diseases/features/fruits/domain/entities/fruit_diseases.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDataSource {
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationCacheDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([FruitDiseasesSchema],
          inspector: true, directory: dir.path);
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isFruitDiseaseFavorite(String fruitDiseasesId) async {
    final isar = await db;
    final FruitDiseases? isFavoriteFruitDiseases = await isar.fruitDiseases
        .filter()
        .idEqualTo(fruitDiseasesId)
        .findFirst();
    return isFavoriteFruitDiseases != null;
  }

  @override
  Future<List<FruitDiseases>> loadFruitDisease() async {
    final isar = await db;

    return isar.fruitDiseases.where().findAll();
  }

  @override
  Future<void> toggleFavorite(FruitDiseases fruitDiseases) async {
    final isar = await db;

    final favoriteFruitDiseases = await isar.fruitDiseases
        .filter()
        .idEqualTo(fruitDiseases.id)
        .findFirst();

    if (favoriteFruitDiseases != null) {
      isar.writeTxnSync(
          () => isar.fruitDiseases.deleteSync(favoriteFruitDiseases.isarId!));
      return;
    } else {
      isar.writeTxnSync(() => isar.fruitDiseases.putSync(fruitDiseases));
    }
  }
}
