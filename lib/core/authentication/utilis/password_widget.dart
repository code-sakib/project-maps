// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class PasswordWidget extends StatefulWidget {
  PasswordWidget({key}) : super(key: key);
  late final TextEditingController _textEditingController;

  String get text => _textEditingController.text.trim();

  bool _isValid = false;
  bool get isValid => _isValid;

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  static bool _obscure = true;
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
      obscureText: _obscure,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return widget._textEditingController.text.length < 6
            ? 'Enter minimum 6 characters'
            : validating();
      },
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: 'Password',
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscure = !_obscure;
                });
              },
              icon: _obscure
                  ? const Icon(Icons.visibility_rounded)
                  : const Icon(Icons.visibility_off_rounded))),
    );
  }

  String? validating() {
    widget._isValid = true;
    return null;
  }
}
