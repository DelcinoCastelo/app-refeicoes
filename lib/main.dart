import 'package:Refeicoes/data/dummy_data.dart';
import 'package:Refeicoes/models/meal.dart';
import 'package:Refeicoes/models/settings.dart';
import 'package:Refeicoes/screens/categories_meals_screen.dart';
import 'package:Refeicoes/screens/meal_detail_screen.dart';
import 'package:Refeicoes/screens/settings_screen.dart';
import 'package:Refeicoes/screens/tabs_screen.dart';
import 'package:Refeicoes/utils/app_routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Settings settings = Settings();
  List<Meal> _availableMeals = DUMMY_MEALS;

  void _filterMeals(Settings settings) {
    setState(() {
      this.settings = settings;
      _availableMeals = DUMMY_MEALS.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;

        return !filterVegetarian &&
            !filterVegan &&
            !filterLactose &&
            !filterGluten;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Refeições',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        fontFamily: 'Raleway',
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      // home: CategoriesScreen(),
      routes: {
        AppRoutes.HOME: (_) => TabsScreen(),
        AppRoutes.CATEGORIES_MEALS: (_) => CategoriesMealsScreen(_availableMeals),
        AppRoutes.MEAL_DETAIL: (_) => MealDetailScreen(),
        AppRoutes.SETTINGS: (_) => SettingsScreen(settings, _filterMeals),
      },
    );
  }
}
