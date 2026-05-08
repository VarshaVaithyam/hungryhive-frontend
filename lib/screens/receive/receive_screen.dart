import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_service.dart';
import '../../models/food_model.dart';
import 'receive_details_screen.dart';

class ReceiveScreen extends StatefulWidget {
  const ReceiveScreen({super.key});

  @override
  State<ReceiveScreen> createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen> {
  late Future<List<dynamic>> foodList;
  String? currentUserId;

  @override
  void initState() {
    super.initState();
    foodList = ApiService.getAllFood();
    loadCurrentUser();
  }

  Future<void> loadCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();

    final savedUserId = prefs.getString('userId');

    print("CURRENT USER ID FROM SHARED PREFS: $savedUserId");

    setState(() {
      currentUserId = savedUserId;
    });
  }

  Future<void> refreshData() async {
    setState(() {
      foodList = ApiService.getAllFood();
    });
  }

  Future<void> deleteFoodItem(FoodModel food) async {
    if (currentUserId == null || currentUserId!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not logged in")),
      );
      return;
    }

    final success = await ApiService.deleteFood(
      food.id,
      currentUserId!,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Food deleted successfully")),
      );

      refreshData();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You can delete only your uploaded food"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2E6D8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2E6D8),
        elevation: 0,
        title: const Text(
          "RECEIVE",
          style: TextStyle(
            color: Color(0xFF6B4F3A),
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
        iconTheme: const IconThemeData(
          color: Color(0xFF6B4F3A),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: foodList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final foods = snapshot.data ?? [];

          final foodModels = foods
              .map((e) => FoodModel.fromJson(e))
              .where((food) => food.status != "DELETED")
              .toList();

          if (foodModels.isEmpty) {
            return const Center(
              child: Text("No food available"),
            );
          }

          return RefreshIndicator(
            onRefresh: refreshData,
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: foodModels.length,
              itemBuilder: (context, index) {
                final food = foodModels[index];

                return GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReceiveDetailScreen(
                          food: food,
                          currentUserId: currentUserId ?? "",
                        ),
                      ),
                    );

                    refreshData();
                  },
                  child: _foodCard(context, food),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _foodCard(BuildContext context, FoodModel food) {
    print("------ FOOD CARD DEBUG ------");
    print("CURRENT USER ID: $currentUserId");
    print("FOOD OWNER USER ID: ${food.ownerUserId}");
    print("FOOD ID: ${food.id}");
    print("FOOD NAME: ${food.foodName}");
    print("-----------------------------");

    final bool isOwner =
        currentUserId != null &&
        currentUserId!.isNotEmpty &&
        food.ownerUserId == currentUserId;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF6B4F3A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.organization.isEmpty
                      ? "No Organization"
                      : food.organization,
                  style: const TextStyle(
                    color: Color(0xFFE6D8C3),
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Items: ${food.foodName}",
                  style: const TextStyle(
                    color: Color(0xFFE6D8C3),
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  "Location: ${food.location}",
                  style: const TextStyle(
                    color: Color(0xFFE6D8C3),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          if (isOwner)
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE6D8C3).withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                splashRadius: 22,
                icon: const Icon(
                  Icons.delete_rounded,
                  color: Color(0xFFE6D8C3),
                  size: 26,
                ),
                onPressed: () => deleteFoodItem(food),
              ),
            ),
        ],
      ),
    );
  }
}