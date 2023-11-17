import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/providers/rating/rating_aplication_repository_providers.dart';

final ratingProvider = StateProvider<double>((ref) => 1.0);
final commentProvider = StateProvider<String>((ref) => "");
final isLoadingProvider = StateProvider<bool>((ref) => false);

final getRatingAplicationProvider = FutureProvider<void>((ref) async {
  // Simulate fetching data from an API
  final ratingAplication =
      await ref.watch(ratingAplicationRepositoryProvider).getRatingAplication();
  // Update the values of ratingProvider and commentProvider
  if (ratingAplication != null) {
    ref.read(ratingProvider.notifier).state = ratingAplication.rating;
    ref.read(commentProvider.notifier).state = ratingAplication.comment;
    return;
  }

  ref.read(ratingProvider.notifier).state = 1.0;
  ref.read(commentProvider.notifier).state = "";
});
