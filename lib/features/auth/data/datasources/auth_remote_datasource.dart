import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rkom_kampus/core/errors/exception.dart';
import 'package:rkom_kampus/core/interceptor/dio_interceptor.dart';
import 'package:rkom_kampus/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<String> authLogin(
    String email,
    String password,
  );

  Future<String> authRegister(
    String fullName,
    String email,
    String password,
  );

  Future<void> authEmailLogin(
    String email,
    String password,
  );

  Future<void> authEmailRegister(
    String fullName,
    String email,
    String password
  );

  Future<void> authGoogleRegister(
    String fullName,
    String email,
    String password
  );
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {

  final Dio dio;

  AuthRemoteDatasourceImpl({required this.dio}) {
    dio.interceptors.add(MyDioInterceptor());
  }


  @override
  Future<String> authLogin(
    String email, 
    String password
  ) async {
    try {
      final response= await dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        }
      );

      if(response.statusCode== 200) {
        final token= response.data['token'];
        return token;
      } else if (response.statusCode== 400) {
        throw GeneralException(message: response.data['message']);
      }
      throw GeneralException(message: response.data['message'] ?? 'An error occurred');

    }on DioException catch (e) {
      throw GeneralException(message: e.response!.data['message'] ?? 'An error occurred');
    }
  }
  
  @override
  Future<String> authRegister(String fullName, String email, String password) async {
    try {
      final userModel= UserModel(
        name: '', 
        email: email, 
        password: password
      );

      final response= await dio.post(
        '/auth/register',
        data:  {
          'username': fullName,
          'email': email,
          'password': password,
          'confirmPassword': password,
        },
      );

      if (response.statusCode == 200) {
        final msg= response.data['message'];
        return msg;
      }
      throw GeneralException(message: response.data['message'] ?? 'An error occurred');

    }on DioException catch (e) {
      throw GeneralException(message: e.response!.data['message'] ?? 'An error occurred');
    }
  }

  @override
  Future<void> authEmailLogin(String email, String password) async {
    // try {
    //   final userCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(
    //     email: email, 
    //     password: password
    //   );

    //   print(userCredential);

    // } on FirebaseAuthException catch (e) {
    //   throw GeneralException(message: e.message!);
    // }
    final GoogleSignIn signIn= GoogleSignIn.instance;
    await signIn.initialize();

    try {
      final googleUser= await GoogleSignIn.instance.authenticate();
      final idToken= googleUser.authentication.idToken;

      final credential= GoogleAuthProvider.credential(
        idToken: idToken
      );

      final userCredential= await FirebaseAuth.instance.signInWithCredential(credential);
      
      if (userCredential.user != null) {
        final userDocRef= FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid);
        final docSnapshot= await userDocRef.get();

        if(!docSnapshot.exists) {
          await userDocRef.set({
            'username': userCredential.user!.displayName ?? 'anon',
            'uid': userCredential.user!.uid,
          });
        }
      }

    } on GoogleSignInException catch (e) {
      throw GeneralException(message: e.description ?? 'Login Google gagal');
    } catch (e) {
      throw GeneralException(message: 'Terjadi kesalahan: ${e.toString()}');
    }
  }
  
  @override
  Future<void> authEmailRegister(String fullName, String email, String password) async {
    try {
      final userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );

      final userDocRef= FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid);
      final docSnapshot= await userDocRef.get();

      if(!docSnapshot.exists) {
        await userDocRef.set({
          'username': fullName,
          'uid': userCredential.user!.uid,
        });
      }

      print(userCredential);

    } on FirebaseAuthException catch (e) {
      throw GeneralException(message: e.message!);
    }
  }
  
  @override
  Future<void> authGoogleRegister(String fullName, String email, String password) async {
    final GoogleSignIn signIn= GoogleSignIn.instance;
    await signIn.initialize();

    try {
      final googleUser= await GoogleSignIn.instance.authenticate();
      final idToken= googleUser.authentication.idToken;

      final credential= GoogleAuthProvider.credential(
        idToken: idToken
      );

      final userCredential= await FirebaseAuth.instance.signInWithCredential(credential);

    } on GoogleSignInException catch (e) {
      throw GeneralException(message: e.description ?? 'Login Google gagal');
    } catch (e) {
      throw GeneralException(message: 'Terjadi kesalahan: ${e.toString()}');
    }
  }


}

// @override
// Future<Either<Failure, void>> authGoogleRegister() async {
//   try {
//     // 1. Trigger Google Sign-In
//     final googleUser = await GoogleSignIn().signIn();
//     if (googleUser == null) return left(Failure('Google login dibatalkan'));

//     // 2. Ambil authentication credential
//     final googleAuth = await googleUser.authentication;

//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     // 3. Login ke Firebase pakai credential Google
//     final userCred = await FirebaseAuth.instance.signInWithCredential(credential);
//     final user = userCred.user;

//     if (user == null) return left(Failure('User kosong setelah login Google'));

//     // 4. Cek apakah data user udah ada di Firestore
//     final userDocRef = FirebaseFirestore.instance.collection("users").doc(user.uid);
//     final docSnapshot = await userDocRef.get();

//     if (!docSnapshot.exists) {
//       // 5. Simpan data user baru ke Firestore
//       await userDocRef.set({
//         "uid": user.uid,
//         "email": user.email,
//         "displayName": user.displayName ?? "",
//         "photoURL": user.photoURL,
//         "createdAt": FieldValue.serverTimestamp(),
//       });
//     }

//     return right(null);
//   } on FirebaseAuthException catch (e) {
//     return left(Failure(e.message ?? "Login Google gagal"));
//   } catch (e) {
//     return left(Failure("Terjadi kesalahan: ${e.toString()}"));
//   }
// }
