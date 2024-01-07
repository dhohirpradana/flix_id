import 'package:flix_id/domain/usecases/get_transactions/get_transactions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/transaction_repository/transaction_repository_provider.dart';

part 'get_transactions_provider.g.dart';

@riverpod
GetTransactions getTransactions(GetTransactionsRef ref) =>
    GetTransactions(transactionRepository: ref.watch(transactionRepositoryProvider));