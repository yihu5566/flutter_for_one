class ClassifyDetailsBean {
  String category;
  String html_content;

  ClassifyDetailsBean({this.category, this.html_content});

  factory ClassifyDetailsBean.fromJson(Map<String, dynamic> json) {
    return new ClassifyDetailsBean(
      category: json['category'],
      html_content: json['html_content'],
    );
  }
}
