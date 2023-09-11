import 'package:get/get.dart';
import 'package:webtutorial/mobile/auth/login_screen.dart';
import 'package:webtutorial/mobile/auth/signup_screen.dart';
import 'package:webtutorial/mobile/chat/chat_screen.dart';
import 'package:webtutorial/mobile/mobilehost.dart';
import 'package:webtutorial/mobile/splash_screen.dart';
import 'package:webtutorial/responsive/responsive.dart';
import 'package:webtutorial/utils/routes_constant.dart';
import 'package:webtutorial/web/webhost.dart';

class AppRoutes {
  // static const String yourRequests = "/yourRequests";

  static List<GetPage<dynamic>> routes = [
    GetPage(
        name: SPLASH_SCREEN,
        page: () => SplashScreen(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: LOGIN_SCREEN,
        page: () => LoginScreen(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: SIGNUP_SCREEN,
        page: () => SignUpScreen(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: BASE_SCREEN,
        page: () => ResponsiveLayer(
          isMobileLayout: MobileHost(),
          isWebLayout: WebHost(),
        ),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: CHAT_SCREEN,
        page: () => ChatScreen(),
        transition: Transition.fadeIn
    ),
  ];
}