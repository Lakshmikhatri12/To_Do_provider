import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:to_do_app/features/auth/failures/failure.dart';
import 'package:to_do_app/features/auth/repositories/auth_repository.dart';
import 'package:to_do_app/features/auth/view_models/auth_view_model.dart';
import 'auth_viewmodel_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository mockAuthRepo;
  late AuthViewModel authViewModel;

  setUp(() {
    mockAuthRepo = MockAuthRepository();
    authViewModel = AuthViewModel(mockAuthRepo);
  });

  group('Login', () {
    test("login success: state should be success", () async {
      when(mockAuthRepo.loginApi(any)).thenAnswer(
        (_) async => {
          'id': 1,
          'email': 'abc@fakeTest.com',
          'username': 'Fake user',
          'accessToken': 'fake123',
        },
      );
      when(mockAuthRepo.saveToken(any)).thenAnswer((_) async => {});

      await authViewModel.login('Fake user', '1234567');

      expect(authViewModel.loginState, AuthState.success);
      expect(authViewModel.loginErrorMessage, null);
    });

    test('login failure: state should be error', () async {
      when(
        mockAuthRepo.loginApi(any),
      ).thenThrow(UnAuthorizedFailure('invalid credentials'));

      await authViewModel.login('wrong', 'wrong');
      expect(authViewModel.loginState, AuthState.error);
      expect(authViewModel.loginErrorMessage, 'invalid credentials');
    });
  });

  group('Signup', () {
    test("signup success: state should be success", () async {
      when(mockAuthRepo.signupApi(any)).thenAnswer(
        (_) async => {
          'id': 1,
          'email': 'abc@fakeTest.com',
          'username': 'Fake user',
          'accessToken': 'fake123',
        },
      );
      await authViewModel.signup(username: 'Fake user', password: 'user123');

      expect(authViewModel.signUpState, AuthState.success);
      expect(authViewModel.signUpErrorMessage, null);
    });

    test('signup failure: state should be error', () async {
      when(
        mockAuthRepo.signupApi(any),
      ).thenThrow(BadRequestFailure('user already exists'));

      await authViewModel.signup(username: 'Fake user', password: ' user123');
      expect(authViewModel.signUpState, AuthState.error);
      expect(authViewModel.signUpErrorMessage, 'user already exists');
    });
  });

  group('logout', () {
    test('Logout - clears user and state', () async {
      when(mockAuthRepo.clearToken()).thenAnswer((_) async => {});
      await authViewModel.logOut();
      expect(authViewModel.currentUser, null);
      expect(authViewModel.loginState, AuthState.idle);
    });
  });

  group('reset login', () {
    test('Reset Login - state should be idle', () {
      authViewModel.resetLogin();
      expect(authViewModel.loginState, AuthState.idle);
      expect(authViewModel.loginErrorMessage, null);
    });
  });

  group('reset signup', () {
    test('Reset signup - state should be idle', () {
      authViewModel.resetSignupState();
      expect(authViewModel.signUpState, AuthState.idle);
      expect(authViewModel.signUpErrorMessage, null);
    });
  });
}
