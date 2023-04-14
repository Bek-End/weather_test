import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_fox_test/core/formatters/string_helper.dart';
import 'package:it_fox_test/main.dart';
import 'package:it_fox_test/presentation/auth/bloc/auth_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final TextEditingController _usernameController = TextEditingController()
    ..addListener(_listen);
  late final TextEditingController _passwordController = TextEditingController()
    ..addListener(_listen);
  final BehaviorSubject<bool> _activeSubject = BehaviorSubject.seeded(false);

  void _listen() {
    _activeSubject.value =
        StringHelper.isEmailValid(_usernameController.text) &&
            !StringHelper.isNullOrEmpty(_passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.auth),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _CustomTextFormField(
              label: l10n.email,
              controller: _usernameController,
            ),
            const SizedBox(height: 10),
            _CustomTextFormField(
              label: l10n.password,
              controller: _passwordController,
            ),
            const SizedBox(height: 10),
            StreamBuilder<bool>(
              stream: _activeSubject.stream,
              builder: (context, snapshot) {
                return ElevatedButton(
                  onPressed: _activeSubject.value
                      ? () => context.read<AuthBloc>().add(AuthLogInEvent(
                            username: _usernameController.text,
                            password: _passwordController.text,
                          ))
                      : null,
                  child: Text(l10n.signIn),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomTextFormField extends StatelessWidget {
  const _CustomTextFormField({
    required this.label,
    required this.controller,
  });

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(width: 2.0),
    );
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(label),
        border: border,
        focusedBorder: border,
        enabledBorder: border,
        errorBorder: border,
        disabledBorder: border,
        focusedErrorBorder: border,
      ),
    );
  }
}
