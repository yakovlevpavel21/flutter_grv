import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/shipments/data/enums/shipment_type.dart';
import 'package:grv/features/shipments/presentation/blocs/shipment_edit/shipment_edit_bloc.dart';
import 'package:grv/features/shipments/presentation/widgets/icon_by_type.dart';

class ShipmentTypeSelector extends StatelessWidget {
  const ShipmentTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShipmentEditBloc, ShipmentEditInitial>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: SegmentedButton<ShipmentType>(
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))
                )
              ),
            ),
            segments: [
              ButtonSegment(
                value: ShipmentType.shipment,
                label: Text(
                  'Отгрузка', 
                  style: TextStyle(
                    color: state.type == ShipmentType.shipment 
                      ? Colors.green
                      : const Color.fromARGB(255, 75, 75, 75)
                  ),
                ),
                //icon: IconByType(type: ShipmentType.shipment),
              ),
              ButtonSegment(
                value: ShipmentType.comeback,
                label: Text(
                  'Возврат', 
                  style: TextStyle(
                    color: state.type == ShipmentType.comeback 
                      ? Colors.red
                      : const Color.fromARGB(255, 75, 75, 75)
                  ),
                ),
                //icon: IconByType(type: ShipmentType.comeback),
              ),
            ],
            selected: {state.type},
            onSelectionChanged: (value) {
              context.read<ShipmentEditBloc>()
                  .add(ShipmentTypeChanged(value.first));
            },
            selectedIcon: IconByType(type: state.type),
          ), 
        );
      },
    );
  }
}