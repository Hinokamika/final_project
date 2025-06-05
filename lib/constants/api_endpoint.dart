import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static String get baseUrl =>
      dotenv.env['BASE_URL'] ?? 'https://default-url.com/api';

  // Authentication endpoints
  static String get login => '$baseUrl/user/get';
  static String get register => '$baseUrl/user/create';
  static String get updateUser => '$baseUrl/user/update/:id';
  static String get deleteUser => '$baseUrl/user/delete/:id';
  static String get getUserbyId => '$baseUrl/user/get/:id';

  // User related endpoints
  static String get getUserProfile => '$baseUrl/user-detail/';
  static String get updateUserProfile => '$baseUrl/user-detail/:id';
  static String get deleteUserProfile => '$baseUrl/user-detail/:id';
  static String get getUserProfileById => '$baseUrl/user-detail/:id';
  static String get createUserProfile => '$baseUrl/user-detail/';

  // Workout related endpoints
  static String get getWorkoutLogs => '$baseUrl/exercise-log/';
  static String get getWorkoutLogsById => '$baseUrl/exercise-log/:id';
  static String get getWorkoutLogsByUserId => '$baseUrl/exercise-log/user/:userId';
  static String get createWorkoutLog => '$baseUrl/exercise-log/';
  static String get updateWorkoutLog => '$baseUrl/exercise-log/:id';
  static String get deleteWorkoutLog => '$baseUrl/exercise-log/:id';

  // Health related endpoints
  static String get getHealthLogs => '$baseUrl/health-log/';
  static String get getHealthLogsById => '$baseUrl/health-log/:id';
  static String get getHealthLogsByUserId => '$baseUrl/health-log/user/:userId';
  static String get createHealthLog => '$baseUrl/health-log/';
  static String get updateHealthLog => '$baseUrl/health-log/:id';
  static String get deleteHealthLog => '$baseUrl/health-log/:id';

  // Nutrition related endpoints
  static String get getNutritionLogs => '$baseUrl/nutrition-log/';
  static String get getNutritionLogsById => '$baseUrl/nutrition-log/:id';
  static String get getNutritionLogsByUserId => '$baseUrl/nutrition-log/user/:userId';
  static String get createNutritionLog => '$baseUrl/nutrition-log/';
  static String get updateNutritionLog => '$baseUrl/nutrition-log/:id';
  static String get deleteNutritionLog => '$baseUrl/nutrition-log/:id';
}
