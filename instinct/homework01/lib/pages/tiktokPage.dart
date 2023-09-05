import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/movieList_constant.dart';
import '../model/movie_model.dart';

class TikTokPage extends StatefulWidget {
  const TikTokPage({Key? key}) : super(key: key);

  @override
  State<TikTokPage> createState() => _TikTokPageState();
}

class _TikTokPageState extends State<TikTokPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildImagePageView(),
      bottomNavigationBar: _buildBottomAppBar(),
    );
  }

  Widget _buildBottomAppBar() {
    return BottomAppBar(
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.home, color: Colors.white)),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.person, color: Colors.white)),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.play_arrow, color: Colors.white)),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.location_history, color: Colors.white)),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_horiz, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildImagePageView() {
    return Stack(
      children: [
        _buildPageviewMovieItem(),
        Positioned(
            top: 1,
            left: 90,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Following",
                    style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                  Text("For You",
                      style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold))
                ],
              ),
            ))
      ],
    );
  }

  Widget _buildPageviewMovieItem() {
    return Stack(
      children: [
        PageView.builder(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => _buildPageViewItem(movielist[index]),
          itemCount: movielist.length,
        ),
        Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.face,
                    color: Colors.black,
                    size: 50,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite, color: Colors.black, size: 50),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.arrowshape_turn_up_right_fill,
                      color: Colors.black, size: 50),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.chat_bubble_text_fill,
                      color: Colors.black, size: 50),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.star, color: Colors.black, size: 50),
                )
              ],
            ))
      ],
    );
  }

  Widget _buildPageViewItem(MovieModel item) {
    return Container(
      child: CachedNetworkImage(
        imageUrl: item.image,
        imageBuilder: (context, provider) => Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: provider,
            fit: BoxFit.cover,
          )),
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return PageView(
      scrollDirection: Axis.vertical,
      children: [
        Container(color: Colors.deepOrange),
        Container(color: Colors.blue),
        Container(color: Colors.pink),
        Container(color: Colors.yellow),
        Container(color: Colors.purple),
      ],
    );
  }
}
