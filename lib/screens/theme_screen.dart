import 'package:flutter/material.dart';
import '../provider/language_provider.dart';
import '../provider/theme_provider.dart';
import '../widgets/drawer.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({Key? key, this.fromOnBoarding=false}) : super(key: key);
  static const routeName = 'theme';
  final bool fromOnBoarding;

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar:fromOnBoarding? AppBar(backgroundColor: Theme.of(context).canvasColor,elevation: 0,):AppBar(
          title: Text(lan.getTexts('theme_appBar_title').toString()),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                lan.getTexts('theme_screen_title').toString(),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    lan.getTexts('theme_mode_title').toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                buildRadioListTile(
                    ThemeMode.system,
                    lan.getTexts('System_default_theme').toString(),
                    Icons.system_security_update_good,
                    context),
                buildRadioListTile(
                    ThemeMode.light,
                    lan.getTexts('light_theme').toString(),
                    Icons.wb_sunny_outlined,
                    context),
                buildRadioListTile(
                    ThemeMode.dark,
                    lan.getTexts('dark_theme').toString(),
                    Icons.nights_stay_outlined,
                    context),
                buildListTile(context, 'primary'),
                buildListTile(context, 'accent'),
              ],
            ))
          ],
        ),
        drawer: const Mydrawer(),
      ),
    );
  }

  RadioListTile<dynamic> buildRadioListTile(
      ThemeMode themeval, String txt, IconData icon, BuildContext ctx) {
    return RadioListTile(
      secondary: Icon(icon, color: Theme.of(ctx).textTheme.headline6!.color),
      value: themeval,
      groupValue: Provider.of<ThemeProvider>(ctx, listen: true).tm,
      onChanged: (newThemeVal) {
        return Provider.of<ThemeProvider>(ctx, listen: false)
            .themeModeChange(newThemeVal);
      },
      title: Text(
        txt,
        style: TextStyle(color: Theme.of(ctx).textTheme.headline6!.color),
      ),
    );
  }

  // :::::::::::::::;;BuildListTile::::::::::::::::::::::::
  ListTile buildListTile(BuildContext context, txt) {
    var lan = Provider.of<LanguageProvider>(context);
    var primaryColor =
        Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    var accentColor =
        Provider.of<ThemeProvider>(context, listen: true).accentColor;
    return ListTile(
      title: Text(
        lan.getTexts(txt).toString(),
        style: Theme.of(context).textTheme.headline6,
      ),
      trailing: CircleAvatar(
        backgroundColor: txt == "primary" ? primaryColor : accentColor,
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return AlertDialog(
                elevation: 4,
                titlePadding: const EdgeInsets.all(0.0),
                contentPadding: const EdgeInsets.all(0.0),
                content: SingleChildScrollView(
                    child: ColorPicker(
                  pickerColor: txt == "primary"
                      ? Provider.of<ThemeProvider>(context, listen: true)
                          .primaryColor
                      : Provider.of<ThemeProvider>(context, listen: true)
                          .accentColor,
                  onColorChanged: (newColor) =>
                      Provider.of<ThemeProvider>(context, listen: false)
                          .onChanged(newColor, txt == "primary" ? 1 : 2),
                  colorPickerWidth: 300.0,
                  pickerAreaHeightPercent: 0.7,
                  enableAlpha: false,
                  displayThumbColor: true,
                )),
              );
            });
      },
    );
  }
}
