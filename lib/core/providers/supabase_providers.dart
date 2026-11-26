import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingleph/core/services/supabase_backend.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Null until the optional Supabase configuration is supplied at build time.
final Provider<SupabaseClient?> supabaseClientProvider =
    Provider<SupabaseClient?>((ref) => SupabaseBackend.tryClient);
