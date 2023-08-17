import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

Widget numberCircle(int count) {
  return Container(
    padding: const EdgeInsets.all(5),
    decoration: const BoxDecoration(
      color: AppColors.warmGrey,
      shape: BoxShape.circle,
    ),
    child: Center(
      child: Text(
        '$count',
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}
