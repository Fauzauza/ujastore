import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Metode untuk mendaftar pengguna baru
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user; // Mengembalikan user jika berhasil
    } catch (e) {
      print('Firebase signUp error: $e'); // Log error untuk debugging
      throw e; // Lempar ulang error untuk ditangani di AuthController
    }
  }

  // Metode untuk login pengguna
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user; // Mengembalikan user jika berhasil
    } catch (e) {
      print('Firebase signIn error: $e'); // Log error untuk debugging
      throw e; // Lempar ulang error untuk ditangani di AuthController
    }
  }

  // Metode untuk mengirim kode verifikasi (SMS) ke pengguna
  Future<void> sendVerificationCode(String phoneNumber, Function(String verificationId) onCodeSent) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Verification failed: $e');
        throw e;
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId); // Memanggil callback dengan verificationId
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Timeout handling jika perlu
      },
      timeout: Duration(seconds: 60), // Sesuaikan timeout sesuai kebutuhan Anda
    );
  }

  // Metode untuk memverifikasi kode dua faktor
  Future<bool> verifyTwoFactorCode(String verificationId, String code) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: code,
      );

      await _auth.signInWithCredential(credential);
      return true; // Mengembalikan true jika verifikasi berhasil
    } catch (e) {
      print('Two-factor verification error: $e');
      throw e; // Lempar ulang error jika terjadi
    }
  }

  // Metode untuk logout
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
