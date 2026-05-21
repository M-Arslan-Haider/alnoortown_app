//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../services/auth_service.dart';
//
// class AuthProvider with ChangeNotifier {
//   final AuthService _authService = AuthService();
//   bool _isLoading = false;
//   String? _errorMessage;
//
//   // User profile additional data
//   String? _userPhone;
//   String? _userHouseNumber;
//   String? _userCnic;
//   String? _userFatherName;
//
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//
//   String? getUserPhone() => _userPhone;
//   String? getUserHouseNumber() => _userHouseNumber;
//   String? getUserCnic() => _userCnic;
//   String? getUserFatherName() => _userFatherName;
//
//   // Sign up
//   Future<bool> signUp({
//     required String name,
//     required String email,
//     required String password,
//   }) async {
//     _setLoading(true);
//     _clearError();
//
//     try {
//       await _authService.signUpWithEmailPassword(
//         name: name,
//         email: email,
//         password: password,
//       );
//       _setLoading(false);
//       return true;
//     } catch (e) {
//       _setError(e.toString());
//       _setLoading(false);
//       return false;
//     }
//   }
//
//   // Sign in
//   Future<bool> signIn({
//     required String email,
//     required String password,
//   }) async {
//     _setLoading(true);
//     _clearError();
//
//     try {
//       await _authService.signInWithEmailPassword(
//         email: email,
//         password: password,
//       );
//       await _loadUserData();
//       _setLoading(false);
//       return true;
//     } catch (e) {
//       _setError(e.toString());
//       _setLoading(false);
//       return false;
//     }
//   }
//
//   // Google Sign In
//   Future<bool> signInWithGoogle() async {
//     _setLoading(true);
//     _clearError();
//
//     try {
//       final user = await _authService.signInWithGoogle();
//       if (user != null) {
//         await _loadUserData();
//       }
//       _setLoading(false);
//       return user != null;
//     } catch (e) {
//       _setError(e.toString());
//       _setLoading(false);
//       return false;
//     }
//   }
//
//   // Forgot Password - Send reset email
//   Future<bool> sendPasswordResetEmail(String email) async {
//     _setLoading(true);
//     _clearError();
//
//     try {
//       await _authService.sendPasswordResetEmail(email);
//       _setLoading(false);
//       return true;
//     } catch (e) {
//       _setError(e.toString());
//       _setLoading(false);
//       return false;
//     }
//   }
//
//   // Load user additional data from SharedPreferences
//   Future<void> _loadUserData() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final userId = _authService.currentUser?.uid;
//       if (userId != null) {
//         _userPhone = prefs.getString('user_phone_$userId');
//         _userHouseNumber = prefs.getString('user_house_number_$userId');
//         _userCnic = prefs.getString('user_cnic_$userId');
//         _userFatherName = prefs.getString('user_father_name_$userId');
//         notifyListeners();
//         print("Loaded - Phone: $_userPhone, House: $_userHouseNumber, CNIC: $_userCnic, Father: $_userFatherName");
//       }
//     } catch (e) {
//       print("Error loading user data: $e");
//     }
//   }
//
//   // Save user profile data
//   Future<void> saveUserProfile({
//     required String phone,
//     required String houseNumber,
//     required String cnic,
//     required String fatherName,
//   }) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final userId = _authService.currentUser?.uid;
//       if (userId != null) {
//         await prefs.setString('user_phone_$userId', phone);
//         await prefs.setString('user_house_number_$userId', houseNumber);
//         await prefs.setString('user_cnic_$userId', cnic);
//         await prefs.setString('user_father_name_$userId', fatherName);
//
//         _userPhone = phone;
//         _userHouseNumber = houseNumber;
//         _userCnic = cnic;
//         _userFatherName = fatherName;
//         notifyListeners();
//         print("Saved - Phone: $phone, House: $houseNumber, CNIC: $cnic, Father: $fatherName");
//       }
//     } catch (e) {
//       print("Error saving user data: $e");
//     }
//   }
//
//   // Check if profile is complete
//   bool isProfileComplete() {
//     return _userPhone != null &&
//         _userPhone!.isNotEmpty &&
//         _userHouseNumber != null &&
//         _userHouseNumber!.isNotEmpty &&
//         _userCnic != null &&
//         _userCnic!.isNotEmpty &&
//         _userFatherName != null &&
//         _userFatherName!.isNotEmpty;
//   }
//
//   // Sign out
//   Future<void> signOut() async {
//     await _authService.signOut();
//     _userPhone = null;
//     _userHouseNumber = null;
//     _userCnic = null;
//     _userFatherName = null;
//     notifyListeners();
//   }
//
//   // Check if user is logged in
//   bool get isLoggedIn => _authService.currentUser != null;
//
//   // Get user name
//   String getUserName() => _authService.getUserName();
//
//   // Get user email
//   String getUserEmail() => _authService.getUserEmail();
//
//   void _setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }
//
//   void _setError(String message) {
//     _errorMessage = message;
//     notifyListeners();
//   }
//
//   void _clearError() {
//     _errorMessage = null;
//     notifyListeners();
//   }
//
//   void clearError() {
//     _clearError();
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  bool _isInitialized = false;
  String? _errorMessage;

  // User profile additional data
  String? _userPhone;
  String? _userHouseNumber;
  String? _userCnic;
  String? _userFatherName;

  bool get isLoading => _isLoading;
  bool get isInitialized => _isInitialized;
  String? get errorMessage => _errorMessage;

  String? getUserPhone() => _userPhone;
  String? getUserHouseNumber() => _userHouseNumber;
  String? getUserCnic() => _userCnic;
  String? getUserFatherName() => _userFatherName;

  // Constructor - app start pe automatically data load karo
  AuthProvider() {
    _init();
  }

  Future<void> _init() async {
    try {
      // Firebase auth state settle hone ka wait karo
      await _authService.user.first;
      if (_authService.currentUser != null) {
        await _loadUserData();
      }
    } catch (e) {
      print("Error during init: $e");
    } finally {
      _isInitialized = true;
      notifyListeners();
    }
  }

  // Sign up
  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      await _authService.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Sign in
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      await _authService.signInWithEmailPassword(
        email: email,
        password: password,
      );
      await _loadUserData();
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Google Sign In
  Future<bool> signInWithGoogle() async {
    _setLoading(true);
    _clearError();

    try {
      final user = await _authService.signInWithGoogle();
      if (user != null) {
        await _loadUserData();
      }
      _setLoading(false);
      return user != null;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Forgot Password - Send reset email
  Future<bool> sendPasswordResetEmail(String email) async {
    _setLoading(true);
    _clearError();

    try {
      await _authService.sendPasswordResetEmail(email);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Load user additional data from SharedPreferences
  Future<void> _loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = _authService.currentUser?.uid;
      if (userId != null) {
        _userPhone = prefs.getString('user_phone_$userId');
        _userHouseNumber = prefs.getString('user_house_number_$userId');
        _userCnic = prefs.getString('user_cnic_$userId');
        _userFatherName = prefs.getString('user_father_name_$userId');
        notifyListeners();
        print("Loaded - Phone: $_userPhone, House: $_userHouseNumber, CNIC: $_userCnic, Father: $_userFatherName");
      }
    } catch (e) {
      print("Error loading user data: $e");
    }
  }

  // Save user profile data
  Future<void> saveUserProfile({
    required String phone,
    required String houseNumber,
    required String cnic,
    required String fatherName,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = _authService.currentUser?.uid;
      if (userId != null) {
        await prefs.setString('user_phone_$userId', phone);
        await prefs.setString('user_house_number_$userId', houseNumber);
        await prefs.setString('user_cnic_$userId', cnic);
        await prefs.setString('user_father_name_$userId', fatherName);

        _userPhone = phone;
        _userHouseNumber = houseNumber;
        _userCnic = cnic;
        _userFatherName = fatherName;
        notifyListeners();
        print("Saved - Phone: $phone, House: $houseNumber, CNIC: $cnic, Father: $fatherName");
      }
    } catch (e) {
      print("Error saving user data: $e");
    }
  }

  // Check if profile is complete
  bool isProfileComplete() {
    return _userPhone != null &&
        _userPhone!.isNotEmpty &&
        _userHouseNumber != null &&
        _userHouseNumber!.isNotEmpty &&
        _userCnic != null &&
        _userCnic!.isNotEmpty &&
        _userFatherName != null &&
        _userFatherName!.isNotEmpty;
  }

  // Sign out
  Future<void> signOut() async {
    await _authService.signOut();
    _userPhone = null;
    _userHouseNumber = null;
    _userCnic = null;
    _userFatherName = null;
    notifyListeners();
  }

  // Check if user is logged in
  bool get isLoggedIn => _authService.currentUser != null;

  // Get user name
  String getUserName() => _authService.getUserName();

  // Get user email
  String getUserEmail() => _authService.getUserEmail();

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _clearError();
  }
}