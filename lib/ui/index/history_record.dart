import 'package:flutter/material.dart';
import 'package:flutter_for_one/http/api.dart';
import 'package:flutter_for_one/http/http_request.dart';
import 'package:flutter_for_one/http/http_util.dart';
import 'package:flutter_for_one/time_selector/flutter_cupertino_date_picker.dart';

import 'package:flutter_for_one/ui/index/history_bean.dart';
import 'package:flutter_for_one/utils/common_utils.dart';

class HistoryRecord extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HistoryRecordState();
  }
}

class HistoryRecordState extends State<HistoryRecord> {
  List _mMainBean;
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;
  String newTime = DateUtil.getCurrentMonthTime();

  String MIN_DATETIME = '2010-05-12';
  String MAX_DATETIME = '2019-05-09';
  String _format = 'yyyy-MMMM';
  DateTime _dateTime;
  DateTimePickerLocale _locale = DateTimePickerLocale.zh_cn;

  @override
  void initState() {
    super.initState();
    MAX_DATETIME = DateUtil.getCurrentMonthDayTime();
    _dateTime = DateTime.parse(MAX_DATETIME);
    //获取当前时间月
    _requestData(newTime, false);
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _requestData(newTime, true);
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text('历史文章'),
        ),
      ),
      backgroundColor: Colors.white,
      body: _mMainBean == null
          ? Center(
              child: Text("数据加载中。。。"),
            )
          : Scaffold(
              body: Column(
                children: <Widget>[
                  Flexible(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, //横轴三个子widget
                        childAspectRatio: 1, //宽高比为1时，子widget
                      ),
                      itemCount: _mMainBean.length,
                      itemBuilder: (context, index) {
                        AccountData bean = _mMainBean[index];
                        return _getGridViewItemUI(context, bean, index);
                      },
                      controller: _scrollController,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        showTime();
                      },
                      child: Container(
                        constraints: new BoxConstraints.expand(
                          height:
                              Theme.of(context).textTheme.display1.fontSize *
                                  1.5,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border: new Border.all(
                              width: 2.0, color: Colors.blueGrey),
                        ),
                        child: Text(
                          getTimeString(),
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      )),
                ],
              ),
            ),
    );
  }

  void _requestData(String s, bool isAutoSlide) async {
    if (!isPerformingRequest) {
      var requestMap = HttpRequest.getRequestMap();
      newTime = DateUtil.getYearMonthTime(s, isAutoSlide);
      if (!isAutoSlide && _mMainBean != null) {
        _mMainBean.clear();
      }
      setState(() => isPerformingRequest = true);
      HttpUtil.get(Api.history_record_url + newTime, (data) {
        if (data != null) {
          List<dynamic> responseJson = data;
          var address = new HistoryBean.fromJson(responseJson);
          setState(() {
            if (_mMainBean == null) {
              _mMainBean = List();
            }
            var accountData = AccountData();
            accountData.cover = "title";
            accountData.date = newTime;
            if (_mMainBean.length % 2 == 0) {
              _mMainBean.add(accountData);
              _mMainBean.add(accountData);
            } else {
              var accountTemp = AccountData();
              accountTemp.cover = "title";
              accountTemp.date = newTime;
              accountTemp.id = 1;
              _mMainBean.add(accountTemp);
              _mMainBean.add(accountData);
              _mMainBean.add(accountData);
            }

            _mMainBean.addAll(address.title);
            isPerformingRequest = false;
          });
          if (_mMainBean.length < 10) {
//            print("我开始第二次请求");
            _requestData(newTime, true);
          }
        }
      }, params: requestMap);
    }
  }

  Widget _getGridViewItemUI(BuildContext context, AccountData city, int index) {
    if (city.cover == "title") {
      if (city.id != 1) {
        return Container(
          color: Colors.grey,
          child: Text(city.date),
          alignment: Alignment.center,
        );
      } else {
        return Text("");
      }
    } else {
      return InkWell(
        onTap: () {
          Navigator.of(context).pop(index);
        },
        child: Card(
          elevation: 4.0,
          child: Column(
            children: <Widget>[
              Image.network(
                city.cover,
                fit: BoxFit.cover,
              ),
              new Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  city.date,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void showTime() {
    DatePicker.showDatePicker(
      context,
      pickerTheme: DateTimePickerTheme(
        confirm: Text('OK', style: TextStyle(color: Colors.red)),
        cancel: Text('Cancel', style: TextStyle(color: Colors.cyan)),
      ),
      minDateTime: DateTime.parse(MIN_DATETIME),
      maxDateTime: DateTime.parse(MAX_DATETIME),
      initialDateTime: _dateTime,
      dateFormat: _format,
      locale: _locale,
      onCancel: () {
        debugPrint('onCancel');
      },
      onChange: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
          newTime = DateUtil.getDateStrByDateTime(dateTime);
          _requestData(newTime, false);
        });
      },
    );
  }

  String getTimeString() {
    var split;
    if (_mMainBean.length < 40) {
      split = MAX_DATETIME.split("-");
    } else {
      split = newTime.split("-");
    }

    ///当前月份
    var month = split[1];

    ///当前年份
    var year = split[0];
    return "${year}年 ${month}月";
  }
}
