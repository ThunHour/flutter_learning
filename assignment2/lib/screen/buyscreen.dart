import 'package:assignment2/logic/shop_logic.dart';
import 'package:assignment2/model/shop.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BuyScreen extends StatefulWidget {
  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  List<ShopModel> buylist = [];
  @override
  Widget build(BuildContext context) {
    buylist = context.watch<ShopLogic>().BuyList;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[300],
        title: Text("Cart"),
        centerTitle: true,
      ),
      body: _buildbody(),
    );
  }

  Widget _buildbody() {
    return ListView(
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: buylist.length,
            itemBuilder: ((context, index) => _buildItem(buylist[index])),
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              TextButton(
                  style: TextButton.styleFrom(primary: Colors.redAccent[400]),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Add more items")),
            ],
          ),
        ]),
        Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Card(
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Subtotal"),
                        Text("\$" +
                            (context.watch<ShopLogic>().sunTotal()).toString())
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Devevery fee"),
                        Text("\$" + (0).toString())
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Discount"), Text("\$" + (0).toString())],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total"),
                      Text((context.watch<ShopLogic>().sunTotal()).toString())
                    ],
                  )
                ]),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  width: 410,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent[400]),
                      onPressed: () {
                        context.read<ShopLogic>().buy();
                        Navigator.pop(context);
                      },
                      child: Text("Buy")))
            ],
          ),
        )
      ],
    );
  }

  Widget _buildItem(ShopModel item) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black38, width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<ShopLogic>().deleteFromCart(item);
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.circleMinus,
                        color: Colors.redAccent[400],
                      ),
                    ),
                    Text(
                      (context.watch<ShopLogic>().count(item)).toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<ShopLogic>().addToCart(item);
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.circlePlus,
                        color: Colors.redAccent[400],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 50,
            height: 50,
            child: Image.network(item.image),
          ),
          Container(
            width: 100,
            child: Text(
              item.title,
              maxLines: 1,
            ),
          ),
          Text("\$" +
              (item.price * context.watch<ShopLogic>().count(item)).toString())
        ],
      ),
    );
  }
}
