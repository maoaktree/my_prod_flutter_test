import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_prod_flutter_test/themes/app_colors.dart';
import 'package:my_prod_flutter_test/themes/app_text_styles.dart';

import 'controller/github_controller.dart';
import 'screens/github/github_tabs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(GithubController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Prod Flutter Test',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: AppColors.navyBlue,
        ),
        primaryColor: AppColors.rustyOrange,
        textTheme: TextTheme(
          displayLarge: AppTextStyles.textStyle1,
          bodyLarge: AppTextStyles.textStyle2,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}
