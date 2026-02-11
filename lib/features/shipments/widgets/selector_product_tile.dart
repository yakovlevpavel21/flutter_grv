import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/shipments/data/models/shipment_product.dart';
import 'package:grv/features/shipments/logic/add_shipment_bloc.dart';

class SelectedProductTile extends StatelessWidget {
  final ShipmentProductUi item;

  const SelectedProductTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(item.productName),
        subtitle: Text('${item.variant} • ${item.color}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove, size: 15,),
              onPressed: () {
                if (item.quantity > 1) {
                  context.read<AddShipmentBloc>()
                    .add(ShipmentProductQuantityChanged(item, item.quantity - 1));
                } else if (item.quantity == 1) {
                  context.read<AddShipmentBloc>()
                    .add(ShipmentProductRemoved(item,));
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
                    item.maxQuantity.toString(), 
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
                    context.read<AddShipmentBloc>()
                      .add(ShipmentProductRemoved(item,));
                  } else if (qty >= item.maxQuantity) {
                    context.read<AddShipmentBloc>()
                      .add(ShipmentProductQuantityChanged(item, item.maxQuantity));
                  }
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add, size: 15,),
              onPressed: () {
                if (item.quantity < item.maxQuantity) {
                  context.read<AddShipmentBloc>()
                    .add(ShipmentProductQuantityChanged(item, item.quantity + 1));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}