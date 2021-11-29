// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
//
// import '../../utils/constants/api_constants.dart';
// import '../api_service.dart';
// import '../base_model.dart';
//
// class AuthApiManager {
//   static final AuthApiManager _instance = AuthApiManager._internal();
//
//   factory AuthApiManager() {
//     return _instance;
//   }
//
//   AuthApiManager._internal();
//
//   // Regenerate Token Api
//   // Future<ResReGenerateToken> reGenerateToken(
//   //     BuildContext context, Map<String, dynamic>? param) async {
//   //   try {
//   //     final response = await ApiService().post(
//   //       context,
//   //       apiReGenerateToken,
//   //       data: param,
//   //     );
//   //     return ResReGenerateToken.fromJson(response.data);
//   //   } on DioError catch (error) {
//   //     throw BaseModel.fromJson(error.response?.data);
//   //   }
//   // }
//
// }
