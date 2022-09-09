import 'package:crud_app/features/home/models/accounts_response.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'accounts_request_client.g.dart';

@RestApi()
abstract class AccountsRequestClient {
  factory AccountsRequestClient(Dio dio, {String baseUrl}) =
      _AccountsRequestClient;

  @GET("/accounts")
  Future<HttpResponse<List<AccountsResponse>?>?> getAccounts();
}
