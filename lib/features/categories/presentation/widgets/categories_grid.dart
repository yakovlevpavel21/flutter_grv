import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/categories/domain/entities/category_entity.dart';
import 'package:grv/features/categories/presentation/blocs/categories/categories_bloc.dart';
import 'package:grv/features/categories/presentation/widgets/category_card.dart';

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = context.select((CategoriesBloc b) {
      if (b.state is CategoriesLoaded) {
        return (b.state as CategoriesLoaded).categories.values.toList();
      }
      return <CategoryEntity>[];
    });
    
    if (categories.isEmpty) return const Center(child: Text('Нет категорий'));
    
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
        childAspectRatio: 1
      ), 
      itemCount: categories.length,
      itemBuilder: (_, i) => CategoryCard(category: categories[i]),
    );
  }
}