import 'dart:io';

import 'package:flix_id/domain/entities/user.dart';
import 'package:flix_id/domain/usecases/get_logged_in_user/get_logged_in_user.dart';
import 'package:flix_id/domain/usecases/login/login.dart';
import 'package:flix_id/domain/usecases/register/register.dart';
import 'package:flix_id/domain/usecases/register/register_param.dart';
import 'package:flix_id/domain/usecases/top_up/top_up_param.dart';
import 'package:flix_id/domain/usecases/upload_profile_picture/upload_profile_picture.dart';
import 'package:flix_id/presentation/providers/movie/now_playing_provider.dart';
import 'package:flix_id/presentation/providers/movie/upcoming_provider.dart';
import 'package:flix_id/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:flix_id/presentation/providers/usecases/register_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/result.dart';
import '../../../domain/usecases/top_up/top_up.dart';
import '../../../domain/usecases/upload_profile_picture/upload_profile_picture_param.dart';
import '../usecases/get_loggen_in_user_provider.dart';
import '../usecases/login_provider.dart';
import '../usecases/logout_provider.dart';
import '../usecases/register_provider.dart';
import '../usecases/top_up_provider.dart';
import '../usecases/upload_profile_picture_provider.dart';

part 'user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class UserData extends _$UserData {
  @override
  Future<User?> build() async {
    GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);

    var userResult = await getLoggedInUser(null);

    switch (userResult) {
      case Success(value: final user):
        _getMovies();
        return user;
      case Failed(message: _):
        return null;
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();

    Login login = ref.read(loginProvider);

    var result = await login(LoginParam(password: password, email: email));

    switch (result) {
      case Success(value: final user):
        _getMovies();
        state = AsyncData(user);
      case Failed(message: final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> register(
      {required String email,
      required String password,
      required String name}) async {
    state = const AsyncLoading();

    Register register = ref.read(registerProvider);

    var result = await register(
        RegisterParam(password: password, email: email, name: name));

    switch (result) {
      case Success(value: final user):
        _getMovies();
        state = AsyncData(user);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> refreashUserData() async {
    state = const AsyncLoading();

    GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);

    var result = await getLoggedInUser(null);

    if (result case Success(value: final user)) {
      state = AsyncData(user);
    }
  }

  Future<void> logout() async {
    var logout = ref.read(logoutProvider);
    var result = await logout(null);

    switch (result) {
      case Success(value: _):
        state = const AsyncData(null);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = AsyncData(state.valueOrNull);
    }
  }

  Future<void> topUp(int amount) async {
    TopUp topUp = ref.read(topUpProvider);
    String? userId = state.valueOrNull?.uid;

    if (userId != null) {
      var result = await topUp(TopUpParam(userId: userId, amount: amount));

      if (result.isSuccess) {
        refreashUserData();
        ref.read(transactionDataProvider.notifier).refreshTransactionData();
      }
    }
  }

  Future<void> uploadProfilePicture(
      {required User user, required File imageFile}) async {
    UploadProfilePicture uploadProfilePicture =
        ref.read(uploadProfilePictureProvider);

    var result = await uploadProfilePicture(
        UploadProfilePictureParam(user: user, imageFile: imageFile));

    if (result case Success(value: final user)) {
      state = AsyncData(user);
    }
  }

  void _getMovies() {
    ref.read(nowPlayingProvider.notifier).getMovies();
    ref.read(upcomingProvider.notifier).getMovies();
  }
}
