import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'otp_screen.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {

  final TextEditingController phoneController =
      TextEditingController();

  bool isLoading = false;

  Future<void> sendOTP() async {

    final phone = phoneController.text.trim();

    if (phone.isEmpty) {
      showMessage("Enter phone number");
      return;
    }

    if (!RegExp(r'^[0-9]{10}$').hasMatch(phone)) {
      showMessage("Phone number must be 10 digits");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      final response = await http.post(

        Uri.parse(
          'https://hungryhive-backend-t081.onrender.com/auth/send-otp',
        ),

        headers: {
          'Content-Type': 'application/json',
        },

        body: jsonEncode({
          'phoneNumber': phone,
        }),
      );

      final data = jsonDecode(response.body);

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {

        showMessage(
          data['message'] ?? "OTP sent successfully",
        );

        if (!mounted) return;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OTPScreen(
              phoneNumber: phone,
            ),
          ),
        );

      } else {

        showMessage(
          data['message'] ?? "Failed to send OTP",
        );
      }

    } catch (e) {

      setState(() {
        isLoading = false;
      });

      showMessage("Error: $e");
    }
  }

  void showMessage(String message) {

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Color(0xFF3E2E22),
          ),
        ),

        backgroundColor: const Color(0xFFF2E6D8),
      ),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF2E6D8),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF2E6D8),
        elevation: 0,

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(24),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            const Text(
              "Enter mobile number",

              style: TextStyle(
                color: Color(0xFF3E2E22),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "We’ll send you an OTP",

              style: TextStyle(
                color: Color(0xFF3E2E22),
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 25),

            TextField(

              controller: phoneController,
              keyboardType: TextInputType.phone,
              maxLength: 10,

              decoration: InputDecoration(

                hintText: "Enter phone number",

                hintStyle: const TextStyle(
                  color: Color(0xFF3E2E22),
                ),

                counterStyle: const TextStyle(
                  color: Color(0xFF3E2E22),
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),

                  borderSide: const BorderSide(
                    color: Color(0xFF3E2E22),
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),

                  borderSide: const BorderSide(
                    color: Color(0xFF6B4F3A),
                    width: 2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            isLoading

                ? const CircularProgressIndicator()

                : SizedBox(

                    width: double.infinity,

                    child: ElevatedButton(

                      onPressed: sendOTP,

                      style: ElevatedButton.styleFrom(

                        foregroundColor:
                            const Color(0xFFE6D8C3),

                        backgroundColor:
                            const Color(0xFF6B4F3A),

                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),

                      child: const Text(
                        "Send OTP",

                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}