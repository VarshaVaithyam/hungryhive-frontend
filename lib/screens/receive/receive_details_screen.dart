import 'package:flutter/material.dart';
import '../../api_service.dart';
import '../../models/food_model.dart';
import '../thank_you/thank_you_receive_screen.dart';

class ReceiveDetailScreen extends StatelessWidget {
  final FoodModel food;
  final String currentUserId;

  const ReceiveDetailScreen({
    super.key,
    required this.food,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOwner = food.ownerUserId == currentUserId;

    return Scaffold(
      backgroundColor: const Color(0xFFF2E6D8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2E6D8),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "DETAILS",
          style: TextStyle(color: Color(0xFF6B4F3A)),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Divider(
            color: Color(0xFF6B4F3A),
            thickness: 2,
          ),
        ),
        actions: [
          if (isOwner)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                final success = await ApiService.deleteFood(
                  food.id,
                  currentUserId,
                );

                if (!context.mounted) return;

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Food deleted successfully"),
                    ),
                  );

                  Navigator.pop(context, true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("You can delete only your uploaded food"),
                    ),
                  );
                }
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _box("Name", food.donorName),
              _box("Name of Organization", food.organization),
              _box("Phone Number", food.phoneNumber),
              _box("Address", food.location),
              _box("Lists of items", food.foodName),
              _box("Quantity", food.quantity),
              _box("Description", food.description),
              _box("Status", food.status),
              const SizedBox(height: 20),
              if (!isOwner && food.status == "AVAILABLE")
                ElevatedButton(
                  onPressed: () async {
                    final success = await ApiService.orderFood(food.id);

                    if (!context.mounted) return;

                    if (success) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ThankYouReceiveScreen(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Failed to confirm order"),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 55),
                    backgroundColor: const Color(0xFF6B4F3A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    "Confirm",
                    style: TextStyle(
                      color: Color(0xFFE6D8C3),
                      fontSize: 16,
                    ),
                  ),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _box(String title, String? value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF6B4F3A),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFE6D8C3),
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            (value == null || value.trim().isEmpty) ? "N/A" : value.trim(),
            style: const TextStyle(
              color: Color(0xFFE6D8C3),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}