import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class MaterialsScreen extends StatefulWidget {
  const MaterialsScreen({super.key});

  @override
  State<MaterialsScreen> createState() => _MaterialsScreenState();
}

class _MaterialsScreenState extends State<MaterialsScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Материалы'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Цвета'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              context.push('/materials/colors');
            },
          )
        ],
      ),
    );
  }
}