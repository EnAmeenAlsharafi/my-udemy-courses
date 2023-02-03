class ChangeFavoritesModel {
  String? message;
  bool? status;

  ChangeFavoritesModel.fromJson(Map json) {
    message = json['message'];
    status = json['status'];
  }
}
