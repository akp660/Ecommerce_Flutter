import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final String error;

  AppErrorWidget({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(error, style: TextStyle(color: Colors.red, fontSize: 16)),
      ),
    );
  }
}
