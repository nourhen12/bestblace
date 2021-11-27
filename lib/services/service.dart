import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class ImageService{
  static Future<dynamic> uploadFile(filePath) async {
    //jwt authentication token
    var authToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxOTk5ZTM4MWZlNzhkMDAyM2YwNGI1NCIsImVtYWlsIjoic2lzaUBnbWFpbC5jb20iLCJyb2xlIjoiUExBQ0UiLCJpYXQiOjE2Mzc0NTc1MjIsImV4cCI6MTY2ODk5MzUyMn0.FvTkxUq1smbzKOeVAs9TdSMiFCxfzKHTtdJ_aDVIIeE';
    //user im use to upload image
    //Note: this authToken and user id parameter will depend on my backend api structure
    //in your case it can be only auth token
    var _userId = '61999e381fe78d0023f04b54';

    try {
      FormData formData =
      new FormData.fromMap({
        "image":
        await MultipartFile.fromFile(filePath, filename: "dp")});

      Response response = await Dio().post("https://bestpkace-api.herokuapp.com/uploadsavatar/avatar/$_userId", data: formData,
          options: Options(
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      })
      );
      return response;
    }on DioError catch (e) {
      return e.response;
    } catch(e){
    }
  }
}
