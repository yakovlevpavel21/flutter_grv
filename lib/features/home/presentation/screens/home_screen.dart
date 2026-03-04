import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/categories/presentation/blocs/categories/categories_bloc.dart';
import 'package:grv/features/home/data/mappers/home_mapper.dart';
import 'package:grv/features/home/presentation/widgets/category_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeUiMapper mapper = HomeUiMapper();
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GRV'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500,),
          child: BlocBuilder<CategoriesBloc, CategoriesState> (
            builder: (context, state) {
              if (state is CategoriesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CategoriesLoaded) {
                return RefreshIndicator(
                  onRefresh: () async {
                    final completer = Completer<void>();
                    context.read<CategoriesBloc>().add(LoadCategories(completer: completer));
                    return completer.future;
                  },
                  child: ListView(
                    padding: const EdgeInsets.all(12),
                    children: mapper
                        .map(state.categories.values.toList()).categories
                        .map((c) => CategorySection(ui: c))
                        .toList(),
                  ),
                );
              }
              if (state is CategoriesError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            }
          ),
        ),
      ), 
    );
  }
}