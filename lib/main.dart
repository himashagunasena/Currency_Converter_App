import 'package:currency_converter_app/view/home_page.dart';
import 'package:currency_converter_app/view_model/currency_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => CurrencyProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor:  const Color(0x374CAE59),
            foregroundColor: Colors.green,
          ),
        ),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Colors.white,
          onPrimary:  Color(0xFF111717),
          secondary: Color(0xffececec),
          onSecondary: Color(0xE88F8F8F),
          error: Color(0xE8880000),
          onError: Colors.white,
          background: Colors.white,
          onBackground: Color(0xE88F8F8F),
          surface: Color(0xffececec),
          onSurface: Color(0xE8222526),
        ),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor:  const Color(0x544CAE50),
            foregroundColor: Colors.green,
          ),
        ),
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFF111717),
          onPrimary: Colors.white,
          secondary: Color(0xE8222526),
          onSecondary: Color(0xE88F8F8F),
          error: Color(0xE8880000),
          onError: Colors.white,
          background: Color(0xFF111717),
          onBackground: Color(0xE88F8F8F),
          surface: Color(0xE8222526),
          onSurface: Colors.white,
        ),
        brightness: Brightness.dark,
      ),
      home:  const HomePage(),
    );
  }
}
