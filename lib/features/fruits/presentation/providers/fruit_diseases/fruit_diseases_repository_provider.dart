import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruit_fungal_diseases/features/auth/presentation/providers/auth_provider.dart';

import 'package:fruit_fungal_diseases/features/fruits/infrastructure/datasources/fruit_diseasesdb_datasource.dart';
import 'package:fruit_fungal_diseases/features/fruits/infrastructure/repositories/fruit_diseases_repository_impl.dart';

final fruitRepositoryProvider = Provider((ref) {

  final accessToken = ref.watch( authProvider ).user?.token ?? '';

    final productsRepository = FruitDiseasesRepositoryImpl(
    FruitDiseasesdbDatasource(accessToken: accessToken )
  );

  return productsRepository;
});


