import 'package:project_management/network/network_dio.dart';
import 'package:project_management/utils/base_api.dart';
class ChangePasswordRepository {


 changePassword({
  required String oldPassword,
  required String newPassword,
  required String confirmPassword,
 }) async {
  var response = await NetworkHttps.postRequest(API.changePasswordUrl, {
   'password': newPassword,
   'password_confirmation': confirmPassword,
   'current_password': oldPassword
  });
  return response;
 }

}