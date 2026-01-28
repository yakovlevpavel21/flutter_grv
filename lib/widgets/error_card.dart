import 'package:flutter/material.dart';


class ErrorCard extends StatelessWidget { 
  final String title;
  final String description;
  final Function() onReload;
  
  const ErrorCard({ 
    super.key, 
    required this.title,
    required this.description,
    required this.onReload
  }); 
 
  @override 
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                onReload(); // Вызываем функцию перезагрузки
              },
              child: const Text("Попробовать снова"),
            ),
          ],
        ),
      ),
    );
  }
}