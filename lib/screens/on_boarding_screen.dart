import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/on_boarding_provider.dart';
import 'package:flutter_application_1/screens/tab_screen.dart';
import 'package:flutter_application_1/screens/theme_screen.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/language_provider.dart';
import 'package:provider/provider.dart';

import 'filter_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  static const routeName = 'boarding-screen';
  bool? fromOnBoarding;
 

  @override
  Widget build(BuildContext context) {
    var bording = Provider.of<OnBoardingProvider>(context);
    var lan = Provider.of<LanguageProvider>(context);
    return Scaffold(
        body: Stack(
          children: [
           PageView(
               children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage("assets/images/amir.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  color: const Color.fromARGB(255, 102, 98, 98),
                  alignment: Alignment.center,
                  width: 350,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Text(
                    lan.getTexts('drawer_name').toString(),
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Container(
                  color: const Color.fromARGB(255, 102, 98, 98),
                  width: 350,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            lan.getTexts('drawer_switch_title').toString(),
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: lan.isEn ? 24 : 40,
                              fontFamily: 'RobotoCondensed',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.language_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            lan.getTexts('drawer_switch_item2').toString(),
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18,
                              fontFamily: 'RobotoCondensed',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Switch(
                              inactiveThumbColor: Theme.of(context).colorScheme.secondary,
                              value: Provider.of<LanguageProvider>(context,
                                      listen: true)
                                  .isEn,
                              onChanged: (value) {
                                Provider.of<LanguageProvider>(context,
                                        listen: false)
                                    .changeLan(value);
                              }),
                          Text(
                            lan.getTexts('drawer_switch_item1').toString(),
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18,
                              fontFamily: 'RobotoCondensed',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const ThemeScreen(fromOnBoarding: true),
          const FilterScreen(fromOnBoarding: true),
        ],
        onPageChanged: (val) {
          bording.skippages(val);
        },
      ),
      Indicator(bording.index),
      Builder(
        builder: (ctx) => Align(
          alignment: const Alignment(0, 0.90),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              child: Text(
                lan.getTexts('start').toString(),
                style: TextStyle(
                  color: useWhiteForeground(Theme.of(ctx).primaryColor)
                      ? Colors.white
                      : Colors.black,
                  fontSize: 25,
                ),
              ),
              onPressed: () async {
                Navigator.of(ctx).pushReplacementNamed(TabScreen.routeName);
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('watched', true);
              },
              style: ButtonStyle(
                padding:MaterialStateProperty.all(lan.isEn?const EdgeInsets.all(7):const EdgeInsets.all(0)),
                backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)
                
              ),
            ),
          ),
        ),
      )
    ]));
  }
}

class Indicator extends StatelessWidget {
  final int index;
  Indicator(this.index);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        buildContainer(context, 0),
        buildContainer(context, 1),
        buildContainer(context, 2),
      ]),
    );
  }

  buildContainer(BuildContext ctx, int i) {
    return index == i
        ? Icon(Icons.star, color: Theme.of(ctx).splashColor)
        : Container(
            margin: const EdgeInsets.all(4),
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              color: Theme.of(ctx).primaryColor,
              shape: BoxShape.circle,
            ),
          );
  }
}
