import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_meals_app/core/providers/favorites_provider.dart';

import '../../../models/meal.dart';

class MealDetailPage extends ConsumerWidget {
  const MealDetailPage({
    Key? key,
    required this.meal,
  }) : super(key: key);

  final Meal meal;

  void _showInfoMessage({
    required msg,
    required IconData? icon,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              msg,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(width: 10),
            Icon(
              icon ?? Icons.add_alert,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    var isFavorite = favoriteMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);

              if (wasAdded) {
                _showInfoMessage(
                    context: context,
                    icon: Icons.thumb_up,
                    msg: "Meals liked.");
              } else {
                _showInfoMessage(
                    context: context,
                    icon: Icons.thumb_down,
                    msg: "Meals unliked.");
              }
            },
            icon: AnimatedSwitcher(
              duration: Durations.medium1,
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                size: 24,
                key: ValueKey(isFavorite),
              ),
              transitionBuilder: (child, animation) => RotationTransition(
                turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                child: child,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Hero(
                  tag: meal.id,
                  child: Image.network(
                    meal.imageUrl,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Ingredients',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 14),
                for (final ingredient in meal.ingredients)
                  Text(
                    ingredient,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                const SizedBox(height: 14),
                Text(
                  'Steps',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 14),
                for (final step in meal.steps)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      step,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
