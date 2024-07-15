import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:socialapp/feature/auth/screens/login_screen.dart';
import 'package:socialapp/feature/whatshot/screens/home_screen_hot.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginPage()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: WhatshotScreen()),
});
