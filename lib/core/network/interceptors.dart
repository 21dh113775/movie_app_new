import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(
      printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true));

  // Hàm xử lý khi có lỗi xảy ra
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
    logger.e('${options.method} request ==> $requestPath'); // Ghi log lỗi
    logger.d(
        'Error type: ${err.error} \n Error message: ${err.message}'); // Log chi tiết lỗi
    handler.next(err); // Tiếp tục xử lý lỗi
  }

  // Hàm xử lý khi gửi yêu cầu
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    logger.i('${options.method} request ==> $requestPath'); // Ghi log yêu cầu
    handler.next(options); // Tiếp tục thực hiện yêu cầu
  }

  // Hàm xử lý khi nhận phản hồi
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d('STATUSCODE: ${response.statusCode} \n '
        'STATUSMESSAGE: ${response.statusMessage} \n'
        'HEADERS: ${response.headers} \n'
        'Data: ${response.data}'); // Ghi log thông tin phản hồi
    handler.next(response); // Tiếp tục xử lý phản hồi
  }
}

class AuthorizationInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token'); // Lấy mã token đã lưu
    options.headers['Authorization'] =
        "Bearer $token"; // Thêm token vào tiêu đề
    handler.next(options); // Tiếp tục với yêu cầu
  }
}
