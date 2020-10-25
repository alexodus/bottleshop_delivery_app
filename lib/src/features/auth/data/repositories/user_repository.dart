import 'dart:async';
import 'dart:io';

import 'package:bottleshopdeliveryapp/src/core/data/res/constants.dart';
import 'package:bottleshopdeliveryapp/src/core/data/services/logger.dart';
import 'package:bottleshopdeliveryapp/src/core/data/services/push_notification_service.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/data/models/device_model.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/data/models/user_model.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/data/services/authentication_service.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/data/services/user_db_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

enum AuthStatus {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated
}

class UserRepository with ChangeNotifier {
  final AuthenticationService _auth;
  final PushNotificationService _notificationService;
  Logger _logger;
  String _error;
  bool _loading;
  AuthStatus _status;
  StreamSubscription _userListener;
  UserModel _fsUser;
  User _user;
  Device _currentDevice;

  String get error => _error;
  AuthStatus get status => _status;
  User get fbUser => _user;
  UserModel get user => _fsUser;
  bool get isLoading => _loading;

  Device get currentDevice => _currentDevice;

  UserRepository.instance(
    this._auth,
    this._notificationService,
  ) {
    _loading = false;
    _error = '';
    _status = AuthStatus.Uninitialized;
    _logger = createLogger(this.runtimeType.toString());
    _auth.authStateChanges.listen(_onAuthStateChanged);
    _notificationService.onTokenRefreshed
        .listen((event) => _onFCMTokenChanged(event));
  }

  Future<void> _onFCMTokenChanged(String token) async {
    await userDeviceDb.updateData(currentDevice.id, {
      DeviceFields.token: token,
    });
  }

  Future<void> _onAuthStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = AuthStatus.Unauthenticated;
      _fsUser = null;
      _user = null;
      _loading = false;
    } else {
      _user = firebaseUser;
      _saveUserRecord();
      _userListener = userDb.streamSingle(_user.uid).listen((user) {
        _fsUser = user;
        _loading = false;
        notifyListeners();
      });
      _status = AuthStatus.Authenticated;
      _loading = false;
    }
    notifyListeners();
  }

  Future<void> _saveUserRecord() async {
    if (_user == null) return;
    UserModel user = UserModel.fromFirebaseUser(user: _user);
    UserModel existing = await userDb.getSingle(_user.uid);
    if (existing == null) {
      await userDb.create(user.toMap(), id: _user.uid);
      _fsUser = user;
    } else {
      await userDb.updateData(_user.uid, {
        UserFields.lastLoggedIn: FieldValue.serverTimestamp(),
      });
    }
    _saveDevice(user);
  }

  Future<void> _saveDevice(UserModel user) async {
    DeviceInfoPlugin devicePlugin = DeviceInfoPlugin();
    String deviceId;
    DeviceDetails deviceDescription;
    if (Platform.isAndroid) {
      AndroidDeviceInfo deviceInfo = await devicePlugin.androidInfo;
      deviceId = deviceInfo.androidId;
      deviceDescription = DeviceDetails(
        device: deviceInfo.device,
        model: deviceInfo.model,
        osVersion: deviceInfo.version.sdkInt.toString(),
        platform: 'android',
      );
    }
    if (Platform.isIOS) {
      IosDeviceInfo deviceInfo = await devicePlugin.iosInfo;
      deviceId = deviceInfo.identifierForVendor;
      deviceDescription = DeviceDetails(
        osVersion: deviceInfo.systemVersion,
        device: deviceInfo.name,
        model: deviceInfo.utsname.machine,
        platform: 'ios',
      );
    }
    userDeviceDb.collection =
        '${AppDBConstants.usersCollection}/${user.uid}/devices';
    Device existing = await userDeviceDb.getSingle(deviceId);
    if (existing != null) {
      var token = existing.token ?? await _notificationService.init();
      await userDeviceDb.updateData(deviceId, {
        DeviceFields.expired: false,
        DeviceFields.uninstalled: false,
        DeviceFields.token: token,
      });
      _currentDevice = existing;
    } else {
      var token = await _notificationService.init();
      Device device = Device(
        createdAt: DateTime.now().toUtc(),
        deviceInfo: deviceDescription,
        token: token,
        expired: false,
        id: deviceId,
        uninstalled: false,
      );
      await userDeviceDb.create(device.toMap(), id: deviceId);
      _currentDevice = device;
    }
    notifyListeners();
  }

  Future<bool> sendResetPasswordEmail(String email) async {
    try {
      _loading = true;
      notifyListeners();
      await _auth.sendPasswordResetEmail(email);
      _error = '';
      return true;
    } catch (e) {
      _error = e.messsage;
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> signUpWithEmailAndPassword(String email, String password) async {
    try {
      _status = AuthStatus.Authenticating;
      _loading = true;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email, password);
      _error = '';
      return true;
    } catch (e) {
      _error = e.message;
      _status = AuthStatus.Unauthenticated;
      _loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      _status = AuthStatus.Authenticating;
      _loading = true;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email, password);
      _error = '';
      return true;
    } catch (e) {
      _error = e.message;
      _status = AuthStatus.Unauthenticated;
      _loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUpWithGoogle() async {
    try {
      _status = AuthStatus.Authenticating;
      _loading = true;
      notifyListeners();
      await _auth.signInWithGoogle();
      _error = '';
      return true;
    } catch (e) {
      _error = e.message;
      _status = AuthStatus.Unauthenticated;
      _loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUpWithFacebook() async {
    try {
      _status = AuthStatus.Authenticating;
      _loading = true;
      notifyListeners();
      await _auth.signInWithFacebook();
      _error = '';
      return true;
    } catch (e) {
      _error = e.message;
      _status = AuthStatus.Unauthenticated;
      _loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUpAnonymously() async {
    try {
      _status = AuthStatus.Authenticating;
      _loading = true;
      notifyListeners();
      await _auth.signInAnonymously();
      _error = '';
      return true;
    } catch (e) {
      _error = e.message;
      _status = AuthStatus.Unauthenticated;
      _loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUpWithApple() async {
    try {
      _status = AuthStatus.Authenticating;
      _loading = true;
      notifyListeners();
      await _auth.signWithApple();
      _error = '';
      return true;
    } catch (e) {
      _error = e.message;
      _status = AuthStatus.Unauthenticated;
      _loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _status = AuthStatus.Unauthenticated;
    _user = null;
    _fsUser = null;
    _userListener.cancel();
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  @override
  void dispose() {
    _logger.d('authState: disposed');
    _userListener.cancel();
    super.dispose();
  }
}
