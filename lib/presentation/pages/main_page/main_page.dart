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
  PageController pageController = PageController();
  int currentIndex = 0;

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
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            children: const [
              Center(
                child: Text('Movies Page'),
              ),
              Center(
                child: Text('Ticket Page'),
              ),
              Center(
                child: Text('Profile Page'),
              ),
            ],
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
