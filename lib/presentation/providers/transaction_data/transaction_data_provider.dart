import 'package:flix_id/domain/entities/user.dart';
import 'package:flix_id/domain/usecases/get_transactions/get_transactions_param.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/result.dart';
import '../../../domain/entities/transaction.dart';
import '../../../domain/usecases/get_transactions/get_transactions.dart';
import '../usecases/get_transactions_provider.dart';
import '../user_data/user_data_provider.dart';

part 'transaction_data_provider.g.dart';

@riverpod
class TransactionData extends _$TransactionData {
  @override
  Future<List<Transaction>?> build() async {
    User? user = ref.read(userDataProvider).valueOrNull;

    if (user != null) {
      state = const AsyncLoading();
      GetTransactions getTransactions = ref.read(getTransactionsProvider);

      var result = await getTransactions(GetTransactionsParam(uid: user.uid));

      if (result case Success(value: final transactions)) {
        return transactions;
      }

      return const [];
    }
  }

  Future<void> refreshTransactionData() async {
    User? user = ref.read(userDataProvider).valueOrNull;

    if (user != null) {
      state = const AsyncLoading();
      GetTransactions getTransactions = ref.read(getTransactionsProvider);

      var result = await getTransactions(GetTransactionsParam(uid: user.uid));

      switch (result) {
        case Success(value: final transactions):
          state = AsyncData(transactions);
        case Failed(:final message):
          state = AsyncError(FlutterError(message), StackTrace.current);
          state = AsyncData(state.valueOrNull ?? []);
      }
    }
  }
}
