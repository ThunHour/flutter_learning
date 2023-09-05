import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import '../../constant/movieList_constant.dart';
import '../../model/movie_model.dart';
import '../movieDetail.dart';
class PlayPage extends StatefulWidget {
  const PlayPage({Key? key}) : super(key: key);

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage>with AutomaticKeepAliveClientMixin {
  Widget build(BuildContext context) {
    return _buildImagePageView();
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
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite, color: Colors.white, size: 50),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.arrowshape_turn_up_right_fill,
                      color: Colors.white, size: 50),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.chat_bubble_text_fill,
                      color: Colors.white, size: 50),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}


