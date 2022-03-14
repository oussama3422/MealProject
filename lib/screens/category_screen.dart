import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/language_provider.dart';
import '../dummy_data.dart';
import '../provider/meal_provider.dart';
import '../widgets/category_item.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(25),
        children: Provider.of<MealProvider>(context)
            .availableCategory
            .map(
              (catData) => CategoryItem(
                catData.id,
                catData.color,
                catData.title,
              ),
            )
            .toList(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 30,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}
