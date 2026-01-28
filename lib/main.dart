import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/products/data/repos/product_repo.dart';
import 'package:grv/features/products/logic/product_bloc.dart';
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
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (_) => AuthBloc()..add(AuthCheckStatus()),
          ),
          BlocProvider<ProductBloc>(
            create: (_) => ProductBloc(ProductRepository())..add(LoadProducts()),
          ),
        ],
        child: const AppRouter(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}