import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/materials/data/repositories/color_edit_repository_impl.dart';
import 'package:grv/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:grv/features/categories/presentation/blocs/categories/categories_bloc.dart';
import 'package:grv/features/materials/presentation/blocs/colors/colors_bloc.dart';
import 'package:grv/features/shipments/data/repositories/shipments_repository_impl.dart';
import 'package:grv/features/shipments/presentation/blocs/shipments/shipments_bloc.dart';
import 'package:grv/features/shops/data/repos/shops_repo.dart';
import 'package:grv/features/shops/logic/shops_bloc.dart';
import 'package:grv/router/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/auth/logic/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://swkertvclrduwefooout.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN3a2VydHZjbHJkdXdlZm9vb3V0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0NzgzMjgsImV4cCI6MjA4MTA1NDMyOH0.8bx8GG1s744L_rejwdJn08pwNexGJm6g3dtaCjOlIkg',
  );

  runApp(const GRVRoot());
}

class GRVRoot extends StatelessWidget {
  const GRVRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (_) => AuthBloc()..add(AuthCheckStatus()),
          ),
          BlocProvider<CategoriesBloc>(
            create: (_) => CategoriesBloc(CategoriesRepositoryImpl())..add(LoadCategories()),
          ),
          BlocProvider<ShipmentsBloc>(
            create: (_) => ShipmentsBloc(ShipmentsRepositoryImpl())..add(LoadShipments()),
          ),
          BlocProvider<ShopsBloc>(
            create: (_) => ShopsBloc(ShopsRepository())..add(LoadShops()),
          ),
          BlocProvider<ColorsBloc>(
            create: (_) => ColorsBloc(ColorEditRepositoryImpl())..add(LoadColors()),
          ),
        ],
        child: const AppRouter(),
      ),
    );
  }
}