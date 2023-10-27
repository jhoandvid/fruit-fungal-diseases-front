import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruit_fungal_diseases/features/fruits/domain/entities/fruit_diseases.dart';
import 'package:fruit_fungal_diseases/features/fruits/domain/repositories/local_storage_repository.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/providers/storage/local_storage_provider.dart';

final favoriteFruitDiseasesProvider = StateNotifierProvider<
    StorageFruitsDiseasesNotifier, Map<String, FruitDiseases>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);

  return StorageFruitsDiseasesNotifier(
      localStorageRepository: localStorageRepository);
});

class StorageFruitsDiseasesNotifier
    extends StateNotifier<Map<String, FruitDiseases>> {
  final LocalStorageRepository localStorageRepository;

  StorageFruitsDiseasesNotifier({required this.localStorageRepository})
      : super({});

  Future<List<FruitDiseases>> loadFavoriteFruitDiseases() async {
    final fruitsDiseases = await localStorageRepository.loadFruitDisease();

    for (final fruitDisease in fruitsDiseases) {
      state = {fruitDisease.id: fruitDisease};
    }

    return fruitsDiseases;
  }

  Future<void> toggleFavorite(FruitDiseases fruitDiseases) async {
    final bool isFruitDiseasesinFavorite =
        await localStorageRepository.isFruitDiseaseFavorite(fruitDiseases.id);
    
    await localStorageRepository.toggleFavorite(fruitDiseases);

    if (isFruitDiseasesinFavorite ) {
      state.remove(fruitDiseases.id);
     
    } else {
       state[fruitDiseases.id]=fruitDiseases;
   
    }
       state = {...state};
  }
}
