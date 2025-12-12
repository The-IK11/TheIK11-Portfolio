/// Simple logger for debugging
class Logger {
  static void info(String message, [dynamic error, StackTrace? stackTrace]) {
    print('ℹ️ INFO: $message');
    if (error != null) print('Error: $error');
    if (stackTrace != null) print('StackTrace: $stackTrace');
  }
  
  static void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    print('⚠️ WARNING: $message');
    if (error != null) print('Error: $error');
    if (stackTrace != null) print('StackTrace: $stackTrace');
  }
  
  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    print('❌ ERROR: $message');
    if (error != null) print('Error: $error');
    if (stackTrace != null) print('StackTrace: $stackTrace');
  }
  
  static void success(String message) {
    print('✅ SUCCESS: $message');
  }
  
  static void debug(String message) {
    print('🔍 DEBUG: $message');
  }
}
