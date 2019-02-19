class AllItem {
  List<DataItem> title;

  AllItem({this.title});

  factory AllItem.fromJson(List<dynamic> json) {
    ContentBeanList weatherBeanList = ContentBeanList.fromJson(json);
    return new AllItem(
      title: weatherBeanList.photos,
    );
  }
}

class ContentBeanList {
  final List<DataItem> photos;

  ContentBeanList({
    this.photos,
  });

  factory ContentBeanList.fromJson(List<dynamic> parsedJson) {
    List<DataItem> photos = new List<DataItem>();
//    print("长度是：" + parsedJson.toString());
    photos = parsedJson.map((i) => DataItem.fromJson(i)).toList();
    return new ContentBeanList(
      photos: photos,
    );
  }
}

class DataItem {
  String cover;
  String title;

  DataItem({this.cover, this.title});

  factory DataItem.fromJson(Map<String, dynamic> json) {
    print(json['content_list']);
    return new DataItem(
      cover: json['cover'],
      title: json['title'],
    );
  }
}
