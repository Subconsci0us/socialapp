import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:socialapp/core/navigation/navigation.dart';
import 'package:socialapp/feature/auth/screens/login_screen.dart';
import 'package:socialapp/feature/whatshot/community/screens/add_mods_screen.dart';
import 'package:socialapp/feature/whatshot/community/screens/community_screens.dart';
import 'package:socialapp/feature/whatshot/community/screens/create_community_screen.dart';
import 'package:socialapp/feature/whatshot/community/screens/edit_community_screen.dart';
import 'package:socialapp/feature/whatshot/community/screens/mod_tools_screen.dart';
import 'package:socialapp/feature/whatshot/post/screens/add_post_screen.dart';
import 'package:socialapp/feature/whatshot/user_profile/screens/edit_profile_screen.dart';
import 'package:socialapp/feature/whatshot/user_profile/screens/user_profile.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginPage()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: Navigation()),
  '/create-community': (_) =>
      const MaterialPage(child: CreateCommunityScreen()),
  '/add-post': (_) => const MaterialPage(child: AddPostScreen()),
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
  '/add-mods/:name': (routeData) => MaterialPage(
        child: AddModsScreen(
          name: routeData.pathParameters['name']!,
        ),
      ),
  '/u/:uid': (routeData) => MaterialPage(
        child: UserProfileScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
  '/edit-profile/:uid': (routeData) => MaterialPage(
        child: EditProfileScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
});
