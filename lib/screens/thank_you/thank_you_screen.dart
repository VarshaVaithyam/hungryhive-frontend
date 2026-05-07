import 'package:flutter/material.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2E6D8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2E6D8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Thank You for your Donation.",
              style: TextStyle(color: const Color(0xFF6B4F3A),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Divider(color: Colors.black),
            SizedBox(height: 16),
            Text(
              "We wouldn’t be able to do what we do without the support of people like you.",
              style: TextStyle(color: const Color(0xFF6B4F3A), fontSize: 16),
            ),
            Spacer(),
            Center(
              child: Icon(
                Icons.volunteer_activism,
                size: 100,
                color: const Color(0xFF6B4F3A),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
