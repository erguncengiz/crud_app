import 'package:crud_app/features/home/models/accounts_response.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

import '../../features/create_account/models/create_account_request_model/create_account_request_model.dart';

part 'accounts_request_client.g.dart';

@RestApi()
abstract class AccountsRequestClient {
  factory AccountsRequestClient(Dio dio, {String baseUrl}) =
      _AccountsRequestClient;

  @GET("/account")
  Future<HttpResponse<List<AccountsResponse>?>?> getAccounts();

  @POST("/account")
  Future<HttpResponse<List<AccountsResponse>?>?> createAccount({
    @Body() AccountRequest? body,
  });
}
