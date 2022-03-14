import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/language_provider.dart';
import '../provider/meal_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = 'filter-screen';
  // final Function setfilters;
  final bool fromOnBoarding;

  const FilterScreen({Key? key, this.fromOnBoarding=false}) : super(key: key);
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool glutenFree = false;
  bool lactoseFree = false;
  bool vegan = false;
  bool vegetarian = false;
  // @override
  // void initState() {
  //   final  Map<String, bool> currentfilters = Provider.of<MealProvider>(context, listen: false).setfilter as Map<String, bool>;
  //   glutenFree = currentfilters['gluten']!;
  //   lactoseFree = currentfilters['lactose']!;
  //   vegan = currentfilters['vegan']!;
  //   vegetarian = currentfilters['vegetarian']!;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    final Map<String, bool> currentfilters =
        Provider.of<MealProvider>(context, listen: true).filters;
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              title: widget.fromOnBoarding?null:Text(lan.getTexts('drawer_item2').toString()),
              backgroundColor: widget.fromOnBoarding?Theme.of(context).canvasColor:Theme.of(context).primaryColor,
            ),
            SliverList(delegate: SliverChildListDelegate([
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(8),
                child: Text(
                  lan.getTexts('filters_screen_title').toString(),
                  style: Theme.of(context).textTheme.headline6,textAlign: TextAlign.center,
                ),
              ),
            
                    SwitchListTile(
                        title: Text(
                          lan.getTexts('Gluten-free').toString(),
                          style: TextStyle(
                              color:  Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Raleway'),
                        ),
                        subtitle: Text(
                          lan.getTexts('Gluten-free-sub').toString(),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        value: currentfilters['gluten']!,
                        inactiveTrackColor: Colors.black,
                        onChanged: (changeVal) {
                          setState(() {
                            currentfilters['gluten'] = changeVal;
                          });
                          Provider.of<MealProvider>(context, listen: false)
                              .setfilter();
                        }),
                    SwitchListTile(
                        title: Text(
                          lan.getTexts('Lactose-free').toString(),
                          style: TextStyle(
                            color:  Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        subtitle: Text(
                          lan.getTexts('Lactose-free_sub').toString(),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        value: currentfilters['lactose']!,
                        inactiveTrackColor: Colors.black,
                        onChanged: (changeVal) {
                          setState(() {
                            currentfilters['lactose'] = changeVal;
                          });
                          Provider.of<MealProvider>(context, listen: false)
                              .setfilter();
                        }),
                    SwitchListTile(
                        title: Text(
                          lan.getTexts('Vegan').toString(),
                          style: TextStyle(
                            color:  Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        subtitle: Text(
                          lan.getTexts('Vegan-sub').toString(),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        value: currentfilters['vegan']!,
                        inactiveTrackColor: Colors.black,
                        onChanged: (changeVal) {
                          setState(() {
                            currentfilters['vegan'] = changeVal;
                          });
                          Provider.of<MealProvider>(context, listen: false)
                              .setfilter();
                        }),
                    SwitchListTile(
                        title: Text(
                          lan.getTexts('Vegetarian').toString(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        subtitle: Text(
                          lan.getTexts('Vegetarian-sub').toString(),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        value: currentfilters['vegetarian']!,
                        inactiveTrackColor: Colors.black,
                        onChanged: (changeVal) {
                          setState(() {
                            currentfilters['vegetarian'] = changeVal;
                          });
                          Provider.of<MealProvider>(context, listen: false)
                              .setfilter();
                        }),
                        SizedBox(height: widget.fromOnBoarding?80:0,)
              //  const SizedBox(height:700),
            ],
            ),
          ),
          ]
        ),
        drawer: widget.fromOnBoarding?null:const Mydrawer(),
      ),
    );
  }
}
