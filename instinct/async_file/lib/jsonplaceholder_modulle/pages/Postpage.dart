import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constant/status-eum.dart';
import '../logic/post_logic.dart';
import '../model/postmodel.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Page"),
      ),
      body: _buildbody(),
    );
  }

  Widget _buildbody() {
    Status status = context.watch<PostLogic>().statue;
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

  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
       await context.read<PostLogic>().readMore(false);
      }
    });
  }

  Widget _buildListView() {
    List<PostModel> items = context.read<PostLogic>().photolist;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<PostLogic>().setLoading();
        context.read<PostLogic>().readMore(true);
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

  Widget _buildItem(PostModel item) {
    return Card(
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(item.id.toString()),
        ),
        title: Text(item.title),
        subtitle: Text("${item.body}"),
        trailing: Text("User Id:${item.userId}"),
      ),
    );
  }
}
