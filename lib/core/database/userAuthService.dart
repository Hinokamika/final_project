import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserAuthService {
  final Dio _dio;

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
      return response;
    } on DioException catch (e) {
      print('Login error: ${e.message}');
      rethrow; // Rethrow to let the caller handle the error
    } catch (e) {
      print('Unexpected error during login: $e');
      rethrow;
    }
  }

  Future<Response> register(String email, String password_hash) async {
    try {
      final response = await _dio.post(
        '/user/create',
        data: {'email': email, 'password_hash': password_hash},
      );
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
