import 'package:intl/intl.dart';

abstract class StringHelper {
  const StringHelper._();

  static final _emailRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\])|(([a-zA-Z\-\d]+\.)+[a-zA-Z]{2,}))$',
  );

  static bool isNullOrEmpty(String? value) => value == null || value.isEmpty;

  static bool isEmailValid(String? value) {
    return !isNullOrEmpty(value) && _emailRegExp.hasMatch(value!);
  }

  static String formattedDate(DateTime dateTime) {
    return DateFormat('dd.MM.yyyy HH:mm').format(dateTime);
  }
}
