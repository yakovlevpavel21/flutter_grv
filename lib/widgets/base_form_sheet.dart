import 'package:flutter/material.dart';

class BaseFormSheet extends StatelessWidget {
  final String title;
  final VoidCallback? onSave;
  final bool isLoading;
  final bool canSubmit;
  final Widget child;

  const BaseFormSheet({
    super.key,
    required this.title,
    this.onSave,
    this.isLoading = false,
    this.canSubmit = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              if (isLoading)
                const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
              else
                IconButton(
                  onPressed: canSubmit ? onSave : null,
                  icon: Icon(Icons.done, color: canSubmit ? Colors.green : Colors.grey, size: 28),
                ),
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}