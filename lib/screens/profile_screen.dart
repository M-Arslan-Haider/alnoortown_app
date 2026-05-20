//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/auth_provider.dart';
// import '../services/home_screen.dart';
//
// class ProfileScreen extends StatefulWidget {
//   final bool isProfileCompletion;
//
//   const ProfileScreen({super.key, this.isProfileCompletion = false});
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
//
//     // If this is profile completion mode, automatically enable editing
//     if (widget.isProfileCompletion) {
//       _isEditing = true;
//     }
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
//
//     // If this was profile completion mode, navigate to home screen
//     if (widget.isProfileCompletion && mounted) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const HomeScreen()),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.isProfileCompletion ? 'Complete Profile' : 'My Profile'),
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         elevation: 2,
//         actions: [
//           if (!_isEditing && !widget.isProfileCompletion)
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
//                     // Add a message for profile completion mode
//                     if (widget.isProfileCompletion && !_isEditing)
//                       Container(
//                         margin: const EdgeInsets.only(top: 12),
//                         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                         decoration: BoxDecoration(
//                           color: Colors.orange[100],
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: const Text(
//                           'Please complete your profile to continue',
//                           style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w500),
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
//                         enabled: false,
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
//               // Buttons section
//               if (!_isEditing && !widget.isProfileCompletion)
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
//

// screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'login_screen.dart'; // for AppColors

class ProfileScreen extends StatefulWidget {
  final bool isProfileCompletion;
  const ProfileScreen({super.key, this.isProfileCompletion = false});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _houseController;
  late TextEditingController _cnicController;
  late TextEditingController _fatherNameController;

  bool _isEditing = false;
  bool _isLoading = false;

  late final AnimationController _fadeCtrl;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    final auth = Provider.of<AuthProvider>(context, listen: false);
    _nameController       = TextEditingController(text: auth.getUserName());
    _emailController      = TextEditingController(text: auth.getUserEmail());
    _phoneController      = TextEditingController(text: auth.getUserPhone() ?? '');
    _houseController      = TextEditingController(text: auth.getUserHouseNumber() ?? '');
    _cnicController       = TextEditingController(text: auth.getUserCnic() ?? '');
    _fatherNameController = TextEditingController(text: auth.getUserFatherName() ?? '');

    _fadeCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _fadeCtrl.forward();

    if (widget.isProfileCompletion) _isEditing = true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _houseController.dispose();
    _cnicController.dispose();
    _fatherNameController.dispose();
    _fadeCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final auth = Provider.of<AuthProvider>(context, listen: false);
    await auth.saveUserProfile(
      phone:       _phoneController.text.trim(),
      houseNumber: _houseController.text.trim(),
      cnic:        _cnicController.text.trim(),
      fatherName:  _fatherNameController.text.trim(),
    );

    setState(() {
      _isLoading = false;
      _isEditing = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'Profile updated successfully',
          style: TextStyle(fontFamily: 'Cormorant', fontSize: 14, color: AppColors.white),
        ),
        backgroundColor: const Color(0xFF2E7D4F),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'MY PROFILE',
          style: TextStyle(
            fontFamily: 'Cormorant',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.charcoal,
            letterSpacing: 3,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.gold),
        actions: [
          if (!_isEditing)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: const Icon(Icons.edit_outlined, color: AppColors.gold),
                onPressed: () => setState(() => _isEditing = true),
                tooltip: 'Edit Profile',
              ),
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.divider),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnim,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // ── Avatar Header ──
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 28),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.offWhite,
                              border: Border.all(color: AppColors.gold, width: 1.5),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.gold.withOpacity(0.2),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: const Icon(Icons.person, size: 48, color: AppColors.gold),
                          ),
                          if (_isEditing)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.gold,
                                  border: Border.all(color: AppColors.white, width: 2),
                                ),
                                child: const Icon(Icons.camera_alt, color: AppColors.white, size: 14),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        _nameController.text,
                        style: const TextStyle(
                          fontFamily: 'Cormorant',
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.charcoal,
                          letterSpacing: 0.4,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _emailController.text,
                        style: const TextStyle(
                          fontFamily: 'Cormorant',
                          fontSize: 13,
                          color: AppColors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const _GoldDivider(),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ── Personal Info Card ──
                _SectionCard(
                  title: 'PERSONAL INFORMATION',
                  children: [
                    _ProfileField(
                      icon: Icons.person_outline,
                      label: 'Full Name',
                      value: _nameController.text,
                      isEditing: false, // name not editable
                      controller: _nameController,
                    ),
                    const SizedBox(height: 12),
                    _ProfileField(
                      icon: Icons.email_outlined,
                      label: 'Email Address',
                      value: _emailController.text,
                      isEditing: false,
                      controller: _emailController,
                    ),
                    const SizedBox(height: 12),
                    _ProfileField(
                      icon: Icons.people_outline,
                      label: "Father's Name",
                      value: _fatherNameController.text,
                      isEditing: _isEditing,
                      controller: _fatherNameController,
                      validator: (v) {
                        if (_isEditing && (v == null || v.isEmpty)) return "Please enter father's name";
                        return null;
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // ── Residence Info Card ──
                _SectionCard(
                  title: 'RESIDENCE DETAILS',
                  children: [
                    _ProfileField(
                      icon: Icons.phone_outlined,
                      label: 'Phone Number',
                      value: _phoneController.text,
                      isEditing: _isEditing,
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (v) {
                        if (_isEditing && (v == null || v.isEmpty)) return 'Please enter phone number';
                        if (_isEditing && v!.length < 10) return 'Enter valid phone number';
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    _ProfileField(
                      icon: Icons.home_outlined,
                      label: 'House / Flat Number',
                      value: _houseController.text,
                      isEditing: _isEditing,
                      controller: _houseController,
                      validator: (v) {
                        if (_isEditing && (v == null || v.isEmpty)) return 'Please enter house/flat number';
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    _ProfileField(
                      icon: Icons.credit_card_outlined,
                      label: 'CNIC Number',
                      value: _cnicController.text,
                      isEditing: _isEditing,
                      controller: _cnicController,
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (_isEditing && (v == null || v.isEmpty)) return 'Please enter CNIC number';
                        if (_isEditing && v!.length < 13) return 'Enter valid CNIC (13 digits)';
                        return null;
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // ── Buttons ──
                if (!_isEditing && !widget.isProfileCompletion)
                  _GoldButton(
                    label: 'EDIT PROFILE',
                    isLoading: false,
                    onPressed: () => setState(() => _isEditing = true),
                  ),

                if (_isEditing)
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            final auth = Provider.of<AuthProvider>(context, listen: false);
                            setState(() {
                              _isEditing = false;
                              _phoneController.text      = auth.getUserPhone() ?? '';
                              _houseController.text      = auth.getUserHouseNumber() ?? '';
                              _cnicController.text       = auth.getUserCnic() ?? '';
                              _fatherNameController.text = auth.getUserFatherName() ?? '';
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                            side: const BorderSide(color: AppColors.greyLight, width: 1.3),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontFamily: 'Cormorant',
                              fontSize: 16,
                              color: AppColors.grey,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: _GoldButton(label: 'SAVE', isLoading: _isLoading, onPressed: _isLoading ? null : _saveProfile)),
                    ],
                  ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Section Card ───────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Cormorant',
              fontSize: 11,
              color: AppColors.grey,
              letterSpacing: 2.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          const _GoldDivider(),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

// ── Profile Field ──────────────────────────────────────────────
class _ProfileField extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isEditing;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool enabled;
  final String? Function(String?)? validator;

  const _ProfileField({
    required this.icon,
    required this.label,
    required this.value,
    required this.isEditing,
    this.controller,
    this.keyboardType,
    this.enabled = true,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    if (isEditing && controller != null) {
      return TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        enabled: enabled,
        validator: validator,
        style: const TextStyle(
          fontFamily: 'Cormorant',
          fontSize: 16,
          color: AppColors.charcoal,
          fontWeight: FontWeight.w600,
        ),
        cursorColor: AppColors.gold,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontFamily: 'Cormorant',
            fontSize: 14,
            color: AppColors.grey,
          ),
          errorStyle: const TextStyle(
            fontFamily: 'Cormorant',
            fontSize: 13,
            color: AppColors.error,
          ),
          prefixIcon: Icon(icon, color: AppColors.gold, size: 20),
          filled: true,
          fillColor: AppColors.inputFill,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.divider),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.divider),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.gold, width: 1.6),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error, width: 1.2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error, width: 1.6),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.gold),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'Cormorant',
                    fontSize: 11,
                    color: AppColors.grey,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value.isEmpty ? 'Not provided' : value,
                  style: TextStyle(
                    fontFamily: 'Cormorant',
                    fontSize: 15,
                    fontWeight: value.isEmpty ? FontWeight.normal : FontWeight.w600,
                    color: value.isEmpty ? AppColors.greyLight : AppColors.charcoal,
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

// ── Gold Button ────────────────────────────────────────────────
class _GoldButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback? onPressed;
  const _GoldButton({required this.label, required this.isLoading, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          gradient: onPressed != null
              ? const LinearGradient(
            colors: [AppColors.goldDark, AppColors.gold, AppColors.goldLight],
            stops: [0.0, 0.5, 1.0],
          )
              : LinearGradient(colors: [
            AppColors.gold.withOpacity(0.5),
            AppColors.goldLight.withOpacity(0.5),
          ]),
          boxShadow: onPressed != null
              ? [
            BoxShadow(color: AppColors.gold.withOpacity(0.35), blurRadius: 18, offset: const Offset(0, 6)),
          ]
              : [],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
            ),
          )
              : Text(
            label,
            style: const TextStyle(
              fontFamily: 'Cormorant',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Gold Divider ───────────────────────────────────────────────
class _GoldDivider extends StatelessWidget {
  const _GoldDivider();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.transparent, AppColors.goldLight]),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Transform.rotate(
            angle: 0.7854,
            child: Container(
              width: 6, height: 6,
              decoration: BoxDecoration(
                color: AppColors.gold,
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.goldLight, Colors.transparent]),
            ),
          ),
        ),
      ],
    );
  }
}