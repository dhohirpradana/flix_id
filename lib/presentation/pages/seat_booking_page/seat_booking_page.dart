import 'package:flix_id/domain/entities/movie_detail.dart';
import 'package:flix_id/domain/entities/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeatBookingPage extends ConsumerStatefulWidget {
  final (MovieDetail, Transaction) transactionDetail;

  const SeatBookingPage({super.key, required this.transactionDetail});

  @override
  ConsumerState<SeatBookingPage> createState() => _SeatBookingPageState();
}

class _SeatBookingPageState extends ConsumerState<SeatBookingPage> {
  @override
  Widget build(BuildContext context) {
    final (movieDetail, transaction) = widget.transactionDetail;
    return Scaffold(
      body: Center(
        child: Text(
          transaction.toString(),
        ),
      ),
    );
  }
}
