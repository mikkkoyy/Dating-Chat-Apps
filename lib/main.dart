
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mingleph/features/achievements/data/activity_recorder.dart';
import 'package:mingleph/features/achievements/view/widgets/badge_celebration.dart';
import 'package:mingleph/features/activity_status/data/my_activity_status.dart';
import 'package:mingleph/features/miniplayer/data/services/pip_controller.dart';
import 'package:mingleph/features/miniplayer/view/widgets/miniplayer_host.dart';
import 'package:mingleph/features/shell/viewmodel/network_notifier.dart';
import 'package:mingleph/features/theme/model/theme_list.dart';
import 'package:mingleph/features/theme/model/theme_modes.dart';
import 'package:mingleph/features/theme/viewmodel/theme_notifier.dart';
import 'package:mingleph/core/services/supabase_backend.dart';
import 'package:mingleph/features/settings/viewmodel/locale_notifier.dart';
import 'package:mingleph/l10n/app_localizations.dart';
import 'package:mingleph/l10n/raj_intl.dart';
import 'package:mingleph/routes/app_router.dart';
import 'package:mingleph/utils/constants.dart';
import 'package:mingleph/utils/ui_sizes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await GetStorage.init();
  await SupabaseBackend.initializeIfConfigured();
  languageLocale =
      await FlutterSecureStorage().read(key: "languageLocale") ?? "en";

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!ref.watch(pipModeProvider)) UiSizes.init(context);
    ref.watch(networkProvider);
    ref.watch(myActivityStatusProvider);
    ref.watch(activityRecorderProvider);
    final themeModel = ThemeList.getThemeModel(
      ref.watch(appThemeProvider).name,
    );

    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      builder: (context, child) => BadgeCelebration(
        child: MiniplayerHost(child: child ?? const SizedBox.shrink()),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizationsRaj.delegate,
      ],
      locale: ref.watch(appLocaleProvider),
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'MinglePH',
      theme: ThemeModes.setLightTheme(themeModel),
      darkTheme: ThemeModes.setDarkTheme(themeModel),
      themeMode: themeModel.themeMode,
    );
  }
}
