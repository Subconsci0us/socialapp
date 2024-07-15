import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:socialapp/feature/auth/screens/login_screen.dart';
import 'package:socialapp/feature/whatshot/community/screens/community_screens.dart';
import 'package:socialapp/feature/whatshot/community/screens/create_community_screen.dart';
import 'package:socialapp/feature/whatshot/community/screens/edit_community_screen.dart';
import 'package:socialapp/feature/whatshot/community/screens/mod_tools_screen.dart';
import 'package:socialapp/feature/whatshot/home/screens/home_screen_hot.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginPage()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: WhatshotHomeScreen()),
  '/create-community': (_) =>
      const MaterialPage(child: CreateCommunityScreen()),
  '/r/:name': (route) => MaterialPage(
        child: CommunityScreen(
          name: route.pathParameters['name']!,
        ),
      ),
  '/mod-tools/:name': (routeData) => MaterialPage(
        child: ModToolsScreen(
          name: routeData.pathParameters['name']!,
        ),
      ),
  '/edit-community/:name': (routeData) => MaterialPage(
        child: EditCommunityScreen(
          name: routeData.pathParameters['name']!,
        ),
      ),
});
