import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:expense/logic/categry_logic.dart';
import 'package:expense/logic/expense_logic.dart';
import 'package:expense/model/category_model.dart';
import 'package:expense/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common/theme_helper.dart';
import 'category_page.dart';
import 'expense_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CategoryModel cat = new CategoryModel();
  var _Edate = TextEditingController();
  var _Edes = TextEditingController();
  var _EFloat = TextEditingController();
  var _date = TextEditingController();
  DateTime _dateFull = DateTime.now();
  SingleValueDropDownController _cnt = SingleValueDropDownController();
  List<DropDownValueModel> dropDown() {
    List<CategoryModel> item = context.read<CategoryLogic>().listOfCate;
    List<DropDownValueModel> result = [];
    item.forEach((element) {
      result.add(
          new DropDownValueModel(name: element.cTitle, value: element.cId));
    });
    return result;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List<CategoryModel> listCat = context.watch<CategoryLogic>().listOfCate;
    return Scaffold(
        floatingActionButton: InkWell(
            onTap: () {
              _date.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
              _cnt = SingleValueDropDownController();
              _Edes = new TextEditingController();
              _EFloat = new TextEditingController();

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    elevation: 0,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Add Expense"),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    content: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height:350,
                      child: Stack(
                        children: [
                          Column(
                            children: [
              
                              Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: ThemeHelper()
                                            .inputBoxDecorationShaddow(),
                                        child: TextFormField(
                                          
                                          controller: _Edes,
                                         autocorrect: false,
                                          decoration: ThemeHelper()
                                              .textInputDecoration(
                                                  'Description',
                                                  'Enter your description'),
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Please enter your Description";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Row(children: [
                                            Container(
                                              width: 120,
                                              decoration: ThemeHelper()
                                                  .inputBoxDecorationShaddow(),
                                              child: TextFormField(
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: _EFloat,
                                                decoration: ThemeHelper()
                                                    .textInputDecoration(
                                                        'Price',
                                                        'Enter your Price'),
                                                validator: (val) {
                                                  if (val!.isEmpty) {
                                                    return "Please enter your Price";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              width: 130,
                                              child: TextFormField(
                                                readOnly: true,
                                                controller: _date,
                                                decoration:
                                                    const InputDecoration(
                                                  icon: Icon(Icons
                                                      .calendar_today_rounded),
                                                  labelText: "Select Date",
                                                ),
                                                onTap: () async {
                                                  DateTime? pickeddate =
                                                      await DatePicker
                                                          .showDatePicker(
                                                    context,
                                                    currentTime: DateTime.now(),
                                                    minTime: DateTime(2000),
                                                    maxTime: DateTime(2101),
                                                  );
                                                  if (pickeddate != null) {
                                                    setState(() {
                                                      _dateFull = pickeddate;
                                                      _date.text = DateFormat(
                                                              'yyyy-MM-dd')
                                                          .format(pickeddate);
                                                    });
                                                  }
                                                },
                                              ),
                                            )
                                          ])
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    DropDownTextField(
                                      singleController: _cnt,
                                      clearOption: false,
                                      // enableSearch: false,
                                      validator: (value) {
                                        if (value == null) {
                                          return "Required field";
                                        } else {
                                          return null;
                                        }
                                      },
                                      dropDownItemCount: 6,
                                      dropDownList: dropDown(),

                                      onChanged: (val) {
                                        setState(() {
                                          cat.cId = val.value;
                                        });
                                      },
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
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                        icon: const Icon(
                                            FontAwesomeIcons.cloudArrowUp,
                                            color: Colors.white),
                                        label: const Text(
                                          "Save",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            Expense exp = new Expense(
                                                eDate: DateTime.now());

                                            exp.cid = cat.cId;
                                            exp.eDes = _Edes.text;
                                            exp.ePrice = _EFloat.text;

                                            bool insertExp = await context
                                                .read<ExpenseLogic>()
                                                .insertExp(exp);
                                            if (insertExp) {
                                              Navigator.of(context).pop();
                                            }
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  color: HexColor("645fd0"), shape: BoxShape.circle),
              child: const Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Stack(
                  children: [
                    Container(
                      color: HexColor("#8380d6"),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 30.0, right: 30.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: const FaIcon(
                                        FontAwesomeIcons.circleUser,
                                        color: Colors.white,
                                        size: 40,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: Text(
                              "Welcme back,",
                              style: TextStyle(
                                fontFamily: 'roboto',
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 30.0, bottom: 50.0),
                            child: Text(
                              "IExpense",
                              style: TextStyle(
                                fontFamily: 'roboto',
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.white,

                            height: MediaQuery.of(context).size.height * 0.06,
                            // child:
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: MediaQuery.of(context).size.height * 0.22,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.88,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  color: HexColor("645fd0"),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50))),
                              child: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children:  [
                                    Text(
                                      "Spending\n today",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "${context.watch<ExpenseLogic>().getAllExpen()}\$",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (() {}),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: HexColor("645fd0"),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50))),
                                  child: const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: FaIcon(
                                        FontAwesomeIcons.calendar,
                                        color: Colors.white,
                                        size: 30,
                                      ))),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => _buildItem(listCat[index]),
                  itemCount: listCat.length,
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildItem(CategoryModel item) {
    return InkWell(
      onTap: (() {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ExpenseView(item)));
        
      }),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 8, bottom: 8),
        child: Card(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20.0, left: 30, right: 30, bottom: 20),
            child: Row(
              children: [
                const Icon(FontAwesomeIcons.cartShopping),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  item.cTitle,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Total Spend   :   " +
                      context.watch<ExpenseLogic>().getTotalOfCat(item),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          color: Color(
            int.parse(item.cColor),
          ),
        ),
      ),
    );
  }
}
