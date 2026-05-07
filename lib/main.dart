import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized(); 
  runApp(const HungryHive());
}

class HungryHive extends StatelessWidget {
  const HungryHive({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hungry Hive',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFE0C7),
      ),
      home: const LoginScreen(),
    );
  }
}