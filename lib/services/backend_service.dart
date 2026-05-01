import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_config.dart';

class BackendServiceException implements Exception {
  const BackendServiceException(this.message);

  final String message;

  @override
  String toString() => message;
}

class BackendService {
  BackendService._();

  static const supabaseUrl = String.fromEnvironment("SUPABASE_URL");
  static const supabaseAnonKey = String.fromEnvironment("SUPABASE_ANON_KEY");
  static const configuredUrl = supabaseUrl != "" ? supabaseUrl : SupabaseConfig.url;
  static const configuredAnonKey = supabaseAnonKey != ""
      ? supabaseAnonKey
      : SupabaseConfig.anonKey;
  static const isConfigured = configuredUrl != "" && configuredAnonKey != "";

  static SupabaseClient? get _client {
    if (!isConfigured) return null;
    return Supabase.instance.client;
  }

  static User? get currentUser => _client?.auth.currentUser;

  static Future<void> initialize() async {
    if (!isConfigured) return;

    await Supabase.initialize(
      url: configuredUrl,
      anonKey: configuredAnonKey,
    );
  }

  static Future<AuthResponse?> signIn({
    required String email,
    required String password,
  }) async {
    final client = _client;
    if (client == null) return null;

    return client.auth.signInWithPassword(email: email, password: password);
  }

  static Future<AuthResponse?> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final client = _client;
    if (client == null) return null;

    final response = await client.auth.signUp(
      email: email,
      password: password,
      data: {"full_name": fullName},
    );

    final user = response.user;
    if (user != null) {
      await upsertProfile(fullName: fullName, email: email);
    }

    return response;
  }

  static Future<void> upsertProfile({
    required String fullName,
    required String email,
  }) async {
    final client = _client;
    final user = currentUser;
    if (client == null || user == null) return;

    await client.from("profiles").upsert({
      "id": user.id,
      "full_name": fullName,
      "email": email,
      "updated_at": DateTime.now().toIso8601String(),
    });
  }

  static Future<void> saveIrisSession({
    required Uint8List leftEye,
    required Uint8List rightEye,
    String? note,
  }) async {
    final client = _client;
    final user = currentUser;
    if (client == null || user == null) {
      throw const BackendServiceException(
        "Please sign in before saving an iris session.",
      );
    }

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final folder = "${user.id}/$timestamp";
    final leftPath = "$folder/left_eye.jpg";
    final rightPath = "$folder/right_eye.jpg";

    try {
      await client.storage.from("iris-images").uploadBinary(
            leftPath,
            leftEye,
            fileOptions: const FileOptions(
              contentType: "image/jpeg",
              upsert: true,
            ),
          );
      await client.storage.from("iris-images").uploadBinary(
            rightPath,
            rightEye,
            fileOptions: const FileOptions(
              contentType: "image/jpeg",
              upsert: true,
            ),
          );

      await client.from("iris_sessions").insert({
        "user_id": user.id,
        "left_eye_path": leftPath,
        "right_eye_path": rightPath,
        "note": note,
      });
    } on StorageException catch (error) {
      final message = error.message.toLowerCase();
      if (message.contains("bucket not found")) {
        throw const BackendServiceException(
          "Cloud save is not ready yet. Create the private Supabase storage bucket 'iris-images' and run the schema SQL, then try again.",
        );
      }

      throw BackendServiceException(
        "Cloud image upload failed: ${error.message}",
      );
    } on PostgrestException catch (error) {
      throw BackendServiceException(
        "Cloud session save failed: ${error.message}",
      );
    } catch (_) {
      throw const BackendServiceException(
        "Something went wrong while saving this iris session to the cloud.",
      );
    }
  }
}
