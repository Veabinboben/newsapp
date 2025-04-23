part of "main.dart";

final GoRouter _router = GoRouter(
  initialLocation: '/news',
  routes: [
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            NavScaffold(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: 'news',
                path: '/news',
                builder: (context, state) => const ArticleList(),
                routes: [
                  GoRoute(
                      name: 'full',
                      path: '/full',
                      builder: (context, state) {
                        final article = state.extra as Article;
                        return ArticleInfo(article: article);
                      },
                  ),
                ]
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: 'bookmarked',
                path: '/bookmarked',
                builder: (context, state) => const BookmarkList(),
              ),
            ],
          ),
        ]
    )
    // GoRoute(
    //   name: 'details',
    //   path: '/details',
    //   builder: (context, state) {
    //     // Retrieve the passed object
    //     final person = state.extra as Person;
    //     return DetailsScreen(person: person);
    //   },
    // ),
  ],
);