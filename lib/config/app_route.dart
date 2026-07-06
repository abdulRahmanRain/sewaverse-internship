
import 'package:go_router/go_router.dart';
import 'package:todo_app/config/app_route_path.dart';
import 'package:todo_app/domain/models/gray_volf_model/job_type_model.dart';
import 'package:todo_app/view/full_auth_screen/login/login_screen.dart';
import 'package:todo_app/view/full_auth_screen/splash_screen.dart';
import 'package:todo_app/view/gray_volf/gray_volf_home_screen.dart';
import 'package:todo_app/view/gray_volf/payment_screen.dart';
import 'package:todo_app/view/gray_volf/profile_update_screen.dart';
import 'package:todo_app/view/gray_volf/provider_profile.dart';
import 'package:todo_app/view/gray_volf/provider_profile_edit.dart';
import 'package:todo_app/view/gray_volf/service_information_screen.dart';
import 'package:todo_app/view/todo_view/todo_home_page.dart';

import '../view/base_screen.dart';
import '../view/dashboard/post_dashboard_home.dart';
import '../view/gray_volf/job_base_Screen.dart';
import '../view/sewaverse_featured_card/featured_sewa_home_screen.dart';

final router = GoRouter(
  initialLocation: '/',

  routes: [
    GoRoute(
        path: '/',
        builder: (context,state) => const SplashScreen()
    ),

    // ShellRoute(
    //   builder: (context, state, child) {
    //     return BaseScreen(child: child);
    //   },
    //   routes: [
    //     GoRoute(
    //       path: '/dashboard',
    //       builder: (context, state) => const DashboardHome(),
    //     ),
    //     GoRoute(
    //       path: '/todoHome',
    //       builder: (context, state) => const TodoHomePage(),
    //     ),
    //     GoRoute(
    //       path: '/sewaHome',
    //       builder: (context, state) => const FeaturedSewaHomeScreen(),
    //     ),
    //   ],
    // ),

    // Job shell
    ShellRoute(
      builder: (context, state, child) {
        return JobBaseScreen(child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutePath.grayHomeScreen,
          builder: (context, state) => const JobListScreen(),
          routes: [
            GoRoute(
              path: AppRoutePath.serviceInformationScreen,
              builder: (context, state) {
                final service = state.extra as JobModel;
                return ServiceInformationScreen(
                    serviceImageUrl: service.imageUrl,
                    providerImageUrl: service.profileImage,
                    providerName: service.name,
                    description: service.description,
                    location: service.location
                );
              }
            ),
            GoRoute(
              path: AppRoutePath.paymentScreen,
              builder: (context, state) {
                return PaymentScreen();
              }
            ),
          ]
        ),
        GoRoute(
          path: AppRoutePath.profileScreen,
          builder: (context,state){
            return ProviderProfile();
          },
          routes: [
            GoRoute(path: AppRoutePath.editProfile,
            builder: (context, state) => const ProviderProfileEdit(),
            ),
            GoRoute(path: AppRoutePath.updateProfile,
              builder: (context, state) => const ProfileUpdateScreen(),
            )
          ]

        ),



        GoRoute(
          path: '/jobListScreen/details',
          builder: (context, state) => const PaymentScreen(),
        ),
      ],
    ),

    GoRoute(
      path: "/login",
      builder: (context,state) => const LoginScreens()
    )
  ],
);

