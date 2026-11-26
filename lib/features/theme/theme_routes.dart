import 'package:go_router/go_router.dart';
import 'package:mingleph/features/theme/view/pages/theme_screen.dart';
import 'package:mingleph/routes/route_paths.dart';

final List<GoRoute> themeRoutes = [
  GoRoute(
    path: RoutePaths.themeScreen,
    builder: (_, _) => const ThemeScreen(),
  ),
];
