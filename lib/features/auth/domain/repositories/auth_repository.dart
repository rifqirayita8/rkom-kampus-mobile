import 'package:dartz/dartz.dart';
import 'package:rkom_kampus/core/errors/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> authLogin(
    String email,
    String password,
  );
}