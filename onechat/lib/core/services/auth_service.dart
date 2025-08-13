import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
	AuthService(this._auth);

	final FirebaseAuth _auth;

	Stream<User?> authStateChanges() => _auth.authStateChanges();

	Future<UserCredential> signInWithGoogle() async {
		final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
		if (googleUser == null) {
			throw Exception('Google sign-in aborted');
		}
		final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
		final credential = GoogleAuthProvider.credential(
			accessToken: googleAuth.accessToken,
			idToken: googleAuth.idToken,
		);
		return _auth.signInWithCredential(credential);
	}

	Future<void> verifyPhoneNumber({
		required String phoneNumber,
		required void Function(PhoneAuthCredential credential) onCompleted,
		required void Function(FirebaseAuthException e) onFailed,
		required void Function(String verificationId, int? resendToken) onCodeSent,
		required void Function(String verificationId) onAutoRetrievalTimeout,
	}) async {
		await _auth.verifyPhoneNumber(
			phoneNumber: phoneNumber,
			verificationCompleted: onCompleted,
			verificationFailed: onFailed,
			codeSent: onCodeSent,
			codeAutoRetrievalTimeout: onAutoRetrievalTimeout,
		);
	}

	Future<UserCredential> signInWithSmsCode({
		required String verificationId,
		required String smsCode,
	}) async {
		final credential = PhoneAuthProvider.credential(
			verificationId: verificationId,
			smsCode: smsCode,
		);
		return _auth.signInWithCredential(credential);
	}

	Future<void> signOut() async {
		await _auth.signOut();
		await GoogleSignIn().signOut();
	}
}