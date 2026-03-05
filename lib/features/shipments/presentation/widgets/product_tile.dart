import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/shipments/domain/entities/stock_details_entity.dart';
import 'package:grv/features/shipments/presentation/blocs/shipment_edit/shipment_edit_bloc.dart';

class ProductTile extends StatefulWidget {
  final BuildContext context;
  final StockDetailsEntity stockDetails;
  final bool selected;
  
  const ProductTile({
    super.key, 
    required this.context,
    required this.stockDetails,
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
      title: Text(widget.stockDetails.productName),
      subtitle: Text('${widget.stockDetails.variantName} • ${widget.stockDetails.color.name}'),
      trailing: Text(
        '${widget.stockDetails.quantity} шт.',
        style: TextStyle(
          fontSize: 14,
        ),
      ),
      leading: Checkbox(
        value: val, 
        onChanged: (value) => { 
          setState(() {
            if (value == true) {
              widget.context.read<ShipmentEditBloc>().add(ShipmentProductAdded(widget.stockDetails));
            } else if (value == false) {
              widget.context.read<ShipmentEditBloc>().add(ShipmentProductRemoved(widget.stockDetails.id));
            }
            val = value;
          }
        )},
      ),
      onTap: () => {
        setState(() {
            if (val == false) {
              widget.context.read<ShipmentEditBloc>().add(ShipmentProductAdded(widget.stockDetails));
              val = true;
            } else if (val == true) {
              widget.context.read<ShipmentEditBloc>().add(ShipmentProductRemoved(widget.stockDetails.id));
              val = false;
            }
          }
        )
      },
    );
  }
}