// import 'package:expenses_tracker/screens/add_screen.dart';
// import 'package:expenses_tracker/screens/home_screen.dart';
// import 'package:expenses_tracker/screens/profile_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({super.key});

//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   late PersistentTabController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = PersistentTabController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: PersistentTabView(
//         controller: _controller,
//         tabs: [
//           PersistentTabConfig(
//             screen: const HomeScreen(),
//             item: ItemConfig(
//               icon: Icon(Icons.home),
//               title: "Home",
//             ),
//           ),
//           PersistentTabConfig(
//             screen:  AddScreen(),
//             item: ItemConfig(
//               icon: Builder(
//                 builder: (context) {
//                   final isSelected = _controller.index == 1;
//                   return AnimatedContainer(
//                     duration: const Duration(milliseconds: 300),
//                     curve: Curves.easeInOut,
//                     width: isSelected ? 60 : 50,
//                     height: isSelected ? 60 : 50,
//                     decoration: BoxDecoration(
//                       color: Colors.blue ,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.add, color: Colors.white, size: 28),
//                   );
//                 },
//               ),
//               title: "",
//               activeForegroundColor: Colors.transparent,
//               inactiveForegroundColor: Colors.transparent,
//             ),
//           ),
//           PersistentTabConfig(
//             screen: const ProfileScreen(),
//             item:  ItemConfig(
//               icon: Icon(Icons.settings),
//               title: "Profile",
//             ),
//           ),
//         ],
//         navBarBuilder: (navBarConfig) => Style1BottomNavBar(
//           navBarConfig: navBarConfig,
//         ),
//       ),
//     );
//   }
// }
