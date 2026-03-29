import 'package:codeit/bindings/certificate_bindings.dart';
import 'package:codeit/bindings/order_bindings.dart';
import 'package:codeit/bindings/upcoming_class_binding.dart';
import 'package:codeit/utils/app_routes.dart';
import 'package:codeit/views/certificate_view.dart';
import 'package:codeit/views/checkout_view.dart';
import 'package:codeit/views/comfirmation_view.dart';
import 'package:codeit/views/course_view.dart';
import 'package:codeit/views/dashboard_view.dart';
import 'package:codeit/views/demo_video_view.dart';
import 'package:codeit/views/login_view.dart';
import 'package:codeit/views/mycourse_view.dart';
import 'package:codeit/views/register_view.dart';
import 'package:codeit/views/splash_view.dart';
import 'package:codeit/views/upcoming_classes.dart';
import 'package:codeit/views/video_view.dart';
import 'package:get/get.dart';

class AppPages {
  static var routes = [
    GetPage(name: AppRoutes.splash, page: () => SplashView()),
    GetPage(name: AppRoutes.login, page: () => LoginView()),
    GetPage(name: AppRoutes.register, page: () => RegisterView()),
    GetPage(name: AppRoutes.dashboard, page: () => DashboardView(),binding: OrderBindings()),
    GetPage(name: AppRoutes.mycourse, page: () => MycourseView()),
    GetPage(name: AppRoutes.checkout, page: () => CheckoutView()),
    GetPage(name: AppRoutes.upcoming, page: () => UpcomingClasses(),binding:UpcomingClassBinding()),
    GetPage(name: AppRoutes.course, page: () => CourseView()),
    GetPage(name: AppRoutes.video, page: () => VideoView()),
    GetPage(name: AppRoutes.demoVideo, page: () => DemoVideoView()),
    GetPage(name: AppRoutes.confirmation, page: () => ConfirmationView()),
    GetPage(name: AppRoutes.certificates, page: () => CertificateView()),
  ];
}
