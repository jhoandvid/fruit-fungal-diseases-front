

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruit_fungal_diseases/features/fruits/domain/entities/fuit_diseases.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/providers/fruit_diseases/fruit_disease_providers.dart';
import 'package:url_launcher/url_launcher.dart';

class FruitDiseasesScreen extends ConsumerWidget {
  final String fruitDiseasesId;
  const FruitDiseasesScreen({super.key, required this.fruitDiseasesId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fruitDiseaseState = ref.watch(fruitDiseaseProvider(fruitDiseasesId));

    final FruitDiseases? fruitDisease = fruitDiseaseState.fruitDisease;

    if (fruitDiseaseState.isLoading == true || fruitDisease == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(fruitDiseases: fruitDisease),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      _FruitDiseaseDetails(fruitDiseases: fruitDisease),
                  childCount: 1))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        //child: const Icon(Icons.save_as_outlined),
        child: const Icon(
          Icons.save_as_rounded,
          color: Colors.green,
        ),
      ),
    );
  }
}

class _FruitDiseaseDetails extends StatelessWidget {
  final FruitDiseases fruitDiseases;
  const _FruitDiseaseDetails({required this.fruitDiseases});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: (size.width - 10) * 1,
                child: Column(children: [
                  _CustomListText(
                      title: 'Nombre Científico:',
                      subtitle: fruitDiseases.commonName),
                  _CustomListText(
                      title: 'Descripción:',
                      subtitle: fruitDiseases.description),
                  _CustomListText(
                      title: 'Sintomas:', subtitle: fruitDiseases.symptoms),
                  _CustomListText(
                      title: 'Control de la enfermedad:',
                      subtitle: fruitDiseases.management),
                  ...fruitDiseases.hostPlants.isEmpty
                      ? [] // No hay elementos en hostPlants, por lo que no se muestra ningún título.
                      : [
                          _CustomListText(
                            title: 'Plantas huésped:',
                            subtitle: fruitDiseases.hostPlants.join(
                                ", "), // Combina los elementos en una sola cadena
                          ),
                        ],
                  const SizedBox(height: 10),
                  _OrderedListView(
                      preventionMethods: fruitDiseases.preventionMethods),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: fruitDiseases.references.length,
                    itemBuilder: (BuildContext context, int index) {
                      final reference = fruitDiseases.references[index];
                      return ListTile(
                        leading: const Icon(Icons.link),
                        title: Text(reference['title'] ?? ''),
                        subtitle: Text(reference['url'] ?? ''),
                        onTap: () {
                          final url = reference['url'];
                          if (url != null) {
                            _launchUrl(url);
                          }
                        },
                      );
                    },
                  ),
                ]),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _launchUrl(url) async {
    final Uri url0 = Uri.parse('https://flutter.dev');
    if (!await launchUrl(url0)) {
      throw Exception('Could not launch $url');
    }
  }



}

class _OrderedListView extends StatelessWidget {
  final List<String> preventionMethods;

  const _OrderedListView({required this.preventionMethods});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Metodo de prevención:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20, // Tamaño medio
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: preventionMethods.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.check),
                title: Text(
                  preventionMethods[index],
                  style: TextStyle(fontSize: 18),
                ),
              );
            },
          ),
        ],
      ),
    );
  }


}

class _CustomListText extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const _CustomListText({this.title = "", this.subtitle = ""});

  @override
  Widget build(Object context) {
    return ListTile(
      title: Text(
        '$title',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20, // Tamaño medio
        ),
      ),
      subtitle: Text(
        '$subtitle',
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final FruitDiseases fruitDiseases;

  const _CustomSliverAppBar({required this.fruitDiseases});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.5,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          fruitDiseases.scientificName,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: fruitDiseases.imageUrl.isEmpty
                  ? Image.asset('assets/images/no-image.jpg', fit: BoxFit.cover)
                  : Image.network(fruitDiseases.imageUrl, fit: BoxFit.cover),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.5, 1.0],
                          colors: [Colors.transparent, Colors.black87]))),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(begin: Alignment.topLeft, stops: [
                0.0,
                0.4
              ], colors: [
                Colors.black87,
                Colors.transparent,
              ]))),
            )
          ],
        ),
      ),
    );
  }
}