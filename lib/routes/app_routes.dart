part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const DASHBOARD = _Paths.DASHBOARD;
  static const PROFILE = _Paths.PROFILE;
  static const MYRECIPE = _Paths.MYRECIPE;
  static const NEWRECIPE = _Paths.NEWRECIPE;
  static const SIGNUP = _Paths.SIGNUP;
  static const LOGIN = _Paths.LOGIN;
  static const WELCOME = _Paths.WELCOME;
}

abstract class _Paths {
  _Paths._();
  static const DASHBOARD = '/dashboard';
  static const PROFILE = '/profile';
  static const MYRECIPE = '/myrecipe';
  static const NEWRECIPE = '/newrecipe';
  static const SIGNUP = '/signup';
  static const LOGIN = '/login';
  static const WELCOME = '/welcome';
}
