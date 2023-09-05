import 'package:assignment2/logic/shop_logic.dart';
import 'package:assignment2/model/shop.dart';
import 'package:assignment2/screen/productdetail.dart';
import 'package:assignment2/screen/search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'buyscreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showIcon = false;
  ScrollController _scrollController = ScrollController();
  void initState() {
    super.initState();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        await context.read<ShopLogic>().readData();
      }
      if (_scrollController.position.pixels >= 200) {
        setState(() {
          _showIcon = true;
        });
      } else {
        setState(() {
          _showIcon = false;
        });
      }
    });
  }

  bool _showDeleteIcon = false;
  List<ShopModel> allItem = [];
  List allCatrgoty = [];

  @override
  Widget build(BuildContext context) {
    allItem = context.watch<ShopLogic>().DisplayDataList;
    allCatrgoty = context.watch<ShopLogic>().getAllcategoty();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.leftToRight, child: SearchItem()));
          },
        ),
        backgroundColor: Colors.red[300],
        centerTitle: true,
        title: Text("IShopPing"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: BuyScreen()));
            },
            icon: FaIcon(
              FontAwesomeIcons.cartShopping,
              size: 20,
            ),
          )
        ],
      ),
      body: _buildBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,
      floatingActionButton: _showIcon ? _buildFloatButton() : null,
    );
  }

  Widget _buildFloatButton() {
    return FloatingActionButton(
      mini: true,
      backgroundColor: Colors.redAccent,
      onPressed: () {
        _scrollController.animateTo(0,
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      },
      child: Icon(
        Icons.arrow_upward,
      ),
    );
  }

  Widget _buildBody() {
    return ListView(
      controller: _scrollController,
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: _showDeleteIcon
                  ? MediaQuery.of(context).size.width * 0.87
                  : MediaQuery.of(context).size.width,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: allCatrgoty.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _showDeleteIcon = true;
                        });

                        context
                            .read<ShopLogic>()
                            .displayByCategoty(allCatrgoty[index]);
                      },
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(6),
                          alignment: Alignment.center,
                          height: 30,
                          child: Text(
                            allCatrgoty[index],
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    );
                  })),
            ),
            Container(
              child: _showDeleteIcon
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          _showDeleteIcon = false;
                        });
                        context.read<ShopLogic>().resetData();
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 2, color: Colors.red.shade400)),
                          child: Icon(
                            Icons.clear_sharp,
                            color: Colors.red.shade200,
                          )),
                    )
                  : null,
            )
          ],
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: allItem.length,
          itemBuilder: ((context, index) => buildItem(allItem[index])),
        ),
      ],
    );
  }

  Widget buildItem(ShopModel item) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => ProductDetail(
                  item: item,
                ))));
      },
      child: Card(
        shadowColor: Colors.black,
        margin: EdgeInsets.only(top: 15),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              child: Image.network(item.image),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 220, child: Text(item.title)),
                Text(item.category),
                Text(item.price.toString() + '\$'),
              ],
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent[400],
                    minimumSize: Size(60, 20),
                    maximumSize: Size(60, 20)),
                onPressed: () {
                  _showModalBottomSheet(item);
                },
                child: Text(
                  "Add",
                  style: TextStyle(fontSize: 12),
                ))
          ],
        ),
      ),
    );
  }

  _showModalBottomSheet(ShopModel item) {
    int amount = context.read<ShopLogic>().count(item);
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  width: 190,
                  height: 190,
                  child: Image.network(item.image),
                ),
              ),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                      title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name:",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 280,
                        child: Text(
                          item.title,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  )),
                  ListTile(
                      title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Category:",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 250,
                        child: Text(
                          item.category,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  )),
                  ListTile(
                    title: Row(
                      children: [
                        Text(
                          "Price:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          item.price.toString() + "\$",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: context.watch<ShopLogic>().count(item) > 1
                              ? () {
                                  context
                                      .read<ShopLogic>()
                                      .deleteFromCart(item);
                                }
                              : null,
                          icon: FaIcon(FontAwesomeIcons.circleMinus),
                        ),
                        Text(
                          (context.watch<ShopLogic>().count(item)).toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<ShopLogic>().addToCart(item);
                          },
                          icon: FaIcon(FontAwesomeIcons.circlePlus),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent[400],
                          minimumSize: const Size(240, 40),
                          maximumSize: const Size(240, 40),
                        ),
                        onPressed: () {
                          context.read<ShopLogic>().addToCart(item);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => BuyScreen()));
                        },
                        child: Text("Add to cart"))
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        );
      },
    );
  }
}
