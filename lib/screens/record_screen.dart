import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/app_drawer.dart';
import '../services/storage_service.dart';
import '../models/bead_record.dart';
import '../utils/constants.dart';
import 'home_screen.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

// Logic to recall historical records and continue chanting
  void _recallAndContinue(BuildContext context, BeadRecord record) async {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text("'${record.title}'"),
        content: const Text(
            "ဤမှတ်တမ်းဟောင်းမှစ၍ ပုတီး ဆက်လက်စိပ်လိုပါသလား။\n(လက်ရှိရေတွက်ချက်နေရာတွင် အစားထိုးသွားမည်ဖြစ်သည်)"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("မလုပ်တော့ပါ")),
          TextButton(
            onPressed: () async {
              // Saves the data and recalls it back to the Home screen
              await StorageService.saveTodayCount(record.count);
              await StorageService.saveTotalCycles(record.cycles);
              await StorageService.saveBeadTitle(record.title);

              if (context.mounted) {
                Navigator.pop(dialogContext);
                // Redirects to the Home screen and forces a refresh
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              }
            },
            child: const Text("ဆက်စိပ်မည်"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<BeadRecord> records = StorageService.getRecords().reversed.toList();

    return Scaffold(
      appBar: AppBar(title: const Text("နေ့စဉ်မှတ်တမ်း")),
      drawer: const AppDrawer(currentRoute: 'record'),
      body: records.isEmpty
          ? const Center(child: Text("မှတ်တမ်းများ မရှိသေးပါ။"))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text("နောက်ဆုံး ရက် ၃၀ စာ မှတ်တမ်း Chart",
                      style: TextStyle(fontSize: 16, color: Colors.amber)),
                  const SizedBox(height: 15),
                  SizedBox(height: 180, child: _buildChart(records)),
                  const SizedBox(height: 15),
                  const Text("👇 မှတ်တမ်းကိုနှိပ်၍ ပုတီးဆက်စိပ်နိုင်ပါသည်",
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: records.length,
                      itemBuilder: (context, index) {
                        final item = records[index];
                        return Card(
                          elevation: 2,
                          child: ListTile(
                            onTap: () => _recallAndContinue(
                                context, item), // 👈 Trigger data recall on tap
                            leading: const Icon(Icons.circle,
                                color: AppConstants.primaryColor),
                            title: Text(item.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber)),
                            subtitle: Text("နေ့စွဲ - ${item.date}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("${item.count} ကြိမ် (${item.cycles} ပတ်)",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(width: 5),
                                const Icon(Icons.arrow_forward_ios,
                                    size: 14,
                                    color: Colors
                                        .grey), // Arrow icon indicating that the user can tap to resume chanting
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }

  // Chart builder that provides 30 days (one month) of historical data
  Widget _buildChart(List<BeadRecord> records) {
    // Fetch 30 days of historical data
    List<BeadRecord> chartData = records.take(30).toList().reversed.toList();
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: chartData.isEmpty
            ? 10
            : chartData
                    .map((e) => e.count.toDouble())
                    .reduce((a, b) => a > b ? a : b) +
                50,
        barGroups: chartData.asMap().entries.map((entry) {
          return BarChartGroupData(
            x: entry.key,
            barRods: [
              BarChartRodData(
                toY: entry.value.count.toDouble(),
                color: AppConstants.primaryColor,
                width: chartData.length > 15
                    ? 6
                    : 14, // Adjusts the bar width dynamically as the number of days increases
              )
            ],
          );
        }).toList(),
        titlesData: const FlTitlesData(show: false),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
      ),
    );
  }
}
