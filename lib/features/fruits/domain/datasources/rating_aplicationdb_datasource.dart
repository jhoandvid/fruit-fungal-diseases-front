import 'package:fruit_fungal_diseases/features/fruits/domain/entities/rating_aplication.dart';

abstract class RatingAplicationDbDataSource {
  Future<RatingAplicationEntity> sendRatingAplication(double rating, String comment);
  Future<RatingAplicationEntity?> getRatingAplication();
}
