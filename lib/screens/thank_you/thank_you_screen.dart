import 'package:flutter/material.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  static const Color backgroundColor = Color(0xFFF2E6D8);
  static const Color primaryColor = Color(0xFF6B4F3A);
  static const Color textColor = Color(0xFF3E2E22);

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 70),

              Text(
                "Thank You for your\nDonation.",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 38,
                  height: 1.35,
                  fontWeight: FontWeight.w800,
                ),
              ),

              SizedBox(height: 32),

              Divider(
                color: textColor,
                thickness: 1.5,
              ),

              SizedBox(height: 32),

              Text(
                "We wouldn’t be able to do what we do without the support of people like you.",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 24,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                ),
              ),

              Spacer(),

              Center(
                child: Icon(
                  Icons.volunteer_activism,
                  size: 130,
                  color: primaryColor,
                ),
              ),

              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
