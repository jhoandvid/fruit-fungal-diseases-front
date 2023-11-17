import 'package:fruit_fungal_diseases/features/fruits/domain/datasources/rating_aplicationdb_datasource.dart';
import 'package:fruit_fungal_diseases/features/fruits/domain/entities/rating_aplication.dart';
import 'package:fruit_fungal_diseases/features/fruits/domain/repositories/rating_aplication_repository.dart';

class RatingAplicationRepositoryImpl extends RatingAplicationRepository {
  final RatingAplicationDbDataSource ratingAplicationDbDataSource;

  RatingAplicationRepositoryImpl(this.ratingAplicationDbDataSource);

  @override
  Future<RatingAplicationEntity?> getRatingAplication()  {
    return  ratingAplicationDbDataSource.getRatingAplication();
  }

  @override
  Future<RatingAplicationEntity> sendRatingAplication(
      double rating, String comment)  {
    return ratingAplicationDbDataSource.sendRatingAplication(rating, comment);
  }
}
