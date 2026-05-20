// // screens/profile_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/auth_provider.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _nameController;
//   late TextEditingController _emailController;
//   late TextEditingController _phoneController;
//   late TextEditingController _houseController;
//   late TextEditingController _cnicController;
//   late TextEditingController _fatherNameController;
//
//   bool _isEditing = false;
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     _nameController = TextEditingController(text: authProvider.getUserName());
//     _emailController = TextEditingController(text: authProvider.getUserEmail());
//     _phoneController = TextEditingController(text: authProvider.getUserPhone() ?? '');
//     _houseController = TextEditingController(text: authProvider.getUserHouseNumber() ?? '');
//     _cnicController = TextEditingController(text: authProvider.getUserCnic() ?? '');
//     _fatherNameController = TextEditingController(text: authProvider.getUserFatherName() ?? '');
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _houseController.dispose();
//     _cnicController.dispose();
//     _fatherNameController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _saveProfile() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     await authProvider.saveUserProfile(
//       phone: _phoneController.text.trim(),
//       houseNumber: _houseController.text.trim(),
//       cnic: _cnicController.text.trim(),
//       fatherName: _fatherNameController.text.trim(),
//     );
//
//     setState(() {
//       _isLoading = false;
//       _isEditing = false;
//     });
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Profile updated successfully!'),
//         backgroundColor: Colors.green,
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Profile'),
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         elevation: 2,
//         actions: [
//           if (!_isEditing)
//             IconButton(
//               icon: const Icon(Icons.edit),
//               onPressed: () {
//                 setState(() {
//                   _isEditing = true;
//                 });
//               },
//               tooltip: 'Edit Profile',
//             ),
//           if (_isEditing)
//             TextButton(
//               onPressed: _isLoading ? null : _saveProfile,
//               child: _isLoading
//                   ? const SizedBox(
//                 height: 20,
//                 width: 20,
//                 child: CircularProgressIndicator(strokeWidth: 2),
//               )
//                   : const Text(
//                 'Save',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // Profile Header with Avatar
//               Container(
//                 margin: const EdgeInsets.only(bottom: 24),
//                 child: Column(
//                   children: [
//                     Stack(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.deepPurple.withOpacity(0.3),
//                                 blurRadius: 20,
//                                 offset: const Offset(0, 5),
//                               ),
//                             ],
//                           ),
//                           child: const CircleAvatar(
//                             radius: 60,
//                             backgroundColor: Colors.deepPurple,
//                             child: CircleAvatar(
//                               radius: 56,
//                               backgroundColor: Colors.white,
//                               child: Icon(
//                                 Icons.person,
//                                 size: 60,
//                                 color: Colors.deepPurple,
//                               ),
//                             ),
//                           ),
//                         ),
//                         if (_isEditing)
//                           Positioned(
//                             bottom: 0,
//                             right: 0,
//                             child: Container(
//                               padding: const EdgeInsets.all(4),
//                               decoration: BoxDecoration(
//                                 color: Colors.deepPurple,
//                                 shape: BoxShape.circle,
//                                 border: Border.all(color: Colors.white, width: 2),
//                               ),
//                               child: const Icon(
//                                 Icons.camera_alt,
//                                 color: Colors.white,
//                                 size: 20,
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     if (!_isEditing)
//                       Text(
//                         _nameController.text,
//                         style: const TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     if (!_isEditing)
//                       Text(
//                         _emailController.text,
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//
//               // Information Card
//               Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Row(
//                         children: [
//                           Icon(Icons.info_outline, color: Colors.deepPurple),
//                           SizedBox(width: 8),
//                           Text(
//                             'Personal Information',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Divider(height: 24),
//
//                       // Full Name
//                       _buildProfileField(
//                         icon: Icons.person_outline,
//                         label: 'Full Name',
//                         value: _nameController.text,
//                         isEditing: _isEditing,
//                         controller: _nameController,
//                         enabled: false, // Name from Firebase, not editable
//                       ),
//
//                       const SizedBox(height: 16),
//
//                       // Father Name
//                       _buildProfileField(
//                         icon: Icons.family_restroom,
//                         label: "Father's Name",
//                         value: _fatherNameController.text,
//                         isEditing: _isEditing,
//                         controller: _fatherNameController,
//                         validator: (value) {
//                           if (_isEditing && (value == null || value.isEmpty)) {
//                             return 'Please enter father name';
//                           }
//                           return null;
//                         },
//                       ),
//
//                       const SizedBox(height: 16),
//
//                       // Email
//                       _buildProfileField(
//                         icon: Icons.email_outlined,
//                         label: 'Email Address',
//                         value: _emailController.text,
//                         isEditing: _isEditing,
//                         controller: _emailController,
//                         enabled: false,
//                       ),
//
//                       const SizedBox(height: 16),
//
//                       // Phone Number
//                       _buildProfileField(
//                         icon: Icons.phone_outlined,
//                         label: 'Phone Number',
//                         value: _phoneController.text,
//                         isEditing: _isEditing,
//                         controller: _phoneController,
//                         keyboardType: TextInputType.phone,
//                         validator: (value) {
//                           if (_isEditing && (value == null || value.isEmpty)) {
//                             return 'Please enter phone number';
//                           }
//                           if (_isEditing && value!.length < 10) {
//                             return 'Enter valid phone number';
//                           }
//                           return null;
//                         },
//                       ),
//
//                       const SizedBox(height: 16),
//
//                       // House/Flat Number
//                       _buildProfileField(
//                         icon: Icons.home_outlined,
//                         label: 'House/Flat Number',
//                         value: _houseController.text,
//                         isEditing: _isEditing,
//                         controller: _houseController,
//                         validator: (value) {
//                           if (_isEditing && (value == null || value.isEmpty)) {
//                             return 'Please enter house/flat number';
//                           }
//                           return null;
//                         },
//                       ),
//
//                       const SizedBox(height: 16),
//
//                       // CNIC Number
//                       _buildProfileField(
//                         icon: Icons.credit_card_outlined,
//                         label: 'CNIC Number',
//                         value: _cnicController.text,
//                         isEditing: _isEditing,
//                         controller: _cnicController,
//                         keyboardType: TextInputType.number,
//                         validator: (value) {
//                           if (_isEditing && (value == null || value.isEmpty)) {
//                             return 'Please enter CNIC number';
//                           }
//                           if (_isEditing && value != null && value.length < 13) {
//                             return 'Enter valid CNIC number';
//                           }
//                           return null;
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               // Edit/Save Buttons for non-editing mode
//               if (!_isEditing)
//                 SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton.icon(
//                     onPressed: () {
//                       setState(() {
//                         _isEditing = true;
//                       });
//                     },
//                     icon: const Icon(Icons.edit),
//                     label: const Text(
//                       'Edit Profile',
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       backgroundColor: Colors.deepPurple,
//                     ),
//                   ),
//                 ),
//
//               if (_isEditing)
//                 Row(
//                   children: [
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: () {
//                           setState(() {
//                             _isEditing = false;
//                             // Reset controllers to original values
//                             final authProvider = Provider.of<AuthProvider>(context, listen: false);
//                             _phoneController.text = authProvider.getUserPhone() ?? '';
//                             _houseController.text = authProvider.getUserHouseNumber() ?? '';
//                             _cnicController.text = authProvider.getUserCnic() ?? '';
//                             _fatherNameController.text = authProvider.getUserFatherName() ?? '';
//                           });
//                         },
//                         style: OutlinedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: const Text('Cancel'),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: _isLoading ? null : _saveProfile,
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           backgroundColor: Colors.green,
//                         ),
//                         child: _isLoading
//                             ? const SizedBox(
//                           height: 20,
//                           width: 20,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                           ),
//                         )
//                             : const Text(
//                           'Save Changes',
//                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProfileField({
//     required IconData icon,
//     required String label,
//     required String value,
//     required bool isEditing,
//     TextEditingController? controller,
//     TextInputType? keyboardType,
//     bool enabled = true,
//     String? Function(String?)? validator,
//   }) {
//     if (isEditing && controller != null) {
//       return TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(icon, color: Colors.deepPurple),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           filled: true,
//           fillColor: Colors.grey[50],
//         ),
//         keyboardType: keyboardType,
//         enabled: enabled,
//         validator: validator,
//       );
//     } else {
//       return Container(
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         decoration: BoxDecoration(
//           color: Colors.grey[50],
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.grey[200]!),
//         ),
//         child: Row(
//           children: [
//             Icon(icon, size: 22, color: Colors.deepPurple),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     label,
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     value.isEmpty ? 'Not provided' : value,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: value.isEmpty ? FontWeight.normal : FontWeight.w500,
//                       color: value.isEmpty ? Colors.grey : Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//   }
// }


// screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/home_screen.dart';

class ProfileScreen extends StatefulWidget {
  final bool isProfileCompletion;

  const ProfileScreen({super.key, this.isProfileCompletion = false});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _houseController;
  late TextEditingController _cnicController;
  late TextEditingController _fatherNameController;

  bool _isEditing = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _nameController = TextEditingController(text: authProvider.getUserName());
    _emailController = TextEditingController(text: authProvider.getUserEmail());
    _phoneController = TextEditingController(text: authProvider.getUserPhone() ?? '');
    _houseController = TextEditingController(text: authProvider.getUserHouseNumber() ?? '');
    _cnicController = TextEditingController(text: authProvider.getUserCnic() ?? '');
    _fatherNameController = TextEditingController(text: authProvider.getUserFatherName() ?? '');

    // If this is profile completion mode, automatically enable editing
    if (widget.isProfileCompletion) {
      _isEditing = true;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _houseController.dispose();
    _cnicController.dispose();
    _fatherNameController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.saveUserProfile(
      phone: _phoneController.text.trim(),
      houseNumber: _houseController.text.trim(),
      cnic: _cnicController.text.trim(),
      fatherName: _fatherNameController.text.trim(),
    );

    setState(() {
      _isLoading = false;
      _isEditing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    // If this was profile completion mode, navigate to home screen
    if (widget.isProfileCompletion && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isProfileCompletion ? 'Complete Profile' : 'My Profile'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
        actions: [
          if (!_isEditing && !widget.isProfileCompletion)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  _isEditing = true;
                });
              },
              tooltip: 'Edit Profile',
            ),
          if (_isEditing)
            TextButton(
              onPressed: _isLoading ? null : _saveProfile,
              child: _isLoading
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Text(
                'Save',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Profile Header with Avatar
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurple.withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.deepPurple,
                            child: CircleAvatar(
                              radius: 56,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        ),
                        if (_isEditing)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (!_isEditing)
                      Text(
                        _nameController.text,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (!_isEditing)
                      Text(
                        _emailController.text,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    // Add a message for profile completion mode
                    if (widget.isProfileCompletion && !_isEditing)
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Please complete your profile to continue',
                          style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w500),
                        ),
                      ),
                  ],
                ),
              ),

              // Information Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.deepPurple),
                          SizedBox(width: 8),
                          Text(
                            'Personal Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24),

                      // Full Name
                      _buildProfileField(
                        icon: Icons.person_outline,
                        label: 'Full Name',
                        value: _nameController.text,
                        isEditing: _isEditing,
                        controller: _nameController,
                        enabled: false,
                      ),

                      const SizedBox(height: 16),

                      // Father Name
                      _buildProfileField(
                        icon: Icons.family_restroom,
                        label: "Father's Name",
                        value: _fatherNameController.text,
                        isEditing: _isEditing,
                        controller: _fatherNameController,
                        validator: (value) {
                          if (_isEditing && (value == null || value.isEmpty)) {
                            return 'Please enter father name';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Email
                      _buildProfileField(
                        icon: Icons.email_outlined,
                        label: 'Email Address',
                        value: _emailController.text,
                        isEditing: _isEditing,
                        controller: _emailController,
                        enabled: false,
                      ),

                      const SizedBox(height: 16),

                      // Phone Number
                      _buildProfileField(
                        icon: Icons.phone_outlined,
                        label: 'Phone Number',
                        value: _phoneController.text,
                        isEditing: _isEditing,
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (_isEditing && (value == null || value.isEmpty)) {
                            return 'Please enter phone number';
                          }
                          if (_isEditing && value!.length < 10) {
                            return 'Enter valid phone number';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // House/Flat Number
                      _buildProfileField(
                        icon: Icons.home_outlined,
                        label: 'House/Flat Number',
                        value: _houseController.text,
                        isEditing: _isEditing,
                        controller: _houseController,
                        validator: (value) {
                          if (_isEditing && (value == null || value.isEmpty)) {
                            return 'Please enter house/flat number';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // CNIC Number
                      _buildProfileField(
                        icon: Icons.credit_card_outlined,
                        label: 'CNIC Number',
                        value: _cnicController.text,
                        isEditing: _isEditing,
                        controller: _cnicController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (_isEditing && (value == null || value.isEmpty)) {
                            return 'Please enter CNIC number';
                          }
                          if (_isEditing && value != null && value.length < 13) {
                            return 'Enter valid CNIC number';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Buttons section
              if (!_isEditing && !widget.isProfileCompletion)
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _isEditing = true;
                      });
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text(
                      'Edit Profile',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.deepPurple,
                    ),
                  ),
                ),

              if (_isEditing)
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _isEditing = false;
                            // Reset controllers to original values
                            final authProvider = Provider.of<AuthProvider>(context, listen: false);
                            _phoneController.text = authProvider.getUserPhone() ?? '';
                            _houseController.text = authProvider.getUserHouseNumber() ?? '';
                            _cnicController.text = authProvider.getUserCnic() ?? '';
                            _fatherNameController.text = authProvider.getUserFatherName() ?? '';
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _saveProfile,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.green,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                            : const Text(
                          'Save Changes',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField({
    required IconData icon,
    required String label,
    required String value,
    required bool isEditing,
    TextEditingController? controller,
    TextInputType? keyboardType,
    bool enabled = true,
    String? Function(String?)? validator,
  }) {
    if (isEditing && controller != null) {
      return TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.deepPurple),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
        keyboardType: keyboardType,
        enabled: enabled,
        validator: validator,
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Icon(icon, size: 22, color: Colors.deepPurple),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value.isEmpty ? 'Not provided' : value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: value.isEmpty ? FontWeight.normal : FontWeight.w500,
                      color: value.isEmpty ? Colors.grey : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}

