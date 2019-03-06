class AccountUserInfoBean {
  String user_name;
  String web_url;

  AccountUserInfoBean({this.user_name, this.web_url});

  factory AccountUserInfoBean.fromJson(Map<String, dynamic> json) {
    return new AccountUserInfoBean(
      user_name: json['user_name'],
      web_url: json['web_url'],
    );
  }
}
