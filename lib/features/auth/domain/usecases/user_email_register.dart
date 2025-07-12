import 'package:dartz/dartz.dart';
import 'package:rkom_kampus/core/errors/failure.dart';
import 'package:rkom_kampus/features/auth/domain/repositories/auth_repository.dart';

class UserEmailRegister {
  final AuthRepository authRepository;

  UserEmailRegister({required this.authRepository});

  Future<Either<Failure, void>> execute(
    String fullName,
    String email,
    String password,
  ) async {
    return await authRepository.authEmailRegister(fullName, email, password);
  }
}