import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed
class Transaction with _$Transaction {

  factory Transaction({
    String? id,
    required String uid,
    int? transactionTime,
    String? transactionImage,
    required String title,
    @Default([]) List<String>? seats,
    String? teatherName,
    int? watchingTime,
    int? ticketAmount,
    int? ticketPrice,
    required int adminFee,
    required int totalPrice,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
}