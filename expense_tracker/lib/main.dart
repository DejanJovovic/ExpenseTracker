import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:expense_tracker/widget/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  // this is how we create an alternative dark theme, to let the user change from light theme to dark theme
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {

/*  WidgetsFlutterBinding.ensureInitialized(); // this make sure that lcoking the orientation and then starting the app looks fine

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // if the user rotates the devices because of this line the app will not rotate, it will stay in portrait mode always
  ]).then((fn) {// UI only gets applied when the orientation has been locked in
*/
    runApp(
      MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          // this is how we add a dark theme
          colorScheme: kDarkColorScheme,
          cardTheme: const CardTheme().copyWith(
            color: kDarkColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              // same as copyWith, uses the default themes
              backgroundColor: kDarkColorScheme.primaryContainer,
              foregroundColor: kDarkColorScheme.onPrimaryContainer,
            ),
          ),
        ),
        theme: ThemeData.light().copyWith(
            colorScheme:
                kColorScheme, // creates a color scheme for different widgets
            appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kColorScheme.onPrimaryContainer,
              foregroundColor: kColorScheme.primaryContainer,
            ),
            cardTheme: const CardTheme().copyWith(
              color: kColorScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                // same as copyWith, uses the default themes
                backgroundColor: kColorScheme.primaryContainer,
              ),
            ),
            textTheme: ThemeData().textTheme.copyWith(
                  titleLarge: TextStyle(
                    // change the style of all of the main titles are presented(in the app bar)
                    fontWeight: FontWeight.bold,
                    color: kColorScheme.onSecondaryContainer,
                    fontSize: 16,
                  ),
                )),
        // default, dont need to set this - themeMode: ThemeMode.system, //looks at the system settings that the user has chosen on their device for the light or dark theme
        home: const Expenses(),
      ),
    );
 // });
}
