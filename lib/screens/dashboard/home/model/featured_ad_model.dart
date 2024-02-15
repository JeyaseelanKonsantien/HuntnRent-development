class FeaturedAdModel{
  String? videoURL;
  String? title;
  String? description;

  FeaturedAdModel({this.videoURL, this.title, this.description});

  FeaturedAdModel.fromJson(Map<String, dynamic> json) {
    videoURL = json['video_url']; // Corrected key
    title = json['title']; // Corrected key
    description = json['description']; // Corrected key
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['video_url'] = videoURL;
    data['title'] = title;
    data['description'] = description;
    return data;
  }

}


class SliderAdModel{
  String? videoURL;
  String? title;
  String? description;

  SliderAdModel({this.videoURL, this.title, this.description});

  SliderAdModel.fromJson(Map<String, dynamic> json) {
    videoURL = json['video_url']; // Corrected key
    title = json['title']; // Corrected key
    description = json['description']; // Corrected key
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['video_url'] = videoURL;
    data['title'] = title;
    data['description'] = description;
    return data;
  }

}