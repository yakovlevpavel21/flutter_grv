import 'package:grv/features/home/domain/repositories/stock_edit_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StockEditRepositoryImpl implements StockEditRepository {
  final supabase = Supabase.instance.client;

  @override
  Future<void> updateStocks({required Map<int, int> items}) async {
    await supabase.rpc(
      'update_stock_items',
      params: {
        'p_items': items.entries.map((e) => {
          'stock_id': e.key,
          'quantity': e.value,
        }).toList(),
      }
    );
  }
}