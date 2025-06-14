import 'dart:convert';

import 'package:flutter_ecommerce_app/core/constant/strings.dart';
import 'package:flutter_ecommerce_app/core/error/exceptions.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/data/models/user/authentication_response_model.dart';
import 'package:flutter_ecommerce_app/domain/usecases/sign_in_usecase.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<AuthenticationResponseModel> signIn(SignInParams params);
  // Future<AuthenticationResponseModel> signUp(SignUpParams params);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthenticationResponseModel> signIn(SignInParams params) async {
    final response = await client.post(Uri.parse('$baseUrl/authentication/local/sign-in'),
      headers: {
      'Content-Type': 'application/json',
      },
      body: json.encode({
        'identifier': params.username,
        'password': params.password
      }),
    );

    if (response.statusCode == 200) {
      return authenticationResponseModelFromJson(response.body);
    }  else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    }  else {
      throw ServerExceptions();
    }
  }
}