import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/auth/logic/auth_bloc.dart';
import 'package:grv/features/auth/ui/login_screen.dart';
import 'package:grv/features/products/ui/products_screen.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading || state is AuthInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is AuthAuthenticated) {
          return const ProductsScreen();
        }

        return const LoginScreen();
      },
    );
  }
}