import 'package:dartz/dartz.dart';
import 'package:rkom_kampus/core/errors/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> authLogin(
    String email,
    String password,
  );

  Future<Either<Failure, String>> authRegister(
    String fullName,
    String email,
    String password,
  );

  Future<Either<Failure, void>> authEmailLogin(
    String email,
    String password,
  );

  Future<Either<Failure, void>> authEmailRegister(
    String fullName,
    String email,
    String password
  );
}