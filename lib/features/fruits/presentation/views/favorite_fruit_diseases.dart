import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/providers/storage/favorite_fruits_diseases_provider.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/widgets/fruit_card.dart';
import 'package:fruit_fungal_diseases/features/shared/widgets/custom_filled_button.dart';
import 'package:go_router/go_router.dart';

class FavoriteFruitDiseasesScreen extends ConsumerWidget {
  const FavoriteFruitDiseasesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enfermedades Agregadas'),
        centerTitle: true,
    
      ),
      body: _FruitDiseasesView(),
    );
  }
}

class _FruitDiseasesView extends ConsumerStatefulWidget {
  const _FruitDiseasesView();

  @override
  _FruitDiseasesViewState createState() => _FruitDiseasesViewState();
}

class _FruitDiseasesViewState extends ConsumerState<_FruitDiseasesView> {
  @override
  void initState() {
    super.initState();
    //LLama a la pagina
    ref
        .read(favoriteFruitDiseasesProvider.notifier)
        .loadFavoriteFruitDiseases();
  }

  @override
  Widget build(BuildContext context) {
    final nowFruitDiseases =
        ref.watch(favoriteFruitDiseasesProvider).values.toList();

    if (nowFruitDiseases.isEmpty) {
      return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'No hay enfermedades de la futa agregadas',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 20,
              ),
              CustomFilledButton(
                  text: Text('Buscar'),
                  buttonColor: Colors.green,
                  onPressed: () {
                    context.push('/');
                  })
            ]),
      );
    }

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 20,
              itemCount: nowFruitDiseases.length,
              itemBuilder: (context, index) {
                return FruitCard(fruitDiseases: nowFruitDiseases[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
}
