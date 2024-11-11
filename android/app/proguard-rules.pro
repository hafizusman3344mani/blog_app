# Keep Flutter-related classes
-keep class io.flutter.** { *; }

# Keep Flutter plugin classes
-keep class io.flutter.plugins.** { *; }

# Do not warn for missing references to Flutter's embedding API
-dontwarn io.flutter.embedding.**
