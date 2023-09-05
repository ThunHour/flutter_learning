import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../../constant/movieList_constant.dart';
import '../../model/movie_model.dart';

class SlideShow extends StatelessWidget {
  const SlideShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: PageView.builder(

        itemBuilder: (context, index) => _buildPageViewItem(movielist[index]),
        itemCount: movielist.length,
      ),
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
}
