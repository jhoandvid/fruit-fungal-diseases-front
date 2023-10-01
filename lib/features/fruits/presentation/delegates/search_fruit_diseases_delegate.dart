import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fruit_fungal_diseases/features/fruits/domain/entities/fruit_diseases.dart';

typedef SearchFruitDiseasesCallback = Future<List<FruitDiseases>> Function(
    String query);

class SearchFruitDiseasesDelegate extends SearchDelegate<FruitDiseases?> {
  final SearchFruitDiseasesCallback searchFruitDiseases;

  StreamController<List<FruitDiseases>> debounceFruitsDiseases =
      StreamController.broadcast();

  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debounceTimer;

  SearchFruitDiseasesDelegate({required this.searchFruitDiseases});

  void clearStreams() {
    debounceFruitsDiseases.close();
  }

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        debounceFruitsDiseases.add([]);
        return;
      }
      final fruitDiseases = await searchFruitDiseases(query);
      debounceFruitsDiseases.add(fruitDiseases);
      isLoadingStream.add(false);
    });
  }

  @override
  String get searchFieldLabel => 'Buscar Enfermedad';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
                spins: 10,
                duration: const Duration(seconds: 20),
                infinite: true,
                child: IconButton(
                    onPressed: () => query = '',
                    icon: const Icon(Icons.refresh_rounded)));
          }

          return FadeIn(
              animate: query.isNotEmpty,
              child: IconButton(
                  onPressed: () => query = '', icon: const Icon(Icons.clear)));
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
        stream: debounceFruitsDiseases.stream,
        builder: (context, snapshot) {

          _onQueryChanged(query);

          final fruitsDiseases = snapshot.data ?? [];
          return ListView.builder(
            itemCount: fruitsDiseases.length,
            itemBuilder: (context, index) {
              final fruitDisiases = fruitsDiseases[index];
              return _FruitDiseases(
                  fruitDisiases: fruitDisiases,
                  onMovieSelected: (context, fruitDisiases) {
                    clearStreams();
                    close(context, fruitDisiases);
                    
                  });
            },
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return StreamBuilder(
        stream: debounceFruitsDiseases.stream,
        //future: searchFruitDiseases(query),
        builder: (context, snapshot) {
          final fruitsDiseases = snapshot.data ?? [];

          return ListView.builder(
            itemCount: fruitsDiseases.length,
            itemBuilder: (context, index) {
              final fruitDisiases = fruitsDiseases[index];
              return _FruitDiseases(
                  fruitDisiases: fruitDisiases,
                  onMovieSelected: (context, fruitDisiases) {
                    clearStreams();
                    close(context, fruitDisiases);
                  });
            },
          );
        });
  }
}

class _FruitDiseases extends StatelessWidget {
  final FruitDiseases fruitDisiases;
  final Function onMovieSelected;

  const _FruitDiseases(
      {required this.fruitDisiases, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
      
       onMovieSelected(context, fruitDisiases);
        //navegar
        
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
          
      
            SizedBox(
              width: size.width * 0.23,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: fruitDisiases.imageUrl.isNotEmpty
                      ? Image.network(fruitDisiases.imageUrl,
                          loadingBuilder: (context, child, loadingProgress) =>
                              FadeIn(child: child))
                      : Image.asset('assets/images/no-image.jpg')),
            ),

            const SizedBox(width: 10),

            //Descripción
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fruitDisiases.scientificName,
                    style: textStyles.titleMedium,
                  ),
                  fruitDisiases.description.length > 100
                      ? Text(
                          '${fruitDisiases.description.substring(0, 100)}...')
                      : Text(fruitDisiases.description)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
