import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rkom_kampus/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:rkom_kampus/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:rkom_kampus/features/auth/domain/repositories/auth_repository.dart';
import 'package:rkom_kampus/features/auth/domain/usecases/user_login.dart';
import 'package:rkom_kampus/features/auth/presentation/bloc/auth_bloc.dart';


part 'init_injection.dart';