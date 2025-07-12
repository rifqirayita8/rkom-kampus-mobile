import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rkom_kampus/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:rkom_kampus/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:rkom_kampus/features/auth/domain/repositories/auth_repository.dart';
import 'package:rkom_kampus/features/auth/domain/usecases/user_login.dart';
import 'package:rkom_kampus/features/auth/presentation/bloc/auth_bloc.dart';

import '../../features/auth/domain/usecases/user_email_login.dart';
import '../../features/auth/domain/usecases/user_email_register.dart';
import '../../features/auth/domain/usecases/user_register.dart';
import '../../features/auth/presentation/bloc/auth_form_cubit.dart';
import '../../features/auth/presentation/bloc/auth_view_cubit.dart';


part 'init_injection.dart';