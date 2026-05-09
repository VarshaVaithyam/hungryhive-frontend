import 'package:flutter/material.dart';
import 'add_food_detail_screen.dart';

class ParticipateScreen extends StatelessWidget {
  const ParticipateScreen({super.key});

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
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,

        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30,
        ),

        title: const Text(
          'PARTICIPATE',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w800,
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
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 20,
          ),

          child: Center(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,

              children: [
                const Text(
                  "We share our love through acts of service.",

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: textColor,
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Please provide details about the food you want to donate.\nThis helps us connect it to the right people safely.",

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    height: 1.7,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 60),

                SizedBox(
                  width: double.infinity,
                  height: 64,

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AddFoodDetailScreen(),
                        ),
                      );
                    },

                    style:
                        ElevatedButton.styleFrom(
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
                      "ADD +",
                      style: TextStyle(
                        color: lightTextColor,
                        fontSize: 24,
                        fontWeight:
                            FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
