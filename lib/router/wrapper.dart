import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grv/features/auth/logic/auth_bloc.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading || state is AuthInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SizedBox();
      },
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go('/products');
        }

        if (state is !AuthLoading && state is !AuthInitial && state is !AuthAuthenticated) {
          context.go('/login');
          print(state);
        }
        //return const LoginScreen();
      },
    );
  }
}