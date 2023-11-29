import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_rebuild_issue/app_routes.dart';
import 'package:go_router_rebuild_issue/custom_breakpoints.dart';

/// [NavigationPage] contains [NavigationBar], [NavigationRail] and [Drawer].
/// This is the root page which controls navigation of the app
/// This also contains the [Drawer] widget
class NavigationPage extends StatefulWidget {
  /// Creates NavigationPage with [key] and
  /// required argument [child] which will be the body
  /// This is used along which [ShellRoute] to make [NavigationBar] and
  /// [NavigationRail] show along the widget at the bottom or left
  const NavigationPage({required this.child, super.key});

  /// The widget to display in the body of the [AdaptiveLayout]
  final Widget child;

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with WidgetsBindingObserver {
  /// Pages used in [NavigationRail]
  late List<NavigationRailDestination> railDestinations;

  /// Pages used in [BottomNavigationBarItem]

  late List<BottomNavigationBarItem> destinations;

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  /// Navigates to appropriate route using the [index] via [GoRouter]
  void onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRoute.dashboard.location);
      case 1:
        {
          context.go(AppRoute.list.location);
        }
    }
  }

  final navigationRailPadding = const EdgeInsets.symmetric(
    vertical: 24,
  );

  @override
  Widget build(BuildContext context) {
    /// initializing destinations with pages
    railDestinations = [
      NavigationRailDestination(
        icon: const Icon(Icons.home_outlined),
        selectedIcon: const Icon(Icons.home_filled),
        label: const Text('Home'),
        padding: navigationRailPadding,
      ),
      NavigationRailDestination(
        icon: const Icon(Icons.data_thresholding_outlined),
        selectedIcon: const Icon(Icons.data_thresholding_rounded),
        label: const Text('List'),
        padding: navigationRailPadding,
      ),
    ];

    destinations = [
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.home_outlined,
        ),
        activeIcon: Icon(
          Icons.home_filled,
        ),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.data_thresholding_outlined,
        ),
        activeIcon: Icon(
          Icons.data_thresholding_rounded,
        ),
        label: 'List',
      ),
    ];

    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: AdaptiveLayout(
            // Body is shown in all breakpoints
            body: SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.standard: SlotLayout.from(
                  key: const Key('rootBody'),
                  builder: (_) => widget.child,
                ),
              },
            ),

            // BottomNavigation is only shown in mobile and tablet portrait view
            bottomNavigation: SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                CustomBreakpoints.mobileAndTablet: SlotLayout.from(
                  key: const Key('navigationBar'),
                  inAnimation: AdaptiveScaffold.bottomToTop,
                  outAnimation: AdaptiveScaffold.topToBottom,
                  builder: (_) => AnimatedContainer(
                    height: 50,
                    duration: const Duration(milliseconds: 500),
                    child: Wrap(
                      children: [
                        BottomNavigationBar(
                          elevation: 0,
                          selectedLabelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          type: BottomNavigationBarType.fixed,
                          items: destinations,
                          currentIndex: 0,
                          onTap: (idx) => onItemTapped(idx, context),
                          selectedIconTheme: IconThemeData(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          selectedFontSize: 12,
                          iconSize: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              },
            ),

            // NavigationRail only shown in tablet landscape view
            secondaryNavigation: SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.large: SlotLayout.from(
                  key: const Key('navigationRail'),
                  inAnimation: AdaptiveScaffold.leftOutIn,
                  builder: (_) => AdaptiveScaffold.standardNavigationRail(
                    padding: EdgeInsets.zero,
                    groupAlignment: 1,
                    destinations: railDestinations,
                    unselectedIconTheme: const IconThemeData(
                      size: 18,
                    ),
                    selectedIconTheme: IconThemeData(
                      color: Theme.of(context).colorScheme.primary,
                      size: 18,
                    ),
                    selectedIndex: 0,
                    onDestinationSelected: (idx) => onItemTapped(idx, context),
                  ),
                ),
              },
            ),
          ),
        ),
      ),
    );
  }
}
