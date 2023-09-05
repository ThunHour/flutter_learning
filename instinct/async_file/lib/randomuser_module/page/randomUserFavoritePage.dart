import 'package:async_file/randomuser_module/model/random_user_model.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../logic/cache_random_user_logic.dart';
import '../logic/random_user_logic.dart';

class RandomUserFavoritePage extends StatefulWidget {
  const RandomUserFavoritePage({Key? key}) : super(key: key);

  @override
  State<RandomUserFavoritePage> createState() => _RandomUserFavoritePageState();
}

class _RandomUserFavoritePageState extends State<RandomUserFavoritePage> {
  bool _showIcon = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >= 500) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Favorite"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                context.read<CacheRamdomLogic>().clearAllFavoite();
              },
              icon: Icon(Icons.delete_forever))
        ],
      ),
      body: _buildbody(),
      floatingActionButton: _showIcon ? _buildFloatButton() : null,
    );
  }

  Widget _buildbody() {
    return _buildListView();
  }

  Widget _buildFloatButton() {
    return FloatingActionButton(
      onPressed: () {
        _scrollController.animateTo(0,
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      },
      child: Icon(Icons.arrow_upward),
    );
  }

  Widget _buildListView() {
    List<Result> items = context.watch<CacheRamdomLogic>().favorite;
    return ListView.builder(
      controller: _scrollController,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _buildItem(items[index]);
      },
    );
  }

  Widget _buildItem(Result item) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) => {
        if (direction == DismissDirection.endToStart)
          {context.read<CacheRamdomLogic>().removeFavorite(item)}
      },
      child: Card(
        child: ListTile(
          leading: Image.network(item.picture.medium),
          title:
              Text("${item.name.title} ${item.name.first} ${item.name.last}"),
          subtitle: Text("${item.location.city}"),
          trailing: IconButton(
            onPressed: () {
              context.read<CacheRamdomLogic>().removeFavorite(item);
            },
            icon: Icon(Icons.clear),
          ),
        ),
      ),
    );
  }
}
