import 'package:dio/dio.dart';
import 'package:fruit_fungal_diseases/config/constants/environment.dart';
import 'package:fruit_fungal_diseases/features/fruits/domain/datasources/rating_aplicationdb_datasource.dart';
import 'package:fruit_fungal_diseases/features/fruits/domain/entities/rating_aplication.dart';

class RatingAplicationDatasourceImpl extends RatingAplicationDbDataSource {
  late final Dio dio;
  final String accessToken;

  RatingAplicationDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
            baseUrl: Enviroment.apiUrl,
            headers: {'Authorization': 'Bearer $accessToken'}));

  @override
  Future<RatingAplicationEntity?> getRatingAplication() async {
    final response = await dio.get('/fruit/rating');
    return  RatingAplicationEntity.fromJson(response.data);
  }

  @override
  Future<RatingAplicationEntity> sendRatingAplication(double rating, String comment) async {
    final response = await dio.post('/fruit/rating', data: {
      "rating": rating,
      "comment": comment
    });
    return RatingAplicationEntity.fromJson(response.data);
  }
}
