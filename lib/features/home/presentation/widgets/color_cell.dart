import 'package:flutter/material.dart';
import 'package:grv/features/materials/domain/entities/color_entity.dart';

class ColorCell extends StatelessWidget {
  final ColorEntity colorEntity;

  const ColorCell({super.key, required this.colorEntity});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: colorEntity.color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black, width: 0.3),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            colorEntity.name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}