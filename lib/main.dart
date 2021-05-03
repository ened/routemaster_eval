import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:routemaster_eval/widgets.dart';

final routes = RouteMap(routes: {
  '/': (_) {
    return MaterialPage(
      child: ListScreen(
        onSelected: (context, id) {
          Routemaster.of(context).push('/detail/$id');
        },
      ),
    );
  },
  '/detail/:id': (info) {
    return MaterialPage(
      child: DetailScreen(
        id: info.pathParameters['id']!,
        onTap: (context, id) {
          Routemaster.of(context).push('/detail/$id/final');
        },
      ),
    );
  },
  '/detail/:id/final': (info) {
    return MaterialPage(
      child: FinalScreen(
        id: info.pathParameters['id']!,
      ),
    );
  }
  // '/feed': (_) => MaterialPage(child: FeedPage()),
  // '/settings': (_) => MaterialPage(child: SettingsPage()),
  // '/feed/profile/:id': (info) =>
  //     MaterialPage(child: ProfilePage(id: info.pathParameters['id'])),
});

class MyObserver extends RoutemasterObserver {
  // RoutemasterObserver extends NavigatorObserver and
  // receives all nested Navigator events
  @override
  void didPop(Route route, Route? previousRoute) {
    print('Popped a route');
  }

  // Routemaster-specific observer method
  @override
  void didChangeRoute(RouteData routeData, Page page) {
    print('New route: ${routeData.path}');
  }
}

void main() {
  runApp(
    MaterialApp.router(
      routerDelegate: RoutemasterDelegate(
        observers: [MyObserver()],
        routesBuilder: (context) => routes,
      ),
      routeInformationParser: RoutemasterParser(),
    ),
  );
}
