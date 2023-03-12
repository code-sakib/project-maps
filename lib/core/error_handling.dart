import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({key, required this.errMsg}) : super(key: key);
  final String? errMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Unable to display😕: ${errMsg ?? 'ERROR'}'),
      ),
    );
  }
}
