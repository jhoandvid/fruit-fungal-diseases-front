import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruit_fungal_diseases/features/auth/presentation/providers/auth_provider.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/screen/home_screen.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/views/favorite_fruit_diseases.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/views/qualificationFruitScreen.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/views/search_fruit_screen.dart';
import 'package:fruit_fungal_diseases/features/shared/widgets/custom_filled_button.dart';
import 'package:go_router/go_router.dart';

class SideMenu extends ConsumerStatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({super.key, required this.scaffoldKey});

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends ConsumerState<SideMenu> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final textStyles = Theme.of(context).textTheme;

    return NavigationDrawer(
        elevation: 1,
        selectedIndex: navDrawerIndex,
        onDestinationSelected: (value) {
          setState(() {
            navDrawerIndex = value;
          });

          // final menuItem = appMenuItems[value];
          // context.push( menuItem.link );
          widget.scaffoldKey.currentState?.closeDrawer();
        },
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, hasNotch ? 0 : 20, 16, 0),
            child: Text('Saludos', style: textStyles.titleMedium),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 16, 10),
            child: Text('${ref.read(authProvider).user?.name}',
                style: textStyles.titleSmall),
          ),

          const NavigationDrawerDestination(
            icon: Icon(Icons.home_outlined),
            label: Text('Menu Principal'),
          ),

          Padding(padding: EdgeInsets.symmetric(horizontal: 12), child:  ListTile(
            onTap: () {
              // Navegar a la segunda ventana
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchAndCheckboxWidgetState(),
                ),
              );
            },
            leading: const Icon(Icons.search_outlined),
            title: const Text('Busqueda IA'),
          ),),
          
          Padding(padding: const  EdgeInsets.symmetric(horizontal: 12), child:  ListTile(
            onTap: () {
              // Navegar a la segunda ventana
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  const FavoriteFruitDiseasesScreen(),
                ),
              );
            },
            leading: const Icon(Icons.favorite_border_outlined),
            title: const Text('Enfermedades Agregadas'),
          ),),

           Padding(padding: const  EdgeInsets.symmetric(horizontal: 12), child:  ListTile(
            onTap: () {
              // Navegar a la segunda ventana
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  const QualificationFruitScreen(),
                ),
              );
            },
            leading: const Icon(Icons.star_border_outlined),
            title: const Text('Calificar Aplicaciòn'),
          ),),
         
          
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomFilledButton(
                onPressed: () {
                  ref.read(authProvider.notifier).logout();
                },
                text: Text('Cerrar sesión')),
          ),
        ]);
  }
}
