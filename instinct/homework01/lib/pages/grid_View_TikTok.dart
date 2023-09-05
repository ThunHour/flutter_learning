import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homework01/model/movie_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../constant/movieList_constant.dart';

class GridViewPage extends StatefulWidget {
  @override
  State<GridViewPage> createState() => GridViewPageState();
}

class GridViewPageState extends State<GridViewPage> {
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
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  //Grid view Extent is use to display by width of object
  Widget _buildGradViewExtent() {
    return GridView.extent(
      maxCrossAxisExtent: 100,
      crossAxisSpacing: 5,
      childAspectRatio: 3 / 4,
      mainAxisSpacing: 5,
      padding: EdgeInsets.all(10),
      children: [
        Container(color: Colors.pink),
        Container(color: Colors.indigo),
        Container(color: Colors.blue),
        Container(color: Colors.lightGreenAccent),
        Container(color: Colors.amberAccent),
        Container(color: Colors.deepPurple),
        Container(color: Colors.deepOrange),
        Container(color: Colors.blueGrey),
        Container(color: Colors.purpleAccent),
        Container(color: Colors.yellowAccent),
        Container(color: Colors.cyanAccent),
        Container(color: Colors.purple),
        Container(color: Colors.pink),
        Container(color: Colors.indigo),
        Container(color: Colors.blue),
        Container(color: Colors.lightGreenAccent),
        Container(color: Colors.amberAccent),
        Container(color: Colors.deepPurple),
        Container(color: Colors.deepOrange),
        Container(color: Colors.blueGrey),
        Container(color: Colors.purpleAccent),
        Container(color: Colors.yellowAccent),
        Container(color: Colors.cyanAccent),
        Container(color: Colors.purple),
      ],
    );
  }

  //gridviewCount is use for give the exact column how many column that display on screen
  Widget _buildGridViewCount() {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      children: [
        Container(color: Colors.pink),
        Container(color: Colors.indigo),
        Container(color: Colors.blue),
        Container(color: Colors.lightGreenAccent),
        Container(color: Colors.amberAccent),
        Container(color: Colors.deepPurple),
        Container(color: Colors.deepOrange),
        Container(color: Colors.blueGrey),
        Container(color: Colors.purpleAccent),
        Container(color: Colors.yellowAccent),
        Container(color: Colors.cyanAccent),
        Container(color: Colors.purple),
        Container(color: Colors.pink),
        Container(color: Colors.indigo),
        Container(color: Colors.blue),
        Container(color: Colors.lightGreenAccent),
        Container(color: Colors.amberAccent),
        Container(color: Colors.deepPurple),
        Container(color: Colors.deepOrange),
        Container(color: Colors.blueGrey),
        Container(color: Colors.purpleAccent),
        Container(color: Colors.yellowAccent),
        Container(color: Colors.cyanAccent),
        Container(color: Colors.purple),
      ],
    );
  }

  Widget _buildGridViewBuilder() {
    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(5),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 9 / 16,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5),
        itemCount: movielist.length,
        itemBuilder: (context, index) => _buildMovieItem(movielist[index]));
  }

  Widget _buildMovieItem(MovieModel item) {
    return Container(
      child: CachedNetworkImage(
        imageUrl: item.image,
        imageBuilder: (context, provider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: provider, fit: BoxFit.cover),
          ),
        ),
        errorWidget: (context, provider, error) => Container(
          color: Colors.grey[500],
          child: Icon(
            Icons.error,
            size: 20,
          ),
        ),
        placeholder: (context, provider) => Container(
          color: Colors.grey[500],
          child: spinkit,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return ListView(
      children: [
        _buildProfile(),
        _buildGridViewBuilder(),
      ],
    );
  }

  Widget _buildProfile() {
    return Container(
      child: Column(
        children: [
          _buildProfilePicture(),
          _buildProfileName(),
          _buildFollowerNumber(),
          _buildButton(),
          _buildQAButton(),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildFollowButton(),
          _buildCameraButton(),
          _buildMenuButton(),
        ],
      ),
    );
  }

  Widget _buildCameraButton() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      width: 35,
      height: 35,
      child: Icon(Icons.camera_alt),
    );
  }

  Widget _buildMenuButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey)),
        child: Icon(Icons.arrow_drop_down),
      ),
    );
  }

  Widget _buildFollowButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.red,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: () {},
      child: Text("FOLLOW"),
    );
  }

  Widget _buildFollowerNumber() {
    return Container(
        width: 300,
        margin: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  "168M",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),                Text(
                  "Following",
                  style: TextStyle(fontSize: 10),
                )

              ],
            ),
            Column(
              children: [
                Text(
                  "618M",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),                Text(
                  "Follower",
                  style: TextStyle(fontSize: 10),
                )

              ],
            ),
            Column(
              children: [
                Text(
                  "861M",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),                Text(
                  "Like",
                  style: TextStyle(fontSize: 10),
                )

              ],
            ),
          ],
        ));
  }

  Widget _buildQAButton() {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message, color: Colors.red),
            Text("Q&A", style: TextStyle(color: Colors.red))
          ],
        ),
      ),
    );
  }

  Widget _buildProfileName() {
    return TextButton(
        onPressed: () {},
        child: Text(
          "@ᴄɪᴘʜᴇʀ_ᴢᴇʀɴɪᴀ",
          style: TextStyle(
            color: Colors.blue,
          ),
        ));
  }

  Widget _buildProfilePicture() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: 90,
        backgroundImage: NetworkImage(
            "https://images-platform.99static.com/SLjEZX0jBz7ed0FqkFqV0iPAOoY=/348x286:1059x997/500x500/top/smart/99designs-contests-attachments/97/97683/attachment_97683945"),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: Icon(Icons.add_a_photo, color: Colors.black),
      backgroundColor: Colors.white,
      title: Text(
        "Grid View",
        style: TextStyle(
          fontSize: 25,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.settings,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
