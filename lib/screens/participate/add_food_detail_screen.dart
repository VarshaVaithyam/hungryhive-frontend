import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_service.dart';
import '../thank_you/thank_you_screen.dart';

class AddFoodDetailScreen extends StatefulWidget {
  const AddFoodDetailScreen({super.key});

  @override
  State<AddFoodDetailScreen> createState() =>
      _AddFoodDetailScreenState();
}

class _AddFoodDetailScreenState
    extends State<AddFoodDetailScreen> {
  final nameController = TextEditingController();
  final organizationController =
      TextEditingController();
  final phoneController =
      TextEditingController();
  final addressController =
      TextEditingController();
  final itemsController =
      TextEditingController();
  final quantityController =
      TextEditingController();
  final descriptionController =
      TextEditingController();

  bool isLoading = false;

  static const Color backgroundColor =
      Color(0xFFF2E6D8);

  static const Color primaryColor =
      Color(0xFF6B4F3A);

  static const Color textColor =
      Color(0xFF3E2E22);

  static const Color lightTextColor =
      Color(0xFFE6D8C3);

  Future<void> _submitFood() async {
    final prefs =
        await SharedPreferences.getInstance();

    final String ownerUserId =
        prefs.getString('userId') ?? '';

    if (ownerUserId.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "User not logged in. Please login again.",
          ),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final bool success =
        await ApiService.addFood(
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

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const ThankYouScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
              Text("Failed to add food"),
        ),
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
    TextEditingController controller,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 22),

      child: TextField(
        controller: controller,

        minLines: 1,
        maxLines: null,

        style: const TextStyle(
          color: lightTextColor,
          fontSize: 20,
        ),

        decoration: InputDecoration(
          hintText: hint,

          hintStyle: const TextStyle(
            color: lightTextColor,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),

          filled: true,
          fillColor: primaryColor,

          contentPadding:
              const EdgeInsets.symmetric(
            horizontal: 26,
            vertical: 28,
          ),

          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),

          enabledBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),

          focusedBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(30),
            borderSide:
                const BorderSide(
              color: lightTextColor,
              width: 1.2,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,

        iconTheme: const IconThemeData(
          color: textColor,
          size: 30,
        ),

        title: const Text(
          'ADD FOOD DETAIL',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w800,
            fontSize: 28,
          ),
        ),

        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(2),

          child: Container(
            height: 2,
            color: primaryColor,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 24,
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              const Text(
                'Food Information',

                style: TextStyle(
                  color: textColor,
                  fontSize: 22,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),

              const SizedBox(height: 28),

              _inputField(
                'Name',
                nameController,
              ),

              _inputField(
                'Organization',
                organizationController,
              ),

              _inputField(
                'Phone',
                phoneController,
              ),

              _inputField(
                'Address',
                addressController,
              ),

              _inputField(
                'Items',
                itemsController,
              ),

              _inputField(
                'Quantity',
                quantityController,
              ),

              _inputField(
                'Description',
                descriptionController,
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 68,

                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : _submitFood,

                  style:
                      ElevatedButton.styleFrom(
                    elevation: 5,

                    backgroundColor:
                        primaryColor,

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        34,
                      ),
                    ),
                  ),

                  child: isLoading
                      ? const SizedBox(
                          height: 26,
                          width: 26,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color:
                                lightTextColor,
                          ),
                        )
                      : const Text(
                          'SUBMIT',
                          style: TextStyle(
                            color:
                                lightTextColor,
                            fontSize: 24,
                            fontWeight:
                                FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}