import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingHandler {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Definisikan Channel ID
  static const String channelId = 'channel_notification'; // Harus sama dengan yang ada di AndroidManifest.xml

  // Inisialisasi kanal notifikasi untuk Android
  final AndroidNotificationChannel _androidChannel = const AndroidNotificationChannel(
    channelId,
    'High Importance Notification',
    description: 'Used For Notification',
    importance: Importance.max,
  );

  // Inisialisasi plugin notifikasi lokal
  final FlutterLocalNotificationsPlugin _localNotification = FlutterLocalNotificationsPlugin();

  Future<void> initPushNotification() async {
    // Kode untuk meminta izin notifikasi dari pengguna
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('Izin yang diberikan pengguna: ${settings.authorizationStatus}');

    // Mendapatkan token FCM
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');

    // Handler untuk notifikasi ketika aplikasi di foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification == null) return;

      // Tampilkan notifikasi lokal
      _localNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@mipmap/ic_launcher', // Pastikan ini ada di folder mipmap
          ),
        ),
        payload: jsonEncode(message.data), // Menyimpan payload jika ada
      );

      print('Pesan diterima saat aplikasi di foreground: ${notification.title}');
    });

    // Handler ketika pesan dibuka dari notifikasi
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Pesan dibuka dari notifikasi: ${message.notification?.title}');
    });
  }

  Future<void> initLocalNotification() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher'); // Pastikan ini sesuai dengan ikon yang ada
    const settings = InitializationSettings(android: android);
    await _localNotification.initialize(settings);
  }
}
