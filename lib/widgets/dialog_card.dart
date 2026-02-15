import 'package:flutter/material.dart';

enum DialogType { info, error, warning}

class DialogCard extends StatelessWidget { 
  final DialogType type;
  final String message;

  final Widget? button;
  final Function()? onMake;
  
  const DialogCard({ 
    super.key, 
    required this.type,
    required this.message,
    this.button,
    this.onMake
  }); 
 
  @override 
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                type == DialogType.info ? 'Информация'
                  : type == DialogType.warning ? 'Предупреждение'
                  : 'Ошибка',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: type == DialogType.info ? Colors.lightBlueAccent
                    : type == DialogType.warning ? Colors.red
                    : Colors.red,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              if (onMake != null) ...[
                ElevatedButton(
                  onPressed: () {
                    onMake!();
                  },
                  child: Text("ОК"),
                ),
              ] else if (button != null) ...[
                button!,
              ]
            ],
          ),
        ),
      ),
    );
  }
}