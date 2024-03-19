import 'package:manager_mobile_app/src/shared/app_binding/app_binding.dart';
import 'package:manager_mobile_app/src/manager_mobile_app.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppBinding.setupLocator();
  runApp(const ManagerMobileApp());
}
