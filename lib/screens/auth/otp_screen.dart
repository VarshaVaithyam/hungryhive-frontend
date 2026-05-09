import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../home/home_screen.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;

  const OTPScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OTPScreen> createState() =>
      _OTPScreenState();
}

class _OTPScreenState
    extends State<OTPScreen> {
  final TextEditingController
      otpController =
      TextEditingController();

  bool isLoading = false;

  static const Color backgroundColor =
      Color(0xFFF2E6D8);

  static const Color primaryColor =
      Color(0xFF6B4F3A);

  static const Color textColor =
      Color(0xFF3E2E22);

  static const Color lightTextColor =
      Color(0xFFE6D8C3);

  Future<void> verifyOTP() async {
    final otp =
        otpController.text.trim();

    if (otp.isEmpty) {
      showMessage("Enter OTP");
      return;
    }

    if (otp.length != 6) {
      showMessage(
        "OTP must be 6 digits",
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(
          'https://hungryhive-backend-f08i.onrender.com/auth/verify-otp',
        ),

        headers: {
          'Content-Type':
              'application/json',
        },

        body: jsonEncode({
          'phoneNumber':
              widget.phoneNumber,
          'otp': otp,
        }),
      );

      final data =
          jsonDecode(response.body);

      setState(() {
        isLoading = false;
      });

      if (response.statusCode ==
              200 &&
          data['token'] != null) {
        final prefs =
            await SharedPreferences
                .getInstance();

        await prefs.setString(
          'token',
          data['token'],
        );

        await prefs.setString(
          'userId',
          data['userId'],
        );

        await prefs.setString(
          'phoneNumber',
          data['phoneNumber'],
        );

        if (!mounted) return;

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const HomeScreen(),
          ),
          (route) => false,
        );
      } else {
        showMessage(
          data['message'] ??
              "Invalid OTP",
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      showMessage("Error: $e");
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        backgroundColor:
            backgroundColor,

        content: Text(
          message,
          style: const TextStyle(
            color: textColor,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          backgroundColor,

      appBar: AppBar(
        backgroundColor:
            backgroundColor,
        elevation: 0,

        iconTheme:
            const IconThemeData(
          color: Colors.black,
          size: 30,
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 28,
          ),

          child: Center(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,

              children: [
                const Text(
                  "Enter OTP",

                  textAlign:
                      TextAlign.center,

                  style: TextStyle(
                    color: textColor,
                    fontSize: 32,
                    fontWeight:
                        FontWeight.w800,
                    height: 1.2,
                  ),
                ),

                const SizedBox(
                  height: 18,
                ),

                Text(
                  "OTP sent to ${widget.phoneNumber}",

                  textAlign:
                      TextAlign.center,

                  style: const TextStyle(
                    color: textColor,
                    fontSize: 21,
                    fontWeight:
                        FontWeight.w400,
                  ),
                ),

                const SizedBox(
                  height: 42,
                ),

                TextField(
                  controller:
                      otpController,

                  keyboardType:
                      TextInputType.number,

                  maxLength: 6,

                  style: const TextStyle(
                    color: textColor,
                    fontSize: 22,
                  ),

                  decoration:
                      InputDecoration(
                    hintText:
                        "Enter OTP",

                    hintStyle:
                        const TextStyle(
                      color: textColor,
                      fontSize: 22,
                    ),

                    counterStyle:
                        const TextStyle(
                      color: textColor,
                      fontSize: 18,
                    ),

                    filled: true,
                    fillColor:
                        backgroundColor,

                    contentPadding:
                        const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 22,
                    ),

                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                        28,
                      ),
                    ),

                    enabledBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                        28,
                      ),

                      borderSide:
                          const BorderSide(
                        color: textColor,
                        width: 1.5,
                      ),
                    ),

                    focusedBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                        28,
                      ),

                      borderSide:
                          const BorderSide(
                        color:
                            primaryColor,
                        width: 2.2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 38,
                ),

                isLoading
                    ? const CircularProgressIndicator(
                        color:
                            primaryColor,
                      )
                    : SizedBox(
                        width:
                            double.infinity,
                        height: 66,

                        child:
                            ElevatedButton(
                          onPressed:
                              verifyOTP,

                          style:
                              ElevatedButton.styleFrom(
                            elevation: 5,

                            backgroundColor:
                                primaryColor,

                            foregroundColor:
                                lightTextColor,

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                32,
                              ),
                            ),
                          ),

                          child:
                              const Text(
                            "Verify OTP",

                            style:
                                TextStyle(
                              fontSize:
                                  24,
                              fontWeight:
                                  FontWeight
                                      .w600,
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