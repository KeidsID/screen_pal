import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:screen_pal/configs/constants.dart';

import 'package:screen_pal/interfaces/router/app_navigator.dart';

// test utils:

// To test which nav bar are rendered (BottomNavBar or NavRail).
const _navBarKey = Key('navigation-bar');

// to test navigations.
const _moviesNav = Key('nav-movies');
const _tvShowsNav = Key('nav-tv-shows');
const _settingsNav = Key('nav-settings');

class HomeViewLayout extends StatelessWidget {
  const HomeViewLayout({
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
  _NavBarDelegate({
    required this.icon,
    required this.label,
    Icon? activeIcon,
  }) : activeIcon = activeIcon ?? icon;

  final Icon icon;
  final String label;
  final Icon activeIcon;
}

final _navs = [
  _NavBarDelegate(
    icon: const Icon(key: _moviesNav, Icons.movie_outlined),
    label: 'Movies',
    activeIcon: const Icon(key: _moviesNav, Icons.movie),
  ),
  _NavBarDelegate(
    icon: const Icon(key: _tvShowsNav, Icons.tv_outlined),
    label: 'Tv Shows',
    activeIcon: const Icon(key: _tvShowsNav, Icons.tv),
  ),
  _NavBarDelegate(
    icon: const Icon(key: _settingsNav, Icons.settings_outlined),
    label: 'Settings',
    activeIcon: const Icon(key: _settingsNav, Icons.settings),
  ),
];

ValueChanged<int> _onNavBarItemTap(BuildContext context) {
  return (value) {
    if (_currentNavIndex(context) == value) return;

    switch (value) {
      case 0:
        AppNavigator.movies(context);
        break;
      case 1:
        AppNavigator.tvShows(context);
        break;
      default:
        AppNavigator.settings(context);
    }
  };
}

int _currentNavIndex(BuildContext context) {
  final currentRoute = GoRouterState.of(context).uri.path;

  if (currentRoute.startsWith('/settings')) return 2;

  return currentRoute.startsWith('/movies') ? 0 : 1;
}

class _ThinDeviceLayout extends StatelessWidget {
  const _ThinDeviceLayout({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        key: _navBarKey,
        onTap: _onNavBarItemTap(context),
        currentIndex: _currentNavIndex(context),
        items: _navs
            .map((e) => BottomNavigationBarItem(
                  icon: e.icon,
                  label: e.label,
                  activeIcon: e.activeIcon,
                ))
            .toList(),
      ),
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
          const _DynamicNavRail(key: _navBarKey),
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

class _DynamicNavRail extends StatefulWidget {
  const _DynamicNavRail({super.key});

  @override
  State<_DynamicNavRail> createState() => _DynamicNavRailState();
}

class _DynamicNavRailState extends State<_DynamicNavRail> {
  bool isExtended = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _setIsExtended(value: true),
      onExit: (_) => _setIsExtended(value: false),
      child: NavigationRail(
        key: widget.key,
        extended: isExtended,
        onDestinationSelected: (navIndex) {
          _setIsExtended(value: false);

          _onNavBarItemTap(context)(navIndex);
        },
        selectedIndex: _currentNavIndex(context),
        destinations: _navs
            .map((e) => NavigationRailDestination(
                  icon: e.icon,
                  label: Text(e.label),
                  selectedIcon: e.activeIcon,
                ))
            .toList(),
        trailing: kIsMobile
            ? Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        tooltip: (isExtended) ? 'Shrink' : 'Extend',
                        onPressed: () => _setIsExtended(),
                        icon: Icon(
                          (isExtended)
                              ? Icons.chevron_left
                              : Icons.chevron_right,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : null,
      ),
    );
  }

  /// Prevent unnecessary widget rebuild on updating state.
  void _setIsExtended({bool? value}) {
    if (value == null) return setState(() => isExtended = !isExtended);

    return (value)
        ? ((!isExtended) ? setState(() => isExtended = true) : null)
        : ((isExtended) ? setState(() => isExtended = false) : null);
  }
}
