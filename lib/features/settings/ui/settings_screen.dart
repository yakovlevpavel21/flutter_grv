import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/auth/logic/auth_bloc.dart';
import 'package:grv/features/settings/widgets/profile_card.dart';
import 'package:grv/widgets/section_title.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is! AuthAuthenticated) {
            return const Center(child: CircularProgressIndicator());
          }

          final profile = state.profile; 

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ProfileCard(
                title: profile.title,
                subtitle: profile.subtitle,
                avatarUrl: profile.avatarUrl,
                onLogout: () {
                  context.read<AuthBloc>().add(AuthLogoutRequested());
                },
              ),

              const SizedBox(height: 24),

              const SectionTitle('Параметры'),

              SwitchListTile(
                value: false,
                onChanged: (v) {
                  // TODO: theme bloc / settings bloc
                },
                title: const Text('Тёмная тема'),
                secondary: const Icon(Icons.dark_mode),
              ),

              SwitchListTile(
                value: true,
                onChanged: (v) {
                  // TODO: compact mode
                },
                title: const Text('Компактный режим'),
                secondary: const Icon(Icons.view_compact),
              ),

              ListTile(
                leading: const Icon(Icons.sort),
                title: const Text('Сортировка по умолчанию'),
                subtitle: const Text('По названию'),
                onTap: () {
                  // TODO: выбрать сортировку
                },
              ),

              const SizedBox(height: 24),

              const SectionTitle('О приложении'),

              const ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Версия'),
                subtitle: Text('1.0.0'),
              ),
            ],
          );
        },
      ),
    );
  }
}