import 'package:codeit/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class DeleteAccountView extends StatefulWidget {
  const DeleteAccountView({super.key});

  @override
  State<DeleteAccountView> createState() => _DeleteAccountViewState();
}

class _DeleteAccountViewState extends State<DeleteAccountView> {
  bool _isChecked = false;
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Account'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Warning Icon
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.delete_forever_rounded,
                    size: 80,
                    color: Colors.red.shade400,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Title
              const Center(
                child: Text(
                  'Delete Your Account',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Subtitle
              const Text(
                'This action is permanent and cannot be undone. All your data will be permanently deleted.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 40),

              // Warning Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.red.shade100),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded,
                        color: Colors.red.shade600, size: 28),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'You will lose access to all your saved data, orders, and preferences.',
                        style: TextStyle(
                          color: Colors.red.shade700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Reason Section
              const Text(
                'Please tell us why you want to delete your account (Optional)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _reasonController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Share your feedback...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
              ),

              const SizedBox(height: 32),

              // Confirmation Checkbox
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() => _isChecked = value ?? false);
                    },
                    activeColor: Colors.red,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _isChecked = !_isChecked);
                      },
                      child: const Text(
                        'I understand that deleting my account is permanent and all my data will be lost.',
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Delete Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isChecked
                      ? () {
                          // Add your delete logic here
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Confirm Deletion'),
                              content: const Text(
                                'Are you sure you want to permanently delete your account?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Handle account deletion
                                    Navigator.pop(context);
                                    authController.deleteAccount();
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red,
                                  ),
                                  child: const Text('Yes, Delete'),
                                ),
                              ],
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Delete My Account',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Cancel Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}