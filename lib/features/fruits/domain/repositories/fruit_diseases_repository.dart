import 'package:fruit_fungal_diseases/features/fruits/domain/entities/fuit_diseases.dart';


abstract class FruitDiseasesRepository {
  Future<List<FruitDiseases>> getFruitDiseases({int page=1}); 
}