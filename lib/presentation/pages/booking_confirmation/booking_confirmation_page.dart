import 'package:flix_id/domain/entities/movie_detail.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/usecases/create_transaction/create_transaction.dart';
import 'package:flix_id/domain/usecases/create_transaction/create_transaction_param.dart';
import 'package:flix_id/presentation/extensions/build_context_extension.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/method.dart';
import 'package:flix_id/presentation/pages/booking_confirmation/methods/transaction_row.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widgets/back_navigation_bar.dart';
import 'package:flix_id/presentation/widgets/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/transaction.dart';
import '../../providers/usecases/create_transaction_provider.dart';

class BookingCnfirmationPage extends ConsumerWidget {
  final (MovieDetail, Transaction) transactionDetail;

  const BookingCnfirmationPage({required this.transactionDetail, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var (movieDetail, transaction) = transactionDetail;

    transaction = transaction.copyWith(
      total: transaction.ticketAmount! * transaction.ticketPrice! +
          transaction.adminFee,
    );

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
            child: Column(
              children: [
                BackNavigationBar(
                  'Booking Confirmation',
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                verticalSpace(24),
                NetworkImageCard(
                  width: MediaQuery.of(context).size.width - 24 - 24,
                  height: (MediaQuery.of(context).size.height - 24 - 24) * 0.6,
                  borderRadius: 15,
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500${movieDetail.backdropPath ?? movieDetail.posterPath}',
                  fit: BoxFit.cover,
                ),
                verticalSpace(24),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 24 - 24,
                  child: Text(
                    movieDetail.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                verticalSpace(5),
                const Divider(color: ghostWhite),
                verticalSpace(5),
                transactionRow(
                  title: 'Showing Date',
                  value: DateFormat('EEEE d MMMM y').format(
                      DateTime.fromMicrosecondsSinceEpoch(
                          transaction.transactionTime ?? 0)),
                  width: MediaQuery.of(context).size.width - 24 - 24,
                ),
                transactionRow(
                  title: 'Theater',
                  value: transaction.teatherName ?? '',
                  width: MediaQuery.of(context).size.width - 24 - 24,
                ),
                transactionRow(
                  title: 'Seat Numbers',
                  value: transaction.seats?.join(', ') ?? '',
                  width: MediaQuery.of(context).size.width - 24 - 24,
                ),
                transactionRow(
                  title: '# of Tickets',
                  value:
                      '${transaction.ticketAmount?.toString() ?? ''} ticket(s)',
                  width: MediaQuery.of(context).size.width - 24 - 24,
                ),
                transactionRow(
                  title: 'Ticket Price',
                  value: NumberFormat.currency(
                          locale: 'id', symbol: 'IDR ', decimalDigits: 0)
                      .format(transaction.ticketPrice),
                  width: MediaQuery.of(context).size.width - 24 - 24,
                ),
                transactionRow(
                  title: 'Admin Fee',
                  value: NumberFormat.currency(
                          locale: 'id', symbol: 'IDR ', decimalDigits: 0)
                      .format(transaction.adminFee),
                  width: MediaQuery.of(context).size.width - 24 - 24,
                ),
                const Divider(color: ghostWhite),
                transactionRow(
                  title: 'Total',
                  value: NumberFormat.currency(
                          locale: 'id', symbol: 'IDR ', decimalDigits: 0)
                      .format(transaction.total),
                  width: MediaQuery.of(context).size.width - 24 - 24,
                ),
                verticalSpace(40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      int transactionTime =
                          DateTime.now().millisecondsSinceEpoch;

                      transaction = transaction.copyWith(
                          transactionTime: transactionTime,
                          id: 'flx-$transactionTime-${transaction.uid}');

                      CreateTransaction createTransaction =
                          ref.read(createTransactionProvider);

                      await createTransaction(
                              CreateTransactionParam(transaction: transaction))
                          .then((result) {
                        switch (result) {
                          case Success(value: _):
                            ref
                                .read(transactionDataProvider.notifier)
                                .refreshTransactionData();
                            ref
                                .read(userDataProvider.notifier)
                                .refreshUserData();
                            ref.read(routerProvider).goNamed('main');
                          case Failed(:final message):
                            context.showSnackBar(message);
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: backgroundColor,
                      backgroundColor: saffron,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Pay Now'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
