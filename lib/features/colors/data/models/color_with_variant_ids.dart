

import 'package:flutter/material.dart';

class ColorWithVariantIdsUi {
  final int id;
  final String name;
  final Color color;
  final List<int> variantIds;

  ColorWithVariantIdsUi({
    required this.id,
    required this.name,
    required this.color,
    required this.variantIds,
  });
}