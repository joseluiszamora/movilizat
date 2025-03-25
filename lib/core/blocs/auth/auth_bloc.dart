import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<GoogleSignInRequested>(_onGoogleSignIn);
    on<SignOutRequested>(_onSignOut);
  }

  Future<void> _onGoogleSignIn(
      GoogleSignInRequested event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        emit(AuthUnauthenticated());
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.user != null) {
        emit(AuthAuthenticated(
            userId: userCredential.user!.uid,
            email: userCredential.user!.email!));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignOut(
      SignOutRequested event, Emitter<AuthState> emit) async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
