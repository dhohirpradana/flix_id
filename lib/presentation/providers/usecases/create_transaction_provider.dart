import 'package:flix_id/domain/usecases/create_transaction/create_transaction.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/transaction_repository/transaction_repository_provider.dart';

part 'create_transaction_provider.g.dart';

@riverpod
CreateTransaction createTransaction(CreateTransactionRef ref) =>
    CreateTransaction(
      transactionRepository: ref.watch(transactionRepositoryProvider),
    );
