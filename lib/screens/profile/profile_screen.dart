import 'package:expenses_tracker/screens/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expenses_tracker/models/user_model.dart';
import 'package:expenses_tracker/services/user_service.dart';
import 'package:expenses_tracker/services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();

  UserModel? _userModel;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final currentUser = _authService.currentUser;
    if (currentUser != null) {
      final user = await _userService.getUserById(currentUser.uid);
      setState(() {
        _userModel = user;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Header with design
                Stack(
                  children: [
                    Container(
                      height: 350,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 90,
                      left: 50,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Color.fromARGB(255, 87, 191, 240),
                      ),
                    ),
                    const Positioned(
                      top: 90,
                      right: 30,
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Color.fromARGB(255, 83, 191, 224),
                      ),
                    ),
                    Positioned(
                      top: 90,
                      left: 160,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.yellow[300],
                      ),
                    ),
                    Positioned(
                      bottom: 1,
                      left: MediaQuery.of(context).size.width / 2 - 45,
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.blue[800],
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                // Name from Firestore
                Text(
                  _userModel?.name ?? "Unknown",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),

                // Email from Firestore
                Text(
                  _userModel?.email ?? "Email not found",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 30),

                // Gray Placeholder Box
                Container(
                  height: 30,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 30),

                // Logout Button
                ElevatedButton.icon(
                  onPressed: () async {
                    await _authService.logOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text("Logout"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
