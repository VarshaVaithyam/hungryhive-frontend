import 'package:flutter/material.dart';
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

  bool isLoading = false; // ✅ loading state

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
            color: const Color(0xFF3E2E22),
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: const Divider(
            color: Color(0xFF6B4F3A),
            thickness: 2,
          ),
        ),
        iconTheme: const IconThemeData(color: const Color(0xFF3E2E22)),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Food Information',
              style: TextStyle( color: const Color(0xFF3E2E22),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),


            _inputField('Name', nameController,textColor: const Color(0xFFE6D8C3)),
            _inputField('Organization', organizationController,textColor: const Color(0xFFE6D8C3)),
            _inputField('Phone', phoneController,textColor: const Color(0xFFE6D8C3)),
            _inputField('Address', addressController, maxLines: 2,textColor: const Color(0xFFE6D8C3)),
            _inputField('Items', itemsController, maxLines: 3,textColor: const Color(0xFFE6D8C3)),
            _inputField('Quantity', quantityController, maxLines: 2,textColor: const Color(0xFFE6D8C3)),
            _inputField('Description', descriptionController, maxLines: 3,textColor: const Color(0xFFE6D8C3)),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24,),
        child: ElevatedButton(
          onPressed: isLoading ? null : _submitFood, // ✅ FIXED
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
                    color: const Color(0xFFE6D8C3),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }

  // ✅ MAIN FUNCTION (THIS WAS MISSING)
  Future<void> _submitFood() async {
    print("BUTTON CLICKED 🔥");

    setState(() {
      isLoading = true;
    });
    final String ownerUserId = phoneController.text.trim();
    bool success = await ApiService.addFood(
      nameController.text,
      itemsController.text,     // quantity -> using items here
      addressController.text,   // location -> using address
      phoneController.text,
      organizationController.text,
      descriptionController.text,
      quantityController.text,
      addressController.text,  
      ownerUserId,
    );

    print("SUCCESS: $success");

    setState(() {
      isLoading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Food Added Successfully")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ThankYouScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to add food")),
      );
    }
  }

  Widget _inputField(
    String hint,
    TextEditingController controller, {
    int maxLines = 1,
    // ignore: unused_element_parameter
    Color textColor = const Color(0xFFE6D8C3),
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField( style: TextStyle(color: textColor),
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: const Color(0xFFE6D8C3)),
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
}