import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favouriteMeals = [];

  void _showInfoMessage(String message){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavouriteStatus(Meal meal){
    final isExisting = _favouriteMeals.contains(meal);

    if (isExisting){
      setState(() {
        _favouriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favourite.');
    } else{
      setState(() {
         _favouriteMeals.add(meal);
         _showInfoMessage('Marked as favourite !');
      });
    }
  }

  void _selectPage(int index){
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier){
    Navigator.of(context).pop();
    if(identifier == 'filters'){
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(onToggleFavourite: _toggleMealFavouriteStatus,);
    var activePageTitle  = 'Categories';

    
    if(_selectedPageIndex == 1){
      activePage = MealsScreen(meals: _favouriteMeals, onToggleFavourite: _toggleMealFavouriteStatus,);
      activePageTitle = 'Your Favourites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen,),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Categories' ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'favourites'),
        ],
      ),
    );
  }
}



