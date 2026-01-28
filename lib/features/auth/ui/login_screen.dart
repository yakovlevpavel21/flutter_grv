import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/auth/logic/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Вход", style: TextStyle(fontSize: 28)),
                const SizedBox(height: 20),

                TextField(
                  controller: emailCtrl,
                  decoration: const InputDecoration(
                    labelText: "Email",
                  ),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: passCtrl,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Пароль",
                  ),
                ),

                const SizedBox(height: 20),

                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const CircularProgressIndicator();
                    }

                    return ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              AuthLoginRequested(
                                emailCtrl.text.trim(),
                                passCtrl.text.trim(),
                              ),
                            );
                      },
                      child: const Text("Войти"),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}