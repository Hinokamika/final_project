// internet_checker.dart
import 'dart:io';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetChecker {
  static final InternetChecker _instance = InternetChecker._internal();
  factory InternetChecker() => _instance;
  InternetChecker._internal();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _subscription;
  final StreamController<bool> _controller = StreamController<bool>.broadcast();
  
  bool _hasConnection = false;
  Timer? _periodicTimer;

  bool get isConnected => _hasConnection;
  Stream<bool> get connectionStream => _controller.stream;

  Future<void> initialize() async {
    await _checkConnection();
    _startPeriodicCheck();
  }

  static Future<bool> checkConnection() async {
    try {
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity == ConnectivityResult.none) {
        return false;
      }

      final result = await InternetAddress.lookup('google.com')
          .timeout(Duration(seconds: 3));
      
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> checkConnectionHTTP() async {
    try {
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity == ConnectivityResult.none) {
        return false;
      }

      final response = await HttpClient()
          .getUrl(Uri.parse('https://www.google.com'))
          .timeout(Duration(seconds: 5))
          .then((request) => request.close());
      
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _checkConnection() async {
    try {
      final connectivity = await _connectivity.checkConnectivity();
      if (connectivity == ConnectivityResult.none) {
        _updateStatus(false);
        return false;
      }

      final result = await InternetAddress.lookup('google.com')
          .timeout(Duration(seconds: 3));
      
      final hasConnection = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      _updateStatus(hasConnection);
      return hasConnection;
    } catch (e) {
      _updateStatus(false);
      return false;
    }
  }

  void _startPeriodicCheck() {
    _periodicTimer = Timer.periodic(Duration(seconds: 30), (_) async {
      await _checkConnection();
    });
  }

  void _updateStatus(bool hasConnection) {
    if (_hasConnection != hasConnection) {
      _hasConnection = hasConnection;
      _controller.add(hasConnection);
    }
  }

  Future<bool> checkNow() async {
    return await _checkConnection();
  }

  Future<bool> canReachHost(String host) async {
    try {
      final result = await InternetAddress.lookup(host)
          .timeout(Duration(seconds: 3));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  void dispose() {
    _subscription?.cancel();
    _periodicTimer?.cancel();
    _controller.close();
  }
}