import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/on_boarding_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/language_provider.dart';
import '../screens/on_boarding_screen.dart';
import 'package:flutter_application_1/screens/theme_screen.dart';
import '../provider/theme_provider.dart';
import '../screens/filter_screen.dart';
import '../screens/meal_details_screen.dart';
import '../screens/tab_screen.dart';
import 'package:provider/provider.dart';
import '../screens/category_meals_screen.dart';
import 'provider/meal_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MealProvider>(
          create: (ctx) => MealProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (ctx) => ThemeProvider(),
        ),
        ChangeNotifierProvider<LanguageProvider>(
          create: (ctx) => LanguageProvider(),
        ),
        ChangeNotifierProvider<OnBoardingProvider>(
          create: (ctx) => OnBoardingProvider(),
        )
      ],
      child:MyApp(prefs) ,
    ),
  );
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
   MyApp(this.prefs);
  @override
  Widget build(BuildContext context) {
    var primaryColor =
        Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    var accentColor =
        Provider.of<ThemeProvider>(context, listen: true).accentColor;
    var tm = Provider.of<ThemeProvider>(context, listen: true).tm;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: tm,
      theme: ThemeData(
          cardColor: Colors.white,
          splashColor: Colors.black45,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor).copyWith(secondary: accentColor),
          buttonTheme: const ButtonThemeData(buttonColor: Colors.black45),
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          shadowColor: const Color.fromARGB(153, 90, 84, 84),
          textTheme: ThemeData.dark().textTheme.copyWith(
                bodyText1: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline6: const TextStyle(
                  fontFamily: 'RobotoCondensed',
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
      darkTheme: ThemeData(
        cardColor: const Color.fromRGBO(35, 34, 39, 1),
        canvasColor: const Color.fromRGBO(14, 22, 33, 1),
        splashColor:  Colors.white70,
        fontFamily: 'Raleway',
        buttonTheme: const ButtonThemeData(buttonColor: Colors.white70),
        shadowColor: Colors.grey,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor).copyWith(secondary: accentColor),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromARGB(255, 18, 5, 202),
              ),
              headline6: const TextStyle(
                fontFamily: 'RobotoCondensed',
                color: Color.fromARGB(251, 0, 0, 0),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ), 
            
        // colorScheme: ColorScheme(
        //   brightness: Brightness.dark,
        //   primary: Colors.pink,
        //   onPrimary: const Color.fromARGB(255, 95, 180, 15),
        //   secondary: accentColor,
        //   onSecondary: accentColor,
        //   error: Colors.red,
        //   onError: const Color.fromARGB(255, 52, 226, 8),
        //   background: Colors.orangeAccent,
        //   onBackground: Colors.blueGrey,
        //   surface: Colors.cyan,
        //   onSurface: Colors.blueGrey,
        // ),
      ),
      home:  (prefs.getBool('watched') ?? false) ? TabScreen() : OnBoardingScreen(),
      // home: OnBoardingScreen(),
      routes: {
        // '/':(ctx)=>homescreen,
        // OnBoardingScreen.routeName:(context)=> OnBoardingScreen(),
        FilterScreen.routeName: (context) => const FilterScreen(),
        TabScreen.routeName: (context) => TabScreen(),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(),
        MealDetailScreen.routeName: (context) => MealDetailScreen(),
        ThemeScreen.routeName: (context) => const ThemeScreen(),
      },
    );
  }
}
