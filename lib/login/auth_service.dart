import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: kIsWeb
        ? "576521761023-gju6pe5fuqsnslgb6m1rv26ieo1oqqgh.apps.googleusercontent.com" // Remplacez par votre Client ID Web
        : null, // Android et iOS utilisent Firebase automatiquement
  );

  Future<User?> signInWithGoogle() async {
/*    if (!kIsWeb && Platform.isWindows) {
      await GoogleSignInDart.register(
        clientId:
        '406099696497-g5o9l0blii9970bgmfcfv14pioj90djd.apps.googleusercontent.com',
      );
    }*/
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // User canceled login

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print('ddddd');

      print(googleAuth.idToken);
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      var idTokenResult = await user?.getIdTokenResult(true);

      print(idTokenResult?.expirationTime.toString() ?? "0");

      return userCredential.user;
    } on PlatformException catch (e) {
      print("Error: ${e.message}");
    } catch (e) {
      print("Error during Google Sign-inx: $e");

      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<void> verifyToken(String idToken) async {
    print('--------------------------'); //contains the token info
    print('https://oauth2.googleapis.com/tokeninfo?access_token =$idToken');
    final response = await http.get(
      Uri.parse('https://oauth2.googleapis.com/tokeninfo?access_token=$idToken'),
    );

    print("Googlex Verification Response: ${response.body}");
  }
}
