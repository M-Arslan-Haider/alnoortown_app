// // screens/ComplaintScreen.dart
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';
// import '../providers/auth_provider.dart';
//
// class ComplaintScreen extends StatefulWidget {
//   const ComplaintScreen({super.key});
//
//   @override
//   State<ComplaintScreen> createState() => _ComplaintScreenState();
// }
//
// class _ComplaintScreenState extends State<ComplaintScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String? _selectedCategory;
//   final _descriptionController = TextEditingController();
//   File? _selectedImage;
//   bool _isSubmitting = false;
//
//   // User profile data - ALL fields from AuthProvider
//   String _userName = '';
//   String _userEmail = '';
//   String _userFatherName = '';
//   String _phoneNumber = '';
//   String _houseNumber = '';
//   String _cnicNumber = '';
//
//   final List<String> _categories = [
//     'Electricity',
//     'Security',
//     'Cleaning',
//     'Other',
//   ];
//
//   final Map<String, IconData> _categoryIcons = {
//     'Electricity': Icons.electrical_services,
//     'Security': Icons.security,
//     'Cleaning': Icons.cleaning_services,
//     'Other': Icons.more_horiz,
//   };
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserProfile();
//   }
//
//   void _loadUserProfile() {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     setState(() {
//       _userName = authProvider.getUserName();
//       _userEmail = authProvider.getUserEmail();
//       _userFatherName = authProvider.getUserFatherName() ?? '';
//       _phoneNumber = authProvider.getUserPhone() ?? '';
//       _houseNumber = authProvider.getUserHouseNumber() ?? '';
//       _cnicNumber = authProvider.getUserCnic() ?? '';
//     });
//
//     // Debug print to check loaded data
//     print("ComplaintScreen Loaded - Name: $_userName");
//     print("ComplaintScreen Loaded - Father: $_userFatherName");
//     print("ComplaintScreen Loaded - Phone: $_phoneNumber");
//     print("ComplaintScreen Loaded - House: $_houseNumber");
//     print("ComplaintScreen Loaded - CNIC: $_cnicNumber");
//   }
//
//   Future<void> _pickImage(ImageSource source) async {
//     try {
//       final picker = ImagePicker();
//       final pickedFile = await picker.pickImage(
//         source: source,
//         maxWidth: 1920,
//         maxHeight: 1080,
//         imageQuality: 85,
//       );
//
//       if (pickedFile != null) {
//         setState(() {
//           _selectedImage = File(pickedFile.path);
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error picking image: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
//
//   void _showImageSourceDialog() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const SizedBox(height: 12),
//             Container(
//               width: 40,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Upload Photo',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'Choose source',
//               style: TextStyle(color: Colors.grey),
//             ),
//             const SizedBox(height: 20),
//             ListTile(
//               leading: const Icon(Icons.camera_alt, color: Colors.blue, size: 28),
//               title: const Text('Camera', style: TextStyle(fontSize: 16)),
//               subtitle: const Text('Take a new photo'),
//               onTap: () {
//                 Navigator.pop(context);
//                 _pickImage(ImageSource.camera);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.photo_library, color: Colors.green, size: 28),
//               title: const Text('Gallery', style: TextStyle(fontSize: 16)),
//               subtitle: const Text('Choose from gallery'),
//               onTap: () {
//                 Navigator.pop(context);
//                 _pickImage(ImageSource.gallery);
//               },
//             ),
//             const SizedBox(height: 8),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _submitComplaint() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     if (_selectedCategory == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please select a category'),
//           backgroundColor: Colors.orange,
//         ),
//       );
//       return;
//     }
//
//     setState(() {
//       _isSubmitting = true;
//     });
//
//     // Here you would upload the complaint to your backend
//     // including the image file if selected
//     // Also include all user data: _userName, _userEmail, _userFatherName,
//     // _phoneNumber, _houseNumber, _cnicNumber, _selectedCategory, _descriptionController.text
//
//     await Future.delayed(const Duration(seconds: 2)); // Simulate API call
//
//     setState(() {
//       _isSubmitting = false;
//     });
//
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Complaint submitted successfully!'),
//           backgroundColor: Colors.green,
//           duration: Duration(seconds: 2),
//         ),
//       );
//       Navigator.pop(context);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Submit Complaint'),
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         elevation: 2,
//         actions: [
//           if (_isSubmitting)
//             const Padding(
//               padding: EdgeInsets.all(16),
//               child: SizedBox(
//                 height: 20,
//                 width: 20,
//                 child: CircularProgressIndicator(strokeWidth: 2),
//               ),
//             ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // User Information Card - Now with ALL fields
//               Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Colors.deepPurple[100],
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: const Icon(
//                               Icons.person,
//                               color: Colors.deepPurple,
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           const Text(
//                             'User Information',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Divider(height: 24),
//                       _buildInfoRow(Icons.person_outline, 'Full Name', _userName),
//                       const SizedBox(height: 12),
//                       _buildInfoRow(Icons.family_restroom, "Father's Name",
//                           _userFatherName.isEmpty ? 'Not provided' : _userFatherName),
//                       const SizedBox(height: 12),
//                       _buildInfoRow(Icons.email_outlined, 'Email', _userEmail),
//                       const SizedBox(height: 12),
//                       _buildInfoRow(Icons.phone_outlined, 'Phone Number',
//                           _phoneNumber.isEmpty ? 'Not provided' : _phoneNumber),
//                       const SizedBox(height: 12),
//                       _buildInfoRow(Icons.home_outlined, 'House/Flat No',
//                           _houseNumber.isEmpty ? 'Not provided' : _houseNumber),
//                       const SizedBox(height: 12),
//                       _buildInfoRow(Icons.credit_card_outlined, 'CNIC Number',
//                           _cnicNumber.isEmpty ? 'Not provided' : _cnicNumber),
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               // Category Selection
//               const Text(
//                 'Select Category',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 12),
//               GridView.count(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 12,
//                 crossAxisSpacing: 12,
//                 childAspectRatio: 2.5,
//                 children: _categories.map((category) {
//                   final isSelected = _selectedCategory == category;
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _selectedCategory = category;
//                       });
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: isSelected
//                             ? Theme.of(context).primaryColor
//                             : Colors.grey[100],
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(
//                           color: isSelected
//                               ? Theme.of(context).primaryColor
//                               : Colors.grey[300]!,
//                           width: 2,
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             _categoryIcons[category],
//                             color: isSelected ? Colors.white : Colors.grey[700],
//                             size: 24,
//                           ),
//                           const SizedBox(width: 8),
//                           Text(
//                             category,
//                             style: TextStyle(
//                               color: isSelected ? Colors.white : Colors.grey[800],
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//
//               const SizedBox(height: 24),
//
//               // Description Field
//               const Text(
//                 'Description',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 controller: _descriptionController,
//                 maxLines: 5,
//                 decoration: InputDecoration(
//                   hintText: 'Please describe your issue in detail...',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey[50],
//                   prefixIcon: const Icon(Icons.description_outlined),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please describe your complaint';
//                   }
//                   if (value.length < 10) {
//                     return 'Please provide more details (at least 10 characters)';
//                   }
//                   return null;
//                 },
//               ),
//
//               const SizedBox(height: 24),
//
//               // Photo Upload Section
//               const Text(
//                 'Attach Photo (Optional)',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               GestureDetector(
//                 onTap: _showImageSourceDialog,
//                 child: Container(
//                   height: 200,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[50],
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(
//                       color: Colors.grey[300]!,
//                       style: BorderStyle.solid,
//                     ),
//                   ),
//                   child: _selectedImage != null
//                       ? Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.file(
//                           _selectedImage!,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       Positioned(
//                         top: 8,
//                         right: 8,
//                         child: CircleAvatar(
//                           backgroundColor: Colors.black54,
//                           child: IconButton(
//                             icon: const Icon(Icons.close, color: Colors.white),
//                             onPressed: () {
//                               setState(() {
//                                 _selectedImage = null;
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                       : Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.cloud_upload_outlined,
//                         size: 48,
//                         color: Colors.grey[400],
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Tap to upload photo',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         'Take a photo or choose from gallery',
//                         style: TextStyle(
//                           color: Colors.grey[400],
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               // Submit Button
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: _isSubmitting ? null : _submitComplaint,
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     backgroundColor: Colors.orange,
//                     foregroundColor: Colors.white,
//                   ),
//                   child: _isSubmitting
//                       ? const SizedBox(
//                     height: 20,
//                     width: 20,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 2,
//                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                     ),
//                   )
//                       : const Text(
//                     'Submit Complaint',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 16),
//
//               // Note
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.blue[50],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.info_outline, color: Colors.blue[700], size: 20),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: Text(
//                         'Your complaint will be reviewed within 24-48 hours. You will receive updates via email.',
//                         style: TextStyle(color: Colors.blue[700], fontSize: 12),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoRow(IconData icon, String label, String value) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//       decoration: BoxDecoration(
//         color: Colors.grey[50],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, size: 20, color: Colors.deepPurple),
//           const SizedBox(width: 12),
//           SizedBox(
//             width: 110,
//             child: Text(
//               label,
//               style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w600, fontSize: 13),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// screens/ComplaintScreen.dart
import 'dart:io';
import 'package:alnoortown_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/auth_provider.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;
  final _descriptionController = TextEditingController();
  File? _selectedImage;
  bool _isSubmitting = false;

  // User profile data - ALL fields from AuthProvider
  String _userName = '';
  String _userEmail = '';
  String _userFatherName = '';
  String _phoneNumber = '';
  String _houseNumber = '';
  String _cnicNumber = '';

  final List<String> _categories = [
    'Electricity',
    'Security',
    'Cleaning',
    'Other',
  ];

  final Map<String, IconData> _categoryIcons = {
    'Electricity': Icons.electrical_services,
    'Security': Icons.security,
    'Cleaning': Icons.cleaning_services,
    'Other': Icons.more_horiz,
  };

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  void _loadUserProfile() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    setState(() {
      _userName = authProvider.getUserName();
      _userEmail = authProvider.getUserEmail();
      _userFatherName = authProvider.getUserFatherName() ?? '';
      _phoneNumber = authProvider.getUserPhone() ?? '';
      _houseNumber = authProvider.getUserHouseNumber() ?? '';
      _cnicNumber = authProvider.getUserCnic() ?? '';
    });

    // Debug print to check loaded data
    print("ComplaintScreen Loaded - Name: $_userName");
    print("ComplaintScreen Loaded - Father: $_userFatherName");
    print("ComplaintScreen Loaded - Phone: $_phoneNumber");
    print("ComplaintScreen Loaded - House: $_houseNumber");
    print("ComplaintScreen Loaded - CNIC: $_cnicNumber");
  }

  // Validation method to check if profile is complete
  bool _isProfileComplete() {
    if (_userFatherName.isEmpty || _phoneNumber.isEmpty ||
        _houseNumber.isEmpty || _cnicNumber.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Upload Photo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Choose source',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.blue, size: 28),
              title: const Text('Camera', style: TextStyle(fontSize: 16)),
              subtitle: const Text('Take a new photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.green, size: 28),
              title: const Text('Gallery', style: TextStyle(fontSize: 16)),
              subtitle: const Text('Choose from gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Future<void> _submitComplaint() async {
    // First check if profile is complete
    if (!_isProfileComplete()) {
      _showIncompleteProfileDialog();
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a category'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // Here you would upload the complaint to your backend
    // including the image file if selected
    // Also include all user data: _userName, _userEmail, _userFatherName,
    // _phoneNumber, _houseNumber, _cnicNumber, _selectedCategory, _descriptionController.text

    await Future.delayed(const Duration(seconds: 2)); // Simulate API call

    setState(() {
      _isSubmitting = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Complaint submitted successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
    }
  }

  void _showIncompleteProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Incomplete Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please complete your profile before submitting a complaint. The following information is missing:',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            if (_userFatherName.isEmpty)
              const BulletPoint(text: "Father's Name"),
            if (_phoneNumber.isEmpty)
              const BulletPoint(text: 'Phone Number'),
            if (_houseNumber.isEmpty)
              const BulletPoint(text: 'House/Flat Number'),
            if (_cnicNumber.isEmpty)
              const BulletPoint(text: 'CNIC Number'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to profile screen to complete profile
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(isProfileCompletion: true),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
            ),
            child: const Text('Complete Profile'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Complaint'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
        actions: [
          if (_isSubmitting)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Information Card - Now with ALL fields
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'User Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      _buildInfoRow(Icons.person_outline, 'Full Name', _userName),
                      const SizedBox(height: 12),
                      _buildInfoRow(Icons.family_restroom, "Father's Name",
                          _userFatherName.isEmpty ? 'Not provided' : _userFatherName,
                          isMissing: _userFatherName.isEmpty),
                      const SizedBox(height: 12),
                      _buildInfoRow(Icons.email_outlined, 'Email', _userEmail),
                      const SizedBox(height: 12),
                      _buildInfoRow(Icons.phone_outlined, 'Phone Number',
                          _phoneNumber.isEmpty ? 'Not provided' : _phoneNumber,
                          isMissing: _phoneNumber.isEmpty),
                      const SizedBox(height: 12),
                      _buildInfoRow(Icons.home_outlined, 'House/Flat No',
                          _houseNumber.isEmpty ? 'Not provided' : _houseNumber,
                          isMissing: _houseNumber.isEmpty),
                      const SizedBox(height: 12),
                      _buildInfoRow(Icons.credit_card_outlined, 'CNIC Number',
                          _cnicNumber.isEmpty ? 'Not provided' : _cnicNumber,
                          isMissing: _cnicNumber.isEmpty),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Warning message if profile incomplete
              if (!_isProfileComplete())
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning_amber_rounded, color: Colors.red[700]),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Please complete your profile before submitting a complaint',
                          style: TextStyle(color: Colors.red[700], fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 24),

              // Category Selection
              const Text(
                'Select Category',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.5,
                children: _categories.map((category) {
                  final isSelected = _selectedCategory == category;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _categoryIcons[category],
                            color: isSelected ? Colors.white : Colors.grey[700],
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            category,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey[800],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              // Description Field
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Please describe your issue in detail...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                  prefixIcon: const Icon(Icons.description_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please describe your complaint';
                  }
                  if (value.length < 10) {
                    return 'Please provide more details (at least 10 characters)';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Photo Upload Section
              const Text(
                'Attach Photo (Optional)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _showImageSourceDialog,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey[300]!,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: _selectedImage != null
                      ? Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: CircleAvatar(
                          backgroundColor: Colors.black54,
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                _selectedImage = null;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        size: 48,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap to upload photo',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Take a photo or choose from gallery',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitComplaint,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: _isProfileComplete() ? Colors.orange : Colors.grey,
                    foregroundColor: Colors.white,
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                      : const Text(
                    'Submit Complaint',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Note
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue[700], size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Your complaint will be reviewed within 24-48 hours. You will receive updates via email.',
                        style: TextStyle(color: Colors.blue[700], fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {bool isMissing = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: isMissing ? Colors.red[50] : Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: isMissing ? Border.all(color: Colors.red[200]!) : null,
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: isMissing ? Colors.red : Colors.deepPurple),
          const SizedBox(width: 12),
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: TextStyle(
                  color: isMissing ? Colors.red : Colors.grey[700],
                  fontWeight: FontWeight.w600,
                  fontSize: 13
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: isMissing ? Colors.red : Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (isMissing)
            Icon(Icons.warning_amber_rounded, color: Colors.red[400], size: 16),
        ],
      ),
    );
  }
}

// Helper widget for bullet points
class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 4),
      child: Row(
        children: [
          const Text('• ', style: TextStyle(fontSize: 14)),
          Text(text, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}