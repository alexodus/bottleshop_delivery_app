import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';

class FirebaseUserMock extends Mock implements FirebaseUser {}

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

class AuthResultMock extends Mock implements AuthResult {}

class GoogleSignInMock extends Mock implements GoogleSignIn {}

class FacebookLoginMock extends Mock implements FacebookLogin {}
