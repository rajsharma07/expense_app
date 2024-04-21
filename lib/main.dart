import 'package:expense_app/widget/expenses.dart';
import 'package:flutter/material.dart';

var kcolorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);
var kdarkcolorscheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(55, 9, 99, 125),
);

void main() {
  
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kdarkcolorscheme,
        cardTheme: const CardTheme().copyWith(
          color: Colors.black26,
          margin: const EdgeInsets.all(16),
        ),
      ),
      theme: ThemeData().copyWith(
          colorScheme: kcolorScheme,
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kcolorScheme.onPrimaryContainer,
              foregroundColor: kcolorScheme.primaryContainer),
          cardTheme: const CardTheme().copyWith(
              color: kcolorScheme.secondaryContainer,
              margin: const EdgeInsets.all(16))),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      home: const Expenses(),
    ),
  );
  //   },
  // );
}
