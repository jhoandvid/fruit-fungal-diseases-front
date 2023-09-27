import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruit_fungal_diseases/features/fruits/domain/entities/fuit_diseases.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/providers/fruit_diseases/fruit_diseases_repository_provider.dart';

final nowFruitDiseasesProvider = StateNotifierProvider<FruitDiseasesNotifier, List<FruitDiseases>>((ref) {
  final fecthMoreFruitDiseases= ref.watch(fruitRepositoryProvider).getFruitDiseases;
  return FruitDiseasesNotifier(fecthMoreFruitDiseases: fecthMoreFruitDiseases);
});


//Typo de callback que requiero y tiene que cumplir con una firma
typedef FruitDiseasesCallback = Future<List<FruitDiseases>> Function();




class FruitDiseasesNotifier extends StateNotifier<List<FruitDiseases>> {
  int currentPage = 0;
  FruitDiseasesCallback fecthMoreFruitDiseases;

  FruitDiseasesNotifier({required this.fecthMoreFruitDiseases}) : super([]);

  Future<void> loadFruitDiseases() async {
    final List<FruitDiseases> fruitsDiseases = await fecthMoreFruitDiseases();
    state = [ ...fruitsDiseases];
  }

  
}
