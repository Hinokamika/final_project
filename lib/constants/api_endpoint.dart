// filepath: x:\Flutter\final_project\lib\constants\api_endpoint.dart

class ApiEndpoints {
  // Base URLs
  static const String baseUrl = 'https://api.example.com/v1';
  static const String imageBaseUrl = 'https://api.example.com/images';

  // Authentication endpoints
  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/auth/register';
  static const String logout = '$baseUrl/auth/logout';
  static const String refreshToken = '$baseUrl/auth/refresh-token';
  static const String forgotPassword = '$baseUrl/auth/forgot-password';
  static const String resetPassword = '$baseUrl/auth/reset-password';

  // User related endpoints
  static const String userProfile = '$baseUrl/user/profile';
  static const String updateProfile = '$baseUrl/user/update';
  static const String changePassword = '$baseUrl/user/change-password';
  static const String uploadProfileImage = '$baseUrl/user/upload-image';

  // Content related endpoints
  static const String getItems = '$baseUrl/items';
  static const String getItemDetail = '$baseUrl/items/detail';
  static const String searchItems = '$baseUrl/items/search';

  // Notification endpoints
  static const String notifications = '$baseUrl/notifications';
  static const String markAsRead = '$baseUrl/notifications/mark-read';

  // Settings and configurations
  static const String appSettings = '$baseUrl/settings';
  static const String appVersion = '$baseUrl/version';
}

