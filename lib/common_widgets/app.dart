import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/src/features/settings/domain/settings_db.dart';
import 'package:flutter_agc_mockup/src/features/chapter/presentation/chapters_view.dart';
import 'package:flutter_agc_mockup/src/features/discussion/presentation/discussions_view.dart';
import 'package:flutter_agc_mockup/src/features/garden/presentation/add_garden_view.dart';
import 'package:flutter_agc_mockup/src/features/garden/presentation/edit_garden_view.dart';
import 'package:flutter_agc_mockup/src/features/garden/presentation/gardens_view.dart';
import 'package:flutter_agc_mockup/src/features/help/presentation/help_view.dart';
import 'package:flutter_agc_mockup/src/features/help/presentation/help_view_local.dart';
import 'package:flutter_agc_mockup/src/common_widgets/home_view.dart';
import 'package:flutter_agc_mockup/src/features/user/presentation/users_view.dart';
import 'package:flutter_agc_mockup/src/features/outcome/presentation/outcomes_view.dart';
import 'package:flutter_agc_mockup/src/common_widgets/page_not_found_view.dart';
import 'package:flutter_agc_mockup/src/features/seed/presentation/seeds_view.dart';
import 'package:flutter_agc_mockup/src/features/authentication/presentation/signin_view.dart';
import 'package:flutter_agc_mockup/src/features/authentication/presentation/signup_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../src/features/sample_feature/presentation/sample_item_details_view.dart';
import '../src/features/settings/presentation/settings_view.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

/// Top-level widget that implements routing to the appropriate page.
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: FlexThemeData.light(scheme: FlexScheme.gold),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.gold),
      themeMode: ref.watch(currentThemeModeProvider),
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case SigninView.routeName:
                return SigninView();
              case SignupView.routeName:
                return const SignupView();
              case HomeView.routeName:
                return const HomeView();
              case GardensView.routeName:
                return const GardensView();
              case AddGardenView.routeName:
                return AddGardenView();
              case EditGardenView.routeName:
                return EditGardenView();
              case ChaptersView.routeName:
                return const ChaptersView();
              case OutcomesView.routeName:
                return const OutcomesView();
              case SeedsView.routeName:
                return const SeedsView();
              case UsersView.routeName:
                return const UsersView();
              case DiscussionsView.routeName:
                return const DiscussionsView();
              case HelpView.routeName:
                return const HelpView();
              case HelpViewLocal.routeName:
                return const HelpViewLocal();
              case SettingsView.routeName:
                return const SettingsView();
              case SampleItemDetailsView.routeName:
                return const SampleItemDetailsView();
              default:
                return const PageNotFoundView();
            }
          },
        );
      },
    );
  }
}
