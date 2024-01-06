import 'package:flix_id/domain/entities/result.dart';

import '../repositories/authentication.dart';

class DummyAuthentication implements Authentication {
  @override
  String? getLoggedInUserId() {
    // TODO: implement getLoggedInUserId
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> login({required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 1));
    // return Future.value(const Result.success('ID-12345'));
    return const Result.failed('Gagal login');
  }

  @override
  Future<Result<void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> register({required String username, required String password}) {
    // TODO: implement register
    throw UnimplementedError();
  }
}