// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EmailWidget extends StatefulWidget {
  EmailWidget({key, this.toValidate = false}) : super(key: key);
  late final TextEditingController _textEditingController;
  final bool toValidate;
  static bool _isValid = false;
  String get text => _textEditingController.text.trim();
  bool get isValid => EmailWidget._isValid;

  @override
  State<EmailWidget> createState() => _EmailWidgetState();
}

class _EmailWidgetState extends State<EmailWidget> {
  @override
  void initState() {
    super.initState();
    widget._textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    widget._textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget._textEditingController,
        decoration: const InputDecoration(
            border: OutlineInputBorder(), hintText: 'Email'),
        autovalidateMode:
            widget.toValidate ? AutovalidateMode.onUserInteraction : null,
        validator: (email) {
          return widget.toValidate && email != ''
              ? !EmailValidator.validate(email!)
                  ? 'Enter a valid email'
                  : validating()
              : null;
        });
  }

  String? validating() {
    EmailWidget._isValid = true;
    return null;
  }
}
