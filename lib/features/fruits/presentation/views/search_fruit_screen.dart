import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/providers/search/search_diseases_provider.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/widgets/fruit_card.dart';
import 'package:fruit_fungal_diseases/features/shared/widgets/custom_filled_button.dart';
import 'package:fruit_fungal_diseases/features/shared/widgets/custom_text_search_field.dart';

enum Fruit { manzana, pera, guanabana, mandarina }

class SearchAndCheckboxWidgetState extends ConsumerWidget {
  const SearchAndCheckboxWidgetState({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchFruitDesease = ref.watch(searchFruitDiseasesFormProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Busqueda de enfermedad'),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            const SizedBox(height: 20),
            CustomTextSearchField(
              label: 'Busqueda Avanzada de enfermedades',
              keyboardType: TextInputType.multiline,
              errorMessage: searchFruitDesease.isFormPosted
                  ? searchFruitDesease.search.errorMessage
                  : null,
              onChanged: (value) {
                   ref
                    .read(searchFruitDiseasesFormProvider.notifier)
                    .onSearchChanged(value);
              
              },
            ),
            const SizedBox(
              height: 20,
            ),
    
            //Cambiarlo...
            _SelectedFruit(
              selectedFruit: searchFruitDesease.fruit,
            ),
    
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  
                  child: CustomFilledButton(
                      text: const Text('Buscar'),
                      buttonColor: Colors.green,
    
                      onPressed: searchFruitDesease.isPosting || searchFruitDesease.search.value.isEmpty? null : ref
                          .read(searchFruitDiseasesFormProvider.notifier)
                          .onFormSubmit)),
            ),
    
            SizedBox(height: 12),
    
            searchFruitDesease.isData==false?
            Container(
            padding: const  EdgeInsets.all(16.0),
            
            child: const Text(
              'No se encontró información relacionada',
              style: TextStyle(
                fontSize: 16.0, // Puedes ajustar el tamaño del texto según tus preferencias
                fontWeight: FontWeight.bold, // Puedes ajustar el estilo del texto según tus preferencias
              ),
            ),
    )
            :
    
           Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 10,
                  itemCount: searchFruitDesease.diseasesFruit.length,
                  itemBuilder: (context, index) {
                    return FruitCard(
                        fruitDiseases: searchFruitDesease.diseasesFruit[index]);
                  },
                ),
              ),
            ),
          ])),
    );

  }
}

class _SelectedFruit extends ConsumerWidget {
  final String selectedFruit;
  final List<String> fruits = const ['Limon', 'Naranja', 'Mandarina', 'Toronja'];

  const _SelectedFruit({required this.selectedFruit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: SegmentedButton(
        emptySelectionAllowed: false,
        multiSelectionEnabled: false,
        showSelectedIcon: false,
        style: const ButtonStyle(visualDensity: VisualDensity.compact),
        segments: fruits.map((size) {
          return ButtonSegment(
              value: size,
              label: Text(size, style: const TextStyle(fontSize: 12)));
        }).toList(),
        selected: {selectedFruit},
        onSelectionChanged: (newSelection) {
          ref
              .read(searchFruitDiseasesFormProvider.notifier)
              .onSelectedFruitChanged(newSelection.first);
        },
      ),
    );
  }
}
