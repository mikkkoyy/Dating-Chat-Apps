import 'package:go_router/go_router.dart';
import 'package:mingleph/features/interests/view/pages/interests_screen.dart';
import 'package:mingleph/routes/route_paths.dart';

final List<GoRoute> interestsRoutes = [
  GoRoute(
    path: RoutePaths.interestsScreen,
    builder: (_, _) => const InterestsScreen(),
  ),
];
