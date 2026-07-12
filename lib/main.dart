import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'services/storage_service.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SERVICE INITIALIZATION
  await StorageService.init();
  await NotificationService.init();

  runApp(const PoteySateMalApp());
}

class PoteySateMalApp extends StatelessWidget {
  const PoteySateMalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ပုတီးစိပ်မယ်',
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
