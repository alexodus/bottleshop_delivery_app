import 'package:bottleshopdeliveryapp/src/core/models/user.dart';
import 'package:bottleshopdeliveryapp/src/core/services/authentication/authentication.dart';
import 'package:bottleshopdeliveryapp/src/core/services/authentication/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';

import '../mock/firebase_mock.dart';

void main() {
  group('AuthenticationService', () {
    final uid = '123456';
    Authentication sut;
    FirebaseAuth firebaseAuth;
    AuthResult authResult;
    FirebaseUser firebaseUser;
    GoogleSignIn googleSignIn;
    FacebookLogin facebookLogin;
    setUpAll(() {
      authResult = AuthResultMock();
      firebaseAuth = FirebaseAuthMock();
      firebaseUser = FirebaseUserMock();
      googleSignIn = GoogleSignInMock();
      facebookLogin = FacebookLoginMock();
      when(authResult.user).thenReturn(firebaseUser);
      when(firebaseUser.uid).thenReturn(uid);
    });

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      sut = AuthenticationService(
          googleSignIn: googleSignIn,
          firebaseAuth: firebaseAuth,
          facebookLogin: facebookLogin);
    });

    test('should sign out user from all providers', () async {
      when(firebaseAuth.signOut()).thenAnswer((_) => Future.value());
      when(googleSignIn.signOut()).thenAnswer((_) => Future.value());
      when(facebookLogin.logOut()).thenAnswer((_) => Future.value());
      await sut.signOut();
      verify(firebaseAuth.signOut()).called(1);
      verify(googleSignIn.signOut()).called(1);
      verify(facebookLogin.logOut()).called(1);
    });

    test('should return null on failed sign out', () async {
      when(firebaseAuth.signOut()).thenThrow(Exception('Firebase down'));
      expect(await sut.signOut().then((value) => null), throwsException);
      verify(firebaseAuth.signOut()).called(1);
    });

    test('should notify when user state changes', () {
      var userStates = [null, firebaseUser, null];
      when(firebaseAuth.signInAnonymously())
          .thenAnswer((_) => Future.value(authResult));
      when(firebaseAuth.onAuthStateChanged)
          .thenAnswer((_) => Stream<FirebaseUser>.fromIterable(userStates));

      var stream = sut.onAuthStateChanged;

      expect(stream, emitsInOrder(<dynamic>[isNull, isA<User>(), isNull]));
    });
  });
}
