import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../constant/movieList_constant.dart';
import '../model/movie_model.dart';
import 'grid_View_TikTok.dart';
import 'movieDetail.dart';
import 'widget/sildeshow.dart';

class ChildrenPage extends StatefulWidget {
  const ChildrenPage({Key? key}) : super(key: key);

  @override
  State<ChildrenPage> createState() => _ChildrenPageState();
}

class _ChildrenPageState extends State<ChildrenPage> {
  bool _dark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildButtonNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Children page",
        ));
  }

  Widget _buildBody() {
    return Container(
      color: Colors.black,
      child: _buildMainListView(),
    );
  }

  Widget _buildMainListView() {
    return ListView(
        children: [SlideShow(), _buildStoryList(), _buildListViewMovie()]);
  }

  Widget _buildStoryList() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movielist.length,
          itemBuilder: (context, index) {
            return _buildStoryItem(movielist[index]);
          }),
    );
  }

  Widget _buildStoryItem(MovieModel item) {
    return Container(
      padding: EdgeInsets.only(right: 10),
      width: 120,
      child: CachedNetworkImage(
        imageUrl: item.image,
        imageBuilder: (context, url) => Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(image: url, fit: BoxFit.cover)),
        ),
        placeholder: (context, url) => Container(
          color: Colors.grey[800],
        ),
        errorWidget: (context, url, error) => Container(
            alignment: Alignment.center,
            height: 200,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Icon(
              Icons.error,
              size: 40,
            )),
      ),
    );
  }

  Widget _buildListViewMovie() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: movielist.length,
      itemBuilder: (context, int index) {
        return _buildMovieItem(movielist[index]);
      },
    );
  }

  Widget _buildMovieItem(MovieModel item) {
    return InkWell(
      onTap: () {
        //apply same as materialoage with page transition
        Navigator.of(context).push(
          PageTransition(
            child: DetailPage(item),
            type: PageTransitionType.bottomToTop,
            fullscreenDialog: true,
            duration: Duration(milliseconds: 400),
            reverseDuration: Duration(milliseconds: 400),
          ),
        );

        //using package to navigate
        // Navigator.of(context).push(PageTransition(
        //     child: DetailPage(item), type: PageTransitionType.bottomToTop));

        //two way of navigate to other page
        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailPage(item)));
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => DetailPage(item),
        //   ),
        // );
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Text(
              item.title,
              style: const TextStyle(
                  fontSize: 20, color: Color.fromARGB(177, 0, 0, 0)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          CachedNetworkImage(
            imageUrl: item.image,
            imageBuilder: (context, imageProvider) => Container(
              height: 400,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                image: DecorationImage(
                  image: NetworkImage(item.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Container(
              color: Colors.grey[800],
            ),
            errorWidget: (context, url, error) => Container(
                alignment: Alignment.center,
                height: 400,
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Icon(
                  Icons.error,
                  size: 340,
                )),
          ),
        ]),
      ),
    );
  }

  final List<String> _fruits_List = [
    "pear",
    "apple",
    "coconut",
    "duran",
    "pineapple",
    "banana",
    "berry",
    "cherry",
  ];

  Widget _buildListView() {
    return ListView.builder(
      itemCount: _fruits_List.length,
      itemBuilder: (context, int index) {
        return Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Colors.greenAccent[100],
          ),
          height: 100,
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Text(_fruits_List[index],
              style: TextStyle(
                fontSize: 20,
              )),
        );
      },
    );
  }

  Widget _buildStackWithBottomIcon() {
    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.grey[100],
        ),
        Container(child: _buildStack()),
        Positioned(
            right: 10,
            bottom: 10,
            child: InkWell(
              onTap: () {
                setState(() {
                  _dark = !_dark;
                });
              },
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    color: _dark
                        ? Colors.red.withOpacity(0.8)
                        : Colors.lightGreenAccent,
                    shape: BoxShape.circle),
                child: Icon(
                  _dark ? Icons.visibility_off : Icons.visibility,
                  color: _dark ? Colors.white : Colors.deepPurple,
                  size: 40,
                ),
              ),
            ))
      ],
    );
  }

  Widget _buildStack() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: _dark ? 0 : 400,
          height: _dark ? 0 : 400,
          color: Colors.black,
        ),
        Container(
          width: _dark ? 0 : 300,
          height: _dark ? 0 : 300,
          color: Colors.blue,
        ),
        Container(
          width: _dark ? 0 : 200,
          height: _dark ? 0 : 200,
          color: Colors.pink,
        ),
        Container(
          width: _dark ? 0 : 100,
          height: _dark ? 0 : 100,
          color: Colors.orange,
        ),
        Container(
          width: _dark ? 0 : 50,
          height: _dark ? 0 : 50,
          color: Colors.amberAccent,
        ),
      ],
    );
  }

  Widget _buildButtonNavigationBar() {
    return BottomAppBar(
      color: Colors.red.withOpacity(0.8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.home),
              color: Colors.white),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person),
              color: Colors.white),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow),
              color: Colors.white),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.location_history),
              color: Colors.white),
          const Spacer(),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_horiz),
              color: Colors.white)
        ],
      ),
    );
  }

  Widget _buildColumn() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: 50, height: 20, color: Colors.red.withOpacity(0.8)),
          Container(
              width: 120, height: 40, color: Colors.blue.withOpacity(0.8)),
          Container(
              width: 30, height: 70, color: Colors.orange.withOpacity(0.8)),
          Container(
              width: 80, height: 20, color: Colors.black.withOpacity(0.8)),
          Container(width: 50, height: 40, color: Colors.pink.withOpacity(0.8))
        ],
      ),
    );
  }

  Widget _buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(width: 50, height: 50, color: Colors.red.withOpacity(0.8)),
        Container(width: 50, height: 50, color: Colors.blue.withOpacity(0.8)),
        Container(width: 50, height: 50, color: Colors.orange.withOpacity(0.8)),
        const Spacer(),
        Container(width: 50, height: 50, color: Colors.black.withOpacity(0.8)),
        Container(width: 50, height: 50, color: Colors.pink.withOpacity(0.8))
      ],
    );
  }
}
