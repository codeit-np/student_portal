
import 'package:codeit/bindings/order_bindings.dart';
import 'package:codeit/bindings/receipt_bindings.dart';
import 'package:codeit/bindings/terms_condition_binding.dart';
import 'package:codeit/bindings/upcoming_class_binding.dart';
import 'package:codeit/utils/app_routes.dart';
import 'package:codeit/views/certificate_view.dart';
import 'package:codeit/views/checkout_view.dart';
import 'package:codeit/views/comfirmation_view.dart';
import 'package:codeit/views/course_view.dart';
import 'package:codeit/views/dashboard_view.dart';
import 'package:codeit/views/demo_video_view.dart';
import 'package:codeit/views/forgot_password_view.dart';
import 'package:codeit/views/login_view.dart';
import 'package:codeit/views/mycourse_view.dart';
import 'package:codeit/views/no_internet_view.dart';
import 'package:codeit/views/otp_verification_view.dart';
import 'package:codeit/views/receipt_view.dart';
import 'package:codeit/views/register_view.dart';
import 'package:codeit/views/reset_password_view.dart';
import 'package:codeit/views/splash_view.dart';
import 'package:codeit/views/terms_condition_view.dart';
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
    GetPage(name: AppRoutes.terms, page: () => TermsConditionView(),binding: TermsConditionBinding()),
    GetPage(name: AppRoutes.otpVerification, page: () => const OtpVerificationView()),
     GetPage(name: AppRoutes.forgotPassword, page: () => const ForgotPasswordView()),
    GetPage(name: AppRoutes.resetPassword, page: () => const ResetPasswordView()),
    GetPage(name: AppRoutes.receipts, page: () => ReceiptView(),binding: ReceiptBindings()),
    GetPage(name: AppRoutes.nointernet, page: () => NoInternetPage()),
  ];
}
