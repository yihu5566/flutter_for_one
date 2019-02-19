class BaseRes<T> {
  int res;
  T data;

  BaseRes({this.res, this.data});

  factory BaseRes.fromJson(Map<String, dynamic> json) {
    return new BaseRes(res: json["res"], data: json['data']);
  }
}
