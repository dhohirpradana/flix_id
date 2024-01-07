import 'dart:math';

import 'package:flix_id/domain/entities/movie_detail.dart';
import 'package:flix_id/domain/entities/transaction.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/method.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widgets/back_navigation_bar.dart';
import 'package:flix_id/presentation/widgets/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../providers/router/router_provider.dart';
import 'methods/options.dart';

class TimeBookingPage extends ConsumerStatefulWidget {
  final MovieDetail movieDetail;
  const TimeBookingPage(this.movieDetail, {super.key});

  @override
  ConsumerState<TimeBookingPage> createState() => _TimeBookingPageState();
}

class _TimeBookingPageState extends ConsumerState<TimeBookingPage> {
  final List<String> _theaterOptions = [
    'XXI Ciputra World',
    'CGV Grand Indonesia',
    'XXI Plaza Senayan',
    'CGV Mall Kelapa Gading',
    'XXI Mall Cilandak Town Square',
  ];

  final List<DateTime> _dateOptions = List.generate(7, (index) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day + index);
  });

  List<int> _hourOptions = List.generate(8, (index) => 12 + index + 1);

  String? selectedTheater;
  DateTime? selectedDate;
  int? selectedHour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: BackNavigationBar(
                title: widget.movieDetail.title,
                onTap: () => ref.read(routerProvider).pop(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: NetworkImageCard(
                width: MediaQuery.of(context).size.width - 24 - 24,
                height: (MediaQuery.of(context).size.width - 24 - 24) * 0.6,
                borderRadius: 15,
                imageUrl:
                    'https://image.tmdb.org/t/p/w500${widget.movieDetail.backdropPath ?? widget.movieDetail.posterPath}',
                fit: BoxFit.cover,
              ),
            ),
            ...options(
              title: 'Select a Theater',
              options: _theaterOptions,
              selectedOption: selectedTheater,
              onOptionTap: (String option) => setState(() {
                if (option == selectedTheater) return;
                selectedTheater = option;
                final random = Random().nextInt(8 - 3) + 3;
                _hourOptions = _hourOptions =
                    List.generate(random, (index) => 12 + index + 1);
              }),
            ),
            verticalSpace(24),
            ...options(
              title: 'Select a Date',
              options: _dateOptions,
              selectedOption: selectedDate,
              optionToString: (DateTime option) =>
                  DateFormat('EEE, d MMMM y').format(option),
              onOptionTap: (DateTime option) => setState(() {
                selectedDate = option;
                // unset selected hour if it's not available for the selected date
                if (selectedHour != null &&
                    !DateTime(selectedDate!.year, selectedDate!.month,
                            selectedDate!.day, selectedHour!)
                        .isAfter(DateTime.now())) {
                  selectedHour = null;
                }
              }),
            ),
            verticalSpace(24),
            ...options(
              title: 'Select a Time',
              options: _hourOptions,
              selectedOption: selectedHour,
              optionToString: (int option) => '$option:00',
              isOptionEnabled: (int option) =>
                  selectedDate != null &&
                  DateTime(selectedDate!.year, selectedDate!.month,
                          selectedDate!.day, option)
                      .isAfter(DateTime.now()),
              onOptionTap: (int option) => setState(() {
                selectedHour = option;
              }),
            ),
            IgnorePointer(
              ignoring: selectedDate == null ||
                  selectedHour == null ||
                  selectedTheater == null,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: backgroundColor,
                        backgroundColor: (selectedDate == null ||
                                selectedHour == null ||
                                selectedTheater == null)
                            ? Colors.grey
                            : saffron,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (selectedDate == null ||
                            selectedHour == null ||
                            selectedTheater == null) return;
                        Transaction transaction = Transaction(
                          uid: ref.read(userDataProvider).value!.uid,
                          title: widget.movieDetail.title,
                          adminFee: 3000,
                          total: 0,
                          watchingTime: DateTime(
                                  selectedDate!.year,
                                  selectedDate!.month,
                                  selectedDate!.day,
                                  selectedHour!)
                              .microsecondsSinceEpoch,
                          teatherName: selectedTheater!,
                          transactionImage: widget.movieDetail.posterPath,
                        );

                        ref.read(routerProvider).pushNamed('seat-booking',
                            extra: (widget.movieDetail, transaction));
                      },
                      child: const Text('Next')),
                ),
              ),
            )
          ],
        )
      ],
    ));
  }
}
