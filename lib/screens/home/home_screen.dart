import 'package:flutter/material.dart';
import '../participate/participate_screen.dart';
import '../receive/receive_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color backgroundColor =
      Color(0xFFF2E6D8);

  static const Color primaryColor =
      Color(0xFF6B4F3A);

  static const Color lightTextColor =
      Color(0xFFE6D8C3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 18,
          ),
          child: Column(
            children: [
              const SizedBox(height: 6),

              // LOGO + TITLE
              Row(
                children: [
                  CircleAvatar(
                    radius: 58,
                    backgroundColor: primaryColor,
                    child: const CircleAvatar(
                      radius: 52,
                      backgroundColor:
                          backgroundColor,
                      backgroundImage:
                          AssetImage(
                        'assets/icon.png',
                      ),
                    ),
                  ),

                  const SizedBox(width: 18),

                  const Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'HUNGRY HIVE',
                        maxLines: 1,
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight:
                              FontWeight.w800,
                          fontSize: 38,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 26),

              Container(
                height: 2,
                color: primaryColor,
              ),

              const SizedBox(height: 44),

              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _homeOption(
                        text: 'PARTICIPATE',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const ParticipateScreen(),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 32),

                    Expanded(
                      child: _homeOption(
                        text: 'RECEIVE',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const ReceiveScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _homeOption({
    required String text,
    required VoidCallback onTap,
  }) {
    return Material(
      color: primaryColor,
      elevation: 5,
      borderRadius: BorderRadius.circular(34),

      child: InkWell(
        borderRadius:
            BorderRadius.circular(34),

        onTap: onTap,

        child: Container(
          width: double.infinity,

          alignment: Alignment.center,

          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: lightTextColor,
              fontSize: 38,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}