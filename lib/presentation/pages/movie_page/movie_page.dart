import 'package:flix_id/presentation/misc/method.dart';
import 'package:flix_id/presentation/pages/movie_page/methods/movie_list.dart';
import 'package:flix_id/presentation/providers/movie/now_playing_provider.dart';
import 'package:flix_id/presentation/providers/movie/upcoming_provider.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/user_data/user_data_provider.dart';
import 'methods/promotion_list.dart';
import 'methods/search_bar.dart';
import 'methods/user_info.dart';

class MoviePage extends ConsumerWidget {
  final List<String> promotionImageFileNames = const [
    'popcorn.jpg',
    'buy1get1.jpg',
  ];
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.read(userDataProvider.notifier).refreshUserData();
      },
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userInfo(ref),
              verticalSpace(40),
              searchBar(context),
              verticalSpace(24),
              ...movieList(
                title: 'Now Playing',
                movies: ref.watch(nowPlayingProvider),
                onTap: (movie) {
                  ref.read(routerProvider).pushNamed('detail', extra: movie);
                },
              ),
              verticalSpace(30),
              ...promotionList(promotionImageFileNames),
              verticalSpace(30),
              ...movieList(
                title: 'Upcoming',
                movies: ref.watch(upcomingProvider),
              ),
              verticalSpace(100)
            ],
          )
        ],
      ),
    );
  }
}
