// import 'package:flutter/material.dart';

// class ScreenNavigator {
//   final BuildContext cx;
//   ScreenNavigator({
//     required this.cx,
//   });
//   navigate(Widget page, Tween<Offset> tween) {
//     Navigator.push(
//       cx,
//       PageRouteBuilder(
//         pageBuilder: (context, animation,
//             secondaryAnimation) {
//           return page;
//         },
//         transitionDuration: Durations.long1,
//         transitionsBuilder: (context, animation,
//             secondaryAnimation, child) {
//           // create CurveTween
//           const Curve curve = Curves.ease;
//           final CurveTween curveTween =
//               CurveTween(curve: curve);
//           // chain Tween with CurveTween
//           final Animatable<Offset> chainedTween =
//               tween.chain(curveTween);
//           final Animation<Offset>
//               offsetAnimation =
//               animation.drive(chainedTween);
//           return SlideTransition(
//               position: offsetAnimation,
//               child: child);
//         },
//       ),
//     );
//   }
// }

// class NavigatorTweens {
//   static Tween<Offset> bottomToTop() {
//     const Offset begin = Offset(0.0, 1.0);
//     const Offset end = Offset(0.0, 0.0);
//     return Tween(begin: begin, end: end);
//   }

//   static Tween<Offset> topToBottom() {
//     const Offset begin = Offset(0.0, -1.0);
//     const Offset end = Offset(0.0, 0.0);
//     return Tween(begin: begin, end: end);
//   }

//   static Tween<Offset> leftToRight() {
//     const Offset begin = Offset(-1.0, 0.0);
//     const Offset end = Offset(0.0, 0.0);
//     return Tween(begin: begin, end: end);
//   }

//   static Tween<Offset> rightToLeft() {
//     const Offset begin = Offset(1.0, 0.0);
//     const Offset end = Offset(0.0, 0.0);
//     return Tween(begin: begin, end: end);
//   }
// }
import 'package:flutter/material.dart';
import 'package:swipet_mobile/main.dart';
import 'package:swipet_mobile/pages/auth_page.dart';
import 'package:swipet_mobile/pages/forgot_page.dart';
import 'package:swipet_mobile/pages/login_page.dart';
import 'package:swipet_mobile/pages/signup_page.dart';
import 'package:swipet_mobile/pages/user_pages/explore_page.dart';
import 'package:swipet_mobile/pages/user_pages/favorite_page.dart';
import 'package:swipet_mobile/pages/user_pages/inquiry_page.dart';
import 'package:swipet_mobile/pages/user_pages/profile_page.dart';
import 'package:swipet_mobile/pages/user_pages/swipe_page.dart';

class ScreenNavigator {
  final BuildContext cx;
  ScreenNavigator({
    required this.cx,
  });

  void navigate(
      String routeName, Tween<Offset> tween) {
    Navigator.push(
      cx,
      PageRouteBuilder(
        pageBuilder: (context, animation,
            secondaryAnimation) {
          return _getPageByRouteName(routeName);
        },
        transitionDuration: Durations.long1,
        transitionsBuilder: (context, animation,
            secondaryAnimation, child) {
          // create CurveTween
          const Curve curve = Curves.ease;
          final CurveTween curveTween =
              CurveTween(curve: curve);
          // chain Tween with CurveTween
          final Animatable<Offset> chainedTween =
              tween.chain(curveTween);
          final Animation<Offset>
              offsetAnimation =
              animation.drive(chainedTween);
          return SlideTransition(
              position: offsetAnimation,
              child: child);
        },
      ),
    );
  }

  Widget _getPageByRouteName(String routeName) {
    switch (routeName) {
      case '/signup':
        return const SignupPage();
      case '/login':
        return const LoginPage();
      case '/forgotpage':
        return const ForgotKeyPage();
      case '/swipepage':
        return const SwipePage();
      case '/explorepage':
        return const ExplorePage();
      case '/favoritepage':
        return const FavoritePage();
      case '/inquirypage':
        return const InquiryPage();
      case '/profilepage':
        return const ProfilePage();
      case '/authpage':
        return const AuthPage();
      default:
        return const WelcomePage();
    }
  }
}

class NavigatorTweens {
  static Tween<Offset> bottomToTop() {
    const Offset begin = Offset(0.0, 1.0);
    const Offset end = Offset(0.0, 0.0);
    return Tween(begin: begin, end: end);
  }

  static Tween<Offset> topToBottom() {
    const Offset begin = Offset(0.0, -1.0);
    const Offset end = Offset(0.0, 0.0);
    return Tween(begin: begin, end: end);
  }

  static Tween<Offset> leftToRight() {
    const Offset begin = Offset(-1.0, 0.0);
    const Offset end = Offset(0.0, 0.0);
    return Tween(begin: begin, end: end);
  }

  static Tween<Offset> rightToLeft() {
    const Offset begin = Offset(1.0, 0.0);
    const Offset end = Offset(0.0, 0.0);
    return Tween(begin: begin, end: end);
  }
}
