//
// import 'dart:io';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import '../core/app_colors.dart';
// import '../providers/auth_provider.dart';
// import 'login_screen.dart'; // for AppColors
//
// class ComplaintScreen extends StatefulWidget {
//   const ComplaintScreen({super.key});
//
//   @override
//   State<ComplaintScreen> createState() => _ComplaintScreenState();
// }
//
// class _ComplaintScreenState extends State<ComplaintScreen> with TickerProviderStateMixin {
//   final _formKey             = GlobalKey<FormState>();
//   String?  _selectedCategory;
//   final    _descriptionController = TextEditingController();
//   File?    _selectedImage;
//   bool     _isSubmitting = false;
//
//   String _userName      = '';
//   String _userEmail     = '';
//   String _userFatherName = '';
//   String _phoneNumber   = '';
//   String _houseNumber   = '';
//   String _cnicNumber    = '';
//
//   late final AnimationController _fadeCtrl;
//   late final Animation<double>   _fadeAnim;
//
//   final List<String> _categories = ['Electricity', 'Security', 'Cleaning', 'Other'];
//   final Map<String, IconData> _categoryIcons = {
//     'Electricity': Icons.electrical_services,
//     'Security':    Icons.security,
//     'Cleaning':    Icons.cleaning_services,
//     'Other':       Icons.more_horiz,
//   };
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserProfile();
//     _fadeCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
//     _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
//     _fadeCtrl.forward();
//   }
//
//   void _loadUserProfile() {
//     final auth = Provider.of<AuthProvider>(context, listen: false);
//     setState(() {
//       _userName       = auth.getUserName();
//       _userEmail      = auth.getUserEmail();
//       _userFatherName = auth.getUserFatherName() ?? '';
//       _phoneNumber    = auth.getUserPhone() ?? '';
//       _houseNumber    = auth.getUserHouseNumber() ?? '';
//       _cnicNumber     = auth.getUserCnic() ?? '';
//     });
//   }
//
//   bool _isProfileComplete() =>
//       _phoneNumber.isNotEmpty &&
//           _houseNumber.isNotEmpty &&
//           _cnicNumber.isNotEmpty &&
//           _userFatherName.isNotEmpty;
//
//   // Oracle VARCHAR2 in PL/SQL maxes at 32,767 bytes.
//   // base64 inflates by ~33%, so raw image must stay under ~22,000 bytes.
//   // We target 20,000 bytes to leave a safe margin.
//   static const int _maxImageBytes = 20000;
//
//   Future<void> _pickImage(ImageSource source) async {
//     try {
//       final picker = ImagePicker();
//       // Step 1: pick with aggressive in-picker compression
//       final pickedFile = await picker.pickImage(
//         source: source,
//         maxWidth: 400,
//         maxHeight: 400,
//         imageQuality: 40,
//       );
//       if (pickedFile == null) return;
//
//       final imageFile = File(pickedFile.path);
//       if (!await imageFile.exists()) {
//         _showSnack('Failed to load image', isError: true);
//         return;
//       }
//
//       // Step 2: hard size guard — reject before it causes ORA-06502
//       final size = await imageFile.length();
//       print('Image file size: $size bytes');
//       if (size > _maxImageBytes) {
//         _showSnack(
//           'Image too large (${(size / 1024).toStringAsFixed(0)} KB). '
//               'Please choose a smaller photo.',
//           isError: true,
//         );
//         return;
//       }
//
//       setState(() => _selectedImage = imageFile);
//     } catch (e) {
//       _showSnack('Error picking image: $e', isError: true);
//     }
//   }
//
//   void _showImageSourceDialog() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: AppColors.white,
//       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
//       builder: (ctx) => SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Center(
//                 child: Container(
//                   width: 36, height: 4,
//                   decoration: BoxDecoration(color: AppColors.greyLight, borderRadius: BorderRadius.circular(2)),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'ATTACH PHOTO',
//                 style: TextStyle(
//                   fontFamily: 'Cormorant', fontSize: 14, fontWeight: FontWeight.w700,
//                   color: AppColors.charcoal, letterSpacing: 2.5,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               const _GoldDivider(),
//               const SizedBox(height: 16),
//               _BottomSheetOption(
//                 icon: Icons.camera_alt_outlined,
//                 label: 'Take Photo',
//                 subtitle: 'Use your camera',
//                 onTap: () { Navigator.pop(ctx); _pickImage(ImageSource.camera); },
//               ),
//               const SizedBox(height: 10),
//               _BottomSheetOption(
//                 icon: Icons.photo_library_outlined,
//                 label: 'Choose from Gallery',
//                 subtitle: 'Select existing photo',
//                 onTap: () { Navigator.pop(ctx); _pickImage(ImageSource.gallery); },
//               ),
//               const SizedBox(height: 8),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _submitComplaint() async {
//     if (!_formKey.currentState!.validate()) return;
//     if (_selectedCategory == null) {
//       _showSnack('Please select a category', isError: true);
//       return;
//     }
//     setState(() => _isSubmitting = true);
//
//     try {
//       final uri = Uri.parse('https://cloud.metaxperts.net:8443/erp/alnoor_town/complaints/post');
//
//       // Convert image to base64 string with MIME type prefix
//       // Oracle APEX requires the data URI format: data:<mime>;base64,<data>
//       String? base64Image;
//       if (_selectedImage != null) {
//         final imageBytes = await _selectedImage!.readAsBytes();
//         final rawBase64  = base64Encode(imageBytes);
//
//         // Detect MIME type from file extension (APEX rejects plain base64)
//         final ext = _selectedImage!.path.split('.').last.toLowerCase();
//         final mime = switch (ext) {
//           'png'  => 'image/png',
//           'gif'  => 'image/gif',
//           'webp' => 'image/webp',
//           _      => 'image/jpeg',   // jpg / jpeg / default
//         };
//
//         base64Image = 'data:$mime;base64,$rawBase64';
//         print('Image file size: ${imageBytes.length} bytes');
//         print('Image base64 length: ${base64Image.length}');
//         print('Image MIME type: $mime');
//       }
//
//       // Send as JSON — matching Oracle bind variables exactly
//       final response = await http.post(
//         uri,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'full_name':    _userName,
//           'father_name':  _userFatherName,
//           'cnic':         _cnicNumber,
//           'contact_no':   _phoneNumber,
//           'house_number': _houseNumber,
//           'category':     _selectedCategory,
//           'description':  _descriptionController.text.trim(),
//           'image':        base64Image,   // null if no image selected
//         }),
//       );
//
//       print('Status: ${response.statusCode}');
//       print('Body: ${response.body}');
//
//       if (mounted) {
//         setState(() => _isSubmitting = false);
//         if (response.statusCode == 200 || response.statusCode == 201) {
//           _showSnack('Complaint submitted successfully!');
//           await Future.delayed(const Duration(seconds: 1));
//           if (mounted) Navigator.pop(context);
//         } else {
//           _showSnack('Failed. Status: ${response.statusCode}', isError: true);
//         }
//       }
//     } catch (e) {
//       print('Error: $e');
//       if (mounted) {
//         setState(() => _isSubmitting = false);
//         _showSnack('Error: $e', isError: true);
//       }
//     }
//   }
//
//   void _showSnack(String msg, {bool isError = false}) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(msg, style: const TextStyle(fontFamily: 'Cormorant', fontSize: 14, color: AppColors.white)),
//       backgroundColor: isError ? AppColors.error : const Color(0xFF2E7D4F),
//       behavior: SnackBarBehavior.floating,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       margin: const EdgeInsets.all(16),
//     ));
//   }
//
//   @override
//   void dispose() {
//     _descriptionController.dispose();
//     _fadeCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.offWhite,
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text(
//           'SUBMIT COMPLAINT',
//           style: TextStyle(
//             fontFamily: 'Cormorant', fontSize: 18, fontWeight: FontWeight.w700,
//             color: AppColors.charcoal, letterSpacing: 3,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: AppColors.gold),
//         actions: [
//           if (_isSubmitting)
//             const Padding(
//               padding: EdgeInsets.all(16),
//               child: SizedBox(
//                 height: 20, width: 20,
//                 child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.gold),
//               ),
//             ),
//         ],
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(1),
//           child: Container(height: 1, color: AppColors.divider),
//         ),
//       ),
//       body: FadeTransition(
//         opacity: _fadeAnim,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//
//                 // ── Submitter Info ──
//                 _SectionCard(
//                   title: 'SUBMITTER INFORMATION',
//                   child: Column(
//                     children: [
//                       _InfoRow(icon: Icons.person_outline,         label: 'Name',         value: _userName,       isMissing: _userName.isEmpty),
//                       const SizedBox(height: 10),
//                       _InfoRow(icon: Icons.email_outlined,         label: 'Email',        value: _userEmail,      isMissing: _userEmail.isEmpty),
//                       const SizedBox(height: 10),
//                       _InfoRow(icon: Icons.people_outline,         label: 'Father Name',  value: _userFatherName, isMissing: _userFatherName.isEmpty),
//                       const SizedBox(height: 10),
//                       _InfoRow(icon: Icons.phone_outlined,         label: 'Phone',        value: _phoneNumber,    isMissing: _phoneNumber.isEmpty),
//                       const SizedBox(height: 10),
//                       _InfoRow(icon: Icons.home_outlined,          label: 'House No.',    value: _houseNumber,    isMissing: _houseNumber.isEmpty),
//                       const SizedBox(height: 10),
//                       _InfoRow(icon: Icons.credit_card_outlined,   label: 'CNIC',         value: _cnicNumber,     isMissing: _cnicNumber.isEmpty),
//                     ],
//                   ),
//                 ),
//
//                 if (!_isProfileComplete()) ...[
//                   const SizedBox(height: 12),
//                   Container(
//                     padding: const EdgeInsets.all(14),
//                     decoration: BoxDecoration(
//                       color: AppColors.error.withOpacity(0.06),
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: AppColors.error.withOpacity(0.3)),
//                     ),
//                     child: const Row(
//                       children: [
//                         Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 18),
//                         SizedBox(width: 10),
//                         Expanded(
//                           child: Text(
//                             'Please complete your profile before submitting a complaint.',
//                             style: TextStyle(fontFamily: 'Cormorant', fontSize: 13, color: AppColors.error),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//
//                 const SizedBox(height: 20),
//
//                 // ── Category ──
//                 _SectionCard(
//                   title: 'COMPLAINT CATEGORY',
//                   child: GridView.count(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     childAspectRatio: 2.6,
//                     children: _categories.map((cat) {
//                       final selected = _selectedCategory == cat;
//                       return GestureDetector(
//                         onTap: () => setState(() => _selectedCategory = cat),
//                         child: AnimatedContainer(
//                           duration: const Duration(milliseconds: 180),
//                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                           decoration: BoxDecoration(
//                             color: selected ? AppColors.gold.withOpacity(0.1) : AppColors.inputFill,
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(
//                               color: selected ? AppColors.gold : AppColors.divider,
//                               width: selected ? 1.5 : 1,
//                             ),
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 _categoryIcons[cat]!,
//                                 size: 18,
//                                 color: selected ? AppColors.gold : AppColors.grey,
//                               ),
//                               const SizedBox(width: 8),
//                               Text(
//                                 cat,
//                                 style: TextStyle(
//                                   fontFamily: 'Cormorant',
//                                   fontSize: 14,
//                                   fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
//                                   color: selected ? AppColors.goldDark : AppColors.charcoal,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // ── Description ──
//                 _SectionCard(
//                   title: 'DESCRIPTION',
//                   child: TextFormField(
//                     controller: _descriptionController,
//                     maxLines: 5,
//                     style: const TextStyle(
//                       fontFamily: 'Cormorant', fontSize: 15,
//                       color: AppColors.charcoal, fontWeight: FontWeight.w500,
//                     ),
//                     cursorColor: AppColors.gold,
//                     decoration: InputDecoration(
//                       hintText: 'Please describe your issue in detail…',
//                       hintStyle: TextStyle(
//                         fontFamily: 'Cormorant', fontSize: 14,
//                         color: AppColors.grey.withOpacity(0.6),
//                       ),
//                       errorStyle: const TextStyle(fontFamily: 'Cormorant', fontSize: 13, color: AppColors.error),
//                       filled: true,
//                       fillColor: AppColors.inputFill,
//                       contentPadding: const EdgeInsets.all(16),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: const BorderSide(color: AppColors.divider),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: const BorderSide(color: AppColors.divider),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: const BorderSide(color: AppColors.gold, width: 1.6),
//                       ),
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: const BorderSide(color: AppColors.error, width: 1.2),
//                       ),
//                     ),
//                     validator: (v) {
//                       if (v == null || v.isEmpty) return 'Please describe your complaint';
//                       if (v.length < 10) return 'Please provide more details (min 10 characters)';
//                       return null;
//                     },
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // ── Photo Attach ──
//                 _SectionCard(
//                   title: 'ATTACH PHOTO  (OPTIONAL)',
//                   child: GestureDetector(
//                     onTap: _showImageSourceDialog,
//                     child: AnimatedContainer(
//                       duration: const Duration(milliseconds: 200),
//                       height: 180,
//                       decoration: BoxDecoration(
//                         color: AppColors.inputFill,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(
//                           color: _selectedImage != null ? AppColors.gold : AppColors.divider,
//                           width: _selectedImage != null ? 1.5 : 1,
//                         ),
//                       ),
//                       child: _selectedImage != null
//                           ? Stack(
//                         fit: StackFit.expand,
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(12),
//                             child: Image.file(_selectedImage!, fit: BoxFit.cover),
//                           ),
//                           Positioned(
//                             top: 8, right: 8,
//                             child: GestureDetector(
//                               onTap: () => setState(() => _selectedImage = null),
//                               child: Container(
//                                 width: 32, height: 32,
//                                 decoration: BoxDecoration(
//                                   color: AppColors.charcoal.withOpacity(0.7),
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: const Icon(Icons.close, color: AppColors.white, size: 16),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                           : Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.cloud_upload_outlined, size: 40, color: AppColors.gold.withOpacity(0.6)),
//                           const SizedBox(height: 10),
//                           const Text(
//                             'Tap to upload photo',
//                             style: TextStyle(fontFamily: 'Cormorant', fontSize: 14, color: AppColors.grey),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             'Camera or gallery',
//                             style: TextStyle(fontFamily: 'Cormorant', fontSize: 12, color: AppColors.grey.withOpacity(0.6)),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 28),
//
//                 // ── Submit Button ──
//                 _GoldButton(
//                   label: 'SUBMIT COMPLAINT',
//                   isLoading: _isSubmitting,
//                   onPressed: (_isSubmitting || !_isProfileComplete()) ? null : _submitComplaint,
//                 ),
//
//                 const SizedBox(height: 16),
//
//                 // ── Info Note ──
//                 Container(
//                   padding: const EdgeInsets.all(14),
//                   decoration: BoxDecoration(
//                     color: AppColors.gold.withOpacity(0.06),
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: AppColors.gold.withOpacity(0.25)),
//                   ),
//                   child: const Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Icon(Icons.info_outline, color: AppColors.gold, size: 18),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: Text(
//                           'Your complaint will be reviewed within 24–48 hours. Updates will be sent via email.',
//                           style: TextStyle(fontFamily: 'Cormorant', fontSize: 13, color: AppColors.charcoal, height: 1.4),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 24),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // ── Section Card ───────────────────────────────────────────────
// class _SectionCard extends StatelessWidget {
//   final String title;
//   final Widget child;
//   const _SectionCard({required this.title, required this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: AppColors.divider),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontFamily: 'Cormorant', fontSize: 11,
//               color: AppColors.grey, letterSpacing: 2.5, fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 12),
//           const _GoldDivider(),
//           const SizedBox(height: 14),
//           child,
//         ],
//       ),
//     );
//   }
// }
//
// // ── Info Row ───────────────────────────────────────────────────
// class _InfoRow extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String value;
//   final bool isMissing;
//   const _InfoRow({required this.icon, required this.label, required this.value, this.isMissing = false});
//
//   @override
//   Widget build(BuildContext context) {
//     final color = isMissing ? AppColors.error : AppColors.charcoal;
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//       decoration: BoxDecoration(
//         color: isMissing ? AppColors.error.withOpacity(0.05) : AppColors.inputFill,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: isMissing ? AppColors.error.withOpacity(0.3) : AppColors.divider),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, size: 18, color: isMissing ? AppColors.error : AppColors.gold),
//           const SizedBox(width: 12),
//           SizedBox(
//             width: 90,
//             child: Text(
//               label,
//               style: TextStyle(
//                 fontFamily: 'Cormorant', fontSize: 12,
//                 color: isMissing ? AppColors.error : AppColors.grey,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value.isEmpty ? 'Missing — update profile' : value,
//               style: TextStyle(
//                 fontFamily: 'Cormorant', fontSize: 14,
//                 fontWeight: FontWeight.w600,
//                 color: color,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//           if (isMissing) const Icon(Icons.warning_amber_rounded, size: 14, color: AppColors.error),
//         ],
//       ),
//     );
//   }
// }
//
// // ── Bottom Sheet Option ────────────────────────────────────────
// class _BottomSheetOption extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String subtitle;
//   final VoidCallback onTap;
//   const _BottomSheetOption({required this.icon, required this.label, required this.subtitle, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         decoration: BoxDecoration(
//           color: AppColors.inputFill,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: AppColors.divider),
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 40, height: 40,
//               decoration: BoxDecoration(
//                 color: AppColors.gold.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(icon, color: AppColors.gold, size: 20),
//             ),
//             const SizedBox(width: 14),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(label, style: const TextStyle(fontFamily: 'Cormorant', fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.charcoal)),
//                 Text(subtitle, style: const TextStyle(fontFamily: 'Cormorant', fontSize: 12, color: AppColors.grey)),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ── Gold Button ────────────────────────────────────────────────
// class _GoldButton extends StatelessWidget {
//   final String label;
//   final bool isLoading;
//   final VoidCallback? onPressed;
//   const _GoldButton({required this.label, required this.isLoading, this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         height: 56,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(13),
//           gradient: onPressed != null
//               ? const LinearGradient(
//             colors: [AppColors.goldDark, AppColors.gold, AppColors.goldLight],
//             stops: [0.0, 0.5, 1.0],
//           )
//               : LinearGradient(colors: [AppColors.gold.withOpacity(0.5), AppColors.goldLight.withOpacity(0.5)]),
//           boxShadow: onPressed != null
//               ? [BoxShadow(color: AppColors.gold.withOpacity(0.35), blurRadius: 18, offset: const Offset(0, 6))]
//               : [],
//         ),
//         child: Center(
//           child: isLoading
//               ? const SizedBox(
//             width: 22, height: 22,
//             child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(AppColors.white)),
//           )
//               : Text(
//             label,
//             style: const TextStyle(
//               fontFamily: 'Cormorant', fontSize: 18,
//               fontWeight: FontWeight.w700, color: AppColors.white, letterSpacing: 1.5,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // ── Gold Divider ───────────────────────────────────────────────
// class _GoldDivider extends StatelessWidget {
//   const _GoldDivider();
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(child: Container(height: 1, decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, AppColors.goldLight])))),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Transform.rotate(
//             angle: 0.7854,
//             child: Container(width: 6, height: 6, decoration: BoxDecoration(color: AppColors.gold, borderRadius: BorderRadius.circular(1.5))),
//           ),
//         ),
//         Expanded(child: Container(height: 1, decoration: const BoxDecoration(gradient: LinearGradient(colors: [AppColors.goldLight, Colors.transparent])))),
//       ],
//     );
//   }
// }
//
// // Helper widget for bullet points (kept for backward compatibility)
// class BulletPoint extends StatelessWidget {
//   final String text;
//
//   const BulletPoint({super.key, required this.text});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 8, bottom: 4),
//       child: Row(
//         children: [
//           const Text('• ', style: TextStyle(
//               fontFamily: 'Cormorant', fontSize: 14, color: AppColors.gold)),
//           Text(text, style: const TextStyle(fontFamily: 'Cormorant',
//               fontSize: 14,
//               color: AppColors.charcoal)),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../core/app_colors.dart';
import '../core/app_widgets.dart';
import '../providers/auth_provider.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen>
    with TickerProviderStateMixin {
  final _formKey                  = GlobalKey<FormState>();
  String?  _selectedCategory;
  final    _descriptionController = TextEditingController();
  File?    _selectedImage;
  bool     _isSubmitting          = false;

  String _userName       = '';
  String _userEmail      = '';
  String _userFatherName = '';
  String _phoneNumber    = '';
  String _houseNumber    = '';
  String _cnicNumber     = '';

  late final AnimationController _fadeCtrl;
  late final Animation<double>   _fadeAnim;

  static const List<String> _categories = [
    'Electricity',
    'Security',
    'Cleaning',
    'Other',
  ];

  static const Map<String, IconData> _categoryIcons = {
    'Electricity': Icons.electrical_services,
    'Security':    Icons.security,
    'Cleaning':    Icons.cleaning_services,
    'Other':       Icons.more_horiz,
  };

  // Oracle VARCHAR2 maxes at 32,767 bytes; base64 inflates ~33%
  // so raw image must stay under ~22,000 bytes. Target: 20,000.
  static const int _maxImageBytes = 20000;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
    _fadeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _fadeCtrl.forward();
  }

  void _loadUserProfile() {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    setState(() {
      _userName       = auth.getUserName();
      _userEmail      = auth.getUserEmail();
      _userFatherName = auth.getUserFatherName() ?? '';
      _phoneNumber    = auth.getUserPhone() ?? '';
      _houseNumber    = auth.getUserHouseNumber() ?? '';
      _cnicNumber     = auth.getUserCnic() ?? '';
    });
  }

  bool _isProfileComplete() =>
      _phoneNumber.isNotEmpty &&
          _houseNumber.isNotEmpty &&
          _cnicNumber.isNotEmpty &&
          _userFatherName.isNotEmpty;

  // ── Image Picker ────────────────────────────────────────────
  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source:       source,
        maxWidth:     400,
        maxHeight:    400,
        imageQuality: 40,
      );
      if (pickedFile == null) return;

      final imageFile = File(pickedFile.path);
      if (!await imageFile.exists()) {
        if (mounted) AppSnackbar.error(context, 'Failed to load image');
        return;
      }

      final size = await imageFile.length();
      if (size > _maxImageBytes) {
        if (mounted) {
          AppSnackbar.error(
            context,
            'Image too large (${(size / 1024).toStringAsFixed(0)} KB). '
                'Please choose a smaller photo.',
          );
        }
        return;
      }

      setState(() => _selectedImage = imageFile);
    } catch (e) {
      if (mounted) AppSnackbar.error(context, 'Error picking image: $e');
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 36, height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.greyLight,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'ATTACH PHOTO',
                style: TextStyle(
                  fontFamily:  'Cormorant',
                  fontSize:    14,
                  fontWeight:  FontWeight.w700,
                  color:       AppColors.charcoal,
                  letterSpacing: 2.5,
                ),
              ),
              const SizedBox(height: 4),
              const AppGoldDivider(),
              const SizedBox(height: 16),
              _BottomSheetOption(
                icon:     Icons.camera_alt_outlined,
                label:    'Take Photo',
                subtitle: 'Use your camera',
                onTap:    () { Navigator.pop(ctx); _pickImage(ImageSource.camera); },
              ),
              const SizedBox(height: 10),
              _BottomSheetOption(
                icon:     Icons.photo_library_outlined,
                label:    'Choose from Gallery',
                subtitle: 'Select existing photo',
                onTap:    () { Navigator.pop(ctx); _pickImage(ImageSource.gallery); },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  // ── Submit ──────────────────────────────────────────────────
  Future<void> _submitComplaint() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategory == null) {
      AppSnackbar.error(context, 'Please select a category');
      return;
    }
    setState(() => _isSubmitting = true);

    try {
      final uri = Uri.parse(
          'https://cloud.metaxperts.net:8443/erp/alnoor_town/complaints/post');

      String? base64Image;
      if (_selectedImage != null) {
        final imageBytes = await _selectedImage!.readAsBytes();
        final rawBase64  = base64Encode(imageBytes);
        final ext  = _selectedImage!.path.split('.').last.toLowerCase();
        final mime = switch (ext) {
          'png'  => 'image/png',
          'gif'  => 'image/gif',
          'webp' => 'image/webp',
          _      => 'image/jpeg',
        };
        base64Image = 'data:$mime;base64,$rawBase64';
      }

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'full_name':    _userName,
          'father_name':  _userFatherName,
          'cnic':         _cnicNumber,
          'contact_no':   _phoneNumber,
          'house_number': _houseNumber,
          'category':     _selectedCategory,
          'description':  _descriptionController.text.trim(),
          'image':        base64Image,
        }),
      );

      if (mounted) {
        setState(() => _isSubmitting = false);
        if (response.statusCode == 200 || response.statusCode == 201) {
          AppSnackbar.success(context, 'Complaint submitted successfully!');
          await Future.delayed(const Duration(seconds: 1));
          if (mounted) Navigator.pop(context);
        } else {
          AppSnackbar.error(context, 'Failed. Status: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        AppSnackbar.error(context, 'Error: $e');
      }
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _fadeCtrl.dispose();
    super.dispose();
  }

  // ── BUILD ───────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,

      // ── Gold gradient AppBar — same as Home ──
      appBar: GoldAppBar(
        title: 'SUBMIT COMPLAINT',
        // whiteStyle: false  →  gold gradient (default, same as Home)
        actions: [
          if (_isSubmitting)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                height: 20, width: 20,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: AppColors.white),
              ),
            ),
        ],
      ),

      body: FadeTransition(
        opacity: _fadeAnim,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ── Submitter Info ──────────────────────────
                AppSectionCard(
                  title: 'SUBMITTER INFORMATION',
                  child: Column(
                    children: [
                      AppInfoRow(
                        icon:      Icons.person_outline,
                        label:     'Name',
                        value:     _userName,
                        isMissing: _userName.isEmpty,
                      ),
                      const SizedBox(height: 10),
                      AppInfoRow(
                        icon:      Icons.email_outlined,
                        label:     'Email',
                        value:     _userEmail,
                        isMissing: _userEmail.isEmpty,
                      ),
                      const SizedBox(height: 10),
                      AppInfoRow(
                        icon:      Icons.people_outline,
                        label:     'Father Name',
                        value:     _userFatherName,
                        isMissing: _userFatherName.isEmpty,
                      ),
                      const SizedBox(height: 10),
                      AppInfoRow(
                        icon:      Icons.phone_outlined,
                        label:     'Phone',
                        value:     _phoneNumber,
                        isMissing: _phoneNumber.isEmpty,
                      ),
                      const SizedBox(height: 10),
                      AppInfoRow(
                        icon:      Icons.home_outlined,
                        label:     'House No.',
                        value:     _houseNumber,
                        isMissing: _houseNumber.isEmpty,
                      ),
                      const SizedBox(height: 10),
                      AppInfoRow(
                        icon:      Icons.credit_card_outlined,
                        label:     'CNIC',
                        value:     _cnicNumber,
                        isMissing: _cnicNumber.isEmpty,
                      ),
                    ],
                  ),
                ),

                if (!_isProfileComplete()) ...[
                  const SizedBox(height: 12),
                  _WarningBanner(
                    message:
                    'Please complete your profile before submitting a complaint.',
                  ),
                ],

                const SizedBox(height: 20),

                // ── Category Grid ───────────────────────────
                AppSectionCard(
                  title: 'COMPLAINT CATEGORY',
                  child: GridView.count(
                    crossAxisCount:  2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing:  10,
                    shrinkWrap:       true,
                    physics:          const NeverScrollableScrollPhysics(),
                    childAspectRatio: 2.6,
                    children: _categories.map((cat) {
                      final selected = _selectedCategory == cat;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedCategory = cat),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.gold.withOpacity(0.1)
                                : AppColors.inputFill,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: selected
                                  ? AppColors.gold
                                  : AppColors.divider,
                              width: selected ? 1.5 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _categoryIcons[cat]!,
                                size:  18,
                                color: selected
                                    ? AppColors.gold
                                    : AppColors.grey,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                cat,
                                style: TextStyle(
                                  fontFamily:  'Cormorant',
                                  fontSize:    14,
                                  fontWeight:  selected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: selected
                                      ? AppColors.goldDark
                                      : AppColors.charcoal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 20),

                // ── Description ─────────────────────────────
                AppSectionCard(
                  title: 'DESCRIPTION',
                  child: AppGoldInputField(
                    controller: _descriptionController,
                    label:      '',
                    hint:       'Please describe your issue in detail…',
                    icon:       Icons.edit_note_outlined,
                    maxLines:   5,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Please describe your complaint';
                      }
                      if (v.length < 10) {
                        return 'Provide more details (min 10 characters)';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // ── Photo Attach ────────────────────────────
                AppSectionCard(
                  title: 'ATTACH PHOTO  (OPTIONAL)',
                  child: _PhotoPicker(
                    selectedImage: _selectedImage,
                    onTap:         _showImageSourceDialog,
                    onRemove:      () => setState(() => _selectedImage = null),
                  ),
                ),

                const SizedBox(height: 28),

                // ── Submit Button ───────────────────────────
                AppGoldButton(
                  label:     'SUBMIT COMPLAINT',
                  isLoading: _isSubmitting,
                  onPressed: (_isSubmitting || !_isProfileComplete())
                      ? null
                      : _submitComplaint,
                ),

                const SizedBox(height: 16),

                // ── Info Note ───────────────────────────────
                _InfoNote(
                  message:
                  'Your complaint will be reviewed within 24–48 hours. '
                      'Updates will be sent via email.',
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════
//  PHOTO PICKER
// ═════════════════════════════════════════════════════════════
class _PhotoPicker extends StatelessWidget {
  final File?        selectedImage;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _PhotoPicker({
    required this.selectedImage,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 180,
        decoration: BoxDecoration(
          color: AppColors.inputFill,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selectedImage != null
                ? AppColors.gold
                : AppColors.divider,
            width: selectedImage != null ? 1.5 : 1,
          ),
        ),
        child: selectedImage != null
            ? Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(selectedImage!, fit: BoxFit.cover),
            ),
            Positioned(
              top: 8, right: 8,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.charcoal.withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                      Icons.close, color: AppColors.white, size: 16),
                ),
              ),
            ),
          ],
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_upload_outlined,
                size: 40,
                color: AppColors.gold.withOpacity(0.6)),
            const SizedBox(height: 10),
            const Text(
              'Tap to upload photo',
              style: TextStyle(
                  fontFamily: 'Cormorant',
                  fontSize:   14,
                  color:      AppColors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              'Camera or gallery',
              style: TextStyle(
                fontFamily: 'Cormorant',
                fontSize:   12,
                color:      AppColors.grey.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════
//  WARNING BANNER
// ═════════════════════════════════════════════════════════════
class _WarningBanner extends StatelessWidget {
  final String message;
  const _WarningBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.error.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded,
              color: AppColors.error, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontFamily: 'Cormorant',
                fontSize:   13,
                color:      AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════
//  INFO NOTE
// ═════════════════════════════════════════════════════════════
class _InfoNote extends StatelessWidget {
  final String message;
  const _InfoNote({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.gold.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gold.withOpacity(0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: AppColors.gold, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontFamily: 'Cormorant',
                fontSize:   13,
                color:      AppColors.charcoal,
                height:     1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════
//  BOTTOM SHEET OPTION
// ═════════════════════════════════════════════════════════════
class _BottomSheetOption extends StatelessWidget {
  final IconData     icon;
  final String       label;
  final String       subtitle;
  final VoidCallback onTap;

  const _BottomSheetOption({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.inputFill,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color:        AppColors.gold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.gold, size: 20),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'Cormorant',
                    fontSize:   15,
                    fontWeight: FontWeight.w700,
                    color:      AppColors.charcoal,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Cormorant',
                    fontSize:   12,
                    color:      AppColors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}