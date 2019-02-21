class ArticleDetailsBean {
  String audio;
  String anchor;
  String id;
  String title;
  String web_url;
  String html_content;

  ArticleDetailsBean(
      {this.audio,
      this.id,
      this.anchor,
      this.title,
      this.web_url,
      this.html_content});

  factory ArticleDetailsBean.fromJson(Map<String, dynamic> json) {
    return ArticleDetailsBean(
      html_content: json['html_content'],
      title: json['title'],
      audio: json['audio'],
      id: json['id'],
      web_url: json['web_url'],
      anchor: json['anchor'],
    );
  }
}
