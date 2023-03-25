import 'package:exam_march/service/card_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/card_model.dart';


Widget cardItem(
  BuildContext context,
  CardModel card,void Function() delete,
    void Function() delete2
) {
  return Container(
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
              child: card.cardnumber.startsWith("8600")
                  ? Text(
                      "UZCARD",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.greenAccent),
                    )
                  : card.cardnumber.startsWith("9860")
                      ? Text(
                          "HUMO",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.brown),
                        )
                      : Text(
                          "Unkown card type",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.red),
                        )),
          Positioned(
            top: 80,
            left: 15,
            child: Text(
              card.name,
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
              card.balance + " sum",
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
              card.name,
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
                  card.cardnumber,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 25,
                ),
                Text(
                  card.date,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ])),
          Positioned(
              right: 0,
              top: 10,
              child:  PopupMenuButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
                onSelected: (value) {
                  if (value == "Delete") {
                    delete();
                    delete2();


                  }

                },
                itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<String>>[
                  const PopupMenuItem(
                      value: "Delete", child: Text("Delete")),

                  ]),
          )],
              ),);

}
