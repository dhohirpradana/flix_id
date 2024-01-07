import 'package:flix_id/presentation/extensions/build_context_extension.dart';
import 'package:flix_id/presentation/misc/method.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widgets/bottom_nav_bar.dart';
import 'package:flix_id/presentation/widgets/bottom_nav_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/router/router_provider.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    ref.listen(userDataProvider, (previous, next) {
      if (previous != null && next is AsyncData && next.value == null) {
        ref.read(routerProvider).goNamed('login');
      } else if (next is AsyncError) {
        context.showSnackBar(next.error.toString());
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Text(ref.watch(userDataProvider).when(
                    data: (data) => data.toString(),
                    error: (error, stackTrace) => 'Error',
                    loading: () => 'loading')),
                ElevatedButton(
                  onPressed: () {
                    ref.read(userDataProvider.notifier).logout();
                  },
                  child: const Text('Logout'),
                ),
                verticalSpace(50),
              ],
            ),
          ),
          BottomNavBar(items: [
            BottomNavBarItem(
                index: 0,
                isActive: true,
                label: 'Home',
                icon: 'assets/movie.png',
                activeIcon: 'assets/movie-selected.png'),
          ], onTap: (index) {}, currentIndex: 0)
        ],
      ),
    );
  }
}
