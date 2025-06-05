import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:final_project/core/database/hive_service.dart';
import 'package:final_project/models/user_auth_models.dart';
import 'package:uuid/uuid.dart';

class UserAuthService {
  final Dio _dio;
  final HiveService _hiveService = HiveService();
  final Uuid _uuid = Uuid();

  UserAuthService()
    : _dio = Dio(
        BaseOptions(
          baseUrl:
              dotenv.env['BASE_URL'] ??
              'https://default-url.com', // Replace with your API base URL
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 20),
        ),
      ) {
    _dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        logPrint: (obj) => print(obj.toString()), // Customize logging as needed
      ),
    );
  }
  Future<Response> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/user/get',
        data: {'email': email, 'password': password},
      );

      // Check if user exists in Hive
      final userKey = await _hiveService.getUserKeyByEmail(email);

      if (userKey != null) {
        // User exists, update authentication status
        final existingUser = await _hiveService.getUserByKey(userKey);
        if (existingUser != null) {
          final updatedUser = UserAuthModels(
            id: existingUser.id,
            email: existingUser.email,
            passwordHash: existingUser.passwordHash,
            isAuthenticated: true, // Set to true on login
            createdAt: existingUser.createdAt,
          );
          await _hiveService.updateUser(userKey, updatedUser);
        }
      } else {
        // User doesn't exist in local storage, create new record
        final userData = UserAuthModels(
          id: _uuid.v4(),
          email: email,
          passwordHash:
              password, // Note: This is already hashed from the caller
          isAuthenticated: true,
          createdAt: DateTime.now(),
        );
        await _hiveService.createUser(userData);
      }

      return response;
    } on DioException catch (e) {
      print('Login error: ${e.message}');
      rethrow; // Rethrow to let the caller handle the error
    } catch (e) {
      print('Unexpected error during login: $e');
      rethrow;
    }
  }

  Future<Response> register(String email, String passwordHash) async {
    try {
      // API call to remote server
      final response = await _dio.post(
        '/user/create',
        data: {'email': email, 'password_hash': passwordHash},
      );

      // Store user data locally in Hive
      final userData = UserAuthModels(
        id: _uuid.v4(), // Generate a unique ID
        email: email,
        passwordHash: passwordHash,
        isAuthenticated: true, // Set to true as requested
        createdAt: DateTime.now(),
      );

      await _hiveService.createUser(userData);

      return response;
    } on DioException catch (e) {
      print('Registration error: ${e.message}');
      rethrow; // Rethrow to let the caller handle the error
    } catch (e) {
      print('Unexpected error during registration: $e');
      rethrow;
    }
  }

  Future<Response> updateUser(String id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/user/update/$id', data: data);
      return response;
    } on DioException catch (e) {
      print('Update user error: ${e.message}');
      rethrow; // Rethrow to let the caller handle the error
    } catch (e) {
      print('Unexpected error during user update: $e');
      rethrow;
    }
  }

  Future<Response> deleteUser(String id) async {
    try {
      final response = await _dio.delete('/user/delete/$id');
      return response;
    } on DioException catch (e) {
      print('Delete user error: ${e.message}');
      rethrow; // Rethrow to let the caller handle the error
    } catch (e) {
      print('Unexpected error during user deletion: $e');
      rethrow;
    }
  }

  Future<Response> getUserById(String id) async {
    try {
      final response = await _dio.get('/user/get/$id');
      return response;
    } on DioException catch (e) {
      print('Get user by ID error: ${e.message}');
      rethrow; // Rethrow to let the caller handle the error
    } catch (e) {
      print('Unexpected error during fetching user by ID: $e');
      rethrow;
    }
  }
}
