import 'package:go_router/go_router.dart';
import 'package:mingleph/features/shell/view/pages/home_screen.dart';
import 'package:mingleph/features/shell/view/pages/tabview_screen.dart';
import 'package:mingleph/routes/route_paths.dart';

final List<GoRoute> shellRoutes = [
  GoRoute(
    path: RoutePaths.tabview,
    builder: (_, _) => const TabViewScreen(),
  ),
  GoRoute(
    path: RoutePaths.homeScreen,
    builder: (_, _) => const HomeScreen(),
  ),
];
