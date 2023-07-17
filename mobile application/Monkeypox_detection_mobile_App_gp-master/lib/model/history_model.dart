class HistoryModel {
  String? image;
  String? status;

  HistoryModel({this.image, this.status});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}