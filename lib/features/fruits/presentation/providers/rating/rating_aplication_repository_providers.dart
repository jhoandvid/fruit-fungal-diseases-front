import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruit_fungal_diseases/features/auth/presentation/providers/auth_provider.dart';
import 'package:fruit_fungal_diseases/features/fruits/infrastructure/datasources/rating_aplicationdb_datasource_imp.dart';
import 'package:fruit_fungal_diseases/features/fruits/infrastructure/repositories/rating_aplication_repository_impl.dart';

final ratingAplicationRepositoryProvider = Provider((ref) {

  final accessToken = ref.watch( authProvider ).user?.token ?? '';

    final ratingAplicationRepository = RatingAplicationRepositoryImpl(
    RatingAplicationDatasourceImpl(accessToken: accessToken )
  );

  return ratingAplicationRepository;
});

