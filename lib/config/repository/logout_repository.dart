import 'package:project_management/network/network_dio.dart';
import 'package:project_management/utils/base_api.dart';

class LogoutRepository {

  logOutFun() async {
    var response = await NetworkHttps.postRequest(API.logoutUrl, {});
    return response;
  }


  deleteUser() async {
    var response =await NetworkHttps.postRequest(API.deleteUser,{});
    return response;
  }

}