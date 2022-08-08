import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:revised_mobile_assignment/view/sign_up_view.dart';
import 'constant/style.dart';
import 'firebase_options.dart';
import 'view/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // debugShowMaterialGrid: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SYSTEM_OVERLAY_STYLE,
          elevation: 0.0,
        ),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const LoginView(),
        "/sign-up": (context) => const SignupView(),
      },
    );
  }
}
