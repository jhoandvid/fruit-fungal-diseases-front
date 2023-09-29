import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruit_fungal_diseases/features/fruits/domain/entities/fuit_diseases.dart';
import 'package:fruit_fungal_diseases/features/fruits/domain/repositories/fruit_diseases_repository.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/providers/fruit_diseases/fruit_diseases_repository_provider.dart';

final fruitDiseaseProvider = StateNotifierProvider.family<FruitDiseaseNotifier,
    FruitDiseaseState, String>((ref, fruitDiseaseId) {
  final fruitDiseasesRepository = ref.watch(fruitRepositoryProvider);
  return FruitDiseaseNotifier(
      fruitDiseasesRepository: fruitDiseasesRepository,
      fruitDiseaseId: fruitDiseaseId);
});

class FruitDiseaseNotifier extends StateNotifier<FruitDiseaseState> {
  final FruitDiseasesRepository fruitDiseasesRepository;

  FruitDiseaseNotifier(
      {required this.fruitDiseasesRepository, required String fruitDiseaseId})
      : super(FruitDiseaseState(id: fruitDiseaseId)) {
    loadFruitDisease();
  }

  Future<void> loadFruitDisease() async {
    try {
      final fruitDisease =
          await fruitDiseasesRepository.getFruitDiseaseById(state.id);

      state = state.copyWith(
        isLoading: false,
        fruitDisease: fruitDisease,
      );
    } catch (e) {
      print(e);
    }
  }
}

class FruitDiseaseState {
  final String id;
  final FruitDiseases? fruitDisease;
  final bool isLoading;

  FruitDiseaseState({
    this.fruitDisease,
    this.isLoading = true,
    required this.id,
  });

  FruitDiseaseState copyWith(
          {String? id, FruitDiseases? fruitDisease, bool? isLoading}) =>
      FruitDiseaseState(
          id: id ?? this.id,
          fruitDisease: fruitDisease ?? this.fruitDisease,
          isLoading: isLoading ?? this.isLoading);
}
