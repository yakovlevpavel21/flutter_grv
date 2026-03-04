import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grv/features/materials/presentation/blocs/colors/colors_bloc.dart';


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
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer<void>();
          context.read<ColorsBloc>().add(LoadColors(completer: completer));
          return completer.future;
        },
        child: ListView(
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
      ),
    );
  }
}