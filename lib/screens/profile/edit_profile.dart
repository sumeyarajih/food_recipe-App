import 'package:flutter/material.dart';
import 'package:food_recipe/screens/widget/background_decoration.dart';
import 'package:food_recipe/screens/widget/top_nav_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final Color _pinkColor = const Color(0xFFEC407A);
  final Color _backgroundColor = const Color.fromARGB(255, 247, 230, 235);
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  
  String _gender = 'Female';
  DateTime? _birthDate;
  
  @override
  void initState() {
    super.initState();
    // Initialize with sample data
    _nameController.text = 'Alexandra Johnson';
    _emailController.text = 'alexandra@example.com';
    _phoneController.text = '+1 (555) 123-4567';
    _bioController.text = 'Digital creator & UI/UX enthusiast. Love designing beautiful interfaces.';
    _locationController.text = 'San Francisco, CA';
    _birthDate = DateTime(1995, 5, 15);
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: _pinkColor,
            colorScheme: ColorScheme.light(primary: _pinkColor),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _birthDate) {
      setState(() {
        _birthDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
       appBar: const TopNavBar(
      ),
      body: Stack(
        children: [
          const BackgroundDecoration(),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Profile Picture Section
                      _buildProfilePictureSection(),
                      
                      const SizedBox(height: 25),
                      
                      // Personal Information Card
                      _buildPersonalInfoCard(),
                      
                      const SizedBox(height: 20),
                      
                      // Additional Information Card
                      _buildAdditionalInfoCard(),
                      
                      const SizedBox(height: 30),
                      
                      // Action Buttons
                      _buildActionButtons(),
                      
                      const SizedBox(height: 20),
                      
                      // Danger Zone
                      _buildDangerZone(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePictureSection() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _pinkColor.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: _pinkColor, width: 3),
                ),
                child: ClipOval(
                  child: _profileImage != null
                      ? Image.file(_profileImage!, fit: BoxFit.cover)
                      : Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                _pinkColor.withOpacity(0.3),
                                _pinkColor.withOpacity(0.1),
                              ],
                            ),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _pinkColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            'Profile Picture',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: _pinkColor,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Upload a clear photo of yourself',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: _pickImage,
            style: ElevatedButton.styleFrom(
              backgroundColor: _pinkColor.withOpacity(0.1),
              foregroundColor: _pinkColor,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: _pinkColor),
              ),
            ),
            child: const Text('Change Photo'),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _pinkColor.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person_outline, color: _pinkColor),
              const SizedBox(width: 10),
              Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: _pinkColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Full Name
          _buildTextField('Full Name', _nameController, Icons.person),
          const SizedBox(height: 15),
          
          // Email
          _buildTextField('Email Address', _emailController, Icons.email),
          const SizedBox(height: 15),
          
          // Phone
          _buildTextField('Phone Number', _phoneController, Icons.phone),
          const SizedBox(height: 15),
          
          // Gender
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Gender',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<String>(
                  value: _gender,
                  isExpanded: true,
                  underline: const SizedBox(),
                  icon: Icon(Icons.arrow_drop_down, color: _pinkColor),
                  items: ['Male', 'Female', 'Other'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _gender = newValue;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _pinkColor.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: _pinkColor),
              const SizedBox(width: 10),
              Text(
                'Additional Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: _pinkColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Bio
          _buildTextField('Bio', _bioController, Icons.description, maxLines: 3),
          const SizedBox(height: 15),
          
          // Location
          _buildTextField('Location', _locationController, Icons.location_on),
          const SizedBox(height: 15),
          
          // Birth Date
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Birth Date',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: _pinkColor, size: 20),
                      const SizedBox(width: 10),
                      Text(
                        _birthDate != null
                            ? '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}'
                            : 'Select your birth date',
                        style: TextStyle(
                          color: _birthDate != null ? Colors.black : Colors.grey[400],
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.arrow_drop_down, color: _pinkColor),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: _pinkColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: _pinkColor, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _discardChanges,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: _pinkColor),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Discard',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _pinkColor,
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: ElevatedButton(
            onPressed: _saveProfile,
            style: ElevatedButton.styleFrom(
              backgroundColor: _pinkColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              shadowColor: _pinkColor.withOpacity(0.3),
            ),
            child: const Text(
              'Save Changes',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDangerZone() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning, color: Colors.red),
              const SizedBox(width: 10),
              Text(
                'Danger Zone',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Text(
            'These actions are irreversible. Please proceed with caution.',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _deactivateAccount,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.withOpacity(0.1),
                    foregroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.red.withOpacity(0.3)),
                    ),
                  ),
                  child: const Text('Deactivate Account'),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _deleteAccount,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Delete Account'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _saveProfile() {
    // Save profile logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Profile updated successfully'),
        backgroundColor: _pinkColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _discardChanges() {
    Navigator.pop(context);
  }

  void _deactivateAccount() {
    showDialog(
      context: context,
      builder: (context) => _buildConfirmationDialog(
        'Deactivate Account',
        'Are you sure you want to deactivate your account? You can reactivate it anytime.',
        'Deactivate',
        Colors.orange,
      ),
    );
  }

  void _deleteAccount() {
    showDialog(
      context: context,
      builder: (context) => _buildConfirmationDialog(
        'Delete Account',
        'This action cannot be undone. All your data will be permanently deleted.',
        'Delete',
        Colors.red,
      ),
    );
  }

  AlertDialog _buildConfirmationDialog(String title, String content, String action, Color color) {
    return AlertDialog(
      title: Text(title, style: TextStyle(color: color)),
      content: Text(content),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$title request submitted'),
                backgroundColor: color,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
          ),
          child: Text(action),
        ),
      ],
    );
  }
}