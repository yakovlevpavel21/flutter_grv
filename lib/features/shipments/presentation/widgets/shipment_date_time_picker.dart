import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/shipments/presentation/blocs/shipment_edit/shipment_edit_bloc.dart';
import 'package:intl/intl.dart';

class ShipmentDateTimePicker extends StatelessWidget {
  const ShipmentDateTimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShipmentEditBloc, ShipmentEditInitial>(
      builder: (context, state) {
        if (state.status == ShipmentStatus.initial){
          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8),
            leading: const Icon(Icons.schedule),
            title: const Text('Дата и время'),
            subtitle: Text(
              DateFormat('dd.MM.yyyy HH:mm').format(state.dateTime),
            ),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: state.dateTime,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
              );

              if (date == null) return;

              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(state.dateTime),
              );

              if (time == null) return;

              context.read<ShipmentEditBloc>().add(
                    ShipmentDateChanged(
                      DateTime(
                        date.year,
                        date.month,
                        date.day,
                        time.hour,
                        time.minute,
                      ),
                    ),
                  );
            },
            trailing: Icon(Icons.edit, size: 21,),
          );
        }
        return const SizedBox();
      },
    );
  }
}