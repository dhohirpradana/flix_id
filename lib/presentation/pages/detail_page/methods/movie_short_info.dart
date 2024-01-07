import 'package:flix_id/presentation/misc/method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/movie_detail.dart';

List<Widget> movieShortInfo(
        {required AsyncValue<MovieDetail?> asyncMovieDetail,
        required BuildContext context}) =>
    [
      Row(
        children: [
          SizedBox(
            height: 14,
            width: 14,
            child: Image.asset('assets/duration.png'),
          ),
          horizontalSpace(5),
          SizedBox(
            width: 95,
            child: Text(
              '${asyncMovieDetail.when(data: (movieDetail) => movieDetail != null ? '${movieDetail.runtime}' : '-', error: (error, stackTrace) => '-', loading: () => '-')} minutes',
              style: const TextStyle(fontSize: 12),
            ),
          ),
          SizedBox(
            width: 14,
            height: 14,
            child: Image.asset('assets/genre.png'),
          ),
          horizontalSpace(5),
          // margin - 24 * 2
          // text width - 95
          // image width duration - 14
          // image width genre - 14
          // horizontal space - 5 * 2
          SizedBox(
            width: MediaQuery.of(context).size.width -
                24 -
                24 -
                95 -
                14 -
                14 -
                5 -
                5,
            child: asyncMovieDetail.when(
              data: (movieDetail) {
                String genres = movieDetail?.genres.join(', ') ?? '-';
                return Text(
                  genres,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                );
              },
              error: (error, stackTrace) =>
                  const Text('-', style: TextStyle(fontSize: 12)),
              loading: () => const Text('-', style: TextStyle(fontSize: 12)),
            ),
          )
        ],
      ),
      verticalSpace(10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 18,
            height: 18,
            child: Image.asset('assets/star.png'),
          ),
          horizontalSpace(5),
          Text(asyncMovieDetail.valueOrNull?.voteAverage.toString() ?? '0',
              style: const TextStyle(fontSize: 12)),
        ],
      )
    ];
