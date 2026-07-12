# Android Manifest ထဲ ထည့်ရမည့် Permissions

`flutter create .` run ပြီးနောက် ရရှိလာမည့် `android/app/src/main/AndroidManifest.xml`
ဖိုင်ထဲတွင် `<manifest>` tag အောက်၊ `<application>` tag အပေါ်တွင် အောက်ပါစာကြောင်းများ
ထည့်ပေးပါ (daily alarm notification အလုပ်လုပ်ရန် လိုအပ်ပါသည်):

```xml
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>
<uses-permission android:name="android.permission.USE_EXACT_ALARM"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
<uses-permission android:name="android.permission.VIBRATE"/>
```

`<application>` tag ထဲတွင် boot receiver ထည့်ပါ (device restart ပြီး alarm ပျက်မသွားစေရန်):

```xml
<receiver android:exported="false" android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver">
    <intent-filter>
        <action android:name="android.intent.action.BOOT_COMPLETED"/>
    </intent-filter>
</receiver>
```

`android/app/build.gradle` ထဲတွင် `minSdkVersion` ကို **21** ထက်မနည်းစေရပါ
(google_fonts / flutter_local_notifications requirement).
