import 'package:google_sign_in/google_sign_in.dart';

class GooglesignInApi {
  static final googleSignIn = GoogleSignIn(
    clientId:
        "148490121536-o0this725e71mpgqkjpbh1hap8dllk9u.apps.googleusercontent.com",
    signInOption: SignInOption.standard,
    forceCodeForRefreshToken: true,
  );
  static Future<GoogleSignInAccount?> login() => googleSignIn.signIn();
}
