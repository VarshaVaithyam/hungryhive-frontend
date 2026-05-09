import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'otp_screen.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() =>
      _PhoneLoginScreenState();
}

class _PhoneLoginScreenState
    extends State<PhoneLoginScreen> {
  final TextEditingController
      phoneController =
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

  Future<void> sendOTP() async {
    final phone =
        phoneController.text.trim();

    if (phone.isEmpty) {
      showMessage(
        "Enter phone number",
      );
      return;
    }

    if (!RegExp(r'^[0-9]{10}$')
        .hasMatch(phone)) {
      showMessage(
        "Phone number must be 10 digits",
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(
          'https://hungryhive-backend-f08i.onrender.com/auth/send-otp',
        ),

        headers: {
          'Content-Type':
              'application/json',
        },

        body: jsonEncode({
          'phoneNumber': phone,
        }),
      );

      final data =
          jsonDecode(response.body);

      setState(() {
        isLoading = false;
      });

      if (response.statusCode ==
          200) {
        showMessage(
          data['message'] ??
              "OTP sent successfully",
        );

        if (!mounted) return;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OTPScreen(
              phoneNumber: phone,
            ),
          ),
        );
      } else {
        showMessage(
          data['message'] ??
              "Failed to send OTP",
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
    phoneController.dispose();
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
                  "Enter mobile number",

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

                const Text(
                  "We’ll send you an OTP",

                  textAlign:
                      TextAlign.center,

                  style: TextStyle(
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
                      phoneController,

                  keyboardType:
                      TextInputType.phone,

                  maxLength: 10,

                  style: const TextStyle(
                    color: textColor,
                    fontSize: 22,
                  ),

                  decoration:
                      InputDecoration(
                    hintText:
                        "Enter phone number",

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
                              sendOTP,

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
                            "Send OTP",

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