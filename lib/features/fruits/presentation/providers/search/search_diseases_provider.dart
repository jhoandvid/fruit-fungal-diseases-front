import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:fruit_fungal_diseases/features/fruits/domain/entities/fruit_diseases.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/providers/fruit_diseases/fruit_diseases_repository_provider.dart';
import 'package:fruit_fungal_diseases/features/shared/infraestructure/input/search.dart';

final searchFruitDiseasesFormProvider =
    StateNotifierProvider.autoDispose<SearchFruitDiseases, SearchDiseaseState>(
        (ref) {
  final searchFruitDisease =
      ref.watch(fruitRepositoryProvider).searchAvencedFruitDisease;

  return SearchFruitDiseases(searchFruitDisease: searchFruitDisease);
});

class SearchFruitDiseases extends StateNotifier<SearchDiseaseState> {
  final Function(String, String) searchFruitDisease;

  SearchFruitDiseases({required this.searchFruitDisease})
      : super(SearchDiseaseState());

  onSearchChanged(String value) {
    final search = Search.dirty(value);
    state = state.copyWith(isData: true, search: search, isValid: Formz.validate([search]));
  }

  onSelectedFruitChanged(String value) {
    state = state.copyWith(fruit: value, isData: true);
    print(value);
  }

  onFormSubmit() async {
    //[{"noFound": No se encontr}]
    _touchedEveryField();
    if (!state.isValid) return;
    state = state.copyWith(isPosting: true, isLoading: true);
    try{
    final List<FruitDiseases> diseasesFruit =
        await searchFruitDisease(state.search.value, state.fruit);

    if(diseasesFruit.isEmpty){
      state = state.copyWith(
        isPosting: false, diseasesFruit: diseasesFruit, isLoading: false, isData: false);
    }else{
      state = state.copyWith(
        isPosting: false, diseasesFruit: diseasesFruit, isLoading: false, isData: true);
    }
    }catch(e){
      state = state.copyWith(
        isPosting: false, diseasesFruit: [], isLoading: false, isData: false);
    }
    

    
  }

  _touchedEveryField() {
    final search = Search.dirty(state.search.value);

    state = state.copyWith(
        isFormPosted: true, search: search, isValid: Formz.validate([search]));
  }
}

class SearchDiseaseState {
  final Search search;
  final String fruit;
  final bool isFormPosted;
  final bool isPosting;
  final bool isLoading;
  final bool isValid;
  final bool isData;
  final List<FruitDiseases> diseasesFruit;

  SearchDiseaseState({
    this.search = const Search.pure(),
    this.isPosting = false,
    this.fruit = "Pera",
    this.isValid = false,
    this.isFormPosted = false,
    this.isLoading = false,
    this.isData=true,
    this.diseasesFruit = const [],
  });

  SearchDiseaseState copyWith({
    Search? search,
    String? fruit,
    bool? isValid,
    bool? isLoading,
    bool? isFormPosted,
    bool? isPosting,
    bool? isData,
    List<FruitDiseases>? diseasesFruit,
  }) =>
      SearchDiseaseState(
        search: search ?? this.search,
        fruit: fruit ?? this.fruit,
        isValid: isValid ?? this.isValid,
        isPosting: isPosting ?? this.isPosting,
        isLoading: isLoading ?? this.isLoading,
        isData: isData?? this.isData,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        diseasesFruit: diseasesFruit ?? this.diseasesFruit,
      );
}
