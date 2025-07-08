import 'package:dartz/dartz.dart';
import 'package:rkom_kampus/core/errors/failure.dart';
import 'package:rkom_kampus/features/auth/domain/repositories/auth_repository.dart';

class UserLogin {
  final AuthRepository authRepository;

  UserLogin({required this.authRepository});

  Future<Either<Failure, String>> execute(
    String email,
    String password,
  ) async {
    return await authRepository.authLogin(
      email, 
      password
    );
  }
}

