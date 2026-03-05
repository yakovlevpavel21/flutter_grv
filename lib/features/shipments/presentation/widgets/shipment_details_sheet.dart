import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grv/features/shipments/domain/entities/shipment_entity.dart';
import 'package:grv/widgets/confirm_card.dart';

class ShipmentDetailsSheet extends StatelessWidget {
  final ShipmentEntity item;

  const ShipmentDetailsSheet({super.key, required this.item});

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
                  item.shop.name,
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
                      builder: (context) => ConfirmDeletionCard(
                        title: 'Подтверждение', 
                        description: 'Ты уверен? Отменить нельзя будет!', 
                        onReload: () {
                          //oldContext.read<ShipmentsBloc>().add(ShipmentDeleted(item.id));
                          Navigator.of(context).pop();
                          oldContext.pop();
                        }),
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
                  ...item.stocks.map(
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
