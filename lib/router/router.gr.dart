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
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
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
