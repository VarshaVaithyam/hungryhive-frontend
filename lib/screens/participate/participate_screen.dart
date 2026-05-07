import 'package:flutter/material.dart';
import 'add_food_detail_screen.dart';

class ParticipateScreen extends StatelessWidget {
  const ParticipateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2E6D8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2E6D8),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          'PARTICIPATE',
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
      ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "We share our love through acts of service.",
                textAlign: TextAlign.center,
                style: TextStyle(color: const Color(0xFF3E2E22),
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Please provide details about the food you want to donate."
                "This helps us connect it to the right people safely.",
                  style: TextStyle(color: const Color(0xFF3E2E22),),
               textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  // Submit donation details(next screen)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddFoodDetailScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: const Color(0xFF3E2E22),
                ),
                child: const Text(
                  "ADD +",
                  style: TextStyle(
                    color: const Color(0xFFE6D8C3),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
