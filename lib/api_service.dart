// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "https://hungryhive-backend-t081.onrender.com";

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
      print("BODY: ${response.body}");

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
    print("GET ALL FOOD API CALLED");

    try {
      final response = await http.get(
        Uri.parse("$baseUrl/food/all"),
      );

      print("GET RESPONSE: ${response.statusCode}");
      print("DATA: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      throw Exception("Failed to load food data");
    } catch (e) {
      print("ERROR GET FOOD: $e");
      return [];
    }
  }

  // =========================
  // GET AVAILABLE FOOD
  // =========================
  static Future<List<dynamic>> getAvailableFood() async {
    print("GET AVAILABLE FOOD API CALLED");

    try {
      final response = await http.get(
        Uri.parse("$baseUrl/food/available"),
      );

      print("AVAILABLE RESPONSE: ${response.statusCode}");
      print("DATA: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      throw Exception("Failed to load available food");
    } catch (e) {
      print("ERROR AVAILABLE FOOD: $e");
      return [];
    }
  }

  // =========================
  // ACCEPT FOOD
  // =========================
  static Future<bool> acceptFood(String id) async {
    print("ACCEPT FOOD API CALLED");

    try {
      final response = await http.put(
        Uri.parse("$baseUrl/food/accept/$id"),
      );

      print("ACCEPT RESPONSE: ${response.statusCode}");
      print("BODY: ${response.body}");

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
    print("ORDER FOOD API CALLED");

    try {
      final response = await http.put(
        Uri.parse("$baseUrl/food/order/$id"),
      );

      print("ORDER RESPONSE: ${response.statusCode}");
      print("BODY: ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("ERROR ORDER FOOD: $e");
      return false;
    }
  }

  // =========================
  // DELETE FOOD
  // =========================
  static Future<bool> deleteFood(String id) async {
    print("DELETE FOOD API CALLED");

    try {
      final response = await http.put(
        Uri.parse("$baseUrl/food/delete/$id"),
      );

      print("DELETE RESPONSE: ${response.statusCode}");
      print("BODY: ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("ERROR DELETE FOOD: $e");
      return false;
    }
  }
}