
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    required String uid,
    required String name,
    required String email,
    String? photoUrl,
    @Default(0) int balance,
  }) = _User;
	
  factory User.fromJson(Map<String, dynamic> json) =>
			_$UserFromJson(json);
}
