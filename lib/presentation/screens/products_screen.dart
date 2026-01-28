import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grv/logic/product/product_bloc.dart';
import 'package:grv/presentation/screens/product_detail_screen.dart';
import 'package:grv/presentation/screens/product_form_screen.dart';
import 'package:grv/presentation/widgets/product_card.dart';

enum ProductSort { name, quantity }

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String search = '';
  ProductSort sort = ProductSort.name;

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Товары"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.go('/product/new');
            },
          )
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndSort(),
          Expanded(child: _buildGrid()),
        ],
      ),
    );
  }

  Widget _buildSearchAndSort() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Поиск по названию",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (v) => setState(() => search = v.toLowerCase()),
            ),
          ),
          const SizedBox(width: 10),
          DropdownButton<ProductSort>(
            value: sort,
            items: const [
              DropdownMenuItem(
                value: ProductSort.name,
                child: Text("По названию"),
              ),
              DropdownMenuItem(
                value: ProductSort.quantity,
                child: Text("По количеству"),
              ),
            ],
            onChanged: (v) => setState(() => sort = v!),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProductLoaded) {
          var products = state.products
              .where((p) => p.name.toLowerCase().contains(search))
              .toList();

          products.sort((a, b) {
            return sort == ProductSort.name
                ? a.name.compareTo(b.name)
                : b.quantity.compareTo(a.quantity);
          });

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 2–4 для планшета
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.9,
            ),
            itemCount: products.length,
            itemBuilder: (_, i) => ProductCard(
              product: products[i],
              onTap: () {
                context.go(
                  '/product/${products[i].id}',
                  extra: products[i],
                );
              },
            ),
          );
        }
        return const Center(child: Text("Ошибка загрузки"));
      },
    );
  }
}