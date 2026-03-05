import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grv/features/shipments/presentation/blocs/shipment_edit/shipment_edit_bloc.dart';
import 'package:grv/features/shipments/presentation/blocs/shipments/shipments_bloc.dart';
import 'package:grv/features/shipments/presentation/widgets/products_section.dart';
import 'package:grv/features/shipments/presentation/widgets/shipment_date_time_picker.dart';
import 'package:grv/features/shipments/presentation/widgets/shipment_type_selector.dart';
import 'package:grv/features/shipments/presentation/widgets/shop_selector.dart';
import 'package:grv/features/shops/logic/shops_bloc.dart';
import 'package:grv/widgets/error_card.dart';

class ShipmentFormScreen extends StatefulWidget {
  const ShipmentFormScreen({super.key});

  @override
  State<ShipmentFormScreen> createState() => _ShipmentFormScreenState();
}

class _ShipmentFormScreenState extends State<ShipmentFormScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ShipmentEditBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Новая операция'),
          actions: [
            _BottomSaveButton(),
          ],
        ),
        body: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShipmentTypeSelector(),
                    SizedBox(height: 16),
          
                    ShipmentDateTimePicker(),
                    SizedBox(height: 16),
          
                    ShopSelector(),
                    SizedBox(height: 16),
          
                    Divider(),
                    SizedBox(height: 16),

                    ProductsSection(),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomSaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShipmentEditBloc, ShipmentEditInitial>(
      listener: (context, state) {
        if (state.status == ShipmentStatus.success) {
          context.read<ShipmentsBloc>().add(LoadShipments());
          context.pop();
        }
      },
      builder: (context, state) {
        if (state.status == ShipmentStatus.loading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.status == ShipmentStatus.initial) {
          return IconButton(
            onPressed: () => state.canSubmit
                ? () => context.read<ShipmentEditBloc>().add(ShipmentSubmitted())
                : null,
            icon: Icon(Icons.done, color: state.canSubmit ? Colors.green : Colors.grey, size: 28),
          );
        }
        if (state.status == ShipmentStatus.error) {
          return ErrorCard(
            title: 'Ошибка', 
            description: state.errorMessage ?? '', 
            onReload: () {
              context.pop();
            }
          );
        }
        return const SizedBox();
      },
    );
  }
}