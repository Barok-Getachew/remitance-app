import 'package:get/get.dart';
import 'package:remitance/src/modules/Transaction/presentation/pages/send_money_page.dart';
import 'package:remitance/src/modules/Transaction/presentation/pages/top_up_page.dart';
import 'package:remitance/src/modules/auth/presentation/pages/signup_page.dart';
import 'package:remitance/src/modules/Transaction/presentation/binding/home_binding.dart';
import 'package:remitance/src/modules/Transaction/presentation/pages/home.dart';
import 'package:remitance/src/modules/exchange/presentation/Binding/exchange_binding.dart';

import '../../modules/auth/presentation/binding/auth_binding.dart';
import '../../modules/auth/presentation/pages/login_page.dart';
import '../../modules/exchange/presentation/pages/exchange_page.dart';

class AppRoutes {
  static const home = '/home';
  static const signup = '/signup_page';
  static const login = '/login_page';
  static const topUp = '/top_uppage';
  static const sendPage = '/send_page';
  static const exchange = '/exchange';
  static const profile = '/profile';
}

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.login,
        page: () => LoginPage(),
        binding: AuthBinding(),
        transition: Transition.fade),
    GetPage(
        name: AppRoutes.signup,
        page: () => SignupPage(),
        binding: AuthBinding(),
        transition: Transition.fade),
    GetPage(
        name: AppRoutes.home,
        page: () => HomePage(),
        binding: HomeBinding(),
        transition: Transition.fade),
    GetPage(
        name: AppRoutes.topUp,
        page: () => TopUpScreen(),
        binding: HomeBinding(),
        transition: Transition.fade),
    GetPage(
        name: AppRoutes.sendPage,
        page: () => SendMoneyScreen(),
        binding: HomeBinding(),
        transition: Transition.fade),
    GetPage(
      name: AppRoutes.exchange,
      page: () => const ExchangeView(),
      binding: ExchangeBinding(),
    ),
    // GetPage(name: AppRoutes.profile, page: () => const ProfilePage()),
  ];
}
