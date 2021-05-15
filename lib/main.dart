import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Screens/Generic/SplashScreen.dart';
import 'Utils/app_localizations.dart';
import 'Utils/size_config.dart';
import 'Utils/styling.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return (OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              title: 'My Barber',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              //List all of the app's supported locales here
              supportedLocales: [
                Locale('tr', 'TR'),
              ],
              localizationsDelegates: [
                // A class which loads the translations from JSON files
                AppLocalizations.delegate,
                // Built-in localization of basic text for Material widgets
                GlobalMaterialLocalizations.delegate,
                // Built-in localization for text direction LTR/RTL
                GlobalWidgetsLocalizations.delegate,

                GlobalCupertinoLocalizations.delegate
              ],

              // Returns a locale which will be used by the app
              localeResolutionCallback: (locale, supportedLocales) {

                // Check if the current device locale is supported
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale.languageCode &&
                      supportedLocale.countryCode == locale.countryCode) {
                    return Locale('tr', 'TR');
                  }
                }
                // If the locale of the device is not supported, use the first one
                // from the list (English, in this case).
                return Locale('tr', 'TR');
              },
              home: SplashScreen(),
            );
          },
        ));
      },
    );
  }
}