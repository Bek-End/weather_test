import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:it_fox_test/presentation/auth/bloc/auth_bloc.dart';
import 'package:it_fox_test/presentation/auth/screen/sign_in_screen.dart';
import 'package:it_fox_test/core/widgets/loading_widget.dart';
import 'package:it_fox_test/presentation/weather/bloc/weather_bloc.dart';
import 'package:it_fox_test/presentation/weather/screen/weather_screen.dart';

class BlocScope extends StatefulWidget {
  const BlocScope({Key? key}) : super(key: key);

  @override
  State<BlocScope> createState() => _BlocScopeState();
}

class _BlocScopeState extends State<BlocScope> {
  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.I;
    final WeatherBloc weatherBloc = getIt.get();
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => getIt.get()..add(AuthInitEvent())),
        BlocProvider<WeatherBloc>(create: (_) => weatherBloc),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLogInState) return const SignInScreen();

          if (state is AuthCompleteState) {
            weatherBloc.add(WeatherInitEvent());
            return const WeatherScreen();
          }

          return const LoadingWidget();
        },
      ),
    );
  }
}
