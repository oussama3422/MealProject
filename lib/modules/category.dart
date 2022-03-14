import 'package:flutter/material.dart';

class Category {
  final String id;
  final Color color;
  final String title;
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange,
    });
}



