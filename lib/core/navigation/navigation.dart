import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socialapp/feature/whatshot/home/screens/home_screen_hot.dart';
import 'package:socialapp/theme/theme.dart';

class Navigation extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const Navigation(),
      );
  const Navigation({super.key});

  @override
  ConsumerState<Navigation> createState() => _NavigationState();
}

class _NavigationState extends ConsumerState<Navigation> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeNotifierProvider);

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: theme.indicatorColor,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.whatshot),
            icon: Icon(Icons.whatshot_outlined),
            label: 'What\'s Hot',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.newspaper),
            icon: Icon(Icons.newspaper_outlined),
            label: 'News',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.school),
            icon: Icon(Icons.school_outlined),
            label: 'Academics',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: const [
          WhatshotHomeScreen(),
          NewsPage(),
          AcademicsPage(),
          SettingsPage(),
        ],
      ),
    );
  }
}

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'News',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

class AcademicsPage extends StatelessWidget {
  const AcademicsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Academics',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Settings',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
