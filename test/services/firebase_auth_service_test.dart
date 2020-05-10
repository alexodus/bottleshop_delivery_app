import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:bottleshopdeliveryapp/src/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/firebase_mock.dart';

void main() {
  group('FirebaseAuthService', () {
    final uid = '123456';
    FirebaseAuthService sut;
    FirebaseAuth firebaseAuth;
    AuthResult authResult;
    FirebaseUser firebaseUser;
    setUpAll(() {
      authResult = AuthResultMock();
      firebaseAuth = FirebaseAuthMock();
      firebaseUser = FirebaseUserMock();
      when(authResult.user).thenReturn(firebaseUser);
      when(firebaseUser.uid).thenReturn(uid);
    });

    setUp(() {
      sut = FirebaseAuthService();
    });

    test('should sign out user', () async {
      when(firebaseAuth.signOut()).thenAnswer((_) => Future.value());
      await sut.signOut();
      verify(firebaseAuth.signOut()).called(1);
    });

    test('should return null on failed sign out', () async {
      when(firebaseAuth.signOut()).thenThrow(Exception('Firebase down'));
      expect(sut.signOut(), throwsException);
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
