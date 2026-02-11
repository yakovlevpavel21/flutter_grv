import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grv/features/shipments/logic/shipments_bloc.dart';
import 'package:grv/features/shipments/widgets/shipments_filter_sheet.dart';
import 'package:grv/features/shipments/widgets/shipments_list.dart';
import 'package:grv/features/shipments/widgets/shipments_top_bar.dart';
import 'package:grv/widgets/empty_state.dart';
import 'package:grv/widgets/error_card.dart';


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
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
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
                        child: state.items.isEmpty 
                          ? const EmptyState() 
                          : ShipmentsList(items: state.items),
                      ),
                      _buildAddButton(context),
                    ],
                  );
                }
                if (state is ShipmentsError) {
                  return ErrorCard(
                    title: "Ошибка",
                    description: state.message,
                    onReload: () => {context.read<ShipmentsBloc>().add(LoadShipments())},
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
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

  Widget _buildAddButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        height: 46,
        child: ElevatedButton.icon(
          label: const Text(
            'Добавить операцию',
            style: TextStyle(fontSize: 15),
          ),
          onPressed: () => {context.push('/shipments/new'),},
        ),
      ),
    );
  }
}


