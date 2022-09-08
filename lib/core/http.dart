import 'package:dio/dio.dart';
import 'package:juna_restaurant/core/config.dart';

BaseOptions options = new BaseOptions(
    // baseUrl: "your base url",
    baseUrl: Config.ENDPOINT,
    receiveDataWhenStatusError: true,
    connectTimeout: 300 * 1000, // 60 seconds
    receiveTimeout: 300 * 1000 // 60 seconds
    );
var dio = Dio(options);
