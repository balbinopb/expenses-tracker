
import 'package:expenses_tracker/bindings/login_binding.dart';
import 'package:expenses_tracker/routes/app_routes.dart';
import 'package:expenses_tracker/screens/login_screen.dart';
import 'package:get/get.dart';


class AppPages {
  static final routes=[
    GetPage(name: AppRoutes.login, page: ()=> LoginScreen(),binding: LoginBinding())
  ];
}