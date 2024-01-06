import 'package:flix_id/domain/entities/user.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  final User user;
  const MainPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Text(
          user.toString(),
        ),
      ),
    );
  }
}
