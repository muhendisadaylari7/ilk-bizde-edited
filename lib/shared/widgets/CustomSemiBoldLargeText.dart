// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomSemiBoldLargeText extends StatelessWidget {
  final String title;
  const CustomSemiBoldLargeText({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.labelLarge,
    );
  }
}
