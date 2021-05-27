// import 'package:covid_track/resources/consts.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'home_screen/home_page.dart';

// class IntroPage extends StatefulWidget {
//   @override
//   _IntroPageState createState() => _IntroPageState();
// }

// class _IntroPageState extends State<IntroPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               AppColors.backgroundColor,
//               AppColors.mainColor,
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Stack(
//           children: <Widget>[
//             Container(
//               child: Positioned(
//                 top: 80,
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   child: Column(
//                     children: <Widget>[
//                       Text(
//                         'Chung tay hành động \nchống lại đại dịch\nCovid-19',
//                         style: TextStyle(
//                           fontSize: 35,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.center,
//               child: Image.asset(
//                 'assets/world.png',
//               ),
//             ),
//             _buildFooter(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFooter(BuildContext context) {
//     return Positioned(
//       bottom: 50,
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(
//               height: 25,
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (_) => HomePage(),
//                   ),
//                 );
//               },
//               child: Container(
//                 width: MediaQuery.of(context).size.width * 0.85,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.8),
//                       spreadRadius: 1,
//                       blurRadius: 1,
//                       offset: Offset(0, 1), // changes position of shadow
//                     ),
//                   ],
//                   color: kBackgroundColor.withOpacity(0.9),
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 child: Center(
//                   child: Text(
//                     'BẮT ĐẦU',
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: AppColors.mainColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
