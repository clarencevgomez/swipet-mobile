import 'package:http/http.dart' as http;
import 'dart:convert';
// For storing JWTs...
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  // App url goes here...
  // Heroku routes to http automatically
  final String baseUrl =
      'https://swipet-becad9ab7362.herokuapp.com';
  final FlutterSecureStorage storage =
      const FlutterSecureStorage();

  // Store JWT token function
  Future<void> storeToken(String token) async {
    await storage.write(
        key: 'jwtToken', value: token);
  }

  // Retrieve JWT token function
  Future<String?> getToken() async {
    return await storage.read(key: 'jwtToken');
  }

  Future<void> logout() async {
    await storage.delete(key: 'jwtToken');
  }

  Future<Map<String, dynamic>> login(
      String userLogin, String password) async {
    // Like a POST 'test' in ARC or Postman
    final response = await http.post(
      Uri.parse('$baseUrl/api/login'),
      headers: <String, String>{
        'Content-Type':
            'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userLogin': userLogin,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result.containsKey('jwtToken') &&
          result['jwtToken'].isNotEmpty) {
        await storeToken(result['jwtToken']);
      }
      return result;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<Map<String, dynamic>> register(
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String location,
      String userLogin,
      String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/register'),
      headers: <String, String>{
        'Content-Type':
            'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'location': location,
        'userLogin': userLogin,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result;
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<Map<String, dynamic>> updateUser(
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String location,
      String userLogin) async {
    // Retrieving JWT
    String? jwtToken = await getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/api/updateUser'),
      headers: <String, String>{
        'Content-Type':
            'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(<String, String>{
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'location': location,
        'userLogin': userLogin,
        'jwtToken': jwtToken!,
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result.containsKey('jwtToken') &&
          result['jwtToken'].isNotEmpty) {
        await storeToken(result['jwtToken']);
      }
      return result;
    } else {
      throw Exception('Failed to update user');
    }
  }

  Future<Map<String, dynamic>> deleteUser(
      String userLogin, String password) async {
    String? jwtToken = await getToken();

    if (jwtToken == null || jwtToken.isEmpty) {
      throw Exception(
          'JWT token not found/empty');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/api/deleteUser'),
      headers: <String, String>{
        'Content-Type':
            'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(<String, String>{
        'userLogin': userLogin,
        'password': password,
        'jwtToken': jwtToken,
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      // No need to store JWT, since deleting anyway
      return result;
    } else {
      throw Exception('Failed to delete user');
    }
  }

  Future<Map<String, dynamic>> forgotPassword(
      String userLogin, String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/forgotPassword'),
      headers: <String, String>{
        'Content-Type':
            'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userLogin': userLogin,
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to forgetPassword?');
    }
  }

  Future<Map<String, dynamic>> addPet(
      String userLogin,
      String petName,
      String type,
      String petAge,
      String petGender,
      List<String> colors,
      String breed,
      String petSize,
      String bio,
      String contactEmail,
      String location,
      List<String> images,
      String adoptionFee) async {
    String? jwtToken = await getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/api/addpet'),
      headers: <String, String>{
        'Content-Type':
            'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(<String, dynamic>{
        'userLogin': userLogin,
        'petName': petName,
        'type': type,
        'petAge': petAge,
        'petGender': petGender,
        'colors': colors,
        'breed': breed,
        'petSize': petSize,
        'bio': bio,
        'contactEmail': contactEmail,
        'location': location,
        'images': images,
        'adoptionFee': adoptionFee,
        'jwtToken': jwtToken,
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result.containsKey('jwtToken') &&
          result['jwtToken'].isNotEmpty) {
        await storeToken(result['jwtToken']);
      }
      return result;
    } else {
      throw Exception('Failed to add pet');
    }
  }

  Future<Map<String, dynamic>> addFavorite(
      String userLogin, String petId) async {
    String? jwtToken = await getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/api/addfavorite'),
      headers: <String, String>{
        'Content-Type':
            'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(<String, String>{
        'userLogin': userLogin,
        'petId': petId,
        'jwtToken': jwtToken!,
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result.containsKey('jwtToken') &&
          result['jwtToken'].isNotEmpty) {
        await storeToken(result['jwtToken']);
      }
      return result;
    } else {
      throw Exception('Failed to add favorite');
    }
  }

  Future<Map<String, dynamic>> removeFavorite(
      String userLogin, String petId) async {
    String? jwtToken = await getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/api/unfavorite'),
      headers: <String, String>{
        'Content-Type':
            'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(<String, String>{
        'userLogin': userLogin,
        'petId': petId,
        'jwtToken': jwtToken!,
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result.containsKey('jwtToken') &&
          result['jwtToken'].isNotEmpty) {
        await storeToken(result['jwtToken']);
      }
      return result;
    } else {
      throw Exception(
          'Failed to remove favorite');
    }
  }

  Future<Map<String, dynamic>> deletePet(
      String userLogin, String petId) async {
    String? jwtToken = await getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/api/deletepet'),
      headers: <String, String>{
        'Content-Type':
            'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(<String, String>{
        'userLogin': userLogin,
        'petId': petId,
        'jwtToken': jwtToken!,
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result.containsKey('jwtToken') &&
          result['jwtToken'].isNotEmpty) {
        await storeToken(result['jwtToken']);
      }
      return result;
    } else {
      throw Exception('Failed to delete pet');
    }
  }

  Future<Map<String, dynamic>> updatePet(
      String userLogin,
      String petId,
      String petName,
      String type,
      String petAge,
      String petGender,
      List<String> colors,
      String breed,
      String petSize,
      String bio,
      String contactEmail,
      String location,
      List<String> images,
      String adoptionFee) async {
    String? jwtToken = await getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/api/updatepet'),
      headers: <String, String>{
        'Content-Type':
            'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(<String, dynamic>{
        'userLogin': userLogin,
        'petId': petId,
        'petName': petName,
        'type': type,
        'petAge': petAge,
        'petGender': petGender,
        'colors': colors,
        'breed': breed,
        'petSize': petSize,
        'bio': bio,
        'contactEmail': contactEmail,
        'location': location,
        'images': images,
        'adoptionFee': adoptionFee,
        'jwtToken': jwtToken,
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result.containsKey('jwtToken') &&
          result['jwtToken'].isNotEmpty) {
        await storeToken(result['jwtToken']);
      }
      return result;
    } else {
      throw Exception('Failed to update pet');
    }
  }

  Future<Map<String, dynamic>> searchPet(
      String userLogin,
      String type,
      String petAge,
      String petGender,
      String breed,
      String petSize,
      String location) async {
    String? jwtToken = await getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/api/searchpet'),
      headers: <String, String>{
        'Content-Type':
            'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(<String, String>{
        'userLogin': userLogin,
        'type': type,
        'petAge': petAge,
        'petGender': petGender,
        'breed': breed,
        'petSize': petSize,
        'location': location,
        'jwtToken': jwtToken!,
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result.containsKey('jwtToken') &&
          result['jwtToken'].isNotEmpty) {
        await storeToken(result['jwtToken']);
      }
      return result;
    } else {
      throw Exception('Failed to search pets');
    }
  }
}
