import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../screens/home_screen.dart';
import '../screens/record_screen.dart';
import '../screens/alarm_screen.dart';
import '../screens/about_screen.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;
  const AppDrawer({super.key, required this.currentRoute});

  void _navigateTo(BuildContext context, Widget screen, String routeName) {
    Navigator.pop(context); // Close drawer
    if (currentRoute != routeName) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => screen));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppConstants.backgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: AppConstants.surfaceColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.brightness_7,
                    size: 50, color: AppConstants.primaryColor),
                SizedBox(height: 10),
                Text(AppConstants.appName,
                    style: TextStyle(
                        color: AppConstants.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.exposure_zero,
                color: AppConstants.primaryColor),
            title: const Text("ပုတီးစိပ်ရန်"),
            selected: currentRoute == 'home',
            onTap: () => _navigateTo(context, const HomeScreen(), 'home'),
          ),
          ListTile(
            leading:
                const Icon(Icons.bar_chart, color: AppConstants.primaryColor),
            title: const Text("မှတ်တမ်းများ"),
            selected: currentRoute == 'record',
            onTap: () => _navigateTo(context, const RecordScreen(), 'record'),
          ),
          ListTile(
            leading: const Icon(Icons.alarm, color: AppConstants.primaryColor),
            title: const Text("သတိပေးချက် နှိုးစက်"),
            selected: currentRoute == 'alarm',
            onTap: () => _navigateTo(context, const AlarmScreen(), 'alarm'),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline,
                color: AppConstants.primaryColor),
            title: const Text("အက်ပ်အကြောင်း"),
            selected: currentRoute == 'about',
            onTap: () => _navigateTo(context, const AboutScreen(), 'about'),
          ),
        ],
      ),
    );
  }
}
