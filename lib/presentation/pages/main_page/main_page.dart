import 'package:flix_id/presentation/extensions/build_context_extension.dart';
import 'package:flix_id/presentation/pages/profile_page/profile_page.dart';
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
                child: ProfilePage(),
              ),
            ],
          ),
          BottomNavBar(
              items: [
                BottomNavBarItem(
                    index: 0,
                    isActive: currentIndex == 0,
                    label: 'Home',
                    icon: 'assets/movie.png',
                    activeIcon: 'assets/movie-selected.png'),
                BottomNavBarItem(
                    index: 1,
                    isActive: currentIndex == 1,
                    label: 'Home',
                    icon: 'assets/ticket.png',
                    activeIcon: 'assets/ticket-selected.png'),
                BottomNavBarItem(
                    index: 2,
                    isActive: currentIndex == 2,
                    label: 'Home',
                    icon: 'assets/profile.png',
                    activeIcon: 'assets/profile-selected.png'),
              ],
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                  pageController.animateToPage(currentIndex,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut);
                });
              },
              currentIndex: currentIndex)
        ],
      ),
    );
  }
}
