import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/language_provider.dart';
import 'package:flutter_application_1/provider/meal_provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = 'detail-screen';

// ::::::::::::Build Title Function:::::::::::::
  Widget buildTitle(BuildContext ctx, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.purple,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 70, 19, 187)),
        borderRadius: BorderRadius.circular(10),
        // color: Colors.red,
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: 300,
      height: 150,
    );
  }

  @override
  Widget build(BuildContext context) {
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final lan = Provider.of<LanguageProvider>(context);
    List<String> ingredientList =
        lan.getTexts('ingredients-$mealId') as List<String>;
    List<String> stepsList = lan.getTexts('steps-$mealId') as List<String>;
    final mealSelected = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    var accentColor =  Theme.of(context).colorScheme.secondary;

    var liSteps = ListView.builder(
      padding: const EdgeInsets.all(0),
      itemBuilder: (ctx, item) => Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Text('# ${item + 1}',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
            ),
            title: Text(
              stepsList[item],
              style: const TextStyle(color: Colors.black),
            ),
          ),
          const Divider(),
        ],
      ),
      itemCount: stepsList.length,
    );
    var liIngredients = ListView.builder(
      padding: const EdgeInsets.all(0),
      itemBuilder: (ctx, item) => Card(
        color: accentColor,
        child: Text(ingredientList[item],
            style: TextStyle(
                color: useWhiteForeground(accentColor)
                    ? const Color.fromARGB(255, 155, 13, 13)
                    : Colors.black)),
      ),
      itemCount: ingredientList.length,
    );

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight:300 ,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  title: Text(lan.getTexts('meal-$mealId').toString()),
                  background:Hero(
                        tag: mealId,
                        child: InteractiveViewer(
                          child: FadeInImage(
                            placeholder: const AssetImage('assets/images/restaurant.png'),
                            image:NetworkImage(mealSelected.imageUrl),
                            fit: BoxFit.cover
                                ),
                          ),
                        ) ,
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              if (isLandScape)
                Row(
                  children: [
                    Column(
                      children: [
                        Column(
                          children: [
                            buildTitle(context,
                                lan.getTexts('Ingredients').toString()),
                            buildContainer(liIngredients),
                          ],
                        ),
                        Column(
                          children: [
                            buildTitle(
                                context, lan.getTexts('Steps').toString()),
                            buildContainer(liSteps),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              if (!isLandScape)
                buildTitle(context, lan.getTexts('Ingredients').toString()),
              if (!isLandScape) buildContainer(liIngredients),
              if (!isLandScape)
                buildTitle(context, lan.getTexts('Steps').toString()),
              if (!isLandScape) buildContainer(liSteps),
              //  const SizedBox(height:700),
            ]))
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<MealProvider>(context, listen: false)
            .toogleFavorite(mealId),
        child: Provider.of<MealProvider>(context, listen: true)
                .isMealFavorite(mealId)
            ? const Icon(Icons.star)
            : const Icon(Icons.star_border),
      ),
      ),
    );
    
  }
}
