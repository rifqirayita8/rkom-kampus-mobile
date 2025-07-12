import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/auth_repository.dart';

class UserEmailLogin {
  final AuthRepository authRepository;

  UserEmailLogin({required this.authRepository});

  Future<Either<Failure, void>> execute(
    String email,
    String password,
  ) async {
    return await authRepository.authEmailLogin(email, password);
  }
}