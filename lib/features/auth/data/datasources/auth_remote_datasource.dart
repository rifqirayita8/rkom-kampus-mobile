import 'package:dio/dio.dart';
import 'package:rkom_kampus/core/errors/exception.dart';
import 'package:rkom_kampus/core/interceptor/dio_interceptor.dart';

abstract class AuthRemoteDatasource {
  Future<String> authLogin(
    String email,
    String password,
  );

  Future<String> authRegister(
    String fullName,
    String email,
    String password,
  );
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {

  final Dio dio;

  AuthRemoteDatasourceImpl({required this.dio}) {
    dio.interceptors.add(MyDioInterceptor());
  }


  @override
  Future<String> authLogin(
    String email, 
    String password
  ) async {
    try {
      final response= await dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        }
      );

      if(response.statusCode== 200) {
        final token= response.data['token'];
        return token;
      } else if (response.statusCode== 400) {
        throw GeneralException(message: response.data['message']);
      }
      throw GeneralException(message: response.data['message'] ?? 'An error occurred');

    }on DioException catch (e) {
      throw GeneralException(message: e.response!.data['message'] ?? 'An error occurred');
    }
  }
  
  @override
  Future<String> authRegister(String fullName, String email, String password) async {
    try {
      final response= await dio.post(
        '/auth/register',
        data:  {
          'username': fullName,
          'email': email,
          'password': password,
          'confirmPassword': password,
        },
      );

      if (response.statusCode == 200) {
        final msg= response.data['message'];
        return msg;
      }
      throw GeneralException(message: response.data['message'] ?? 'An error occurred');

    }on DioException catch (e) {
      throw GeneralException(message: e.response!.data['message'] ?? 'An error occurred');
    }
  }
}