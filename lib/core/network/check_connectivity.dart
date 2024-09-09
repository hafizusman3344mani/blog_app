import 'package:connectivity_plus/connectivity_plus.dart';

abstract interface class CheckConnectivity {
  Future<bool> get isConnected;
  Stream<List<ConnectivityResult>> get onConnectivityChanged;
}

class CheckConnectivityImpl implements CheckConnectivity {
  final Connectivity _connectivity;

  CheckConnectivityImpl({required Connectivity connectivity})
      : _connectivity = connectivity;
  @override
  Future<bool> get isConnected async => await _getConnectivityStatus();

  Future<bool> _getConnectivityStatus() async {
    var result = await _connectivity.checkConnectivity();

    if (result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.ethernet)) {
      return true;
    }
    return false;
  }

  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;
}
