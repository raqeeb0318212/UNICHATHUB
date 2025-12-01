import 'package:flutter/material.dart';
import 'menu_screen.dart'; // Import Menu Screen
import 'notification_screen.dart'; // Import Notification Screen

// --- Color Constants ---
const Color _primaryTaupe = Color(0xFFB4AFAF);
const Color _darkText = Color(0xFF333333);
const Color _lightButtonBg = Color(0xFFEBEBEB);
const Color _confirmButtonBg = Color(0xFFD2C1A8);
const Color _editIconGradientStart = Color(0xFF00BFFF);
const Color _editIconGradientEnd = Color(0xFF1E90FF);

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _primaryTaupe,
      appBar: AppBar(
        backgroundColor: _primaryTaupe,
        elevation: 0,
        toolbarHeight: 50,
        title: const Text(
          'Profile Setting',
          style: TextStyle(
            color: _darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        // --- MENU ICON ACTION ---
        leading: IconButton(
          icon: const Icon(Icons.menu, color: _darkText),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MenuScreen(),
              ),
            );
          },
        ),
        actions: [
          // --- NOTIFICATION ICON ACTION ---
          IconButton(
            icon: const Icon(Icons.notifications_none, color: _darkText),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              // --- Back Button Row ---
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.arrow_back_ios, size: 18, color: _darkText),
                    SizedBox(width: 4),
                    Text(
                      'Back',
                      style: TextStyle(
                        color: _darkText,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),

              // --- Profile Avatar with Edit Icon ---
              const Center(child: _ProfileAvatarWithEdit()),

              const SizedBox(height: 40),

              // --- Edit Username Label ---
              const Text(
                'Edit Username',
                style: TextStyle(
                  color: _darkText,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),

              // --- Username Input Field ---
              const _UsernameInputField(),

              const SizedBox(height: 60),

              // --- Confirm Button ---
              const Center(child: _ConfirmButton()),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileAvatarWithEdit extends StatelessWidget {
  const _ProfileAvatarWithEdit();

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  // TODO: Implement Gallery logic
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  // TODO: Implement Camera logic
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // 1. Large Profile Avatar
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _lightButtonBg,
            border: Border.all(color: _darkText.withOpacity(0.1), width: 1),
          ),
          child: const Center(
            child: Icon(Icons.person, size: 60, color: _darkText),
          ),
        ),

        // 2. Overlayed Edit Icon
        Positioned(
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: () {
              _showImagePickerOptions(context);
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [_editIconGradientStart, _editIconGradientEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 2,
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.edit_outlined,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _UsernameInputField extends StatelessWidget {
  const _UsernameInputField();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: _lightButtonBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          hintText: 'Enter new username',
          hintStyle: TextStyle(color: Colors.grey),
        ),
        style: TextStyle(color: _darkText),
      ),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  const _ConfirmButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Done Successfully'),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _confirmButtonBg,
          foregroundColor: _darkText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        child: const Text(
          'Confirm',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}