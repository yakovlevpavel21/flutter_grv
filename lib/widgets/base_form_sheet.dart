import 'package:flutter/material.dart';

class BaseFormSheet extends StatelessWidget {
  final String title;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onSave;
  final bool isLoading;
  final bool canSubmit;
  final Widget child;

  const BaseFormSheet({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.onSave,
    this.isLoading = false,
    this.canSubmit = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Шапка
                Row(
                  children: [
                    if (leading != null) ...[
                      leading!,
                      const SizedBox(width: 8),
                    ],
                    Expanded(
                      child: Text(
                        title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    if (trailing != null) ...[
                      const SizedBox(width: 8),
                      trailing!,
                    ],
                    const SizedBox(width: 8),
                    _buildAction(theme),
                  ],
                ),
                const SizedBox(height: 20),
                // Контент
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAction(ThemeData theme) {
    if (isLoading) {
      return const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    return IconButton(
      onPressed: canSubmit ? onSave : null,
      icon: Icon(
        Icons.done,
        color: canSubmit 
            ? theme.colorScheme.primary // Используем основной цвет темы
            : theme.disabledColor,
        size: 28,
      ),
      tooltip: 'Сохранить',
    );
  }
}