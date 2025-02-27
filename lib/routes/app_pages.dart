import 'package:foodie/app/modules/dashboard/dashboard_view.dart';
import 'package:foodie/app/modules/login/login_binding.dart';
import 'package:foodie/app/modules/login/login_view.dart';
import 'package:foodie/app/modules/myrecipe/myrecipe_view.dart';
import 'package:foodie/app/modules/newrecipe/newrecipe_view.dart';
import 'package:foodie/app/modules/profile/profile_binding.dart';
import 'package:foodie/app/modules/profile/profile_view.dart';
import 'package:foodie/app/modules/signup/signup_binding.dart';
import 'package:foodie/app/modules/signup/signup_view.dart';
import 'package:foodie/app/modules/welcomescreen/welcomescreen_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.DASHBOARD;

  static final routes = [
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.MYRECIPE,
      page: () => MyrecipeView(),
    ),
    GetPage(
      name: _Paths.NEWRECIPE,
      page: () => NewRecipeView(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      binding: SignUpBinding(),
      name: _Paths.SIGNUP,
      page: () => SignUpView(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => WelcomeScreen(),
    ),
  ];
}
