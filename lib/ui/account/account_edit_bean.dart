class AccountEditBean {
  List<AccountData> title;

  AccountEditBean({this.title});

  factory AccountEditBean.fromJson(List<dynamic> json) {
    ContentBeanList weatherBeanList = ContentBeanList.fromJson(json);
    return new AccountEditBean(
      title: weatherBeanList.photos,
    );
  }
}

class ContentBeanList {
  final List<AccountData> photos;

  ContentBeanList({
    this.photos,
  });

  factory ContentBeanList.fromJson(List<dynamic> parsedJson) {
    List<AccountData> photos = new List<AccountData>();
//    print("长度是：" + parsedJson.toString());
    photos = parsedJson.map((i) => AccountData.fromJson(i)).toList();
    return new ContentBeanList(
      photos: photos,
    );
  }
}

class AccountData {
  String content;
  String picture;

  AccountData({this.content, this.picture});

  factory AccountData.fromJson(Map<String, dynamic> json) {
    return new AccountData(
      content: json['content'],
      picture: json['picture'],
    );
  }
}
