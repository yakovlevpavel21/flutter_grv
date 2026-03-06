import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grv/features/categories/presentation/blocs/categories/categories_bloc.dart';
import 'package:grv/features/shipments/domain/entities/shipment_entity.dart';
import 'package:grv/features/shipments/presentation/blocs/shipment_edit/shipment_edit_bloc.dart';
import 'package:grv/features/shipments/presentation/blocs/shipments/shipments_bloc.dart';
import 'package:grv/widgets/dialog_card.dart';

class ShipmentDetailsSheet extends StatelessWidget {
  final ShipmentEntity shipment;

  const ShipmentDetailsSheet({super.key, required this.shipment});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  shipment.shop.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    final oldContext = context;

                    showDialog(
                      context: context, 
                      builder: (context) => DialogCard(
                        type: DialogType.warning,
                        message: 'Ты уверен? Отменить нельзя будет!',
                        button: BlocProvider(
                          create: (_) => ShipmentEditBloc(),
                          child: _DeleteButton(
                            shipmentId: shipment.id, 
                            onSuccess: () {
                              Navigator.of(context).pop();
                              oldContext.pop();
                              oldContext.read<ShipmentsBloc>().add(LoadShipments());
                              oldContext.read<CategoriesBloc>().add(LoadCategories());
                            }
                          ),
                        ),
                      ),
                    );
                  }, 
                  icon: Icon(
                    Icons.delete_forever, 
                    color: Colors.red,
                    size: 20,
                  )
                ),
              ],
            ),
            const SizedBox(height: 12),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ...shipment.stocks.map(
                    (p) => ListTile(
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadiusGeometry.all(Radius.circular(1)),
                        
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      title: Text(p.stock.productName),
                      subtitle: Text('${p.stock.variantName} • ${p.stock.color.name}'),
                      trailing: Text('${p.quantity} шт.', style: TextStyle(fontSize: 13),),
                    ),
                  ),
                ],
              )
            ),
            
          ],
        ),
      ),
    );
  }
}


class _DeleteButton extends StatelessWidget {
  final int shipmentId;
  final VoidCallback onSuccess;

  const _DeleteButton({required this.shipmentId, required this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShipmentEditBloc, ShipmentEditInitial>(
      listener: (context, state) {
        if (state.status == ShipmentEditStatus.success) onSuccess();
        if (state.status == ShipmentEditStatus.error) {
          print(state.errorMessage);
          //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        if (state.status == ShipmentEditStatus.loading) return const CircularProgressIndicator();
        return ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => context.read<ShipmentEditBloc>().add(ShipmentDeleted(id: shipmentId)),
          child: const Text('Удалить', style: TextStyle(color: Colors.white)),
        );
      },
    );
  }
}