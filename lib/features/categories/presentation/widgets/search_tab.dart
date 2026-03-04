import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/categories/presentation/blocs/categories/categories_bloc.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Найти товар",
              suffixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (v) {
              context.read<CategoriesBloc>().add(SearchProducts(query: v.toLowerCase()));
            }
          ),
        ),
        //const SizedBox(width: 10),
        //DropdownButton<ProductSort>(
        //  value: sort,
        //  items: const [
        //    DropdownMenuItem(
        //      value: ProductSort.name,
        //      child: Text("По названию"),
        //    ),
        //    DropdownMenuItem(
        //      value: ProductSort.quantity,
        //      child: Text("По количеству"),
        //    ),
        //  ],
        //  onChanged: (v) => setState(() => sort = v!),
        //),
      ],
    );
  }
}