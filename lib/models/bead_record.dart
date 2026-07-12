import 'dart:convert'; // 👈 This is required (No longer unused)

class BeadRecord {
  final String date; // YYYY-MM-DD
  final String title; // Title (e.g., Nine Virtues of Buddha)
  final int count;
  final int cycles;

  BeadRecord({
    required this.date,
    required this.title,
    required this.count,
    required this.cycles,
  });

  Map<String, dynamic> toMap() {
    return {'date': date, 'title': title, 'count': count, 'cycles': cycles};
  }

  factory BeadRecord.fromMap(Map<String, dynamic> map) {
    return BeadRecord(
      date: map['date'] ?? '',
      title: map['title'] ?? 'အထွေထွေ ပုတီးစိပ်ခြင်း',
      count: map['count'] ?? 0,
      cycles: map['cycles'] ?? 0,
    );
  }

  // String JSON conversion methods used together
  String toJson() => json.encode(toMap());

  factory BeadRecord.fromJson(String source) =>
      BeadRecord.fromMap(json.decode(source));
}
