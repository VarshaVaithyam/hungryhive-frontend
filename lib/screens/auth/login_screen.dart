// import 'package:flutter/material.dart';
// import 'login_google_screen.dart';
// import 'phone_login_screen.dart';
// import 'create_account_screen.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
            
//             // Logo circle (placeholder for now)
//           CircleAvatar(
//             radius: 55,
//             backgroundColor: Colors.white,
//             child: Icon(
//               Icons.restaurant,
//               size: 50,
//               color: Colors.brown,
//             ),
//           ),
            
//             const SizedBox(height: 20),

//             const Text(
//               "WELCOME",
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 6),

//             const Text(
//               "Sign-Up",
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.black,
//               ),
//             ),

//             const SizedBox(height: 35),

//             //Google button
//             ElevatedButton.icon(
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const LoginGoogleScreen(),
//                   ),
//                 );
//               },
//               icon: const Icon(Icons.g_mobiledata),
//               label: const Text("Continue with Google"),
//               style: _buttonStyle(),
//             ),

//             const SizedBox(height: 14),

//             //Number button
//             ElevatedButton.icon(
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const PhoneLoginScreen(),
//                   ),
//                 );
//               },
//               icon: const Icon(Icons.phone),
//               label: const Text("Continue with Number"),
//               style: _buttonStyle(),
//             ),

//             const SizedBox(height: 25),

//             //OR divider
//             const Row(
//               children: [
//                 Expanded(child: Divider(color: Colors.black,thickness: 1,)),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Text("OR"),
//                 ),
//                 Expanded(child: Divider(color: Colors.black,thickness: 1,)),
//               ],
//             ),

//             const SizedBox(height: 20),

//             //Create Account
//             OutlinedButton.icon(
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const CreateAccountScreen(),
//                   ),
//                 );
//               },
//               icon: const Icon(Icons.person),
//               label: const Text("Create an Account"),
//               style: OutlinedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 50),
//                 foregroundColor: Colors.black,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   ButtonStyle _buttonStyle() {
//     return ElevatedButton.styleFrom(
//       minimumSize: const Size(double.infinity, 50),
//       backgroundColor: const Color(0xFFFFB7A6),
//       foregroundColor: Colors.black,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'phone_login_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const Color backgroundColor = Color(0xFFF2E6D8);
  static const Color primaryColor = Color(0xFF6B4F3A);
  static const Color textColor = Color(0xFF3E2E22);
  static const Color lightTextColor = Color(0xFFE6D8C3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 72,
                  backgroundColor: primaryColor,
                  child: const CircleAvatar(
                    radius: 64,
                    backgroundColor: backgroundColor,
                    backgroundImage: AssetImage('assets/icon.png'),
                  ),
                ),

                const SizedBox(height: 34),

                const Text(
                  "WELCOME",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                    color: textColor,
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  "Continue with your phone number",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    height: 1.3,
                    color: textColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 58),

                SizedBox(
                  width: double.infinity,
                  height: 64,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PhoneLoginScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.phone,
                      size: 26,
                    ),
                    label: const Text(
                      "Continue with Number",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 4,
                      backgroundColor: primaryColor,
                      foregroundColor: lightTextColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
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