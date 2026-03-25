import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Background message handler
Future<void> _backgroundHandler(RemoteMessage message) async {
  print("BackGround message: ${message.notification?.title}");
}

class FCMHelper {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'default_channel',
    'Default Notifications',
    description: 'Channel for app notifications',
    importance: Importance.max,
  );

  static Future<void> initFCM({String? topic}) async {
    // Request permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print("Permission: ${settings.authorizationStatus}");


    // Token refresh listener
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      print("NEW TOKEN: $newToken");
    });

    // Create notification channel
    await _localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    // Initialize local notifications
    const InitializationSettings initSettings =
    InitializationSettings(android: AndroidInitializationSettings('@mipmap/ic_launcher'));
    await _localNotifications.initialize(settings: initSettings);

    // Foreground message listener
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("ForGround Message: ${message.notification?.title}");
      if (message.notification != null) {
        showNotification(
          message.notification!.title ?? "No title",
          message.notification!.body ?? "No body",
        );
      }
    });

    // App opened from notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("open From notification");
    });

    // Background message handler
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

    // Optional topic subscription
    if (topic != null && topic.isNotEmpty) {
      await _messaging.subscribeToTopic(topic);
      print("Subscribed to topic: $topic");
    }
  }

  // Show local notification
  static Future<void> showNotification(String title, String body) async {
    final androidDetails = AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      channelDescription: _channel.description,
      importance: Importance.max,
      priority: Priority.high,
    );
    await _localNotifications.show(
      id: title.hashCode,
      title: title,
      body: body,
      notificationDetails: NotificationDetails(android: androidDetails),
    );
    print("local notification: $title - $body");
  }

  // Get token manually
  static Future<String?> getToken() async {
    try {
      String? token = await _messaging.getToken();
      return token;
    } catch (e) {
      return null;
    }
  }
}