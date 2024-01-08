import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Controllers/auth_controller.dart';
import 'Views/Screens/SplashScreen.dart';
import 'Views/Screens/auth/login_screen.dart';
import 'Views/Screens/auth/signup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          appId: "1:135942380119:android:c884d91d8189c2981ce112",
          projectId: "task-management-system-3da5d",
          apiKey: 'AIzaSyCKEQVUn1S4cpyN9CUDtlX664PnRw2AfU0',
          messagingSenderId: '')
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignupScreen(),
    );
  }
}
class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    // Add other controllers as needed
  }
}
















// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'Views/Screens/SplashScreen.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//       options: const FirebaseOptions(
//           appId: "1:135942380119:android:c884d91d8189c2981ce112",
//           projectId: "task-management-system-3da5d",
//           apiKey: '',
//           messagingSenderId: '')
//   );
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return const GetMaterialApp(
//       title: 'Task Management System',
//       home: SplashScreen(),
//     );
//   }
// }



