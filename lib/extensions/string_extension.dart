import 'package:flutter/material.dart';

extension StringExtension on String {
  String? isEmptyValueLength(BuildContext context,
      {String? emptyMessage, String? lengthMessage, int length = 2}) {
    if (isEmpty) {
      return emptyMessage;
    } else if (trim().length < length) {
      return lengthMessage;
    } else {
      return null;
    }
  }

  String? isEmptyValue(BuildContext context, {required String message}) {
    if (isEmpty) {
      return message;
    } else {
      return null;
    }
  }
}
