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

  static const Color backgroundColor =
      Color(0xFFF2E6D8);

  static const Color primaryColor =
      Color(0xFF6B4F3A);

  static const Color textColor =
      Color(0xFF3E2E22);

  static const Color lightTextColor =
      Color(0xFFE6D8C3);

  @override
  Widget build(BuildContext context) {
    final bool isOwner =
        food.ownerUserId == currentUserId;

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
          "DETAILS",
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 28,
            letterSpacing: 0.5,
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

        actions: [
          if (isOwner)
            Padding(
              padding:
                  const EdgeInsets.only(
                right: 8,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.delete_rounded,
                  color: primaryColor,
                  size: 30,
                ),

                onPressed: () async {
                  final success =
                      await ApiService
                          .deleteFood(
                    food.id,
                    currentUserId,
                  );

                  if (!context.mounted) {
                    return;
                  }

                  if (success) {
                    ScaffoldMessenger.of(
                            context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Food deleted successfully",
                        ),
                      ),
                    );

                    Navigator.pop(
                      context,
                      true,
                    );
                  } else {
                    ScaffoldMessenger.of(
                            context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          "You can delete only your uploaded food",
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 22,
          ),

          child: Column(
            children: [
              _box(
                "Name",
                food.donorName,
              ),

              _box(
                "Name of Organization",
                food.organization,
              ),

              _box(
                "Phone Number",
                food.phoneNumber,
              ),

              _box(
                "Address",
                food.location,
              ),

              _box(
                "Lists of items",
                food.foodName,
              ),

              _box(
                "Quantity",
                food.quantity,
              ),

              _box(
                "Description",
                food.description,
              ),

              _box(
                "Status",
                food.status,
              ),

              const SizedBox(height: 24),

              if (food.status ==
                  "AVAILABLE")
                SizedBox(
                  width: double.infinity,
                  height: 64,

                  child: ElevatedButton(
                    onPressed: () async {
                      final success =
                          await ApiService
                              .orderFood(
                        food.id,
                      );

                      if (!context.mounted) {
                        return;
                      }

                      if (success) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const ThankYouReceiveScreen(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(
                                context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Failed to confirm order",
                            ),
                          ),
                        );
                      }
                    },

                    style:
                        ElevatedButton
                            .styleFrom(
                      elevation: 5,

                      backgroundColor:
                          primaryColor,

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          32,
                        ),
                      ),
                    ),

                    child: const Text(
                      "Confirm",
                      style: TextStyle(
                        color:
                            lightTextColor,
                        fontSize: 22,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }

  Widget _box(
    String title,
    String? value,
  ) {
    final String displayValue =
        (value == null ||
                value.trim().isEmpty)
            ? "N/A"
            : value.trim();

    return Container(
      width: double.infinity,

      constraints:
          const BoxConstraints(
        minHeight: 110,
      ),

      margin:
          const EdgeInsets.only(
        bottom: 18,
      ),

      padding:
          const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),

      decoration: BoxDecoration(
        color: primaryColor,

        borderRadius:
            BorderRadius.circular(22),

        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [
          Text(
            title,

            style: const TextStyle(
              color: lightTextColor,
              fontWeight:
                  FontWeight.w700,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            displayValue,

            softWrap: true,

            style: const TextStyle(
              color: lightTextColor,
              fontSize: 20,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}