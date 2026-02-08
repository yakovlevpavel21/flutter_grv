import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/shipments/logic/shipments_bloc.dart';
import 'package:grv/features/shipments/widgets/shipments_filter_sheet.dart';
import 'package:grv/features/shipments/widgets/shipments_list.dart';
import 'package:grv/features/shipments/widgets/shipments_top_bar.dart';
import 'package:grv/widgets/empty_state.dart';


class ShipmentsScreen extends StatefulWidget {
  const ShipmentsScreen({super.key});

  @override
  State<ShipmentsScreen> createState() => _ShipmentsScreenState();
}

class _ShipmentsScreenState extends State<ShipmentsScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("История")
      ),
      body: SafeArea(
        child: BlocBuilder<ShipmentsBloc, ShipmentsState>(
          builder: (context, state) {
            if (state is ShipmentsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ShipmentsLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShipmentsTopBar(
                    selected: state.selectedType,
                    hasFilters: state.hasActiveFilters,
                    onFiltersTap: () {
                      _openFilters(context);
                    },
                    onTypeChanged: (type) {
                      context.read<ShipmentsBloc>().add(ShipmentsTypeChanged(type));
                    },
                  ),
                  Expanded(
                    child: state.items.isNotEmpty 
                      ? const EmptyState() 
                      : ShipmentsList(items: state.items),
                  ),
                ],
              );
            }
            if (state is ShipmentsError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openAdd(context),
        icon: const Icon(Icons.add),
        label: const Text('Добавить'),
      ),
    );
  }

  void _openFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const ShipmentsFiltersSheet(),
    );
  }

  void _openAdd(BuildContext context) {
    // Navigator.push(...) или bottom sheet
  }
}


