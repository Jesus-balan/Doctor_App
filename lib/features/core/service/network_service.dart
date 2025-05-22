import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();
  factory ConnectivityService() => _instance;
  ConnectivityService._internal();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  BuildContext? _context;
  bool _isDialogShowing = false;

  void initialize(BuildContext context) {
    _context = context;
    _subscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final result = results.isNotEmpty ? results.first : ConnectivityResult.none;

    if (result == ConnectivityResult.none) {
      _showNoInternetDialog();
    } else {
      _closeDialogIfOpen();
    }
  }


void _showNoInternetDialog() {
  if (_isDialogShowing) return;

  _isDialogShowing = true;
  showDialog(
    context: _context!,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      titlePadding: EdgeInsets.zero, // Remove default padding
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      title: Column(
        children: [
          Lottie.asset(
            'assets/lottie/no_internet.json', // <-- your lottie file path
            height: 150,
            repeat: true,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Text(
            'No Internet Connection',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
      content: Text(
        'Please check your internet settings and try again.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[700],
        ),
      ),
     
    ),
  );
}

  void _closeDialogIfOpen() {
    if (_isDialogShowing) {
      Navigator.of(_context!, rootNavigator: true).pop();
      _isDialogShowing = false;
    }
  }

  void dispose() {
    _subscription?.cancel();
  }
}
