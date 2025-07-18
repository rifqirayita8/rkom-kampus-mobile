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
  
  @override
  Future<Either<Failure, String>> authRegister(String fullName, String email, String password) async {
    try {
      final response= await authRemoteDatasource.authRegister(fullName, email, password);
      return right(response);

    } on GeneralException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> authEmailLogin(String email, String password) async {
    try {
      final response= await authRemoteDatasource.authEmailLogin(email, password);
      return right(response);

    } on GeneralException catch (e) {
      return left(Failure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, void>> authEmailRegister(String fullName, String email, String password) async {
    try {
      final response= await authRemoteDatasource.authEmailRegister(fullName, email, password);
      return right(response);

    } on GeneralException catch (e) {
      return left(Failure(e.message));
    }
  }
}