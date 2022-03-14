import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/category.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dummy_data.dart';
import '../modules/meal.dart';

class MealProvider with ChangeNotifier {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  //::::::::::::::::This is For Available Meal::::::::::::::::::
  List<Meal> availableMeals = DUMMY_MEALS;
  // ::::::::::::::::This is For Fqavourite Meal::::::::::::::::::
  List<Meal> favoriteMeals = [];

  List<Category> availableCategory = DUMMY_CATEGORIES;

  void setfilter() async {
    // filters = filterData;
    availableMeals = DUMMY_MEALS.where((meal) {
      if (filters['gluten']! && !meal.isGlutenFree) {
        return false;
      }
      if (filters['lactose']! && !meal.isLactoseFree) {
        return false;
      }
      if (filters['vegan']! && !meal.isVegan) {
        return false;
      }
      if (filters['vegetarian']! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    List<Category> ac = [];
    availableMeals.forEach((meal) {
      meal.categories.forEach((categoryId) {
        DUMMY_CATEGORIES.forEach((category) {
          if (category.id == categoryId) {
            if (!ac.any((cat) => cat.id == categoryId)) {
              ac.add(category);
            }
          }
        });
      });
    });
    availableCategory = ac;

    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("gluten", filters['gluten']!);
    prefs.setBool("lactose", filters['lactose']!);
    prefs.setBool("vegan", filters['vegan']!);
    prefs.setBool("vegetarian", filters['vegetarian']!);
  }

  List<String> prefsMealId = [];
  void setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filters['gluten'] = prefs.getBool("gluten") ?? false;
    filters['lactose'] = prefs.getBool("lactose") ?? false;
    filters['vegan'] = prefs.getBool("vegan") ?? false;
    filters['vegetarian'] = prefs.getBool("vegetarian") ?? false;

    prefsMealId = prefs.getStringList("prefMealId") ?? [];
    for (var mealId in prefsMealId) {
      final existingIndex =
          favoriteMeals.indexWhere((meal) => meal.id == mealId);
      if (existingIndex < 0) {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      } else {
        return;
      }
    }
    List<Meal> fvM = [];
    favoriteMeals.forEach((favemeal) {
      availableMeals.forEach((availblemeal) {
        if (favemeal.id == availblemeal.id) fvM.add(favemeal);
      });
    });
    favoriteMeals = fvM;
    notifyListeners();
  }

  void toogleFavorite(String mealId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      favoriteMeals.removeAt(existingIndex);
      prefsMealId.remove(mealId);
    } else {
      favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      prefsMealId.add(mealId);
    }

    notifyListeners();

    prefs.setStringList("prefMealId", prefsMealId);
  }

  bool isMealFavorite(String id) {
    return favoriteMeals.any((meal) => meal.id == id);
  }
}
