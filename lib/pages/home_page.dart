import 'package:escanio_app/components/loading.dart';
import 'package:escanio_app/models/history_model.dart';
import 'package:escanio_app/pages/favorite_page.dart';
import 'package:escanio_app/pages/history_page.dart';
import 'package:escanio_app/pages/user_page.dart';
import 'package:escanio_app/services/history_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageController = PageController(initialPage: 0);
  void onPageChanged(int index) {
    setState(() {
      // previousIndex = currentIndex;
      currentIndex = index;
    });
  }

  int previousIndex = 0;
  int currentIndex = 0;
  void onTap(int index) {
    if (currentIndex == 0 && index == 2) {
      setState(() {
        previousIndex = 0;
      });
    } else {
      setState(() {
        previousIndex = 1;
      });
    }
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  final history = <HistoryModel>[];

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Visibility(
        visible: currentIndex != 2,
        child: NavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
        ),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: HistoryService.all,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Loading();
            }

            history.clear();
            history.addAll(snapshot.data!.docs.map((e) => e.data()));

            return PageView(
              controller: pageController,
              onPageChanged: onPageChanged,
              children: [
                HistoryPage(history: history),
                FavoritesPage(
                  favourites:
                      history.where((element) => element.isFavourite).toList(),
                ),
                UserPage(
                  history: history,
                  onBack: () {
                    pageController.animateToPage(
                      previousIndex,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  onFavourite: () {
                    pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  onHistory: () {
                    pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class NavigationBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const NavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      currentIndex: currentIndex,
      selectedItemColor: Colors.white,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
              currentIndex == 0 ? Icons.home_rounded : Icons.home_outlined),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon:
              Icon(currentIndex == 1 ? Icons.favorite : Icons.favorite_border),
          label: "Favoritos",
        ),
        BottomNavigationBarItem(
          icon: Icon(currentIndex == 2
              ? Icons.person_rounded
              : Icons.person_outline_rounded),
          label: "Conta",
        ),
      ],
    );
  }
}
