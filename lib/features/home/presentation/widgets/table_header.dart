import 'package:flutter/material.dart';

class TableHeader extends StatelessWidget {
  final List<String> variants;

  const TableHeader({super.key, required this.variants});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          const Expanded(child: _HeaderText('Цвет')),
          const Expanded(child: _HeaderText('Не собранные')),
          ...variants.map(
            (v) => Expanded(child: _HeaderText(v)),
          ),
        ],
      ),
    );
  }
}

class _HeaderText extends StatelessWidget {
  final String text;
  const _HeaderText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: const Color.fromARGB(255, 73, 73, 73),
      ),
    );
  }
}