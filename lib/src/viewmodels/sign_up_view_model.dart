import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics_service.dart';
import 'package:bottleshopdeliveryapp/src/services/authentication/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:hooks_riverpod/all.dart';
import 'package:state_notifier/state_notifier.dart';

final signUpViewModelProvider =
    StateNotifierProvider<SignUpViewModel>((_) => SignUpViewModel());

final appleSignInAvailableProvider = FutureProvider<bool>(
  (_) async => await AuthenticationService().supportsAppleSignIn(),
);

final userDetailsProvider = FutureProvider<User>((ref) async {
  final user = await AuthenticationService().currentUser();
  return user;
});

final authStateProvider = StreamProvider.autoDispose<AuthState>((ref) async* {
  final authService = AuthenticationService();
  await for (final value in authService.authStateChanges) {
    yield value is auth.User ? AuthState.LOGGED_IN : AuthState.LOGGED_OUT;
  }
});

class SignUpViewModel extends StateNotifier<bool> {
  final _authService = AuthenticationService();
  final _analytics = AnalyticsService();

  SignUpViewModel() : super(false);

  bool get isLoading => state;

  set isLoading(bool loading) => state = loading;

  void _toggleLoading() {
    state = !state;
  }

  Future<void> sendResetPasswordEmail(String email) async {
    _toggleLoading();
    await _authService.sendPasswordResetEmail(email);
    _toggleLoading();
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    _toggleLoading();
    await _authService.createUserWithEmailAndPassword(email, password);
    await _authService.signInWithEmailAndPassword(email, password);
    await _analytics.logSignUp('email');
    _toggleLoading();
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    _toggleLoading();
    await _authService.signInWithEmailAndPassword(email, password);
    await _analytics.logLogin('email');
    _toggleLoading();
  }

  Future<void> signUpWithGoogle() async {
    _toggleLoading();
    await _authService.signInWithGoogle();
    await _analytics.logSignUp('google');
    _toggleLoading();
  }

  Future<void> signUpWithFacebook() async {
    _toggleLoading();
    await _authService.signInWithFacebook();
    await _analytics.logSignUp('facebook');
    _toggleLoading();
  }

  Future<void> signUpAnonymously() async {
    _toggleLoading();
    await _authService.signInAnonymously();
    await _analytics.logSignUp('anonymously');
    _toggleLoading();
  }

  Future<void> signUpWithApple() async {
    _toggleLoading();
    await _authService.signWithApple();
    await _analytics.logSignUp('apple');
    _toggleLoading();
  }

  Future<void> signOut() async {
    _toggleLoading();
    await _authService.signOut();
    _toggleLoading();
  }
}
