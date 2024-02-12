// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddingBirthdayRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddingBirthdayPage(),
      );
    },
    DateFormatSelectionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DateFormatSelectionPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    InfoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: InfoPage(),
      );
    },
    LanguageSelectionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LanguageSelectionPage(),
      );
    },
    SettingsNotificationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsNotificationPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsPage(),
      );
    },
    ThemeSelectionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ThemeSelectionPage(),
      );
    },
    UpdateBirthdayRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateBirthdayRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UpdateBirthdayPage(
          key: args.key,
          personmodel: args.personmodel,
        ),
      );
    },
  };
}

/// generated route for
/// [AddingBirthdayPage]
class AddingBirthdayRoute extends PageRouteInfo<void> {
  const AddingBirthdayRoute({List<PageRouteInfo>? children})
      : super(
          AddingBirthdayRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddingBirthdayRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DateFormatSelectionPage]
class DateFormatSelectionRoute extends PageRouteInfo<void> {
  const DateFormatSelectionRoute({List<PageRouteInfo>? children})
      : super(
          DateFormatSelectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'DateFormatSelectionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [InfoPage]
class InfoRoute extends PageRouteInfo<void> {
  const InfoRoute({List<PageRouteInfo>? children})
      : super(
          InfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'InfoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LanguageSelectionPage]
class LanguageSelectionRoute extends PageRouteInfo<void> {
  const LanguageSelectionRoute({List<PageRouteInfo>? children})
      : super(
          LanguageSelectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'LanguageSelectionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsNotificationPage]
class SettingsNotificationRoute extends PageRouteInfo<void> {
  const SettingsNotificationRoute({List<PageRouteInfo>? children})
      : super(
          SettingsNotificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsNotificationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ThemeSelectionPage]
class ThemeSelectionRoute extends PageRouteInfo<void> {
  const ThemeSelectionRoute({List<PageRouteInfo>? children})
      : super(
          ThemeSelectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'ThemeSelectionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UpdateBirthdayPage]
class UpdateBirthdayRoute extends PageRouteInfo<UpdateBirthdayRouteArgs> {
  UpdateBirthdayRoute({
    Key? key,
    required PersonModel personmodel,
    List<PageRouteInfo>? children,
  }) : super(
          UpdateBirthdayRoute.name,
          args: UpdateBirthdayRouteArgs(
            key: key,
            personmodel: personmodel,
          ),
          initialChildren: children,
        );

  static const String name = 'UpdateBirthdayRoute';

  static const PageInfo<UpdateBirthdayRouteArgs> page =
      PageInfo<UpdateBirthdayRouteArgs>(name);
}

class UpdateBirthdayRouteArgs {
  const UpdateBirthdayRouteArgs({
    this.key,
    required this.personmodel,
  });

  final Key? key;

  final PersonModel personmodel;

  @override
  String toString() {
    return 'UpdateBirthdayRouteArgs{key: $key, personmodel: $personmodel}';
  }
}
