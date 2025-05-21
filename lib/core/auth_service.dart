import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';


class AuthService {
  final LocalAuthentication _localAuth = LocalAuthentication();
  Future<bool> authenticateWithBiometrics() async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to access this feature',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        // Handle not available error
      } else if (e.code == auth_error.passcodeNotSet) {
        // Handle passcode not set error
      } else if (e.code == auth_error.notEnrolled) {
        // Handle not enrolled error
      } else if (e.code == auth_error.lockedOut) {
        // Handle locked out error
      } else {
        // Handle other errors
      }
    }
    return isAuthenticated;
  }
}