import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/data/models/color.dart';
import 'package:grv/features/home/data/models/home_category.dart';
import 'package:grv/features/home/data/models/home_product.dart';
import 'package:grv/features/home/data/models/home_table_row.dart';
import 'package:grv/features/home/data/models/home_variant_cell.dart';
import 'package:grv/features/home/logic/home_bloc.dart';
import 'package:grv/widgets/section_title.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          child: BlocBuilder<HomeBloc, HomeState> (
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is HomeLoaded) {
                return ListView(
                  padding: const EdgeInsets.all(12),
                  children: state.data.categories
                      .map((c) => CategorySection(ui: c))
                      .toList(),
                );
              }
              if (state is HomeError) {
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
class CategorySection extends StatelessWidget {
  final HomeCategoryUi ui;

  const CategorySection({super.key, required this.ui});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ui.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        ...ui.products.map(
          (p) => ProductSection(ui: p),
        ),
      ],
    );
  }
}

class ProductSection extends StatelessWidget {
  final HomeProductUi ui;

  const ProductSection({super.key, required this.ui});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(ui.name),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              TableHeader(variants: ui.variants),
              Divider(height: 1, color: Colors.grey.shade300),
              ...ui.rows.map(
                (r) => TableRowWidget(row: r),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class TableHeader extends StatelessWidget {
  final List<String> variants;

  const TableHeader({super.key, required this.variants});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          const Expanded(child: _HeaderText('Цвет')),
          const Expanded(child: _HeaderText('Не собранные')),
          ...variants.map(
            (v) => Expanded(child: _HeaderText(v)),
          ),
        ],
      ),
    );
  }
}

class _HeaderText extends StatelessWidget {
  final String text;
  const _HeaderText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: const Color.fromARGB(255, 73, 73, 73),
      ),
    );
  }
}

class TableRowWidget extends StatelessWidget {
  final HomeTableRowUi row;

  const TableRowWidget({super.key, required this.row});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Row(
        children: [
          Expanded(child: _ColorCell(row.color)),
          Expanded(child: _BigCell(row.semiFinished)),
          ...row.cells.map(
            (c) => Expanded(child: _StageCell(cell: c)),
          ),
        ],
      ),
    );
  }
}

class _ColorCell extends StatelessWidget {
  final ColorModel color;

  const _ColorCell(this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color.toFlutterColor(),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black, width: 0.3),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            color.name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

class _BigCell extends StatelessWidget {
  final int value;

  const _BigCell(this.value);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        value == 0 ? '—' : '$value',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _StageCell extends StatelessWidget {
  final HomeVariantCellUi cell;

  const _StageCell({required this.cell});

  @override
  Widget build(BuildContext context) {
    if (cell.isEmpty) {
      return const Center(
        child: Text('—', style: TextStyle(color: Colors.grey)),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${cell.packed}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (cell.built > 0)
          Text(
            ' (${cell.built})',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
      ],
    );
  }
}