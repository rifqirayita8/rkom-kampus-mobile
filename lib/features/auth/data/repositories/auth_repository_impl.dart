import 'package:dartz/dartz.dart';
import 'package:rkom_kampus/core/errors/exception.dart';
import 'package:rkom_kampus/core/errors/failure.dart';
import 'package:rkom_kampus/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:rkom_kampus/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository{
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl({required this.authRemoteDatasource});

  @override
  Future<Either<Failure, String>> authLogin(String email, String password) async {
    try {
      final response= await authRemoteDatasource.authLogin(email, password);
      return right(response);
    } on GeneralException catch (e) {
      return left(Failure(e.message));
    }
  }
}