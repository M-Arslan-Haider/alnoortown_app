import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Stream of user changes
  Stream<User?> get user => _auth.authStateChanges();

  // Current user
  User? get currentUser => _auth.currentUser;

  // Sign up with email and password
  Future<User?> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Create user
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // Update user profile with name
      await userCredential.user?.updateDisplayName(name);
      await userCredential.user?.reload();

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      String message = _getAuthErrorMessage(e);
      throw Exception(message);
    } catch (e) {
      throw Exception('An unexpected error occurred. Please try again.');
    }
  }

  // Sign in with email and password
  Future<User?> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      String message = _getAuthErrorMessage(e);
      throw Exception(message);
    } catch (e) {
      throw Exception('An unexpected error occurred. Please try again.');
    }
  }

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      // Trigger Google Sign In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      // Get authentication details
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Create credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      String message = _getAuthErrorMessage(e);
      throw Exception(message);
    } catch (e) {
      throw Exception('An unexpected error occurred. Please try again.');
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      String message = _getAuthErrorMessage(e);
      throw Exception(message);
    } catch (e) {
      throw Exception('An unexpected error occurred. Please try again.');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      throw Exception('Error signing out. Please try again.');
    }
  }

  // Get user name
  String getUserName() {
    return _auth.currentUser?.displayName ?? 'User';
  }

  // Get user email
  String getUserEmail() {
    return _auth.currentUser?.email ?? '';
  }

  // Error message handler
  String _getAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email is already registered. Please login or use another email.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password should be at least 6 characters.';
      case 'user-not-found':
        return 'No user found with this email. Please sign up first.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
}