import 'package:dio/dio.dart';
import 'package:fruit_fungal_diseases/config/constants/environment.dart';
import 'package:fruit_fungal_diseases/features/fruits/domain/datasources/fruit_diseasesdb_datasource.dart';
import 'package:fruit_fungal_diseases/features/fruits/domain/entities/fuit_diseases.dart';
import 'package:fruit_fungal_diseases/features/fruits/infrastructure/errors/fruit_disease_error.dart';
import 'package:fruit_fungal_diseases/features/fruits/infrastructure/mappers/fruit_diseases_mapper.dart';

class FruitDiseasesdbDatasource extends FruitDiseasesDatasource {
  //final dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8000'));

    late final Dio dio;
    final String accessToken;

  FruitDiseasesdbDatasource({
    required this.accessToken
  }) : dio = Dio(
    BaseOptions(
      baseUrl: Enviroment.apiUrl,
      headers: {
        'Authorization': 'Bearer $accessToken'
      }
    )
  );


  @override
  Future<List<FruitDiseases>> getFruitDiseases() async {
    final response = await dio.get('/fruit/diseases');
    final List<FruitDiseases> fruitsDisiases = [];
    for (final fruitsDisease in response.data ?? []) {
      fruitsDisiases.add(FruitDiseasesMapper.jsonToEntity(fruitsDisease));
    }
    return fruitsDisiases;

  
  }
  
  @override
  Future<List<FruitDiseases>> searchFruitDisease(String query) async {
    final response = await dio.get('/fruit/search', queryParameters: {'query':query});
    final List<FruitDiseases> fruitsDisiases = [];
    for (final fruitsDisease in response.data ?? []) {
      fruitsDisiases.add(FruitDiseasesMapper.jsonToEntity(fruitsDisease));
    }
    return fruitsDisiases;
  }
  
  
  @override
  Future<FruitDiseases> getFruitDiseaseById(String id) async {
    
    try {
      
      final response = await dio.get('/fruit/diseases/$id');
      final fruitDisease = FruitDiseasesMapper.jsonToEntity(response.data);
      return fruitDisease;

    } on DioException catch (e) {
      if ( e.response!.statusCode == 404 ) throw FruitDiseaseNotFount();
      throw Exception();

    }catch (e) {
      throw Exception();
    }

  }



   //@override
  //Future<FruitDiseases> getProductById(String id) async {
    
    //try {
    //  final response = await dio.get('/products/$id');
    //  final product = FruitDiseasesMapper.jsonToEntity(response.data);
    //  return product;
    //} on DioError catch (e) {
    //  if ( e.response!.statusCode == 404 ) throw ProductNotFound();
    //  throw Exception();

    //}catch (e) {
    //  throw Exception();
    //}

  //}

}
