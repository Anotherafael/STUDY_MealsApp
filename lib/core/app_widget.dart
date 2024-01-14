import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_meals_app/modules/tabs/tabs_page.dart';
import 'package:study_meals_app/shared/theme/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const TabsPage(),
        theme: AppTheme.defaultTheme,
      ),
    );
  }
}
