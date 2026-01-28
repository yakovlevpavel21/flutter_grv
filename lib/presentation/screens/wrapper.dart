import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/presentation/screens/screens.dart';
import '../../logic/auth/auth_bloc.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading || state is AuthInitial) {
          return const SplashScreen();
        }

        if (state is AuthAuthenticated) {
          return const ProductsScreen();
        }

        return const LoginScreen();
      },
    );
  }
}