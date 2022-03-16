import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/meal_provider.dart';
import 'package:provider/provider.dart';
import '../modules/meal.dart';
import '../provider/language_provider.dart';
import '../widgets/meal_item.dart';
import 'dart:io';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = 'category-meals';

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  List<Meal>? displayedMeal;
  String? categoryId;

  void removeMeal(String mealId) {
    setState(() {
      displayedMeal!.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  void didChangeDependencies() {
    final List<Meal> availableMeals =
        Provider.of<MealProvider>(context, listen: false).availableMeals;

    final routeArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    categoryId = routeArg['id'];
    // categoryTitle = routeArg['title'];
    displayedMeal = availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }
  
  var platform = Platform.isWindows;
 
  // ignore: non_constant_identifier_names
  SliverGridDelegateWithMaxCrossAxisExtent SliverGridDelegate() {
    return  Platform.isWindows
        ? const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 600,
            childAspectRatio: 2.6 / 2.8,
            crossAxisSpacing: 200,
            mainAxisSpacing: 40)
        : const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio:  2.2 / 2.2,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0
            );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    // :::::::::::::::::::::::MediaQuery:::::::::::::::::::
   
    //:::::::::::::::::::Build Scaffold:::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    return Scaffold(
      appBar: AppBar(
        title: Text(lan.getTexts('cat-$categoryId').toString()),
      ),
      body: GridView.builder(
        itemBuilder: (ctx, item) {
          return MealItem(
            id: displayedMeal![item].id,
            imgurl: displayedMeal![item].imageUrl,
            title: displayedMeal![item].title,
            complexity: displayedMeal![item].complexity,
            duration: displayedMeal![item].duration,
            affordability: displayedMeal![item].affordability,
          );
        },
        itemCount: displayedMeal!.length,
        gridDelegate: SliverGridDelegate(),
      ),
    );
  }
}
