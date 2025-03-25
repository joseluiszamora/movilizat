import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movilizat/core/data/models/user.dart';

class AuthProvider with ChangeNotifier {
  // UserModel? _currentUser;
  // bool _isLoading = false;

  // UserModel? get currentUser => _currentUser;
  // bool get isLoading => _isLoading;

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  // // Inicializar usuario desde local storage
  // Future<void> initializeUser() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final userJson = prefs.getString('user');

  //   if (userJson != null) {
  //     _currentUser = UserModel.fromJson(userJson as Map<String, dynamic>);
  //     notifyListeners();
  //   }
  // }

  // // Iniciar sesión con Google
  // Future<bool> signInWithGoogle() async {
  //   try {
  //     _isLoading = true;
  //     notifyListeners();

  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser!.authentication;

  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     final UserCredential authResult =
  //         await _auth.signInWithCredential(credential);

  //     if (authResult.user != null) {
  //       _currentUser =
  //           UserModel.fromFirebaseUser(authResult.user! as UserModel);

  //       // Guardar en local storage
  //       final prefs = await SharedPreferences.getInstance();
  //       await prefs.setString('user', _currentUser!.toJson().toString());

  //       _isLoading = false;
  //       notifyListeners();
  //       return true;
  //     }

  //     _isLoading = false;
  //     notifyListeners();
  //     return false;
  //   } catch (error) {
  //     print('Error de inicio de sesión: $error');
  //     _isLoading = false;
  //     notifyListeners();
  //     return false;
  //   }
  // }

  // // Cerrar sesión
  // Future<void> signOut() async {
  //   try {
  //     await _googleSignIn.signOut();
  //     await _auth.signOut();

  //     // Limpiar local storage
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.remove('user');

  //     _currentUser = null;
  //     notifyListeners();
  //   } catch (error) {
  //     print('Error al cerrar sesión: $error');
  //   }
  // }
}
