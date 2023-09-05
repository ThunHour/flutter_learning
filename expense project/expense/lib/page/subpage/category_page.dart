import 'dart:async';

import 'package:expense/logic/categry_logic.dart';
import 'package:expense/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../common/theme_helper.dart';
import 'add_category.dart';
import 'edit_cate.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    List<CategoryModel> listCat = context.watch<CategoryLogic>().listOfCate;
    return Scaffold(
      body: ListView.builder(
          itemCount: listCat.length,
          itemBuilder: ((context, index) => Slidable(
                endActionPane: ActionPane(
                  motion: DrawerMotion(),
                  extentRatio: 1 / 2,
                  children: [
                    SlidableAction(
                      onPressed: (((context) => {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditCategory(item: listCat[index],)))
                      })),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      icon: Icons.copy,
                      label: 'Edit',
                    ),
                    SlidableAction(
                      onPressed: (context) => {
                        context.read<CategoryLogic>().deleteCat(listCat[index])
                      },
                      backgroundColor: Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15, top: 8, bottom: 8),
                  child: Card(
                    // ignore: sort_child_properties_last
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 30, right: 30, bottom: 15),
                      child: Row(
                        children: [
                          const Icon(FontAwesomeIcons.cartShopping),
                          const SizedBox(
                            width: 50,
                          ),
                          Text(
                            "Title   :   " + listCat[index].cTitle,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    color: Color(
                      int.parse(listCat[index].cColor),
                    ),
                  ),
                ),
              ))),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await context.read<CategoryLogic>().readCate();
              },
              icon: Icon(Icons.abc_outlined))
        ],
        backgroundColor: HexColor("645fd0"),
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.productHunt,
              color: Colors.white,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              "Category",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor("645fd0"),
        onPressed: (() {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddCategory()));
        }),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
