import 'package:flutter/material.dart';
import '../provider/language_provider.dart';
import '../screens/tab_screen.dart';
import '../screens/theme_screen.dart';
import 'package:provider/provider.dart';
import '../screens/filter_screen.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({Key? key}) : super(key: key);

  buildListtile(String title, IconData icon, Function func) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () => func,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).colorScheme.secondary,
              height: 120,
              width: 400,
              padding: const EdgeInsets.all(20),
              alignment:
                  lan.isEn ? Alignment.centerLeft : Alignment.centerRight,
              child: Text(
                lan.getTexts('drawer_name').toString(),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 22),
            ListTile(
              leading: Icon(
                Icons.restaurant,
                color: Theme.of(context).splashColor,
              ),
              title: Text(
                lan.getTexts('drawer_item1').toString(),
                style: TextStyle(
                  color: Theme.of(context).splashColor,
                  fontSize: 24,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(TabScreen.routeName),
            ),
            ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Theme.of(context).splashColor,
                ),
                title: Text(
                  lan.getTexts('drawer_item2').toString(),
                  style: TextStyle(
                    color: Theme.of(context).splashColor,
                    fontSize: 24,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(FilterScreen.routeName);
                }),
            ListTile(
                leading: Icon(
                  Icons.color_lens_outlined,
                  color: Theme.of(context).splashColor,
                ),
                title: Text(
                  lan.getTexts('drawer_item3').toString(),
                  style: TextStyle(
                    color: Theme.of(context).splashColor,
                    fontSize: 24,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(ThemeScreen.routeName);
                }),
            Divider(color: Theme.of(context).primaryColor, height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.language_outlined,
                  color: Theme.of(context).splashColor,
                ),
                const SizedBox(width: 8),
                Text(
                  lan.getTexts('drawer_switch_title').toString(),
                  style: TextStyle(
                    color: Theme.of(context).splashColor,
                    fontSize: lan.isEn ? 24 : 40,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: lan.isEn ? 0 : 20, left: lan.isEn ? 20 : 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    lan.getTexts('drawer_switch_item2').toString(),
                    style: TextStyle(
                      color: Theme.of(context).splashColor,
                      fontSize: 18,
                      fontFamily: 'RobotoCondensed',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Switch(
                      inactiveThumbColor:
                          Theme.of(context).colorScheme.secondary,
                      value:
                          Provider.of<LanguageProvider>(context, listen: true)
                              .isEn,
                      onChanged: (value) {
                        Provider.of<LanguageProvider>(context, listen: false)
                            .changeLan(value);
                        // Navigator.of(context).pop();
                      }),
                  Text(
                    lan.getTexts('drawer_switch_item1').toString(),
                    style: TextStyle(
                      color: Theme.of(context).splashColor,
                      fontSize: 18,
                      fontFamily: 'RobotoCondensed',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Theme.of(context).primaryColor, height: 20),
          ],
        ),
      ),
    );
  }
}
