import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/shipments/domain/entities/stock_shipment_entity.dart';
import 'package:grv/features/shipments/presentation/blocs/shipment_edit/shipment_edit_bloc.dart';

class SelectedProductTile extends StatelessWidget {
  final StockShipmentEntity item;

  const SelectedProductTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(item.stock.productName),
        subtitle: Text('${item.stock.variantName} • ${item.stock.color.name}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove, size: 15,),
              onPressed: () {
                if (item.quantity > 1) {
                  context.read<ShipmentEditBloc>()
                    .add(ShipmentProductQuantityChanged(item.stock.id, item.quantity - 1));
                } else if (item.quantity == 1) {
                  context.read<ShipmentEditBloc>()
                    .add(ShipmentProductRemoved(item.stock.id,));
                }
              },
            ),
            SizedBox(
              width: 40,
              child: 
              TextField(
                controller: TextEditingController(text: item.quantity.toString()) ,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  label: Text(
                    item.stock.quantity.toString(), 
                    style: TextStyle(
                      fontSize: 14, 
                    ),
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 6),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  final qty = int.tryParse(value) ?? 0;
                  
                  if (qty <= 0) {
                    context.read<ShipmentEditBloc>()
                      .add(ShipmentProductRemoved(item.stock.id,));
                  } else if (qty >= item.stock.quantity) {
                    context.read<ShipmentEditBloc>()
                      .add(ShipmentProductQuantityChanged(item.stock.id, item.stock.quantity));
                  }
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add, size: 15,),
              onPressed: () {
                if (item.quantity < item.stock.quantity) {
                  context.read<ShipmentEditBloc>()
                    .add(ShipmentProductQuantityChanged(item.stock.id, item.quantity + 1));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}