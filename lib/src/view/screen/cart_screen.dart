import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:juna_restaurant/core/app_color.dart';
import 'package:juna_restaurant/core/app_extension.dart';
import 'package:juna_restaurant/src/view/widget/counter_button.dart';
import 'package:juna_restaurant/src/view/widget/empty_widget.dart';
import 'package:get/get.dart';
import '../../../core/app_style.dart';
import '../../../core/config.dart';
import '../../../core/http.dart';
import '../../controller/food_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:http/http.dart' as http;

final FoodController controller = Get.put(FoodController());

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Cart screen",
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }


  TextEditingController your_name = new TextEditingController();
  var _table ="";
  final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
    primary: Colors.white,
    backgroundColor: Colors.red,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  ).copyWith(
    side: MaterialStateProperty.resolveWith<BorderSide>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return BorderSide(
            color: Colors.red,
            width: 1,
          );
        return BorderSide(
          color: Colors.red,
          width: 1,
        );
        // return ; // Defer to the widget's default.
      },
    ),
  );
  final ButtonStyle flatoutlineButtonStyle = OutlinedButton.styleFrom(
    primary: Colors.white,
    backgroundColor: Colors.blue,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  ).copyWith(
    side: MaterialStateProperty.resolveWith<BorderSide>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return BorderSide(
            color: Colors.blue,
            width: 1,
          );
        return BorderSide(
          color: Colors.blue,
          width: 1,
        );
        // return ; // Defer to the widget's default.
      },
    ),
  );

  Future<List> _fetchData() async {
    List posts = [];
    const API = Config.ENDPOINT + "table";
    final http.Response response = await http.get(Uri.parse(API));
    posts = json.decode(response.body);
    // print(posts);
    return posts;
  }

  Widget _bottomAppBar(double height, double width, BuildContext context) {
    return BottomAppBar(
      child: SizedBox(
        height: height * 0.32,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Subtotal",
                            style: Theme.of(context).textTheme.headline5),
                        Obx(() {
                          return Text("${controller.subtotalPrice.value}",
                              style: Theme.of(context).textTheme.headline2);
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Taxes",
                            style: Theme.of(context).textTheme.headline5),
                        Text("${5.00}",
                            style: Theme.of(context).textTheme.headline2),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      thickness: 4.0,
                      height: 30.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total",
                            style: Theme.of(context).textTheme.headline2),
                        Obx(() {
                          return Text(
                            controller.totalPrice.value == 5.0
                                ? "0.0"
                                : "${controller.totalPrice}",
                            style:
                                h2Style.copyWith(color: LightThemeColor.accent),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                        child: ElevatedButton(
                            onPressed: () {

                              List products = [];
                              for (int i = 0;
                              i < controller.cartFood.length;
                              i++) {
                                var productMap = {
                                  'name': controller.cartFood[i].name,
                                  'price': controller.cartFood[i].price,
                                  'quantity': controller.cartFood[i].quantity,
                                  // 'quantity': controller.cartFood[i].,
                                };
                                products.add(productMap);
                              }
                              // products.addAll(controller.cartFood);
                              // print(products);
                              // orderSushi(products,"Anang",1);
                              showModalBottomSheet<void>(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(24.0),
                                      topRight: Radius.circular(24.0),
                                    ),
                                  ),
                                  builder: (BuildContext context) {
                                    return SingleChildScrollView(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: Container(
                                          child: Center(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                              children: <Widget>[
                                                SizedBox(height: 15),
                                                SizedBox(
                                                    height: 300,
                                                    child:Padding(padding: EdgeInsets.all(10),
                                                      child: Column(
                                                        children:[
                                                          Text("Your Name", style: TextStyle(fontSize: 16),),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          TextFormField(
                                                            keyboardType: TextInputType.text,
                                                            controller: your_name,
                                                            decoration: InputDecoration(
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors.grey),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors.grey),
                                                              ),
                                                              border: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors.grey),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text("List Table", style: TextStyle(fontSize: 16),),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
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
                                                                      snapshot.data![index]
                                                                      ['is_booking']?
                                                                      showDialog<String>(
                                                                          context: context,
                                                                          builder: (BuildContext context) => AlertDialog(
                                                                            title: const Text('Alert'),
                                                                            content: const Text('Table is Full, Pleasa change the table'),
                                                                            actions: <Widget>[
                                                                              TextButton(
                                                                                onPressed: () => Navigator.pop(context, 'OK'),
                                                                                child: const Text('OK'),
                                                                              ),
                                                                            ],
                                                                          )):
                                                                      _table=snapshot.data![index]
                                                                      ['nomor'].toString(),
                                                                      showDialog<String>(
                                                                          context: context,
                                                                          builder: (BuildContext context) => AlertDialog(
                                                                            title: const Text('Alert'),
                                                                            content:  Text("You are book table nomor "+snapshot.data![index]
                                                                            ['nomor'].toString()),
                                                                            actions: <Widget>[
                                                                              TextButton(
                                                                                onPressed: () => Navigator.pop(context, 'OK'),
                                                                                child: const Text('OK'),
                                                                              ),
                                                                            ],
                                                                          ))

                                                                    },
                                                                    child: snapshot.data![index]
                                                                    ['is_booking']?Container(
                                                                      padding: const EdgeInsets.all(10.0),
                                                                      width: MediaQuery.of(context).size.width * 0.8,
                                                                      height: 50,
                                                                      decoration: BoxDecoration(
                                                                        color: Colors.grey,
                                                                        borderRadius: BorderRadius.circular(
                                                                          5.0,
                                                                        ),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color: Colors.black.withOpacity(0.1),
                                                                            spreadRadius: 1.0,
                                                                            blurRadius: 8.0,
                                                                            offset: const Offset(
                                                                              0,
                                                                              8,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        children: [
                                                                          Text( snapshot.data![index]
                                                                          ['name'])
                                                                        ],
                                                                      ),
                                                                    ):
                                                                    Container(
                                                                      padding: const EdgeInsets.all(10.0),
                                                                      width: MediaQuery.of(context).size.width * 0.8,
                                                                      height: 50,
                                                                      decoration: BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.circular(
                                                                          5.0,
                                                                        ),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color: Colors.black.withOpacity(0.1),
                                                                            spreadRadius: 1.0,
                                                                            blurRadius: 8.0,
                                                                            offset: const Offset(
                                                                              0,
                                                                              8,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        children: [
                                                                          Text( snapshot.data![index]
                                                                          ['name'])
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
                                                        ]),
                                                    )
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: [
                                                    // SizedBox(height: 40),
                                                    OutlinedButton(
                                                      style: outlineButtonStyle,
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Close'),
                                                    ),
                                                    SizedBox(width: 10),
                                                    OutlinedButton(
                                                      style: flatoutlineButtonStyle,
                                                      onPressed: () {
                                                        if(your_name.text.toString().isNotEmpty && _table.isNotEmpty){
                                                          orderSushi(products,your_name.text.toString().toString(),int.parse(_table), context, "${controller.totalPrice}");
                                                          Navigator.pop(context);
                                                        }else{
                                                          showDialog<String>(
                                                              context: context,
                                                              builder: (BuildContext context) => AlertDialog(
                                                                title: const Text('Alert'),
                                                                content:  Text("Check your name and your table!!"),
                                                                actions: <Widget>[
                                                                  TextButton(
                                                                    onPressed: () => Navigator.pop(context, 'OK'),
                                                                    child: const Text('OK'),
                                                                  ),
                                                                ],
                                                              ));
                                                        }
                                                      },
                                                      child: Text('Save'),
                                                    ),
                                                    SizedBox(width: 10)
                                                  ],
                                                ),
                                                SizedBox(height: 20)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: const Text("Order"))),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> orderSushi(Object order, String nama, int table, BuildContext context, String s) async {
    var data ={
      "order":order,
      "name":nama,
      "table":table,
      "t_price":s,
    };
    var _return_back = [];
    // const API = "https://manrisk.wikagedung.id/maspot";
    const API = Config.ENDPOINT + "order";
    print(API);
    print(jsonEncode(data));
    // final http.Response response = await http.get(Uri.parse(API));
    final http.Response response = await http.post(
      Uri.parse(API),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    _return_back = json.decode(response.body);
    if(_return_back.isNotEmpty){
      final snackBar = SnackBar(
          content: Text("Success for order"),
          backgroundColor: Color(0xFFFD8629));
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
    }
    print(response);
  }
  Widget cartListView(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(30),
      shrinkWrap: true,
      itemCount: controller.cartFood.length,
      itemBuilder: (_, index) {
        return Dismissible(
          onDismissed: (direction) {
            if (direction == DismissDirection.startToEnd) {
              controller.removeCartItemAtSpecificIndex(index);
            }
          },
          key: Key(controller.cartFood[index].name),
          background: Row(
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(15)),
                  child: const FaIcon(FontAwesomeIcons.trash)),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: controller.isLightTheme
                  ? Colors.white
                  : DarkThemeColor.primaryLight,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 20),
                Image.asset(controller.cartFood[index].image, scale: 10),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.cartFood[index].name,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${controller.cartFood[index].price}",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    CounterButton(
                      onIncrementSelected: () =>
                          controller.increaseItem(controller.cartFood[index]),
                      onDecrementSelected: () =>
                          controller.decreaseItem(controller.cartFood[index]),
                      size: const Size(24, 24),
                      padding: 0,
                      label: Text(
                        controller.cartFood[index].quantity.toString(),
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    Text(
                      "${controller.calculatePricePerEachItem(controller.cartFood[index])}",
                      style: h2Style.copyWith(color: LightThemeColor.accent),
                    )
                  ],
                )
              ],
            ),
          ).fadeAnimation(index * 0.6),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Padding(padding: EdgeInsets.all(10));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: controller.cartFood.isNotEmpty
          ? _bottomAppBar(height, width, context)
          : const SizedBox(),
      appBar: _appBar(context),
      body: EmptyWidget(
        title: "Empty cart",
        condition: controller.cartFood.isNotEmpty,
        child: SingleChildScrollView(
          child: SizedBox(
            height: height * 0.5,
            child: GetBuilder(
              builder: (FoodController controller) {
                return cartListView(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
