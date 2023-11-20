import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_rebuild_issue/app_routes.dart';
import 'package:go_router_rebuild_issue/pages/dashboard_page.dart';
import 'package:go_router_rebuild_issue/pages/detail_page.dart';
import 'package:go_router_rebuild_issue/pages/list_page.dart';
import 'package:go_router_rebuild_issue/pages/login_page.dart';
import 'package:go_router_rebuild_issue/pages/navigation_page.dart';
import 'package:go_router_rebuild_issue/pages/not_found_page.dart';
import 'package:go_router_rebuild_issue/pages/sub_detail_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

/// [GoRouter] instance we can access everywhere
late GoRouter publicRouter;

/// A global key for the root navigator. This is used to enable the
/// app to navigate between different pages.
final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

/// A global key for the application shell navigator. This is used to
/// navigate between the different screens within the app shell.
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

@Riverpod(keepAlive: true)

/// Configures the GoRouter for the application.
///
/// This function creates an instance of GoRouter with the specified
/// configuration options, including the initial location, routes,
/// and error builder.
Raw<GoRouter> goRouter(Ref ref) {
  CustomTransitionPage<void> customTransitionWidget({required Widget child}) {
    return CustomTransitionPage(
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(
            Tween<Offset>(
              begin: const Offset(0.75, 0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeInOut)),
          ),
          child: child,
        );
      },
    );
  }

  final router = publicRouter = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoute.login.location,
    routes: [
      // Application shell
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return NavigationPage(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
              path: AppRoute.dashboard.location,
              name: AppRoute.dashboard.location,
              pageBuilder: (context, state) {
                debugPrint('GoRouter Page Builder Rebuilding - Dashboard');
                return customTransitionWidget(
                  child: const DashboardPage(),
                );
              }),
          GoRoute(
            path: AppRoute.list.location,
            name: AppRoute.list.name,
            pageBuilder: (context, state) {
              debugPrint('GoRouter Page Builder Rebuilding - List');
              return customTransitionWidget(
                child: const ListPage(),
              );
            },
            routes: <RouteBase>[
              GoRoute(
                parentNavigatorKey: rootNavigatorKey,
                path: AppRoute.detail.location,
                name: AppRoute.detail.location,
                pageBuilder: (context, state) {
                  debugPrint('GoRouter Page Builder Rebuilding - Detail');
                  return customTransitionWidget(
                    child: const DetailPage(),
                  );
                },
                routes: <RouteBase>[
                  GoRoute(
                      parentNavigatorKey: rootNavigatorKey,
                      path: AppRoute.subdetail.location,
                      name: AppRoute.subdetail.location,
                      pageBuilder: (context, state) {
                        debugPrint('GoRouter Page Builder Rebuilding - Sub Detail');
                        return customTransitionWidget(
                          child: const SubDetailPage(),
                        );
                      }),
                ],
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRoute.login.location,
        name: AppRoute.login.name,
        pageBuilder: (context, state) =>
            customTransitionWidget(child: const LoginPage()),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );
  ref.onDispose(router.dispose);
  return router;
}
