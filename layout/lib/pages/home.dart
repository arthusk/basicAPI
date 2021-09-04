import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:layout/pages/detail.dart';

import 'package:http/http.dart' as http;
import 'dart:async';

class HomePage extends StatefulWidget {
  //const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ความรู้เกี่ยวกับเกม"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
            builder: (context, AsyncSnapshot snapshot) {
              //var data = json.decode(snapshot.data.toString());
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return MyBox(snapshot.data[index]['title'], snapshot.data[index]['subtitle'],
                      snapshot.data[index]['image_url'], snapshot.data[index]['detail']);
                },
                itemCount: snapshot.data.length,
              );
            },
            future: getdata(),
            //future: DefaultAssetBundle.of(context).loadString('assets/data.json'),
          )), 
    );
  }

  Widget MyBox(String title, String subtitle, String imageurl, String detail) {
    var v1, v2, v3, v4;
    v1 = title;
    v2 = subtitle;
    v3 = imageurl;
    v4 = detail;
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(20),
      //color: Colors.orangeAccent[700],
      height: 150,
      decoration: BoxDecoration(
          color: Colors.orangeAccent[700],
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: NetworkImage(imageurl),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.darken))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                print("next page >>");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PageDetail(v1, v2, v3, v4)),
                );
              },
              child: Text("อ่านต่อ >>"))
        ],
      ),
    );
  }

  Future getdata() async {
    var url = Uri.https('raw.githubusercontent.com',
        '/arthusk/basicAPI/main/data.json');
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    return result;
  }

}
