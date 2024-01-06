import 'package:flix_id/domain/usecases/usecase.dart';

import '../../../data/repositories/transaction_repository.dart';
import '../../entities/result.dart';
import 'create_transaction_param.dart';

class CreateTransaction
    implements UseCase<Result<void>, CreateTransactionParam> {
  final TransactionRepository _transactionRepository;

  CreateTransaction({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;

  @override
  Future<Result<void>> call(CreateTransactionParam params) async {
    int transactionTime = DateTime.now().millisecondsSinceEpoch;
    final result = await _transactionRepository.createTransaction(
        transaction: params.transaction.copyWith(
            transactionTime: transactionTime,
            id: params.transaction.id ?? 'flx-$transactionTime-${params.transaction.uid}'));

    return switch (result) {
      Success(value: final _) => const Result.success(null),
      Failed(message: final message) => Result.failed(message),
    };
  }
}
