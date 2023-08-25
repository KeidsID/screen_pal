import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:screen_pal/interfaces/router/navigate_paths.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        if (constraints.maxWidth >= 600) {
          return _WideDeviceLayout(child: child);
        }

        return _ThinDeviceLayout(child: child);
      },
    );
  }
}

class _NavBarDelegate {
  _NavBarDelegate(this.icon, this.label);

  final Icon icon;
  final String label;
}

final _navs = [
  _NavBarDelegate(const Icon(Icons.movie_outlined), 'Movie'),
  _NavBarDelegate(const Icon(Icons.tv_outlined), 'Series'),
];

ValueChanged<int> _onNavBarItemTap(BuildContext context) {
  return (value) => value == 0
      ? context.go(NavigatePaths.movies)
      : context.go(NavigatePaths.series);
}

int _currentNavIndex(BuildContext context) {
  final currentRoute = GoRouterState.of(context).uri.path;

  return currentRoute == '/movies' ? 0 : 1;
}

class _ThinDeviceLayout extends StatelessWidget {
  const _ThinDeviceLayout({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        onTap: _onNavBarItemTap(context),
        currentIndex: _currentNavIndex(context),
        items: _navs
            .map((e) => BottomNavigationBarItem(
                  icon: e.icon,
                  label: e.label,
                ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
        tooltip: 'Settings',
        onPressed: () => context.go(NavigatePaths.settings),
        child: const Icon(Icons.settings),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _WideDeviceLayout extends StatelessWidget {
  const _WideDeviceLayout({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          NavigationRail(
            labelType: NavigationRailLabelType.selected,
            onDestinationSelected: _onNavBarItemTap(context),
            selectedIndex: _currentNavIndex(context),
            destinations: _navs
                .map((e) => NavigationRailDestination(
                      icon: e.icon,
                      label: Text(e.label),
                    ))
                .toList(),
            trailing: Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      tooltip: 'Settings',
                      onPressed: () => context.go(NavigatePaths.settings),
                      icon: const Icon(Icons.settings),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const VerticalDivider(width: 2.0, thickness: 2.0),
          Expanded(
            child: Scaffold(
              body: child,
            ),
          )
        ],
      ),
    );
  }
}