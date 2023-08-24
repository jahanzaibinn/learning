import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:webtutorial/mobile/mobilehost.dart';
import 'package:webtutorial/responsive/responsive.dart';
import 'package:webtutorial/web/webhost.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey).copyWith(background: Colors.grey),
        canvasColor: Colors.grey
      ),
      home: const ResponsiveLayer(
        isMobileLayout: MobileHost(),
        isWebLayout: WebHost(),
      )
    );
  }
}
