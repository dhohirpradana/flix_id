import 'dart:math';

import 'package:flix_id/domain/entities/movie_detail.dart';
import 'package:flix_id/domain/entities/transaction.dart';
import 'package:flix_id/presentation/misc/method.dart';
import 'package:flix_id/presentation/pages/seat_booking_page/methods/movie_screen.dart';
import 'package:flix_id/presentation/pages/seat_booking_page/methods/seat_section.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/widgets/back_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../misc/constants.dart';
import '../../widgets/seat.dart';
import 'methods/legend.dart';

class SeatBookingPage extends ConsumerStatefulWidget {
  final (MovieDetail, Transaction) transactionDetail;

  const SeatBookingPage({super.key, required this.transactionDetail});

  @override
  ConsumerState<SeatBookingPage> createState() => _SeatBookingPageState();
}

class _SeatBookingPageState extends ConsumerState<SeatBookingPage> {
  List<int> selectedSeats = [];
  List<int> bookedSeats = [];

  @override
  void initState() {
    super.initState();
    Random random = Random();
    int numberOfBookedSeats = random.nextInt(36) + 1;

    while (bookedSeats.length < 8) {
      if (!bookedSeats.contains(numberOfBookedSeats)) {
        bookedSeats.add(numberOfBookedSeats);
      }
      numberOfBookedSeats = random.nextInt(36) + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final (movieDetail, transaction) = widget.transactionDetail;
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              BackNavigationBar(
                movieDetail.title,
                onTap: () => ref.read(routerProvider).pop(),
              ),
              movieScreen(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  seatSection(
                    seatNumbers: List.generate(18, (index) => index + 1),
                    onTap: onSeatTap,
                    seatStatusChecker: seatStatusChecker,
                  ),
                  horizontalSpace(30),
                  seatSection(
                    seatNumbers: List.generate(18, (index) => index + 19),
                    onTap: onSeatTap,
                    seatStatusChecker: seatStatusChecker,
                  ),
                ],
              ),
              verticalSpace(20),
              legend(),
              verticalSpace(40),
              Text(
                '${selectedSeats.length} seats selected',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalSpace(40),
              IgnorePointer(
                ignoring: selectedSeats.isEmpty,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      var updatedTransaction = transaction.copyWith(
                          seats: selectedSeats
                              .map((seat) => seat.toString())
                              .toList(),
                          ticketAmount: selectedSeats.length,
                          ticketPrice: 30000);

                      ref.read(routerProvider).pushNamed('booking-confirmation',
                          extra: (movieDetail, updatedTransaction));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: backgroundColor,
                      backgroundColor:
                          selectedSeats.isEmpty ? Colors.grey : saffron,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Next'),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ));
  }

  void onSeatTap(int seatNumber) {
    if (selectedSeats.contains(seatNumber)) {
      selectedSeats.remove(seatNumber);
    } else {
      selectedSeats.add(seatNumber);
    }
    setState(() {});
  }

  SeatStatus seatStatusChecker(int seatNumber) {
    if (bookedSeats.contains(seatNumber)) {
      return SeatStatus.booked;
    } else if (selectedSeats.contains(seatNumber)) {
      return SeatStatus.selected;
    } else {
      return SeatStatus.available;
    }
  }
}
