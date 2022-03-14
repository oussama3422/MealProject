import 'package:flutter/material.dart';
import '../provider/language_provider.dart';
import '../provider/meal_provider.dart';
import '../provider/theme_provider.dart';
import '../screens/category_screen.dart';
import '../screens/favourite_screen.dart';
import 'package:provider/provider.dart';

import '../widgets/drawer.dart';

class TabScreen extends StatefulWidget {
  static const routeName = 'tab-screen';

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedPageIndex = 0;
  late final List<Map<String, dynamic>> pages;

  @override
  void initState() {
    Provider.of<MealProvider>(context, listen: false).setData();
    Provider.of<ThemeProvider>(context, listen: false).getThemeMode();
    Provider.of<ThemeProvider>(context, listen: false).getThemeColors();
    Provider.of<LanguageProvider>(context, listen: false).getLan();
    pages = [
      {
        'page': const CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoriteScreen(),
        'title': 'Your Favorites',
      }
    ];
    super.initState();
  }

  void _selectPage(int value) {
    setState(() {
      _selectedPageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    return Directionality(
      textDirection: lan.isEn? TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lan.getTexts('categories').toString()),
        ),
        body: pages[_selectedPageIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
            onTap: _selectPage,
            backgroundColor:Theme.of(context).colorScheme.primary,
            selectedItemColor:Theme.of(context).colorScheme.secondary,
            unselectedItemColor: Colors.white,
            currentIndex: _selectedPageIndex,
            items:  
            [
              BottomNavigationBarItem(
                icon: const Icon(Icons.category),
                label: lan.getTexts('categories').toString(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.star),
                label: lan.getTexts('your_favorites').toString(),
              ),
            ],
            ),
        drawer: const Mydrawer(),
      ),
    );
  }
}
