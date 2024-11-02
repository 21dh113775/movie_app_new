import 'package:dio/dio.dart';
import 'interceptors.dart';

class DioClient {
  late final Dio _dio;

  // Khởi tạo Dio với cấu hình cơ bản
  DioClient()
      : _dio = Dio(
          BaseOptions(
            headers: {
              'Content-Type':
                  'application/json; charset=UTF-8' // Cấu hình tiêu đề mặc định cho JSON
            },
            responseType: ResponseType.json, // Định dạng phản hồi JSON
            sendTimeout:
                const Duration(seconds: 10), // Thời gian chờ khi gửi yêu cầu
            receiveTimeout:
                const Duration(seconds: 10), // Thời gian chờ khi nhận phản hồi
          ),
        )..interceptors.addAll([
            LoggerInterceptor()
          ]); // Thêm các interceptors, ở đây là LoggerInterceptor để log thông tin

  // PHƯƠNG THỨC GET
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters, // Tham số truy vấn
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback?
        onReceiveProgress, // Gọi lại khi có tiến trình nhận dữ liệu
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response; // Trả về phản hồi
    } on DioException {
      rethrow; // Ném lại ngoại lệ để xử lý ở nơi gọi
    }
  }

  // PHƯƠNG THỨC POST
  Future<Response> post(
    String url, {
    data, // Dữ liệu gửi lên server
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress, // Gọi lại khi có tiến trình gửi dữ liệu
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PHƯƠNG THỨC PUT
  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PHƯƠNG THỨC DELETE
  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data; // Trả về dữ liệu trong phản hồi
    } catch (e) {
      rethrow;
    }
  }
}
