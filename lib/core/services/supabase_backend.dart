import 'package:supabase_flutter/supabase_flutter.dart';

/// Optional Supabase client used by MinglePH dating features.
///
/// The existing Appwrite AuthRepository remains authoritative until an
/// explicitly planned account migration is implemented. Without Supabase
/// compile-time configuration, the inherited app starts normally.
abstract final class SupabaseBackend {
  static const String url = String.fromEnvironment('SUPABASE_URL');
  static const String publishableKey =
      String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY');

  static bool _initialized = false;

  static bool get isInitialized => _initialized;

  static SupabaseClient? get tryClient =>
      _initialized ? Supabase.instance.client : null;

  static Future<void> initializeIfConfigured() async {
    if (url.isEmpty && publishableKey.isEmpty) return;
    if (url.isEmpty || publishableKey.isEmpty) {
      throw StateError(
        'Set both SUPABASE_URL and SUPABASE_PUBLISHABLE_KEY, or leave both unset.',
      );
    }

    final parsedUrl = Uri.tryParse(url);
    final isLocalHttp = parsedUrl != null &&
        parsedUrl.scheme == 'http' &&
        const {'localhost', '127.0.0.1'}.contains(parsedUrl.host);
    if (parsedUrl == null ||
        parsedUrl.host.isEmpty ||
        (parsedUrl.scheme != 'https' && !isLocalHttp)) {
      throw const FormatException(
        'SUPABASE_URL must use HTTPS, except for localhost development.',
      );
    }

    await Supabase.initialize(url: url, publishableKey: publishableKey);
    _initialized = true;
  }
}
