import 'package:mingleph/core/providers/get_storage_provider.dart';
import 'package:mingleph/features/theme/data/stored_theme.dart';
import 'package:mingleph/features/theme/model/theme_enums.dart';
import 'package:mingleph/utils/constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/theme_notifier.g.dart';

String _placeholderIdFor(Themes theme) {
  switch (theme) {
    case Themes.amber:
      return amberUserProfileImagePlaceholderID;
    case Themes.vintage:
      return vintageUserProfileImagePlaceholderID;
    case Themes.time:
      return timeUserProfileImagePlaceholderID;
    case Themes.classic:
      return classicUserProfileImagePlaceholderID;
    case Themes.forest:
      return forestUserProfileImagePlaceholderID;
    case Themes.cream:
      return creamUserProfileImagePlaceholderID;
  }
}

@Riverpod(keepAlive: true)
class AppTheme extends _$AppTheme {
  @override
  Themes build() {
    final box = ref.watch(getStorageBoxProvider);
    return Themes.fromName(box.read<String>(themeStorageKey));
  }

  void setTheme(Themes theme) {
    ref.read(getStorageBoxProvider).write(themeStorageKey, theme.name);
    state = theme;
  }
}

@Riverpod(keepAlive: true)
String userProfileImagePlaceholderUrl(Ref ref) {
  final theme = ref.watch(appThemeProvider);
  final placeholderId = _placeholderIdFor(theme);
  return "$appwriteEndpoint/storage/buckets/$userProfileImageBucketId/files/$placeholderId/view?project=$appwriteProjectId&mode=admin";
}
