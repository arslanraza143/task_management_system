import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Models/user.dart';
import '../Views/Screens/auth/login_screen.dart';
import '../Views/Screens/tasks/task_list_screen.dart';


class AuthController extends GetxController {
  RxBool isLoggedIn = false.obs;
  Rx<AppUser?> currentUser = Rx<AppUser?>(null);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void setCurrentUser(AppUser? user) {
    currentUser.value = user;
  }

  Future<void> signUp(String email, String password, String phone) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store user data in Firestore
      await FirebaseFirestore.instance.collection('users').doc(authResult.user?.uid).set({
        'email': email,
        'phone': phone,
        'role': 'User', // Set the default role for new users
      });

      // Create a User object for local state management
      AppUser user = AppUser(
        id: authResult.user?.uid ?? '',
        email: email,
        phone: phone,
        role: UserRole.User,
      );

      setCurrentUser(user);
      isLoggedIn.value = true;

      // Route to task list screen after signup
      Get.offAll(() => TaskListScreen());
    } catch (error) {
      // Handle signup errors
      print('Error during signup: $error');
    }
  }


  Future<void> login(String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Fetch additional user data from Firestore based on the user's UID
      await _fetchUserDataFromFirestore(authResult.user!.uid);

      // Access the currentUser property directly from AuthController instance
      AuthController authController = Get.find(); // You may need to use Get.put() or another initialization method

      // Fetch user information from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(authResult.user!.uid).get();

      if (userDoc.exists) {
        // Extract user data from Firestore document
        var userData = userDoc.data() as Map<String, dynamic>;

        // Set the user's role using the fetched data
        authController.currentUser.value?.role = _convertStringToUserRole(userData['role']) ?? UserRole.User;

        print('Current User Role: ${authController.currentUser.value?.role}');
      }

      // Create a user object for local state management
      AppUser user = AppUser(
        id: authResult.user?.uid ?? '',
        email: email,
        phone: '1234567890', // You might fetch this from Firestore
        role: authController.currentUser.value?.role ?? UserRole.User, // Use the role from the AuthController or set a default value
      );

      setCurrentUser(user);
      isLoggedIn.value = true;
      Get.offAll(() => TaskListScreen());
    } catch (error) {
      // Handle login errors
      print('Error during login: $error');
    }
  }


  // Function to fetch user data from Firestore
  Future<void> _fetchUserDataFromFirestore(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

      if (userDoc.exists) {
        // Extract user data from Firestore document
        var userData = userDoc.data() as Map<String, dynamic>;

        // Update the current user with fetched data, including the role
        setCurrentUser(
          AppUser(
            id: userId,
            email: userData['email'],
            phone: userData['phone'],
            role: _convertStringToUserRole(userData['role']),
          ),
        );

        // ... other code ...
      }
    } catch (error) {
      // Handle error fetching user data from Firestore
      print('Error fetching user data: $error');
    }
  }

  // Function to convert String role to UserRole enum
  UserRole _convertStringToUserRole(String role) {
    switch (role) {
      case 'Admin':
        return UserRole.Admin;
      case 'Manager':
        return UserRole.Manager;
      case 'User':
        return UserRole.User;
      default:
        return UserRole.User; // Default to User if role is not recognized
    }
  }


  Future<void> logout() async {
    print('Logging out...');
    try {
      await _auth.signOut();
      setCurrentUser(null);
      isLoggedIn.value = false;
      print('Logged out successfully');
      Get.to(() => LoginScreen());
    } catch (error) {
      // Handle logout errors
      print('Error during logout: $error');
    }
  }

}
