import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('data'),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: Get.width,
//         height: Get.height,
//         decoration: const BoxDecoration(
//           image: DecorationImage(image: NetworkImage('https://th.bing.com/th/id/OIP.HLuY60jzx5puuKjbqmWRRwHaEK?w=324&h=182&c=7&r=0&o=5&pid=1.7')),
//         ),
//         child: Column(
//           children: [
//             Text('arslan'),
//           ],
//         ),
//       ),
//     );
//   }
// }
