import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/bead_logo.dart';
import '../utils/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("အက်ပ်အကြောင်း")),
      drawer: const AppDrawer(currentRoute: 'about'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const BeadLogo(size: 130),
              const SizedBox(height: 20),
              const Text(AppConstants.appName,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.primaryColor)),
              Text("ဗားရှင်း - ၁.၀.၀",
                  style: TextStyle(color: Colors.grey[400])),
              const Divider(height: 40, color: Colors.grey),
              _buildInfoRow(Icons.person, "ဖန်တီးသူ", AppConstants.creatorName),
              _buildInfoRow(Icons.email, "အီးမေးလ်", AppConstants.contactEmail),
              _buildInfoRow(
                  Icons.phone, "ဖုန်းနံပါတ်", AppConstants.contactPhone),
              _buildInfoRow(Icons.date_range, "ထုတ်ဝေသည့်ရက်စွဲ",
                  AppConstants.releaseDate),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppConstants.primaryColor),
          const SizedBox(width: 15),
          Text("$title :", style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          Text(value, style: const TextStyle(color: Colors.amber)),
        ],
      ),
    );
  }
}
