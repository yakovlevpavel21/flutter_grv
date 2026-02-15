import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grv/features/home/logic/home_bloc.dart';
import 'package:grv/features/shipments/logic/shipment_bloc.dart';
import 'package:grv/features/shipments/logic/shipments_bloc.dart';
import 'package:grv/features/shipments/widgets/products_section.dart';
import 'package:grv/features/shipments/widgets/shipment_date_time_picker.dart';
import 'package:grv/features/shipments/widgets/shipment_type_selector.dart';
import 'package:grv/features/shipments/widgets/shop_selector.dart';
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
    context.read<ShopsBloc>().add(LoadShops());
    context.read<HomeBloc>().add(LoadHome());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Новая операция'),
      ),
      body: BlocProvider(
        create: (_) => ShipmentBloc(),
        child: SafeArea(
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
                    _BottomSaveButton(),
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
    return Padding(
      padding: const EdgeInsets.all(0),
      child: BlocConsumer<ShipmentBloc, ShipmentState>(
        listener: (context, state) {
          if (state is ShipmentSuccess) {
            context.read<ShipmentsBloc>().add(LoadShipments());
            context.pop();
          }
        },
        builder: (context, state) {
          if (state is ShipmentLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ShipmentInitial) {
            return SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                label: const Text(
                  'Сохранить',
                  style: TextStyle(fontSize: 15),
                ),
                onPressed: 
                  state.canSubmit
                    ? () {
                        context.read<ShipmentBloc>().add(ShipmentSubmitted());
                      }
                    : null,
              ),
            );
          }
          if (state is ShipmentError) {
            return ErrorCard(
              title: 'Ошибка', 
              description: state.message, 
              onReload: () {
                context.pop();
              }
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}