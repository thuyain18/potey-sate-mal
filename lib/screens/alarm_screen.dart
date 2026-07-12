import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../services/storage_service.dart';
import '../services/notification_service.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  int _hour = 20;
  int _minute = 0;
  bool _isEnabled = false;
  final TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _hour = StorageService.getAlarmHour();
    _minute = StorageService.getAlarmMinute();
    _isEnabled = StorageService.isAlarmEnabled();
    _descController.text = StorageService.getAlarmDesc();
  }

  void _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _hour, minute: _minute),
    );
    if (picked != null) {
      setState(() {
        _hour = picked.hour;
        _minute = picked.minute;
      });
      _updateAlarm();
    }
  }

  void _updateAlarm() async {
    String descText = _descController.text.trim().isEmpty
        ? "ပုတီးစိပ်ရန် အချိန်ကျပါပြီ"
        : _descController.text.trim();
    await StorageService.saveAlarmSettings(
        _hour, _minute, descText, _isEnabled);

    if (_isEnabled) {
      await NotificationService.scheduleDailyNotification(
        hour: _hour,
        minute: _minute,
        bodyText:
            descText, // 👈 Inserts the typed text into the notification body
      );
    } else {
      await NotificationService.cancelNotification();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("သတိပေးချက် နှိုးစက်")),
      drawer: const AppDrawer(currentRoute: 'alarm'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("နေ့စဉ် သတိပေးချက်",
                        style: TextStyle(fontSize: 18)),
                    Switch(
                      value: _isEnabled,
                      activeThumbColor: Colors.amber,
                      activeTrackColor: Colors.amber.withValues(alpha: 0.3),
                      onChanged: (value) {
                        setState(() => _isEnabled = value);
                        _updateAlarm();
                      },
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_isEnabled) ...[
              GestureDetector(
                onTap: _selectTime,
                child: Card(
                  color: Colors.amber.withValues(alpha: 0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.access_time,
                            size: 32, color: Colors.amber),
                        const SizedBox(width: 15),
                        Text(
                          "${_hour.toString().padLeft(2, '0')}:${_minute.toString().padLeft(2, '0')}",
                          style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("နှိုးစက်စာတန်း/ညွှန်ကြားချက် ထည့်ရန်",
                          style: TextStyle(fontSize: 16, color: Colors.amber)),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _descController,
                        decoration: const InputDecoration(
                          hintText:
                              "ဥပမာ - သမ္ဗုဒ္ဓေ ဂုဏ်တော်စိပ်ရန် အချိန်ရောက်ပါပြီ။",
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 2,
                        onChanged: (value) =>
                            _updateAlarm(), // Auto-save immediately when text changes
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
