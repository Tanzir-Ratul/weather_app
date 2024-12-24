import 'package:flutter/material.dart';

abstract class BaseApiServices {
  Future<dynamic> get(
    String url, {
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
  });

  Future<dynamic> post(
    String url, {
    Map<String, dynamic> headers,
    @required body,
  });

  Future<dynamic> put(
    String url, {
    Map<String, dynamic> headers,
    Map<String, dynamic>? body,
  });

  Future<dynamic> delete(
    String url, {
    Map<String, dynamic> headers,
    Map<String, dynamic>? body,
  });
}
