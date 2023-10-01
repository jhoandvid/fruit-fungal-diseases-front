import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruit_fungal_diseases/features/fruits/domain/entities/fruit_diseases.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/delegates/search_fruit_diseases_delegate.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/providers/fruit_diseases/fruit_diseases_providers.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/providers/fruit_diseases/fruit_diseases_repository_provider.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/widgets/fruit_card.dart';
import 'package:fruit_fungal_diseases/features/shared/widgets/side_menu.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

class FruitDiseasesViews extends ConsumerWidget {
  const FruitDiseasesViews({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldkey = GlobalKey<ScaffoldState>();

    //Refactorizar el Side Menu para las 3 pantallas
    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldkey),
      appBar: AppBar(
        title: const Text('Enfermedades de la Fruta'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                final fruitRepository = ref.read(fruitRepositoryProvider);

                showSearch<FruitDiseases?>(
                        
                        context: context,
                        delegate: SearchFruitDiseasesDelegate(
                            searchFruitDiseases:
                                fruitRepository.searchFruitDisease))
                    .then((fruitDiseases) {

                      if(fruitDiseases==null) return;
                      context.push('/fruit/diseases/${fruitDiseases.id}');
                    });

              },
              icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: const Center(
        child: _FruitDiseasesView(),
      ),
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
    ref.read(nowFruitDiseasesProvider.notifier).loadFruitDiseases();
  }

  @override
  Widget build(BuildContext context) {
    final nowFruitDiseases = ref.watch(nowFruitDiseasesProvider);
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
