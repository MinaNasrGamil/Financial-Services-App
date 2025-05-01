import 'package:finance_app/view/screens/about_company_screen.dart';
import 'package:finance_app/view/screens/contact_us_screen.dart';
import 'package:finance_app/view/screens/home_screen.dart';
import 'package:finance_app/view/screens/products_screen.dart';
import 'package:finance_app/view/screens/submit_complaint_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String home = '/';
  static const String contact = '/contact';
  static const String products = '/products';
  static const String complaint = '/complaint';
  static const String about = '/about';

  static Route<dynamic> _createRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondary) => screen,
      transitionsBuilder: (context, animation, secondary, child) {
        final tween = Tween(begin: const Offset(1, 0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeInOut));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  static Route<dynamic>? onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _createRoute(HomeScreen());
      case contact:
        return _createRoute(ContactUsScreen());
      case products:
        return _createRoute(ProductsScreen());
      case complaint:
        return _createRoute(SubmitComplaintScreen());
      case about:
        return _createRoute(AboutCompanyScreen());
      default:
        return null;
    }
  }
}
