class ApiResponseModel {
  bool successfulConnection;
  dynamic data;
  String? errorMessage;

  ApiResponseModel({required this.successfulConnection, this.data, this.errorMessage});
}
