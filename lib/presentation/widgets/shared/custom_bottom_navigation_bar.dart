import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int pageIndex;
  const CustomBottomNavigationBar({super.key, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    return BottomNavigationBar(
        elevation: 0,
        onTap: (value) => onTabTapped(context, value),
        currentIndex: pageIndex,
        selectedItemColor: themeColors.primary,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_outline_rounded), label: 'Populares'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined), label: 'Favoritos'),
        ]);
  }

  void onTabTapped(BuildContext context, int index) {
    context.go('/home/$index');
  }
}
