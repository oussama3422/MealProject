import 'package:flutter/material.dart';
import '../provider/language_provider.dart';
import '../screens/category_meals_screen.dart';
import 'package:provider/provider.dart';


class CategoryItem extends StatelessWidget {
  CategoryItem(this.id, this.color, this.title);
  final String id;
  final Color color;
  final String title;
  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoryMealsScreen.routeName,
      arguments:{
        'id':id,
        },
      
      );
  }

  @override
  Widget build(BuildContext context) {
    var lan=Provider.of<LanguageProvider>(context);
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          // lan.getTexts(title).toString(),
          lan.getTexts('cat-$id').toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
            fontSize: 22,
          ),
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
