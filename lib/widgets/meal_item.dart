import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/language_provider.dart';
import '../modules/meal.dart';
import '../screens/meal_details_screen.dart';
import 'package:provider/provider.dart';

class MealItem extends StatelessWidget {
  MealItem({
    required this.id,
    required this.imgurl,
    required this.title,
    required this.complexity,
    required this.duration,
    required this.affordability,
  });
  final String id;
  final String imgurl;
  final String title;
  final Complexity complexity;
  final int duration;
  final Affordability affordability;
  get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
      case Complexity.Challenging:
        return 'Challenging';
      case Complexity.Hard:
        return 'Hard';
      default:
        return 'UnKnow';
    }
  }

  get affordabilityPrice {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
      case Affordability.Luxurious:
        return 'Lexurious';
      case Affordability.Pricey:
        return 'Pricey';
    }
  }

  void selectMeal(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      MealDetailScreen.routeName,
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    return GestureDetector(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(11),
        child: Column(
          children: [
            Stack(children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: (Radius.circular(8)),
                  topRight: (Radius.circular(8)),
                ),
                child: Hero(
                  tag: id,
                  child: InteractiveViewer(
                    child: FadeInImage(
                      placeholder:const AssetImage('assets/images/err.png') ,
                      image: NetworkImage(
                        imgurl,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if(lan.isEn)
                  Row(
                    children: [
                      Icon(
                        Icons.timer,
                        color: Theme.of(context).textTheme.headline6!.color,
                      ),
                      const SizedBox(width: 8),
                      if(duration<=10)
                      Text( 
                         "$duration"+ lan.getTexts('min2').toString(),
                          style: const TextStyle(
                            color: Colors.purple,
                            fontSize: 13,
                            fontWeight: FontWeight.bold
                            ),
                         ),
                      if(duration>10)
                      Text(
                        "$duration "+lan.getTexts("min").toString(),
                         style: const TextStyle(
                            color: Colors.purple,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  if(!lan.isEn)
                      Row(
                    children: [
                       if(duration<=10)
                      if(lan.isEn)
                      Text( 
                         "$duration "+lan.getTexts("min2").toString(),
                         style: const TextStyle(
                            color: Colors.purple,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                         ),
                      if(duration>10)
                      Text(
                        lan.getTexts("min").toString()+"$duration ",
                        style: const TextStyle(
                            color: Colors.purple,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                            ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.timer,
                        color: Theme.of(context).textTheme.headline6!.color,
                      ),
                     
                    ],
                  ),
                  if(lan.isEn)
                  Row(
                    children: [
                      Icon(Icons.shopping_bag,
                          color: Theme.of(context).textTheme.headline6!.color),
                      const SizedBox(width: 8),
                      Text(
                         lan.getTexts('$complexity').toString(),
                        style: const TextStyle(
                            color: Colors.purple,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  if(!lan.isEn)
                  Row(
                    children: [
                      Text(
                         lan.getTexts('$complexity').toString(),
                        style: const TextStyle(
                            color: Colors.purple,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.shopping_bag,
                          color: Theme.of(context).textTheme.headline6!.color),
                    ],
                  ),
                  if(lan.isEn)
                  Row(
                    children: [
                    Icon(Icons.attach_money_sharp,
                        color: Theme.of(context).textTheme.headline6!.color),
                    const SizedBox(width: 8),
                    Text(
                       lan.getTexts('$affordability').toString(),
                      style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ]
                  ),
                  if(!lan.isEn)
                   Row( 
                    children: [
                    Text(
                       lan.getTexts('$affordability').toString(),
                      style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.attach_money_sharp,
                        color: Theme.of(context).textTheme.headline6!.color),
                  ]
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
