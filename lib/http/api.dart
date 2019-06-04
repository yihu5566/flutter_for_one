class Api {
  //基础url
  static const String Base_Url = "http://v3.wufazhuce.com:8000/api";
  static const String One = "http://v3.wufazhuce.com:8000/api/channel/one/";
  static const String ALl_List_1 =
      "http://v3.wufazhuce.com:8000/api/banner/list/4";
  static const String ALl_List_2 =
      "http://v3.wufazhuce.com:8000/api/author/hot";
  static const String ARTICLE_DETAILS_URL =
      "http://v3.wufazhuce.com:8000/api/essay/htmlcontent";
  static const String classify_DETAILS_URL =
      "http://v3.wufazhuce.com:8000/api/all/list";

  ///请求个人页面
  static const String account_edit_url =
      "http://v3.wufazhuce.com:8000/api/personal/diary";

  static const String account_user_infor_url =
      "http://v3.wufazhuce.com:8000/api/user/info/10072491";

  ///	GET /api/feeds/list/2019-04?user_id=10072491&channel=360&
  ///sign=e038da75fece6d669b7c6adc788715d6&version=4.5.9
  ///&uuid=ffffffff-d33b-3794-ffff-ffff8546fc17&platform=android HTTP/1.1
  static const String history_record_url =
      "http://v3.wufazhuce.com:8000/api/feeds/list/";

}
