import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../logic/cache_random_user_logic.dart';
import '../logic/random_user_logic.dart';
import '../model/random_user_model.dart';

class RandomUserSearchPage extends StatefulWidget {
  const RandomUserSearchPage({Key? key}) : super(key: key);

  @override
  State<RandomUserSearchPage> createState() => _RandomUserSearchPageState();
}

class _RandomUserSearchPageState extends State<RandomUserSearchPage> {
  List<Result> items = [];
  List<Result> _foundItem = [];
  @override
  Widget build(BuildContext context) {
    items = context.read<CacheRamdomLogic>().result;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
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
                .where((element) => (element.name.first.toLowerCase() +
                        element.name.last.toLowerCase())
                    .contains(text.toLowerCase()))
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
        return _buildItem(_foundItem[index]);
      },
    );
  }

  Widget _buildItem(Result item) {
    bool _check = context.watch<CacheRamdomLogic>().isFavorite(item);
    return Card(
      child: ListTile(
        leading: Image.network(item.picture.medium),
        title: Text("${item.name.title} ${item.name.first} ${item.name.last}"),
        subtitle: Text("${item.location.city}"),
        trailing: IconButton(
          onPressed: () {
            if (_check) {
              context.read<CacheRamdomLogic>().removeFavorite(item);
            } else {
              context.read<CacheRamdomLogic>().addFavorite(item);
            }
          },
          icon: Icon(
            _check ? Icons.favorite : Icons.favorite_border_outlined,
            color: _check ? Colors.red : Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}
