import 'package:flutter/material.dart';

class EditDeleteMenuButton extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const EditDeleteMenuButton({super.key, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (context) => [
        PopupMenuItem(value: 'edit', child: Text('Изменить')),
        PopupMenuItem(value: 'delete', child: Text('Удалить')),
      ],
      onSelected: (value) {
        if (value == 'edit') {
          onEdit();
        } else if (value == 'delete') {
          onDelete();
        }
      },
    );
  }
}