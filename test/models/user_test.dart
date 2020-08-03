import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/firebase_mock.dart';

void main() {
  group('User', () {
    String uid;
    setUp(() {
      uid = '12345';
    });

    test('can be created from FirebaseUser', () {
      final firebaseUser = FirebaseUserMock();
      when(firebaseUser.uid).thenReturn(uid);
    });
  });
}
