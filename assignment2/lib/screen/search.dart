import 'package:assignment2/logic/shop_logic.dart';
import 'package:assignment2/model/shop.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SearchItem extends StatefulWidget {
  SearchItem({Key? key}) : super(key: key);

  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  @override
  List<ShopModel> items = [];
  List<ShopModel> _foundItem = [];
  @override
  Widget build(BuildContext context) {
    items = context.read<ShopLogic>().MainData;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: FaIcon(
            FontAwesomeIcons.cartShopping,
            size: 20,
          ),
        ),
        backgroundColor: Colors.red[300],
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_forward),
          ),
        ],
        title: _buildSearchTextField(),
      ),
      body: _buildbody(),
    );
  }

  var _searchController = TextEditingController(text: "");
  Widget _buildSearchTextField() {
    return TextField(
      controller: _searchController,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyle(
            color: Colors.white70,
          )),
      onChanged: (text) {
        setState(() {
          if (text.trim() == "") {
            _foundItem = [];
          } else {
            _foundItem = items
                .where((element) =>
                    element.title.toLowerCase().contains(text.toLowerCase()))
                .toList();
          }
        });
      },
    );
  }

  Widget _buildbody() {
    return Container(
      child: _buildListView(),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: _foundItem.length,
      itemBuilder: (context, index) {
        return buildItem(_foundItem[index]);
      },
    );
  }

  Widget buildItem(ShopModel item) {
    return Card(
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
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopify_rounded,
                size: 35,
                color: Colors.blue,
              ))
        ],
      ),
    );
  }
}
