import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/bead_ring.dart';
import '../widgets/app_drawer.dart';
import '../services/storage_service.dart';
import '../models/bead_record.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _count = 0;
  int _cycles = 0;
  String _beadTitle = "ဂုဏ်တော်";
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCurrentData();
  }

  // To retrieve saved or recalled data
  void _loadCurrentData() {
    setState(() {
      _count = StorageService.getTodayCount();
      _cycles = StorageService.getTotalCycles();
      _beadTitle = StorageService.getBeadTitle();
    });
  }

  void _incrementCount() {
    HapticFeedback.lightImpact();
    setState(() {
      _count++;
      if (_count % 108 == 0) {
        _cycles++;
        StorageService.saveTotalCycles(_cycles);
      }
      StorageService.saveTodayCount(_count);
    });
  }

  void _resetCount() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("သုညသို့ ပြန်ပြင်ရန်"),
        content:
            const Text("ယနေ့ရေတွက်ချက်ကို သုည ပြန်လုပ်ချင်တာ သေချာပါသလား။"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("မလုပ်တော့ပါ")),
          TextButton(
            onPressed: () {
              setState(() {
                _count = 0;
                _cycles = 0;
                StorageService.saveTodayCount(0);
                StorageService.saveTotalCycles(0);
              });
              Navigator.pop(context);
            },
            child: const Text("သေချာသည်"),
          ),
        ],
      ),
    );
  }

  void _showSaveDialog() {
    _titleController.text = _beadTitle;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("မှတ်တမ်းခေါင်းစဉ် ထည့်သွင်းရန်"),
        content: TextField(
          controller: _titleController,
          decoration: const InputDecoration(
            labelText: "တရားတော် / ဂုဏ်တော် အမည်",
            hintText: "ဥပမာ - ဂုဏ်တော်ကိုးပါး",
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("မသိမ်းတော့ပါ")),
          TextButton(
            onPressed: () async {
              String todayStr = DateTime.now().toIso8601String().split('T')[0];
              setState(() {
                _beadTitle = _titleController.text.trim().isEmpty
                    ? "ဂုဏ်တော်"
                    : _titleController.text.trim();
              });

              await StorageService.saveBeadTitle(_beadTitle);

              BeadRecord record = BeadRecord(
                  date: todayStr,
                  title: _beadTitle,
                  count: _count,
                  cycles: _count ~/ 108);
              await StorageService.saveRecord(record);

              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          "'$_beadTitle' မှတ်တမ်းကို သိမ်းဆည်းပြီးပါပြီ။ ဆက်လက်ပုတီးစိပ်နိုင်ပါသည်။"),
                      backgroundColor: Colors.amber),
                );
              }
            },
            child: const Text("သိမ်းဆည်းမည်"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ပုတီးစိပ်မယ်")),
      drawer: const AppDrawer(currentRoute: 'home'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("လက်ရှိစိပ်နေသော ခေါင်းစဉ် - $_beadTitle",
                style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 5),
            Text("စုစုပေါင်းပတ်ရေ: $_cycles ပတ်",
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 25),
            BeadRing(currentCount: _count, onTap: _incrementCount),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _resetCount,
                  icon: const Icon(Icons.refresh),
                  label: const Text("ပြန်စမည်"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      foregroundColor: Colors.white),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: _showSaveDialog,
                  icon: const Icon(Icons.save),
                  label: const Text("သိမ်းဆည်းမည်"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
