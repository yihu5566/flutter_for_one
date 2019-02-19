///作者列表

class AuthorItem {
  List<DataAuthorItem> title;

  AuthorItem({this.title});

  factory AuthorItem.fromJson(List<dynamic> json) {
    ContentBeanList weatherBeanList = ContentBeanList.fromJson(json);
    return new AuthorItem(
      title: weatherBeanList.photos,
    );
  }
}

class ContentBeanList {
  final List<DataAuthorItem> photos;

  ContentBeanList({
    this.photos,
  });

  factory ContentBeanList.fromJson(List<dynamic> parsedJson) {
    List<DataAuthorItem> photos = new List<DataAuthorItem>();
//    print("长度是：" + parsedJson.toString());
    photos = parsedJson.map((i) => DataAuthorItem.fromJson(i)).toList();
    return new ContentBeanList(
      photos: photos,
    );
  }
}

class DataAuthorItem {
  String user_name;
  String desc;
  String web_url;

  DataAuthorItem({this.user_name, this.desc, this.web_url});

  factory DataAuthorItem.fromJson(Map<String, dynamic> json) {
    return new DataAuthorItem(
      user_name: json['user_name'],
      desc: json['desc'],
      web_url: json['web_url'],
    );
  }
}
