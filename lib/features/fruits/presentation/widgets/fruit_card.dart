import 'package:flutter/material.dart';
import 'package:fruit_fungal_diseases/features/fruits/domain/entities/fruit_diseases.dart';
import 'package:go_router/go_router.dart';

class FruitCard extends StatelessWidget {
  final FruitDiseases fruitDiseases;

  const FruitCard({super.key, required this.fruitDiseases});

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;
    return Column(
      
      children: [
        SizedBox(height: 10),
        Container(
          width: 350, // Ancho de la tarjeta
          height: 250, // Alto de la tarjeta
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(7.0), // Bordes redondeados
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Color de la sombra
                spreadRadius: 5, // Radio de expansión de la sombra
                blurRadius: 7, // Radio de desenfoque de la sombra
                offset: Offset(0, 3), // Desplazamiento de la sombra
              )
            ],
            
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => context.push('/fruit/diseases/${fruitDiseases.id}'),
                child: fruitDiseases.imageUrl.isEmpty
              ? Image.asset('assets/images/no-image.jpg', width: 200, height: 200, fit: BoxFit.cover)
              : Image.network(fruitDiseases.imageUrl, width: 200, height: 220, fit: BoxFit.cover),
              
              ),
              const SizedBox(height: 5),
              Center(
                child: Text(
                  fruitDiseases.scientificName,
                  style: textStyles.titleMedium,
                ),
                
              ),


            ],
          ),
        ),
          
      ],
      
    );
  }
}



class _ImageViewer extends StatelessWidget {
  final String images;

  const _ImageViewer({
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    if(images.isEmpty){

    }
    return Placeholder();
  }
}
