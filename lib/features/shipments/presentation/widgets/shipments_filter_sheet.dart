import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/shipments/presentation/blocs/shipments/shipments_bloc.dart';
import 'package:grv/features/shops/data/models/shop_item.dart';
import 'package:grv/features/shops/logic/shops_bloc.dart';
import 'package:grv/widgets/base_form_sheet.dart';

class ShipmentsFiltersSheet extends StatefulWidget {
  //final ShipmentsBloc shipmentsBloc;
  const ShipmentsFiltersSheet({super.key});

  @override
  State<ShipmentsFiltersSheet> createState() => _ShipmentsFiltersSheetState();
}

class _ShipmentsFiltersSheetState extends State<ShipmentsFiltersSheet> {
  @override
  Widget build(BuildContext context) {
    final selectedShopIds = (context.read<ShipmentsBloc>().state as ShipmentsLoaded).selectedShopIds;

    return BaseFormSheet(
      title: 'Фильтры', 
      child: Column(
        children: [
          _ShopsSection(
            selectedShopIds: selectedShopIds
          ),
        ],
      ),
      onSave: () {
        Navigator.pop(context);
      },
    );
  }
}

class _ShopsSection extends StatefulWidget {
  final List<int> selectedShopIds;
  const _ShopsSection({required this.selectedShopIds});

  @override
  State<_ShopsSection> createState() => __ShopsSectionState();
}

class __ShopsSectionState extends State<_ShopsSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopsBloc, ShopsState>(
      builder: (context, state) {
        if (state is ShopsLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                children: [
                  Icon(Icons.shop_outlined),
                  SizedBox(width: 10,),
                  Text(
                    'Магазины',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true, 
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final shop = state.items[index];
                  return _ShopTile(
                    shop: shop,
                    selected: widget.selectedShopIds.contains(shop.id),
                  );
                }
              ),
            ],
          );
        }
        return Text('Магазины не найдены');
      }
    );
    
  }
}

class _ShopTile extends StatefulWidget {
  final ShopItemUi shop;
  final bool selected;
  const _ShopTile({required this.shop, required this.selected});

  @override
  State<_ShopTile> createState() => __ShopTileState();
}

class __ShopTileState extends State<_ShopTile> {
  bool? val;

  @override
  void initState() {
    val = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.shop.title),
      leading: Checkbox(
        value: val, 
        onChanged: (value) {
          setState(() {
            if (value == true) {
              context.read<ShipmentsBloc>().add(ShipmentsFilterShopAdded(widget.shop.id));
            } else if (value == false) {
              context.read<ShipmentsBloc>().add(ShipmentsFilterShopRemoved(widget.shop.id));
            }
            val = value;
          });
        }
      ),
    );
  }
}