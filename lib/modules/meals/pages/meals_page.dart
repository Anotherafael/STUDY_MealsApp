import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_meals_app/models/meal.dart';
import 'package:study_meals_app/modules/meals/components/meal_item_widget.dart';
import 'package:study_meals_app/modules/meals/pages/meal_detail_page.dart';

class MealsPage extends ConsumerWidget {
  const MealsPage({
    Key? key,
    this.title,
    required this.meals,
  }) : super(key: key);

  final String? title;
  final List<Meal> meals;

  void selectMeal(BuildContext ctx, Meal meal) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailPage(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget content = ListView.builder(
      itemBuilder: (ctx, index) => Text(
        meals[index].title,
      ),
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Uh oh.. nothing here.",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              "Try selecting another category!",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
      );
    } else {
      content = ListView.builder(
        itemBuilder: (ctx, index) => MealItemWidget(
          meal: meals[index],
          onSelectMeal: (ctx, meal) => selectMeal(ctx, meal),
        ),
        itemCount: meals.length,
      );
    }

    if (title == null) return content;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title!,
        ),
      ),
      body: content,
    );
  }
}
