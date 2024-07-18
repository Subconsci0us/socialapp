  /*
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

// Provider for the ConnectionChecker interface
final connectionCheckerProvider = Provider<ConnectionChecker>((ref) {
  // Replace with actual implementation or dependency injection
  return ConnectionCheckerImpl(InternetConnection());
});

abstract interface class ConnectionChecker {
  Future<bool> get isConnected;
}

class ConnectionCheckerImpl implements ConnectionChecker {
  final InternetConnection internetConnection;
  ConnectionCheckerImpl(this.internetConnection);

  @override
  Future<bool> get isConnected async =>
      await internetConnection.hasInternetAccess;
}

*/
