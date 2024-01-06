import 'package:flix_id/domain/usecases/login/login.dart';
import 'package:flix_id/presentation/pages/main_page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/result.dart';
import '../../providers/repositories/user_repository/usecases/login_provider.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Login login = ref.watch(loginProvider);
              login(LoginParams(email: "dhohir.pradana@icloud.com", password: "2wsx1qaz"))
                  .then((result) {
                if (result is Success) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          MainPage(user: result.resultValue!)));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(result.errorMessage!)));
                }
              });
            },
            child: const Text('Login')),
      ),
    );
  }
}
