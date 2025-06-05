import 'package:final_project/models/user_auth_models.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// HiveService is a class that provides CRUD operations for Hive database
/// It works with any type of Hive model, but in this case, it's specifically designed for UserAuthModels
class HiveService {
  /// Singleton instance
  static final HiveService _instance = HiveService._internal();

  /// Private constructor
  HiveService._internal();

  /// Factory constructor to return the singleton instance
  factory HiveService() => _instance;

  /// Box name
  final String _boxName = 'userAuthModels';

  /// Get the box
  Future<Box<UserAuthModels>> get _box async =>
      await Hive.openBox<UserAuthModels>(_boxName);

  /// Create a new user auth model
  /// Returns the key of the created item
  Future<int> createUser(UserAuthModels user) async {
    try {
      final box = await _box;
      return await box.add(user);
    } catch (e) {
      debugPrint('Error creating user: $e');
      rethrow;
    }
  }

  /// Create or update a user auth model with a specific key
  /// This is useful when you want to update a specific user
  Future<void> putUser(int key, UserAuthModels user) async {
    try {
      final box = await _box;
      await box.put(key, user);
    } catch (e) {
      debugPrint('Error putting user: $e');
      rethrow;
    }
  }

  /// Get a user auth model by key
  Future<UserAuthModels?> getUserByKey(int key) async {
    try {
      final box = await _box;
      return box.get(key);
    } catch (e) {
      debugPrint('Error getting user by key: $e');
      rethrow;
    }
  }

  /// Get a user auth model by email
  Future<UserAuthModels?> getUserByEmail(String email) async {
    try {
      final box = await _box;
      return box.values.firstWhere(
        (user) => user.email == email,
        orElse:
            () => UserAuthModels(
              email: '',
              passwordHash: '',
              id: '',
              isAuthenticated: false,
            ),
      );
    } catch (e) {
      debugPrint('Error getting user by email: $e');
      rethrow;
    }
  }

  /// Get all user auth models
  Future<List<UserAuthModels>> getAllUsers() async {
    try {
      final box = await _box;
      return box.values.toList();
    } catch (e) {
      debugPrint('Error getting all users: $e');
      rethrow;
    }
  }

  /// Update a user auth model
  Future<void> updateUser(int key, UserAuthModels updatedUser) async {
    try {
      final box = await _box;
      await box.put(key, updatedUser);
    } catch (e) {
      debugPrint('Error updating user: $e');
      rethrow;
    }
  }

  /// Delete a user auth model by key
  Future<void> deleteUser(int key) async {
    try {
      final box = await _box;
      await box.delete(key);
    } catch (e) {
      debugPrint('Error deleting user: $e');
      rethrow;
    }
  }

  /// Delete all user auth models
  Future<void> deleteAllUsers() async {
    try {
      final box = await _box;
      await box.clear();
    } catch (e) {
      debugPrint('Error deleting all users: $e');
      rethrow;
    }
  }

  /// Get user key by email
  Future<int?> getUserKeyByEmail(String email) async {
    try {
      final box = await _box;
      final Map<dynamic, UserAuthModels> userMap = box.toMap();

      for (var entry in userMap.entries) {
        if (entry.value.email == email) {
          return entry.key as int;
        }
      }
      return null;
    } catch (e) {
      debugPrint('Error getting user key by email: $e');
      rethrow;
    }
  }

  /// Check if a user exists by email
  Future<bool> userExistsByEmail(String email) async {
    try {
      final box = await _box;
      return box.values.any((user) => user.email == email);
    } catch (e) {
      debugPrint('Error checking if user exists by email: $e');
      rethrow;
    }
  }

  /// Close the box
  Future<void> closeBox() async {
    try {
      final box = await _box;
      await box.close();
    } catch (e) {
      debugPrint('Error closing box: $e');
      rethrow;
    }
  }
}
