import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DropDownListAPI extends StatefulWidget {
  @override
  _DropDownListAPIState createState() => _DropDownListAPIState();
}

List citiesList = List(); //sehir
List stateList = List(); //ilce

String _myCity;
String _myState;

class _DropDownListAPIState extends State<DropDownListAPI> {
  @override
  void initState() {
    Future.microtask(() {
      stateDataGet();
      cityDataGet();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade200,
      appBar: AppBar(
        title: Text("İl İlçe DropdownList"),
        backgroundColor: Colors.pink.shade200,
      ),
      body: Center(
        child: Container(
          height: 500,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 23.0),
                child: Text(
                  "İl",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            value: _myCity,
                            iconSize: 30,
                            icon: (null),
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                            hint: Text('Seç'),
                            onChanged: (String newValue) {
                              setState(() {
                                _myCity = newValue;
                                _myState = null;
                                stateDataGet();
                                print(_myCity);
                              });
                            },
                            items: citiesList?.map((item) {
                                  return new DropdownMenuItem(
                                    child: new Text(item['cityName']),
                                    value: item['cityCode'].toString(),
                                  );
                                })?.toList() ??
                                [],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 23.0),
                child: Text(
                  "İlçe",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            value: _myState,
                            iconSize: 30,
                            icon: (null),
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                            hint: Text('Seç'),
                            onChanged: (String newValue) {
                              setState(() {
                                _myState = newValue;
                                print(newValue + "helloooooooo");
                                //cityDataGet();
                                print(_myState);
                              });
                            },
                            items: stateList?.map((item) {
                                  return new DropdownMenuItem(
                                    child: new Text(item['districtName']),
                                    value: item['districtCode'].toString(),
                                  );
                                })?.toList() ??
                                [],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String cities;
  String cityCode;
  String cityName;
  void cityDataGet() async {
    try {
      Dio dio = new Dio();
      Response response = await dio.post(
          "https://servicedev.artinokta.com/api/reportservice/getcitylist",
          data: {"cities": cities, "cityCode": cityCode, "cityName": cityName});
      setState(() {
        return citiesList = response.data["cities"];
      });
    } catch (e) {
      print(e.toString());
    }
  }

  String districts;
  //String cityCodeState;
  String districtName;
  String districtCode;

  void stateDataGet() async {
    try {
      Dio dio = new Dio();
      Response response = await dio.post(
          "https://servicedev.artinokta.com/api/reportservice/getdistrictlist",
          data: {
            "districts": districts,
            "cityCode": _myCity,
            "districtName": districtName,
            "districtCode": districtCode
          });
      setState(() {
        return stateList = response.data["districts"];
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
