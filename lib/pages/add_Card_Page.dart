import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask/mask/mask.dart';
import 'package:mask/models/hashtag_is.dart';

import '../models/card_model.dart';
import '../service/card_service.dart';
import '../service/utils_service.dart';
import '../storages.dart';
import 'cards_page.dart';


class AddCardPage extends StatefulWidget {
  const AddCardPage({Key? key}) : super(key: key);

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  var numberCtr = TextEditingController();
  var CardnameCtr = TextEditingController();
  var zCtr = TextEditingController();
  String cardNumber = "";
  String cardName = "";
  String date = "";
  String type = "";
  String cardBalance = "";
  String dateError = "";
  String numError = "";
  bool card16 = false;
  bool dateTrue = false;
  bool cardType = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: const Text(
            'Add card',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          foregroundColor: Colors.black,
          actions: [],
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          height: 210,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/card_background.jpg",
                                  ),
                                  fit: BoxFit.cover)),
                          child: Stack(
                            children: [
                              Positioned(
                                  left: 15,
                                  top: 20,
                                  child: type.startsWith("8600")
                                      ? Text(
                                          "UZCARD",
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.greenAccent),
                                        )
                                      : SizedBox()),
                              Positioned(
                                  left: 15,
                                  top: 20,
                                  child: type.startsWith("9860")
                                      ? Text(
                                          "HUMO",
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.greenAccent),
                                        )
                                      : SizedBox()),
                              Positioned(
                                top: 80,
                                left: 15,
                                child: Text(
                                  cardName,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                              Positioned(
                                top: 115,
                                left: 15,
                                child: Text(
                                  cardBalance,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Positioned(
                                top: 145,
                                left: 15,
                                child: Text(
                                  cardName,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Positioned(
                                  bottom: 15,
                                  left: 15,
                                  child: Row(children: [
                                    Text(
                                      cardNumber,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Text(
                                      date,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    )
                                  ])),
                            ],
                          ),
                        ),
                        const Text(
                          "Card number",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40)),
                          padding: const EdgeInsets.all(5),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Card Number";
                              }
                              if (!cardType) {
                                return "you can add only cards 'HUMO' and 'UZCARD'";
                              }

                              if (!card16) {
                                return "required 16 numbers";
                              }

                              return null;
                            },
                            onChanged: (number) {
                              cardNumber = number;
                              setState(() {});
                              type = number;
                              setState(() {});

                              setState(() {});
                              numberCtr.text.startsWith("9860") ||
                                      numberCtr.text.startsWith("8600")
                                  ? cardType = true
                                  : cardType = false;

                              setState(() {});
                              numberCtr.text.length == 19
                                  ? card16 = true
                                  : card16 = false;

                              setState(() {});
                            },
                            onEditingComplete: () {
                              cardBalance = "000 sum";
                              // numberCtr.text.startsWith("9860") ||
                              //         numberCtr.text.startsWith("8600")
                              //     ? cardType = true
                              //     : cardType = false;
                              // print(cardType);
                              // setState(() {});
                              // numberCtr.text.length == 19
                              //     ? card16 = true
                              //     : card16 = false;
                              // print(card16);
                              // setState(() {});
                            },
                            keyboardType: TextInputType.number,
                            controller: numberCtr,
                            inputFormatters: [
                              Mask.generic(
                                masks: ['#### #### #### ####'],
                                hashtag: Hashtag.numbers, // optional field
                              ),
                            ],
                            decoration: const InputDecoration(
                                hintText: "Enter card number",
                                hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.brown)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide())),
                          ),
                        ),
                        Text(
                          numError,
                          style: TextStyle(color: Colors.red),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Date",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40)),
                          padding: const EdgeInsets.all(5),
                          child: TextFormField(
                            validator: (date) {
                              if (date == null || date.isEmpty) {
                                return "Please Enter Date";
                              }
                              if (zCtr.text.codeUnitAt(0) >= 49 &&
                                      zCtr.text.codeUnitAt(1) > 50 ||
                                  zCtr.text.codeUnitAt(0) > 49) {
                                return "Invalid date";
                              }

                              return null;
                            },
                            onChanged: (dateCard) {
                              date = dateCard;
                              setState(() {});
                              // if (zCtr.text.codeUnitAt(0) >= 49 &&
                              //         zCtr.text.codeUnitAt(1) > 50 ||
                              //     zCtr.text.codeUnitAt(0) > 49) {
                              //   dateError = "invalid date!";
                              //   dateTrue = false;
                              //   setState(() {});
                              // } else {
                              //   dateError = "";
                              //   dateTrue = true;
                              //   print(dateTrue);
                              //   setState(() {});
                              // }
                            },
                            onEditingComplete: () {
                              // if (zCtr.text.codeUnitAt(0) >= 49 &&
                              //         zCtr.text.codeUnitAt(1) > 50 ||
                              //     zCtr.text.codeUnitAt(0) > 49) {
                              //   dateError = "invalid date!";
                              //   setState(() {});
                              // } else {
                              //   dateError = "";
                              //   setState(() {});
                              // }
                            },
                            keyboardType: TextInputType.number,
                            controller: zCtr,
                            inputFormatters: [
                              Mask.generic(
                                masks: ['##/##'],
                                hashtag: Hashtag.numbers, // optional field
                              ),
                            ],
                            decoration: const InputDecoration(
                                hintText: "Enter date",
                                hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                                focusedBorder: OutlineInputBorder(),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide())),
                          ),
                        ),
                        Text(
                          dateError,
                          style: TextStyle(color: Colors.red),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Card name",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40)),
                          padding: const EdgeInsets.all(5),
                          child: TextFormField(
                            validator: (name) {
                              if (name!.isEmpty || name == null) {
                                return "Please enter card name!";
                              }
                              return null;
                            },
                            onChanged: (name) {
                              cardName = name;
                              setState(() {});
                            },
                            keyboardType: TextInputType.text,
                            controller: CardnameCtr,
                            decoration: InputDecoration(
                                hintText: 'Enter card name',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide())),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            SizedBox(
                              width: 30,
                            ),
                            // SizedBox(
                            //   width: 30,
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(120, 50),
                                  backgroundColor: Colors.brown),
                              onPressed: () {
                                // if (numberCtr.text.isNotEmpty &&
                                //     CardnameCtr.text.isNotEmpty &&
                                //     zCtr.text.isNotEmpty &&
                                //     card16 &&
                                //     cardType &&
                                //     dateTrue) {
                                if (_formKey.currentState!.validate()) {
                                  box?.add(CardModel(
                                      cardnumber: numberCtr.text,
                                      name: CardnameCtr.text,
                                      balance: "0",
                                      date: zCtr.text, id: ''));
                                  CardModel newCard = CardModel(
                                      name: CardnameCtr.text,
                                      cardnumber: numberCtr.text,
                                      date: zCtr.text,
                                      id: "1", balance: '000') ;
                                  _addCard(newCard);


                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                    return const CardsPage();
                                  }));
                                  setState(() {});
                                }
                                // if (numberCtr.text.isEmpty ||
                                //     CardnameCtr.text.isEmpty ||
                                //     zCtr.text.isEmpty) {
                                //   showModalBottomSheet(
                                //       backgroundColor: Colors.transparent,
                                //       context: context,
                                //       builder: (context) {
                                //         return Container(
                                //           decoration: const BoxDecoration(
                                //             borderRadius: BorderRadius.only(
                                //               topLeft: Radius.circular(25),
                                //               topRight: Radius.circular(25),
                                //             ),
                                //             color: Colors.transparent,
                                //           ),
                                //           height: 30,
                                //           child: const Center(
                                //             child: Text(
                                //               "Enter required elements!",
                                //               style: TextStyle(
                                //                   color: Colors.redAccent),
                                //             ),
                                //           ),
                                //         );
                                //       });
                                // }
                              },
                              child: Text(
                                "Done",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )),
                          // ElevatedButton(
                          //     onPressed: () {
                          //       if (_formKey.currentState!.validate()) {
                          //         showModalBottomSheet(
                          //             context: context,
                          //             builder: (context) {
                          //               return Container();
                          //             });
                          //       }
                          //     },
                          //     child: Text('Zaybal'))
                        )
                      ]),
                ))));
  }
  void _addCard(CardModel newCard) async {
    bool result =
    await CardService.addCard(newCard);
    if (result) {
      setState(() {});
      Utils.snackBarSuccess(
          'Created successfully', context);
    } else {
      Utils.snackBarError('Someting is wrong', context);
    }
  }
}
