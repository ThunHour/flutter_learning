import 'package:expense/logic/categry_logic.dart';
import 'package:expense/model/category_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../common/theme_helper.dart';

class EditCategory extends StatefulWidget {
  final CategoryModel item;
   EditCategory( {required this.item});


  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> 
{@override
  void initState() {
  _Edes = TextEditingController(text: widget.item.cTitle);
   pickerColor = Color(int.parse(widget.item.cColor));
    super.initState();
  }
  var _Edes = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Color   pickerColor = Colors.white;


  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }
  @override
  Widget build(BuildContext context) {
   
  
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          backgroundColor: HexColor("#8380d6"),
          title: const Text("Add Category",style: TextStyle(color: Colors.white),),
        ),
        body: Column(children: [
          const SizedBox(height: 20,),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            width: MediaQuery.of(context).size.width * 0.9,

            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                              child: TextFormField(
                                controller: _Edes,
                                decoration: ThemeHelper().textInputDecoration(
                                    'Category Title',
                                    'Enter your category title'),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Category Title";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                           const SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              // ignore: sort_child_properties_last
                              child: MaterialButton(
                                color: pickerColor,
                                onPressed: () {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Pick a color!'),
                                          content: SingleChildScrollView(
                                            child: ColorPicker(
                                              pickerColor: pickerColor,
                                              onColorChanged: changeColor,
                                            ),
                                          ),
                                          actions: <Widget>[
                                            ElevatedButton(
                                              child: const Text('DONE'),
                                              onPressed: () {
                                    
  
                                                Navigator.of(context)
                                                    .pop(); 
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: const Text("Default Color Picker"),
                              ),
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                  
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: HexColor("645fd0"),
                                fixedSize: const Size(100, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              icon: const Icon(FontAwesomeIcons.cloudArrowUp,
                                  color: Colors.white),
                              label: const Text(
                                "Edit",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async{
                                if (_formKey.currentState!.validate()) {
                                  CategoryModel cateUp= CategoryModel();
                                  cateUp.cColor=pickerColor.value.toString();
                                  cateUp.cTitle=_Edes.text;
                                  cateUp.cId=widget.item.cId;
                                  print(cateUp);
                                  bool insert=await context.read<CategoryLogic>().editCate(cateUp);
                                  if(insert){
                                      Navigator.of(context).pop();
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ]));
  }
}
