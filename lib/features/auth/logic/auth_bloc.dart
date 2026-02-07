import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/data/models/profile_info.dart';
import 'package:grv/features/settings/data/repos/settings_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part "auth_event.dart"; 
part "auth_state.dart"; 

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final supabase = Supabase.instance.client;
  final repository = SettingsRepository();


  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_login);
    on<AuthLogoutRequested>(_logout);
    on<AuthCheckStatus>(_checkStatus);
  }


  Future<void> _login(AuthLoginRequested event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());

      final response = await supabase.auth.signInWithPassword(
        email: event.email,
        password: event.password,
      );

      final session = response.session;
      if (session == null) {
        emit(AuthError('Неверный логин или пароль'));
        return;
      }
      final userId = session.user.id;
      final profile = await repository.fetchProfile();
      emit(
        AuthAuthenticated(
          userId: userId,
          profile: profile,
        ),
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }


  Future<void> _logout(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      await supabase.auth.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }


  Future<void> _checkStatus(AuthCheckStatus event, Emitter<AuthState> emit) async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      final userId = user.id;
      final profile = await repository.fetchProfile();
      emit(
        AuthAuthenticated(
          userId: userId,
          profile: profile,
        ),
      );
    } else {
      emit(AuthUnauthenticated());
    }
  }
}