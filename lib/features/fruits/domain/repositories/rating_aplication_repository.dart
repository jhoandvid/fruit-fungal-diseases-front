 import 'package:fruit_fungal_diseases/features/fruits/domain/entities/rating_aplication.dart';

abstract class RatingAplicationRepository {
  Future<RatingAplicationEntity> sendRatingAplication(double rating, String comment);
  Future<RatingAplicationEntity?> getRatingAplication();
}