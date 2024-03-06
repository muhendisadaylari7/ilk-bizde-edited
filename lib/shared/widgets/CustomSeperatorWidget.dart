// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomSeperatorWidget extends StatelessWidget {
  final Color color;
  const CustomSeperatorWidget({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      height: 0,
      thickness: 1,
    );
  }
}
