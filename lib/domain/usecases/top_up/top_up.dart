import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/entities/transaction.dart';
import 'package:flix_id/domain/usecases/create_transaction/create_transaction.dart';

import '../../../data/repositories/transaction_repository.dart';
import '../create_transaction/create_transaction_param.dart';
import '../usecase.dart';
import 'top_up_param.dart';

class TopUp implements UseCase<Result<void>, TopUpParam> {
  final TransactionRepository _transactionRepository;

  TopUp({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;

  @override
  Future<Result<void>> call(TopUpParam params) async {
    CreateTransaction createTransaction =
        CreateTransaction(transactionRepository: _transactionRepository);

    int transactionTime = DateTime.now().millisecondsSinceEpoch;

    var createTransactionResult = await createTransaction.call(
        CreateTransactionParam(
            transaction: Transaction(
                uid: params.userId,
                title: 'Top Up',
                adminFee: 0,
                total: -params.amount,
                transactionTime: transactionTime,
                id: 'flxtp-$transactionTime-${params.userId}')));

    return switch (createTransactionResult) {
      Success(value: final _) => const Result.success(null),
      Failed(message: _) => const Result.failed('Failed to top up'),
    };
  }
}
