import 'package:http/http.dart' as http;
import 'dart:convert';
// For setting file types
import 'package:http_parser/http_parser.dart';
// For file handling
import 'dart:io';
// For storing JWTs...
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  // App url goes here...
  // Heroku routes to http automatically
  final String baseUrl =
      'https://swipet-becad9ab7362.herokuapp.com';
  final FlutterSecureStorage storage =
      FlutterSecureStorage();

  // Store JWT token function
  Future<void> storeToken(String token) async {
    await storage.write(
        key: 'jwtToken', value: token);
  }

  // Retrieve JWT token function
  Future<String?> getToken() async {
    return await storage.read(key: 'jwtToken');
  }

  // Remove JWT token function
  Future<void> removeToken() async {
    await storage.delete(key: 'jwtToken');
  }

  // Logout function
  Future<void> logout() async {
    await removeToken();
  }

  // Login function
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

  // Register function
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

  // Update user function
  Future<Map<String, dynamic>> updateUser(
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String location,
    String userLogin,
    File? userImage,
  ) async {
    String? jwtToken = await getToken();
    final uri =
        Uri.parse('$baseUrl/api/updateUser');
    final request =
        http.MultipartRequest('POST', uri);
    request.headers['Authorization'] =
        'Bearer $jwtToken';

    if (userImage != null) {
      String fileExtension = userImage.path
          .split('.')
          .last
          .toLowerCase();
      MediaType mediaType;

      if (fileExtension == 'jpeg' ||
          fileExtension == 'jpg') {
        mediaType = MediaType('image', 'jpeg');
      } else if (fileExtension == 'png') {
        mediaType = MediaType('image', 'png');
      } else {
        throw Exception(
            'Unsupported image format');
      }

      request.files.add(
        await http.MultipartFile.fromPath(
          'userImage',
          userImage.path,
          contentType: mediaType,
        ),
      );
    }

    request.fields['firstName'] = firstName;
    request.fields['lastName'] = lastName;
    request.fields['email'] = email;
    request.fields['phoneNumber'] = phoneNumber;
    request.fields['location'] = location;
    request.fields['userLogin'] = userLogin;
    request.fields['jwtToken'] = jwtToken!;

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData =
          await response.stream.bytesToString();
      final result = jsonDecode(responseData);
      if (result.containsKey('jwtToken') &&
          result['jwtToken'].isNotEmpty) {
        await storeToken(result['jwtToken']);
      }
      return result;
    } else {
      throw Exception('Failed to update user');
    }
  }

  // Delete user function
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

  // Forgot password function
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

  // Add pet function
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
    String prompt1,
    String prompt2,
    String contactEmail,
    String location,
    List<File> images,
    String adoptionFee,
  ) async {
    String? jwtToken = await getToken();
    final uri = Uri.parse('$baseUrl/api/addpet');
    final request =
        http.MultipartRequest('POST', uri);
    request.headers['Authorization'] =
        'Bearer $jwtToken';

    for (var image in images) {
      String fileExtension = image.path
          .split('.')
          .last
          .toLowerCase();
      MediaType mediaType;

      if (fileExtension == 'jpeg' ||
          fileExtension == 'jpg') {
        mediaType = MediaType('image', 'jpeg');
      } else if (fileExtension == 'png') {
        mediaType = MediaType('image', 'png');
      } else {
        throw Exception(
            'Unsupported image format');
      }

      request.files.add(
        await http.MultipartFile.fromPath(
          'petImages',
          image.path,
          contentType: mediaType,
        ),
      );
    }

    request.fields['userLogin'] = userLogin;
    request.fields['petName'] = petName;
    request.fields['type'] = type;
    request.fields['petAge'] = petAge;
    request.fields['petGender'] = petGender;
    request.fields['colors'] = jsonEncode(colors);
    request.fields['breed'] = breed;
    request.fields['petSize'] = petSize;
    request.fields['bio'] = bio;
    request.fields['prompt1'] = prompt1;
    request.fields['prompt2'] = prompt2;
    request.fields['contactEmail'] = contactEmail;
    request.fields['location'] = location;
    request.fields['adoptionFee'] = adoptionFee;
    request.fields['jwtToken'] = jwtToken!;

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData =
          await response.stream.bytesToString();
      final result = jsonDecode(responseData);
      if (result.containsKey('jwtToken') &&
          result['jwtToken'].isNotEmpty) {
        await storeToken(result['jwtToken']);
      }
      return result;
    } else {
      throw Exception('Failed to add pet');
    }
  }

  // Add pet to favorites function
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

  // Remove pet from favorites function
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

  // Delete pet function
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

  // Update pet function
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
    String prompt1,
    String prompt2,
    String contactEmail,
    String location,
    List<File> images,
    String adoptionFee,
  ) async {
    String? jwtToken = await getToken();
    final uri =
        Uri.parse('$baseUrl/api/updatepet');
    final request =
        http.MultipartRequest('POST', uri);
    request.headers['Authorization'] =
        'Bearer $jwtToken';

    for (var image in images) {
      String fileExtension = image.path
          .split('.')
          .last
          .toLowerCase();
      MediaType mediaType;

      if (fileExtension == 'jpeg' ||
          fileExtension == 'jpg') {
        mediaType = MediaType('image', 'jpeg');
      } else if (fileExtension == 'png') {
        mediaType = MediaType('image', 'png');
      } else {
        throw Exception(
            'Unsupported image format');
      }

      request.files.add(
        await http.MultipartFile.fromPath(
          'petImages',
          image.path,
          contentType: mediaType,
        ),
      );
    }

    request.fields['userLogin'] = userLogin;
    request.fields['petId'] = petId;
    request.fields['petName'] = petName;
    request.fields['type'] = type;
    request.fields['petAge'] = petAge;
    request.fields['petGender'] = petGender;
    request.fields['colors'] = jsonEncode(colors);
    request.fields['breed'] = breed;
    request.fields['petSize'] = petSize;
    request.fields['bio'] = bio;
    request.fields['prompt1'] = prompt1;
    request.fields['prompt2'] = prompt2;
    request.fields['contactEmail'] = contactEmail;
    request.fields['location'] = location;
    request.fields['adoptionFee'] = adoptionFee;
    request.fields['jwtToken'] = jwtToken!;

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData =
          await response.stream.bytesToString();
      final result = jsonDecode(responseData);
      if (result.containsKey('jwtToken') &&
          result['jwtToken'].isNotEmpty) {
        await storeToken(result['jwtToken']);
      }
      return result;
    } else {
      throw Exception('Failed to update pet');
    }
  }

  // Search pet function
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

  // Pet inquiry function
  Future<Map<String, dynamic>> sendInquiry(
      String userLogin, String petId) async {
    String? jwtToken = await getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/api/sendInquiry'),
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
      throw Exception('Failed to inquire');
    }
  }

  // Getters
  Future<Map<String, dynamic>> getUser(
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
      throw Exception('Failed to get user info');
    }
  }

  Future<Map<String, dynamic>> getUserListings(
      String userLogin) async {
    // Retrieving JWT
    String? jwtToken = await getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/api/getUserListings'),
      headers: <String, String>{
        'Content-Type':
            'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(<String, String>{
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
      throw Exception(
          'Failed to get users listings');
    }
  }

  Future<Map<String, dynamic>> getUserFavorites(
      String userLogin) async {
    // Retrieving JWT
    String? jwtToken = await getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/api/getUserFavorites'),
      headers: <String, String>{
        'Content-Type':
            'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(<String, String>{
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
      throw Exception(
          'Failed to get users favorites');
    }
  }
}
