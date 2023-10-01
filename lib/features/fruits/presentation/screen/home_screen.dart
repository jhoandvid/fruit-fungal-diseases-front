import 'package:flutter/material.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/views/favorite_fruit_diseases.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/views/fruit_diseases_views.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/views/search_fruit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    
     final screens = [const FruitDiseasesViews(),  const SearchAndCheckboxWidgetState(), const FavoriteFruitDiseasesScreen()];

    return Scaffold(
       body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),

      bottomNavigationBar: BottomNavigationBar(
      currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined), label: 'Buscar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline), label: 'Favoritos'),
        ]),
    );
  }
}
