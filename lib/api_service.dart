// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "https://hungryhive-backend-f08i.onrender.com";

  // =========================
  // ADD FOOD
  // =========================
  static Future<bool> addFood(
    String name,
    String items,
    String address,
    String phone,
    String organization,
    String description,
    String quantity,
    String location,
    String ownerUserId,
  ) async {
    print("ADD FOOD API CALLED");
    print("OWNER USER ID SENT: $ownerUserId");

    if (ownerUserId.isEmpty) {
      print("ERROR: ownerUserId is empty. Food owner will not be saved.");
      return false;
    }

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/food/add"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "foodName": items,
          "donorName": name,
          "phoneNumber": phone,
          "location": address,
          "organization": organization,
          "description": description,
          "quantity": quantity,
          "ownerUserId": ownerUserId,
        }),
      );

      print("ADD RESPONSE: ${response.statusCode}");
      print("ADD BODY: ${response.body}");

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("ERROR ADD FOOD: $e");
      return false;
    }
  }

  // =========================
  // GET ALL FOOD
  // =========================
  static Future<List<dynamic>> getAllFood() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/food/all"),
      );

      print("GET ALL RESPONSE: ${response.statusCode}");
      print("GET ALL BODY: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return [];
    } catch (e) {
      print("ERROR GET FOOD: $e");
      return [];
    }
  }

  // =========================
  // GET AVAILABLE FOOD
  // =========================
  static Future<List<dynamic>> getAvailableFood() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/food/available"),
      );

      print("GET AVAILABLE RESPONSE: ${response.statusCode}");
      print("GET AVAILABLE BODY: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return [];
    } catch (e) {
      print("ERROR AVAILABLE FOOD: $e");
      return [];
    }
  }

  // =========================
  // ACCEPT FOOD
  // =========================
  static Future<bool> acceptFood(String id) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/food/accept/$id"),
      );

      print("ACCEPT RESPONSE: ${response.statusCode}");
      print("ACCEPT BODY: ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("ERROR ACCEPT FOOD: $e");
      return false;
    }
  }

  // =========================
  // ORDER FOOD
  // =========================
  static Future<bool> orderFood(String id) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/food/order/$id"),
      );

      print("ORDER RESPONSE: ${response.statusCode}");
      print("ORDER BODY: ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("ERROR ORDER FOOD: $e");
      return false;
    }
  }

  // =========================
  // DELETE FOOD
  // =========================
  static Future<bool> deleteFood(
    String id,
    String userId,
  ) async {
    print("DELETE FOOD API CALLED");
    print("DELETE FOOD ID: $id");
    print("DELETE USER ID: $userId");

    if (userId.isEmpty) {
      print("ERROR: userId is empty. Delete blocked.");
      return false;
    }

    try {
      final response = await http.put(
        Uri.parse("$baseUrl/food/delete/$id?userId=$userId"),
      );

      print("DELETE RESPONSE: ${response.statusCode}");
      print("DELETE BODY: ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("ERROR DELETE FOOD: $e");
      return false;
    }
  }
}