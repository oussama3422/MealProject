import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import '../modules/meal.dart';
import '../provider/language_provider.dart';
import 'package:provider/provider.dart';

import '../provider/meal_provider.dart';
import '../widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var devicewidth = MediaQuery.of(context).size.width;
    var lan = Provider.of<LanguageProvider>(context);
    final List<Meal> favoriteMeals =
        Provider.of<MealProvider>(context, listen: false).favoriteMeals;
    return favoriteMeals.isEmpty
        ?  Center(
            child: Text(
              lan.getTexts('favorites_text').toString(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold,fontSize: 20,
              ),
              softWrap:true ,
              overflow: TextOverflow.ellipsis,
              ),
          )
        : GridView.builder(
            itemBuilder: (ctx, item) {
              return MealItem(
                id: favoriteMeals[item].id,
                imgurl: favoriteMeals[item].imageUrl,
                title: favoriteMeals[item].title,
                complexity: favoriteMeals[item].complexity,
                duration: favoriteMeals[item].duration,
                affordability: favoriteMeals[item].affordability,
              );
            },
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: devicewidth <= 400 ? 400 : 500,
              childAspectRatio: isLandScape ? 4 / 2 : 2.65 / 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
            ),
            itemCount: favoriteMeals.length,
          );
  }
}
