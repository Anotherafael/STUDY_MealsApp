import 'package:flutter/material.dart';
import 'package:study_meals_app/core/data/dummy_data.dart';
import 'package:study_meals_app/models/category.dart';
import 'package:study_meals_app/modules/meals/pages/meals_page.dart';

import '../../models/meal.dart';
import 'components/category_grid_item.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({
    Key? key,
    required this.availableMeals,
  }) : super(key: key);
  final List<Meal> availableMeals;

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Durations.medium2,
      upperBound: 1,
      lowerBound: 0,
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext ctx, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (ctx) => MealsPage(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: AnimatedBuilder(
            animation: _animationController,
            child: GridView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              children: [
                for (final category in availableCategories)
                  CategoryGridItemWidget(
                    category: category,
                    onSelectCategory: () => _selectCategory(context, category),
                  ),
              ],
            ),
            builder: (context, child) => SlideTransition(
              position: Tween(
                begin: const Offset(0, 0.05),
                end: const Offset(0, 0),
              ).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.easeInBack,
                ),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
