import 'package:flutter/material.dart';

class ThankYouReceiveScreen extends StatelessWidget {
  const ThankYouReceiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2E6D8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2E6D8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.check_circle, size: 80, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              "Thank you!!",
              style: TextStyle(color: const Color(0xFF6B4F3A), fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Text(
              "Your order has been confirmed.",
              style: TextStyle(color: const Color(0xFF6B4F3A), fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
