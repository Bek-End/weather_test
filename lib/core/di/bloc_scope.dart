import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:it_fox_test/main.dart';
import 'package:it_fox_test/presentation/auth/bloc/auth_bloc.dart';
import 'package:it_fox_test/presentation/auth/screen/sign_in_screen.dart';
import 'package:it_fox_test/core/widgets/loading_widget.dart';

class BlocScope extends StatefulWidget {
  const BlocScope({Key? key}) : super(key: key);

  @override
  State<BlocScope> createState() => _BlocScopeState();
}

class _BlocScopeState extends State<BlocScope> {
  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.I;
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => getIt.get()..add(AuthInitEvent())),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLogInState) return const SignInScreen();
          if (state is AuthCompleteState) return const MyHomePage();
          return const LoadingWidget();
        },
      ),
    );
  }
}
