import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/nomenclature/data/models/category_item.dart';
import 'package:grv/features/nomenclature/logic/nomenclature_bloc.dart';
import 'package:grv/features/nomenclature/widgets/category_card.dart';

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = context.select((NomenclatureBloc b) {
      if (b.state is NomenclatureLoaded) {
        return (b.state as NomenclatureLoaded).nomenclature.categoriesList;
      }
      return <CategoryItemUi>[];
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