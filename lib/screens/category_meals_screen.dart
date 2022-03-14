import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/meal_provider.dart';
import 'package:provider/provider.dart';
import '../modules/meal.dart';
import '../provider/language_provider.dart';
import '../widgets/meal_item.dart';

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

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    // :::::::::::::::::::::::MediaQuery:::::::::::::::::::
    bool isLandScap =
        MediaQuery.of(context).orientation == Orientation.landscape;
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
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            childAspectRatio: isLandScap ? 2.4 / 2 : 2.65 / 2,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0),
      ),
    );
  }
}
