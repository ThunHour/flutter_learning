import 'package:assignment2/model/shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../logic/shop_logic.dart';
import 'buyscreen.dart';

class ProductDetail extends StatefulWidget {
  final ShopModel item;
  ProductDetail({required this.item});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[300],
          title: Text(
            "Detail of ${widget.item.title}",
            style: TextStyle(fontSize: 15),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: double.infinity,
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  width: 300,
                  height: 300,
                  child: Image.network(widget.item.image),
                ),
              ),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                      title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name:",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 280,
                        child: Text(
                          widget.item.title,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  )),
                  ListTile(
                      title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Category:",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 250,
                        child: Text(
                          widget.item.category,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  )),
                  ListTile(
                    title: Row(
                      children: [
                        Text(
                          "Rating:",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Row(
                          children: [
                            RatingBar(
                                ignoreGestures: true,
                                initialRating: widget.item.rating.rate,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 20,
                                ratingWidget: RatingWidget(
                                    full: const Icon(Icons.star,
                                        color: Colors.orange),
                                    half: const Icon(
                                      Icons.star_half,
                                      color: Colors.orange,
                                    ),
                                    empty: const Icon(
                                      Icons.star_outline,
                                      color: Colors.orange,
                                    )),
                                onRatingUpdate: (value) {}),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              widget.item.rating.rate.toString(),
                              style:
                                  TextStyle(fontSize: 20, color: Colors.orange),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            FaIcon(
                              FontAwesomeIcons.peopleGroup,
                              size: 20,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                      title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description:",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 230,
                        child: ReadMoreText(
                          trimLines: 4,
                          trimMode: TrimMode.Line,
                          widget.item.description,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  )),
                  ListTile(
                    title: Row(
                      children: [
                        Text(
                          "Price:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          widget.item.price.toString() + "\$",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed:
                              context.watch<ShopLogic>().count(widget.item) > 1
                                  ? () {
                                      context
                                          .read<ShopLogic>()
                                          .deleteFromCart(widget.item);
                                    }
                                  : null,
                          icon: FaIcon(FontAwesomeIcons.circleMinus),
                        ),
                        Text(
                          (context.watch<ShopLogic>().count(widget.item))
                              .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<ShopLogic>().addToCart(widget.item);
                          },
                          icon: FaIcon(FontAwesomeIcons.circlePlus),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(240, 40),
                            maximumSize: const Size(240, 40),
                            primary: Colors.redAccent[400]),
                        onPressed: () {
                          context.read<ShopLogic>().addToCart(widget.item);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => BuyScreen()));
                        },
                        child: Text("Add to cart"))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
