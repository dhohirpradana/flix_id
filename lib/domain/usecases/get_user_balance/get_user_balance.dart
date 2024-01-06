import 'package:flix_id/data/repositories/user_repository.dart';
import 'package:flix_id/domain/usecases/usecase.dart';

import '../../entities/result.dart';
import 'get_user_balance_param.dart';

class GetUserBalance implements UseCase<Result<int>, GetUserBalanceParam> {
  final UserRepository _userRepository;

  GetUserBalance({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Result<int>> call(GetUserBalanceParam params) =>
      _userRepository.getUserBalance(uid: params.userId);
}
