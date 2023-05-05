import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:country_codes/country_codes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:fluid_dating_app/View/HomeScreenTab.dart';
import 'package:fluid_dating_app/View/registration_screens/SignUpOrLoginScreen.dart';
import 'package:fluid_dating_app/View/registration_screens/complete_profile_screens/CompleteRegistration1Screen.dart';
import 'package:fluid_dating_app/View/splashscreen.dart';
import 'package:fluid_dating_app/network/my_http_overrides.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:fluid_dating_app/network/http_methods.dart';

import 'View/MessageScreen.dart';
import 'View/home_screen_tabs/profile_editing_screens/account_settings_screen/AccountSettingsScreen.dart';
import 'View/registration_screens/complete_profile_screens/CompleteRegistration4Screen.dart';
import 'View/registration_screens/complete_profile_screens/CompleteRegistration6Screen.dart';
import 'View/registration_screens/complete_profile_screens/CompleteRegistration7Screen.dart';
import 'helper/themes.dart';
// iOS only: Localized labels language setting is equal to CFBundleDevelopmentRegion value (Info.plist) of the iOS project
// Set iOSLocalizedLabels=false if you always want english labels whatever is the CFBundleDevelopmentRegion value.
const iOSLocalizedLabels = false;
late List<CameraDescription> cameras;






int id = 0;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream =
StreamController<String?>.broadcast();

const MethodChannel platform = MethodChannel('dexterx.dev/flutter_local_notifications_example');

const String portName = 'notification_send_port';

String? selectedNotificationPayload;

/// A notification action which triggers a url launch event
const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  if(!kIsWeb){
    final document = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(document.path);
  }
  else{
    await Hive.initFlutter();
  }
  /*if(!kIsWeb){
    await CountryCodes.init();
  }*/
  /*await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/

  // Get any initial links
  if(!kIsWeb){
   // DynamicLinksApi().handleDynamicLink();
    cameras = await availableCameras();
  }


  HttpOverrides.global = MyHttpOverrides();


  ///TO hide Red Screen of Death!

 /// userSessionModel.firebaseUserId = FirebaseAuth.instance.currentUser?.uid.toString();

  //await requestFCMPermission();
  /*FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    showNotification(message);

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });*/

  initLocalNotifications();


  ///FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FlutterError.onError = (errorDetails) {
    // If you wish to record a "non-fatal" exception, please use `FirebaseCrashlytics.instance.recordFlutterError` instead
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    // If you wish to record a "non-fatal" exception, please remove the "fatal" parameter
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(MyApp());
}


Future<void> initLocalNotifications() async {
  final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb &&
      Platform.isLinux
      ? null
      : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  /* String initialRoute = "/";
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    selectedNotificationPayload =
        notificationAppLaunchDetails!.notificationResponse?.payload;
    initialRoute = SecondPage.routeName;
  }*/

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/launcher_icon');

  final List<DarwinNotificationCategory> darwinNotificationCategories =
  <DarwinNotificationCategory>[
    DarwinNotificationCategory(
      darwinNotificationCategoryText,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.text(
          'text_1',
          'Action 1',
          buttonTitle: 'Send',
          placeholder: 'Placeholder',
        ),
      ],
    ),
    DarwinNotificationCategory(
      darwinNotificationCategoryPlain,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2 (destructive)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          navigationActionId,
          'Action 3 (foreground)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
        DarwinNotificationAction.plain(
          'id_4',
          'Action 4 (auth required)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.authenticationRequired,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    )
  ];

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final DarwinInitializationSettings initializationSettingsDarwin =
  DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    onDidReceiveLocalNotification:
        (int id, String? title, String? body, String? payload) async {
      didReceiveLocalNotificationStream.add(
        ReceivedNotification(
          id: id,
          title: title,
          body: body,
          payload: payload,
        ),
      );
    },
    notificationCategories: darwinNotificationCategories,
  );
  final LinuxInitializationSettings initializationSettingsLinux =
  LinuxInitializationSettings(
    defaultActionName: 'Open notification',
    defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
  );
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
    macOS: initializationSettingsDarwin,
    linux: initializationSettingsLinux,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          selectNotificationStream.add(notificationResponse.payload);
          break;
        case NotificationResponseType.selectedNotificationAction:
          if (notificationResponse.actionId == navigationActionId) {
            selectNotificationStream.add(notificationResponse.payload);
          }
          break;
      }
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );
}



/*
Future<void> showNotification(RemoteMessage payload) async {

  showNotificationReally(payload.notification?.title??"",payload.notification?.body??"",payload.data);

}
Future<void> showNotificationReally(String title,String body,Map? data) async {
  AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails('your channel id', 'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      //color: const Color.fromARGB(255, 255, 255, 255),
      priority: Priority.high,
      ticker: 'ticker');
  NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

  await flutterLocalNotificationsPlugin.show(
      id++, title, body, notificationDetails,
      payload: 'item x');
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> requestFCMPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
}

*/


class MyApp extends StatelessWidget {
  final _mainNavigatorKey = GlobalKey<NavigatorState>();

  MyApp({Key? key}) : super(key: key);

  /*ThemeData getCurrentTheme(){
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.get(key);
    return Themes().wingsLightTheme.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(),
    );
  }*/

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: _mainNavigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Fluid',
      theme:Themes().fluidsLightTheme.copyWith(
        textTheme: GoogleFonts.ralewayTextTheme(),
      ),
      darkTheme: Themes().fluidsLightTheme,
      //home:ProfilePage(profileName: "shraf6",),
      //home: MyWingsProfileForOtherUserScreen(profileName: 'ashrafking',),
      //initialRoute: '/',
      home:HomeScreenTab(),
      //home:ChatScreen(),
    );
  }
}

