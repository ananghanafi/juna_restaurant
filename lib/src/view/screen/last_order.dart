import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/config.dart';

class LastOrder extends StatefulWidget {
  const LastOrder({Key? key}) : super(key: key);

  @override
  State<LastOrder> createState() => _LastOrderState();
}

class _LastOrderState extends State<LastOrder> {
  List posts = [];
  var nama="";
  var table="";
  var t_q=0;
  var t_p="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  getPref() async {
    var API = Config.ENDPOINT + "order/last";
    final http.Response response = await http.get(Uri.parse(API));
    setState(() {
      posts = json.decode(response.body);
      print(posts[0]['name']);
      nama = posts[0]['name'];
      t_p = posts[0]['t_price'];
      table = posts[0]['table'].toString();
    });
    // print(t_p);
  }
  Future<List> _fetchData() async {
    // var API = Config.ENDPOINT + "order/last";
    // final http.Response response = await http.get(Uri.parse(API));
    // // setState(() {
    // //   posts = json.decode(response.body);
    // //   print(posts[0]['name']);
    // //   nama = posts[0]['name'];
    // //   table = posts[0]['table'].toString();
    // // });
    // print(posts);
    // t_q = posts[0]['order']['quantity'].reduce((a, b) => a + b);
    return posts[0]['order'];
  }



  @override
  Widget build(BuildContext context) {
    // String nama_ = nama;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom),
        child: Container(
          padding: EdgeInsets.only(
              left: 10, right: 10, top: 30),
          child: Center(
            child: Column(
              // crossAxisAlignment:
              // CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 15),
                Text("JUNA RESTAURANT", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                SizedBox(height: 15),
                Text("LAST ORDER", style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),),
                SizedBox(height: 20),
                Row(
                  // mainAxisAlignment:
                  // MainAxisAlignment.center,
                  children:  <Widget>[
                    Text("Nama",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                    SizedBox(width: 20,),
                    Text(nama.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  // mainAxisAlignment:
                  // MainAxisAlignment.center,
                  children:  <Widget>[
                    Text("Table Nomor",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                    SizedBox(width: 20,),
                    Text(table, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 300,
                  child:
                  Expanded(
                    // flex: 0,
                    child: FutureBuilder(
                      future: _fetchData(),
                      builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                      snapshot.hasData
                          ? ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, index) => Padding(
                          padding: EdgeInsets.fromLTRB(2, 5, 2, 5),
                          child: GestureDetector(
                            onTap: () => {
                            // t_q = snapshot.data![index]['quantity'].reduce((a, b) => a + b),
                            //   t_q += int.parse(snapshot.data![index]['quantity'].toString()),
                            //   t_p += int.parse(snapshot.data![index]['price'].toString()),

                            },
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(snapshot.data![index]['name'].toString(),style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                  SizedBox(width: 20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(snapshot.data![index]['quantity'].toString(), style: TextStyle(fontSize: 16),),
                                      SizedBox(width: 20,),
                                      Text(snapshot.data![index]['price'].toString(), style: TextStyle(fontSize: 16),),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                          : Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 20,),
                    Text("Total",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                    SizedBox(width: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Text(t_q.toString(), style: TextStyle(fontSize: 16),),
                        SizedBox(width: 20,),
                        Text("$t_p*", style: TextStyle(fontSize: 16),),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 20,),
                    Text("*Taxes 5.0",style: TextStyle(fontStyle: FontStyle.italic),),
                    SizedBox(width: 20,),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}