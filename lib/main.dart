import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:routemaster/routemaster.dart';
import 'package:routemaster_eval/widgets.dart';

final routes = RouteMap(routes: {
  '/': (info) {
    return MaterialPage(
      child: Builder(builder: (context) {
        final isMobile = getValueForScreenType<bool>(
          context: context,
          mobile: true,
          tablet: false,
        );

        final String? id = info.queryParameters['id'];
        return ListScreen(
          id: id,
          onSelected: (context, id) {
            if (isMobile) {
              Routemaster.of(context).push('detail/$id');
            } else {
              Routemaster.of(context).replace('?id=$id');
            }
          },
          onDetailTapped: (context, id) {
            if (isMobile) {
              print('ignore!');
              return;
            }

            Routemaster.of(context).push('detail/final?id=$id');
          },
        );
      }),
    );
  },
  '/detail/:id': (info) {
    return MaterialPage(
      child: DetailScreen(
        id: info.pathParameters['id']!,
        onTap: (context, id) {
          Routemaster.of(context).push('final');
        },
      ),
    );
  },
  '/detail/final': (info) {
    return MaterialPage(
      child: FinalScreen(
        id: info.queryParameters['id']!,
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
});

class MyObserver extends RoutemasterObserver {
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
