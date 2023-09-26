import 'package:dio/dio.dart';
import 'package:fruit_fungal_diseases/features/fruits/domain/datasources/fruit_diseasesdb_datasource.dart';
import 'package:fruit_fungal_diseases/features/fruits/domain/entities/fuit_diseases.dart';
import 'package:fruit_fungal_diseases/features/fruits/infrastructure/mappers/fruit_diseases_mapper.dart';

class FruitDiseasesdbDatasource extends FruitDiseasesDatasource {
  final dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8000'));

  @override
  Future<List<FruitDiseases>> getFruitDiseases() async {
    final response = await dio.get<List>('/fruit/diseases');
    final List<FruitDiseases> fruitsDisiases = [];
    for (final product in response.data ?? []) {
      fruitsDisiases.add(FruitDiseasesMapper.jsonToEntity(product));
    }
    return fruitsDisiases;

    //final List<FruitDiseases> movies = fruitDBResponse.map((moviedb) => MovieMapper.movieDBToEntity(moviedb)).toList();

    //return fruitDBResponse;
  }
}
