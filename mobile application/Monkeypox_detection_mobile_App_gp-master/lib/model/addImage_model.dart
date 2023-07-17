class AddImageMessage {
  String? message;

  AddImageMessage({this.message});

  AddImageMessage.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
class AddImageModel {
  String? imagePath;

  AddImageModel({this.imagePath});

  AddImageModel.fromJson(Map<String, dynamic> json) {
    imagePath = json['image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_path'] = this.imagePath;
    return data;
  }
}