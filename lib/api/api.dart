import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api.g.dart';

@RestApi(baseUrl: "https://serial.aitigo.de")
abstract class APIClient {
  factory APIClient(Dio dio, {String baseUrl}) = _APIClient;

  @GET("/")
  Future<String> sendDNNs(
      @Query("data") String data,
      @Query("checksum") String checksum,
      @Query('id') String id,
      @Query('debug') int debug);
}
