import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/providers/rating/rating_aplication_providers.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/providers/rating/rating_aplication_repository_providers.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/views/alert_dailog_rating.dart';
import 'package:fruit_fungal_diseases/features/shared/widgets/custom_filled_button.dart';
import 'package:fruit_fungal_diseases/features/shared/widgets/custom_text_form_field.dart';
import 'package:go_router/go_router.dart';

class QualificationFruitScreen extends ConsumerWidget {
  const QualificationFruitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Calificar aplicación'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(child: _RatingAplicationView()),
      ),
    );
  }
}

class _RatingAplicationView extends ConsumerStatefulWidget {
  const _RatingAplicationView();

  @override
  __RatingAplicationViewState createState() => __RatingAplicationViewState();
}

class __RatingAplicationViewState extends ConsumerState<_RatingAplicationView> {
  @override
  void initState() {
    super.initState();
    ref.read(getRatingAplicationProvider);
  }

  @override
  Widget build(BuildContext context) {
    final rating = ref.watch(ratingProvider);
    final comment = ref.watch(commentProvider);
    final isLoading = ref.watch(isLoadingProvider);

    final sendRatingAplication =
        ref.watch(ratingAplicationRepositoryProvider).sendRatingAplication;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Puntuación: ${rating}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        RatingBar.builder(
          initialRating: rating,
          minRating: 1,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            ref.read(ratingProvider.notifier).state = rating;
          },
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          hint: ref.read(commentProvider) == ''
              ? 'Ingrese un comentario'
              : ref.read(commentProvider),
          initialValue: ref.read(commentProvider),
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          onChanged: (value) {
            ref.read(commentProvider.notifier).state = value;
          },
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomFilledButton(
            onPressed: () async {
              if (ref.read(isLoadingProvider.notifier).state) {
                return;
              }

              ref.read(isLoadingProvider.notifier).state = true;
              sendRatingAplication(rating, comment);
              ref.read(isLoadingProvider.notifier).state = false;
             showThankYouDialog(context);
             
            },
            text: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Text('Enviar'),
          ),
        ),
      ],
    );
  }
}
