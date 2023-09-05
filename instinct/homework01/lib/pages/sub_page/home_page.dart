import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import '../../constant/movieList_constant.dart';
import '../../model/movie_model.dart';
import '../movieDetail.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;
  final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.green,
        ),
      );
    },
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: _buildMainListView(),
    );
  }

  Widget _buildMainListView() {
    return ListView(
        children: [ _buildStoryList(), _buildListViewMovie()]);
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
            placeholder: (context, url) => spinkit,

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


}


