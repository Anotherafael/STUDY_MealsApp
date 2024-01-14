import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_meals_app/core/data/dummy_data.dart';

final mealsProvider = Provider(
  (ref) => dummyMeals,
);
