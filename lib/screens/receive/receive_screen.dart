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

  static const Color backgroundColor = Color(0xFFF2E6D8);
  static const Color primaryColor = Color(0xFF6B4F3A);
  static const Color textColor = Color(0xFF3E2E22);
  static const Color lightTextColor = Color(0xFFE6D8C3);

  @override
  void initState() {
    super.initState();
    foodList = ApiService.getAllFood();
    loadCurrentUser();
  }

  Future<void> loadCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentUserId = prefs.getString('userId');
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
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: primaryColor,
          size: 30,
        ),
        title: const Text(
          "RECEIVE",
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w800,
            fontSize: 34,
            letterSpacing: 0.5,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            height: 2,
            color: primaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<List<dynamic>>(
          future: foodList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }

            final foods = snapshot.data ?? [];

            final foodModels = foods
                .map((e) => FoodModel.fromJson(e))
                .where((food) => food.status != "DELETED")
                .toList();

            if (foodModels.isEmpty) {
              return const Center(
                child: Text(
                  "No food available",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }

            return RefreshIndicator(
              color: primaryColor,
              onRefresh: refreshData,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 28,
                ),
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
                    child: _foodCard(food),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _foodCard(FoodModel food) {
    final bool isOwner =
        currentUserId != null &&
        currentUserId!.isNotEmpty &&
        food.ownerUserId == currentUserId;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 22),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.organization.isEmpty
                      ? "No Organization"
                      : food.organization,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: lightTextColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  "Items: ${food.foodName}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: lightTextColor,
                    fontSize: 24,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Location: ${food.location}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: lightTextColor,
                    fontSize: 24,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          if (isOwner) ...[
            const SizedBox(width: 18),
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: lightTextColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(22),
              ),
              child: IconButton(
                splashRadius: 26,
                icon: const Icon(
                  Icons.delete_rounded,
                  color: lightTextColor,
                  size: 34,
                ),
                onPressed: () => deleteFoodItem(food),
              ),
            ),
          ],
        ],
      ),
    );
  }
}