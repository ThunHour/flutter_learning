import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:expense/logic/expense_logic.dart';
import 'package:expense/model/category_model.dart';
import 'package:expense/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common/theme_helper.dart';
import '../../logic/categry_logic.dart';

class ExpenseView extends StatefulWidget {
  final CategoryModel item;
  const ExpenseView(this.item);

  @override
  State<ExpenseView> createState() => _ExpenseViewState();
}

class _ExpenseViewState extends State<ExpenseView> {
  CategoryModel cat = CategoryModel();
  final _Edate = TextEditingController();
  var _Edes = TextEditingController();
  var _EFloat = TextEditingController();
  final _date = TextEditingController();
  DateTime _dateFull = DateTime.now();
  SingleValueDropDownController _cnt = SingleValueDropDownController();
  List<DropDownValueModel> dropDown() {
    List<CategoryModel> item = context.read<CategoryLogic>().listOfCate;
    List<DropDownValueModel> result = [];
    for (var element in item) {
      result.add(DropDownValueModel(name: element.cTitle, value: element.cId));
    }
    return result;
  }

  DropDownValueModel findOne(String cid) {
    List<CategoryModel> item = context.read<CategoryLogic>().listOfCate;
    CategoryModel itemFound = CategoryModel();
    for (CategoryModel e in item) {
      e.cId == cid;
      itemFound = e;
      break;
    }
    return DropDownValueModel(name: itemFound.cTitle, value: itemFound.cId);
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List<Expense> itemList = context.watch<ExpenseLogic>().findExp(widget.item);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: HexColor('#8380d6'),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              "List of expense " + "of ${widget.item.cTitle}",
              style: TextStyle(color: Colors.white),
            )),
        body: ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              return Slidable(
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  extentRatio: 1 / 2,
                  children: [
                    SlidableAction(
                      onPressed: (context) => {
                        _date.text = DateFormat('yyyy-MM-dd')
                            .format(itemList[index].eDate),
                        _cnt = SingleValueDropDownController(
                            data: findOne(itemList[index].cid)),
                        _Edes =
                            TextEditingController(text: itemList[index].eDes),
                        _EFloat =
                            TextEditingController(text: itemList[index].ePrice),
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              elevation: 0,
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Edit Expense"),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle),
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
                                height: 350,
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: ThemeHelper()
                                                      .inputBoxDecorationShaddow(),
                                                  child: TextFormField(
                                                    controller: _Edes,
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
                                                padding:
                                                    const EdgeInsets.all(1.0),
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
                                                              TextInputType
                                                                  .number,
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
                                                            labelText:
                                                                "Select Date",
                                                          ),
                                                          onTap: () async {
                                                            DateTime?
                                                                pickeddate =
                                                                await DatePicker
                                                                    .showDatePicker(
                                                              context,
                                                              currentTime:
                                                                  DateTime
                                                                      .now(),
                                                              minTime: DateTime(
                                                                  2000),
                                                              maxTime: DateTime(
                                                                  2101),
                                                            );
                                                            if (pickeddate !=
                                                                null) {
                                                              setState(() {
                                                                _dateFull =
                                                                    pickeddate;
                                                                _date
                                                                    .text = DateFormat(
                                                                        'yyyy-MM-dd')
                                                                    .format(
                                                                        pickeddate);
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ElevatedButton.icon(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: HexColor("645fd0"),
                                                    fixedSize:
                                                        const Size(100, 40),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                    ),
                                                  ),
                                                  icon: const Icon(
                                                      FontAwesomeIcons
                                                          .cloudArrowUp,
                                                      color: Colors.white),
                                                  label: const Text(
                                                    "Save",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () async {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      Expense exp = Expense(
                                                          eDate: _dateFull);
                                                      exp.eId =
                                                          itemList[index].eId;
                                                      exp.cid = widget.item.cId;
                                                      exp.eDes = _Edes.text;
                                                      exp.ePrice = _EFloat.text;

                                                      bool insertExp =
                                                          await context
                                                              .read<
                                                                  ExpenseLogic>()
                                                              .editexp(exp);
                                                      if (insertExp) {
                                                        Navigator.of(context)
                                                            .pop();
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
                        )
                      },
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      icon: Icons.copy,
                      label: 'Edit',
                    ),
                    SlidableAction(
                      onPressed: (context) => {
                        context.read<ExpenseLogic>().deleteExp(itemList[index])
                      },
                      backgroundColor: const Color(0xFFFE4A49),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Icon(FontAwesomeIcons.cartShopping),
                              const SizedBox(
                                width: 30,
                              ),
                              Text(
                                "Title : ${itemList[index].eDes}",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Text(
                                "Price : ${itemList[index].ePrice}",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "date : ${DateFormat('yyyy-MM-dd').format(itemList[index].eDate)}",
                            style: const TextStyle(),
                          ),
                        ],
                      ),
                    ),
                    color: Color(
                      int.parse(widget.item.cColor),
                    ),
                  ),
                ),
              );
            }));
  }
}
