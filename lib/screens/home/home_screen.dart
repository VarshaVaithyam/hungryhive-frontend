import 'package:flutter/material.dart';
import '../participate/participate_screen.dart';
import '../receive/receive_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2E6D8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2E6D8),
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 120,
        title: Row(
          children: [
            CircleAvatar(
                radius: 55,
                backgroundColor: const Color(0xFF6B4F3A),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/icon.png'),
                ),
              ),
            const SizedBox(width: 22,height: 44,),
            const Text(
              'HUNGRY HIVE',
              style: TextStyle(
                color: Color(0xFF6B4F3A),
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          children: [
            const Divider(
              color: Color(0xFF6B4F3A),
              thickness: 2,
            ),
            const SizedBox(height: 40),

            _homeOption(
              text: 'PARTICIPATE',
              textColor: const Color(0xFFE6D8C3),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ParticipateScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 26),

            _homeOption(
              text: 'RECEIVE',
              textColor: const Color(0xFFE6D8C3),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ReceiveScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _homeOption({
    required String text,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: const Color(0xFF6B4F3A),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 200,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}