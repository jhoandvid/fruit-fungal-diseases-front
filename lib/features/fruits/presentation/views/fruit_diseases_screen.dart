import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/providers/fruit_diseases/fruit_diseases_providers.dart';


class FruitDiseasesScreen extends StatelessWidget {
  const FruitDiseasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: Center(
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
    return ListView.builder(
      itemCount: nowFruitDiseases.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(nowFruitDiseases[index].description),
        );
      },
    );
  }
}
