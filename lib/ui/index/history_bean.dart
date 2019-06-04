class HistoryBean {
  List<AccountData> title;

  HistoryBean({this.title});

  factory HistoryBean.fromJson(List<dynamic> json) {
    ContentBeanList weatherBeanList = ContentBeanList.fromJson(json);
    return new HistoryBean(
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
  int id;
  String date;
  String cover;
  bool isLeft;

  AccountData({this.id, this.date, this.cover, this.isLeft});

  factory AccountData.fromJson(Map<String, dynamic> json) {
    return new AccountData(
      id: json['id'],
      date: json['date'],
      cover: json['cover'],
    );
  }
}
