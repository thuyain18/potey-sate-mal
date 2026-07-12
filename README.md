# Potey Sate Mal (ပုတီးစိပ်မယ်)

A lightweight and elegant Flutter-based Android application designed to help users count, track, and maintain their daily chanting and meditation routines. The app allows users to log their daily progress, view analytical statistics, and set customized daily reminders via notifications.

---

## ✨ Features

| Feature | Description |
| :--- | :--- |
| 🔴 **Interactive Bead Counter** | A custom interactive bead ring interface — 108 counts complete exactly 1 cycle. |
| 💾 **Instant Save** | Persist your current day's chanting progress instantly to local storage. |
| 📖 **Comprehensive Records** | View your chanting history through a detailed daily list, dynamic bar charts, and lifetime statistics. |
| ⏰ **Daily Reminders** | Set a preferred time to receive local notifications, ensuring you never miss your daily routine. |
| ℹ️ **About & Contact** | Quick access to app information, version control, release dates, and creator contact details. |
| 🎨 **Cultural UI/UX** | Styled with an elegant Gold/Monastic aesthetic, utilizing the Myanmar Padauk font, and a fluid custom-drawn vector bead logo. |

---

## 📂 Project Structure

```text
lib/
 ├─ main.dart                 # App entry point & initialization
 ├─ theme/app_theme.dart      # Global styling, colors, and typography
 ├─ utils/constants.dart      # App constants, shared preferences keys, and layout sizes
 ├─ models/bead_record.dart   # Data model representing daily chanting history
 ├─ services/
 │   ├─ storage_service.dart      # SharedPreferences wrapper for counts, history, and settings
 │   └─ notification_service.dart # Local notification scheduling agent for daily alarms
 ├─ widgets/
 │   ├─ bead_logo.dart         # Custom-painted vector bead logo (requires no image assets)
 │   ├─ bead_ring.dart         # Interactive 108-bead custom painter counting ring
 │   └─ app_drawer.dart        # Main navigation drawer (Home, Record, Alarm, About)
 └─ screens/
     ├─ home_screen.dart       # Main counter interface with auto-save capabilities
     ├─ record_screen.dart     # Analytics dashboard with dynamic chart scaling (30-day view)
     ├─ alarm_screen.dart      # Reminder configuration and scheduling panel
     └─ about_screen.dart      # Developer info and application metadata