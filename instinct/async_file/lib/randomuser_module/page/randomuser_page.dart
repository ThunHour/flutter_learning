import 'package:async_file/randomuser_module/model/random_user_model.dart';
import 'package:async_file/randomuser_module/page/randomuser_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../logic/cache_random_user_logic.dart';

import 'RandomUserFavoritePage.dart';

class RandomUserPage extends StatefulWidget {
  const RandomUserPage({Key? key}) : super(key: key);

  @override
  State<RandomUserPage> createState() => _RandomUserPageState();
}

class _RandomUserPageState extends State<RandomUserPage> {
  bool _showIcon = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        await context.read<CacheRamdomLogic>().readMore(refresh: false);
      }
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
    bool hasFavorite = context.watch<CacheRamdomLogic>().hasFavorite();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Post Page"),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: RandomUserFavoritePage()));
          },
          icon: hasFavorite
              ? FaIcon(
                  FontAwesomeIcons.heartCircleCheck,
                  color: Colors.red,
                )
              : Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: RandomUserSearchPage()));
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: _buildbody(),
      floatingActionButton: _showIcon ? _buildFloatButton() : null,
    );
  }

  Widget _buildbody() {
    Status status = context.watch<CacheRamdomLogic>().statue;
    switch (status) {
      case Status.none:
      case Status.loading:
        return Center(
          child: CircularProgressIndicator(),
        );
      case Status.error:
        return Center(
          child: Text("Error"),
        );
      case Status.success:
        return _buildListView();
    }
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
    List<Result> items = context.read<CacheRamdomLogic>().result;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<CacheRamdomLogic>().setLoading();
        context.read<CacheRamdomLogic>().readMore(refresh: true);
      },
      child: ListView.builder(
        controller: _scrollController,
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          if (index < items.length) {
            return _buildItem(items[index]);
          } else {
            return Container(
              height: 50,
              alignment: Alignment.center,
              child: Text("Loading more item ...."),
            );
          }
        },
      ),
    );
  }

  Widget _buildItem(Result item) {
    bool _check = context.watch<CacheRamdomLogic>().isFavorite(item);
    return Slidable(
        endActionPane: ActionPane(
          motion: DrawerMotion(),
          extentRatio: 1 / 2,
          children: [
            SlidableAction(
              onPressed: (ctx) =>
                  {context.read<CacheRamdomLogic>().copyItem(item)},
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.copy,
              label: 'Copy',
            ),
            SlidableAction(
              onPressed: (context) => {
                context.read<CacheRamdomLogic>().removeItem(item),
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Card(
          child: ListTile(
            leading: Image.network(item.picture.medium),
            title:
                Text("${item.name.title} ${item.name.first} ${item.name.last}"),
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
        ));
  }
}
