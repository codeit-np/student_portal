import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/connectivity_controller.dart';

class NoInternetPage extends StatefulWidget {
  const NoInternetPage({super.key});

  @override
  State<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {
  final ConnectivityController controller = ConnectivityController.to;

  @override
  void initState() {
    super.initState();
    ever(controller.isConnected, (bool connected) {
      if (connected && Get.isRegistered<ConnectivityController>()) {
        Future.microtask(() {
          if (Get.currentRoute != '/') Get.back();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.wifi_off, size: 80, color: Colors.red),
              SizedBox(height: 20),
              Text(
                'No Internet Connection',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Please check your internet and try again.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}