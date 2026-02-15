import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/shipments/data/models/shipment_product.dart';
import 'package:grv/features/shipments/logic/shipment_bloc.dart';

class ProductTile extends StatefulWidget {
  final BuildContext context;
  final ShipmentProductUi product;
  final bool selected;
  
  const ProductTile({
    super.key, 
    required this.context,
    required this.product,
    required this.selected,
  });

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  bool? val;

  @override
  void initState() {
    val = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(widget.product.productName),
      subtitle: Text('${widget.product.variant} • ${widget.product.color}'),
      trailing: Text(
        '${widget.product.quantity} шт.',
        style: TextStyle(
          fontSize: 14,
        ),
      ),
      leading: Checkbox(
        value: val, 
        onChanged: (value) => { 
          setState(() {
            if (value == true) {
              widget.context.read<ShipmentBloc>().add(ShipmentProductsAdded([widget.product]));
            } else if (value == false) {
              widget.context.read<ShipmentBloc>().add(ShipmentProductRemoved(widget.product));
            }
            val = value;
          }
        )},
      ),
      onTap: () => {
        setState(() {
            if (val == false) {
              widget.context.read<ShipmentBloc>().add(ShipmentProductsAdded([widget.product]));
              val = true;
            } else if (val == true) {
              widget.context.read<ShipmentBloc>().add(ShipmentProductRemoved(widget.product));
              val = false;
            }
          }
        )
      },
    );
  }
}

//class ProductTile extends StatefulWidget {
//  final String productName;
//  final String variant;
//  final String color;
//  final int count;
//  bool? val = false;
//  
//  ProductTile({
//    super.key, 
//    required this.productName,
//    required this.variant,
//    required this.color,
//    required this.count,
//  });
//
//  @override
//  Widget build(BuildContext context) {
//    return ListTile(
//      contentPadding: EdgeInsets.all(0),
//      title: Text(productName),
//      subtitle: Text('$variant • $color'),
//      trailing: Text(
//        '$count шт.',
//        style: TextStyle(
//          fontSize: 14,
//        ),
//      ),
//      leading: Checkbox(
//        value: val, 
//        onChanged: (value) => { print(value) },
//      ),
//    );
//  }
//}