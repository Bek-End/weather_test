import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_fox_test/core/formatters/string_helper.dart';
import 'package:it_fox_test/core/widgets/loading_widget.dart';
import 'package:it_fox_test/main.dart';
import 'package:it_fox_test/presentation/auth/bloc/auth_bloc.dart';
import 'package:it_fox_test/presentation/weather/bloc/weather_bloc.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherCompleteState) {
          final data = state.weatherEntity;
          return Scaffold(
            appBar: AppBar(
              title: Text(data.cityName),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogOutEvent());
                  },
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Text('${l10n.temperature}: ${data.temp}°'),
                Text('${l10n.feelsLike}: ${data.feelsLike}°'),
                Text('${l10n.humidity}: ${data.humidity}%'),
                Text('${l10n.weather}: ${data.desc}'),
                Text('${l10n.lastUpdate}: ${StringHelper.formattedDate(data.dateTime)}'),
              ],
            ),
            floatingActionButton: _UpdateIconWidget(
              onTap: () {
                context.read<WeatherBloc>().add(WeatherUpdateEvent());
              },
            ),
          );
        }

        return const Scaffold(
          body: LoadingWidget(),
        );
      },
    );
  }
}

class _UpdateIconWidget extends StatefulWidget {
  const _UpdateIconWidget({required this.onTap});

  final VoidCallback onTap;

  @override
  State<_UpdateIconWidget> createState() => _UpdateIconWidgetState();
}

class _UpdateIconWidgetState extends State<_UpdateIconWidget> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        widget.onTap.call();
        _controller.forward();
      },
      child: RotationTransition(
        turns: _animation,
        child: const Icon(Icons.update),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
