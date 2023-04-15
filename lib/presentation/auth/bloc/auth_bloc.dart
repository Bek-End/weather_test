import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:it_fox_test/domain/usecases/auth.usecase.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthLoadingState()) {
    final AuthUsecase authUsecase = GetIt.I.get();

    on<AuthInitEvent>((event, emit) async {
      final hasToken = await authUsecase.hasToken();
      emit(hasToken ? AuthCompleteState() : AuthLogInState());
    });

    on<AuthLogInEvent>((event, emit) async {
      await authUsecase.logIn(
        username: event.username,
        password: event.password,
      );
      add(AuthInitEvent());
    });

    on<AuthLogOutEvent>((event, emit) async {
      await authUsecase.logOut();
      emit(AuthLogInState());
    });
  }
}

@immutable
abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitEvent extends AuthEvent {}

class AuthLogInEvent extends AuthEvent {
  AuthLogInEvent({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  @override
  List<Object?> get props => [super.props, username, password];
}

class AuthLogOutEvent extends AuthEvent {}

@immutable
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthLoadingState extends AuthState {}

class AuthLogInState extends AuthState {}

class AuthCompleteState extends AuthState {}
