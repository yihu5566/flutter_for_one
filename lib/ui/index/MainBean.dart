import 'dart:convert';

class MainBean {
  String id;
  WeatherBean weatherBean;
  String date;
  List<ContentBean> content_list;
  MenuBean menuBean;

  MainBean(
      {this.id, this.weatherBean, this.date, this.content_list, this.menuBean});

  factory MainBean.fromJson(Map<String, dynamic> json) {
    print(json['content_list']);
    ContentBeanList weatherBeanList =
        ContentBeanList.fromJson(json['content_list']);
    return new MainBean(
        id: json['id'],
        weatherBean: WeatherBean.fromJson(json['weather']),
        date: json['date'],
        content_list: weatherBeanList.photos,
        menuBean: MenuBean.fromJson(json['menu']));
  }
}

class ContentBeanList {
  final List<ContentBean> photos;

  ContentBeanList({
    this.photos,
  });

  factory ContentBeanList.fromJson(List<dynamic> parsedJson) {
    List<ContentBean> photos = new List<ContentBean>();
//    print("长度是：" + parsedJson.toString());

    photos = parsedJson.map((i) => ContentBean.fromJson(i)).toList();

    return new ContentBeanList(
      photos: photos,
    );
  }
}

class WeatherBean {
  String city_name;
  String date;
  String temperature;
  String climate;

  WeatherBean({this.city_name, this.date, this.temperature, this.climate});

  factory WeatherBean.fromJson(Map<String, dynamic> json) {
    return new WeatherBean(
      city_name: json['city_name'],
      date: json['date'],
      temperature: json['temperature'],
      climate: json['climate'],
    );
  }
}

class ContentBean {
  String item_id;
  String id;
  String title;
  String img_url;
  String pic_info;
  String forward;
  String words_info;
  int like_count; //喜欢数
  String post_date;
  Object volume;
  Author author;
  ShareInfo share_info;

  ContentBean({
    this.item_id,
    this.id,
    this.title,
    this.img_url,
    this.pic_info,
    this.forward,
    this.words_info,
    this.like_count,
    this.author,
    this.post_date,
    this.volume,
    this.share_info,
  });

  factory ContentBean.fromJson(Map<String, dynamic> json) {
    return new ContentBean(
        item_id: json['item_id'],
        id: json['id'],
        title: json['title'],
        img_url: json['img_url'],
        pic_info: json['pic_info'],
        forward: json['forward'],
        words_info: json['words_info'],
        like_count: json['like_count'],
        post_date: json['post_date'],
        volume: json['volume'],
        author: Author.fromJson(json['author']),
        share_info: ShareInfo.fromJson(json['share_info']));
  }
}

class ShareInfo {
  String title;

  ShareInfo({this.title});

  factory ShareInfo.fromJson(Map<String, dynamic> json) {
    return new ShareInfo(
      title: json['title'],
    );
  }
}

class Author {
  String user_name;

  Author({this.user_name});

  factory Author.fromJson(Map<String, dynamic> json) {
    return new Author(
      user_name: json['user_name'],
    );
  }
}

class MenuBean {
  String vol;
  List<MenuBeanItem> menuBeanItem;

  MenuBean({this.vol, this.menuBeanItem});

  factory MenuBean.fromJson(Map<String, dynamic> json) {
    MenuBeanItemList weatherBeanList = MenuBeanItemList.fromJson(json['list']);
    return MenuBean(
      vol: json['vol'],
      menuBeanItem: weatherBeanList.photos,
    );
  }
}

class MenuBeanItemList {
  final List<MenuBeanItem> photos;

  MenuBeanItemList({
    this.photos,
  });

  factory MenuBeanItemList.fromJson(List<dynamic> parsedJson) {
    List<MenuBeanItem> photos = new List<MenuBeanItem>();
    photos = parsedJson.map((i) => MenuBeanItem.fromJson(i)).toList();
    return new MenuBeanItemList(
      photos: photos,
    );
  }
}

class MenuBeanItem {
  String content_type;
  String title;
  Tag tag;

  MenuBeanItem({this.content_type, this.title, this.tag});

  factory MenuBeanItem.fromJson(Map<String, dynamic> json) {
    return MenuBeanItem(
      content_type: json['content_type'],
      title: json['title'],
//      tag: json[Tag.fromJson(json['tag'])],
    );
  }
}

class Tag {
  String id;
  String title;

  Tag({this.id, this.title});

  factory Tag.fromJson(Map<String, dynamic> json) {
    print("Tag长度是：" + json.toString());
    return new Tag(
      id: json['id'],
      title: json['title'],
    );
  }
}
