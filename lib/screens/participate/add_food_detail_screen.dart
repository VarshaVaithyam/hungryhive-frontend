import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_service.dart';
import '../thank_you/thank_you_screen.dart';

class AddFoodDetailScreen extends StatefulWidget {
  const AddFoodDetailScreen({super.key});

  @override
  State<AddFoodDetailScreen> createState() => _AddFoodDetailScreenState();
}

class _AddFoodDetailScreenState extends State<AddFoodDetailScreen> {
  final nameController = TextEditingController();
  final organizationController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final itemsController = TextEditingController();
  final quantityController = TextEditingController();
  final descriptionController = TextEditingController();

  bool isLoading = false;

  Future<void> _submitFood() async {
    final prefs = await SharedPreferences.getInstance();
    final String ownerUserId = prefs.getString('userId') ?? '';

    print("BUTTON CLICKED");
    print("LOGGED IN OWNER USER ID: $ownerUserId");

    if (ownerUserId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not logged in. Please login again.")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final bool success = await ApiService.addFood(
      nameController.text.trim(),
      itemsController.text.trim(),
      addressController.text.trim(),
      phoneController.text.trim(),
      organizationController.text.trim(),
      descriptionController.text.trim(),
      quantityController.text.trim(),
      addressController.text.trim(),
      ownerUserId,
    );

    print("SUCCESS: $success");

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Food Added Successfully")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ThankYouScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to add food")),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    organizationController.dispose();
    phoneController.dispose();
    addressController.dispose();
    itemsController.dispose();
    quantityController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Widget _inputField(
    String hint,
    TextEditingController controller, {
    int maxLines = 1,
    Color textColor = const Color(0xFFE6D8C3),
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFE6D8C3)),
          filled: true,
          fillColor: const Color(0xFF6B4F3A),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2E6D8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2E6D8),
        elevation: 0,
        title: const Text(
          'ADD FOOD DETAIL',
          style: TextStyle(
            color: Color(0xFF3E2E22),
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Divider(
            color: Color(0xFF6B4F3A),
            thickness: 2,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF3E2E22)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Food Information',
              style: TextStyle(
                color: Color(0xFF3E2E22),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _inputField('Name', nameController),
            _inputField('Organization', organizationController),
            _inputField('Phone', phoneController),
            _inputField('Address', addressController, maxLines: 2),
            _inputField('Items', itemsController, maxLines: 3),
            _inputField('Quantity', quantityController, maxLines: 2),
            _inputField('Description', descriptionController, maxLines: 3),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: ElevatedButton(
          onPressed: isLoading ? null : _submitFood,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            backgroundColor: const Color(0xFF6B4F3A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.black)
              : const Text(
                  'SUBMIT',
                  style: TextStyle(
                    color: Color(0xFFE6D8C3),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}