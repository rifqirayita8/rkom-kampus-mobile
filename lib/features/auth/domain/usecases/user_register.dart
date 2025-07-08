import 'package:dartz/dartz.dart';
import 'package:rkom_kampus/core/errors/failure.dart';
import 'package:rkom_kampus/features/auth/domain/repositories/auth_repository.dart';

class UserRegister {
  final AuthRepository authRepository;

  UserRegister({required this.authRepository});

  Future<Either<Failure, String>> execute(
    String fullName,
    String email,
    String password,
  ) async {
    return await authRepository.authRegister(fullName, email, password);
  }
}