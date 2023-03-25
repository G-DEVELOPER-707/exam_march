import 'package:exam_march/service/card_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../items/card_item.dart';
import '../service/utils_service.dart';
import '../states.dart';
import '../storages.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({Key? key}) : super(key: key);

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          "My cards",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder(
          future: CardService.getCard(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return cardItem(context, snapshot.data![index],
                        (){
                      _deleteUser(snapshot.data![index].id);
                    },(){box?.deleteAt(index);
                setState(() {

                });}

                );
              });
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('No data'),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ),
      // body: SingleChildScrollView(
      //     child: Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      //   child: Column(
      //     children: [
      //       SizedBox(
      //         child: ListView.builder(
      //             physics: NeverScrollableScrollPhysics(),
      //             shrinkWrap: true,
      //             itemCount: box?.values.length,
      //             itemBuilder: (context, index) {
      //               return cardItem(context,
      //                   box!.getAt((box?.values.length!)! - 1 - index)!, () {
      //                 box?.deleteAt((box!.values.length)!-1-index);
      //                 setState(() {});
      //               },(){CardService.deleteCard(box!.getAt(index)!.id);
      //               print(box!.getAt(index)!.id);});
      //             }),
      //       ),
      //       // SizedBox(
      //       //   child: ListView.builder(
      //       //       physics: NeverScrollableScrollPhysics(),
      //       //       shrinkWrap: true,
      //       //       itemCount: cardList.length,
      //       //       itemBuilder: (context, index) {
      //       //         return cardItem(context, cardList[index], () {
      //       //           cardList.removeAt(index);
      //       //           setState(() {});
      //       //         },(){});
      //       //       }),
      //       // ),
      //     ],
      //   ),
      // )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/AddCardPage");
          setState(() {

          });
        },
        child: Icon(
          CupertinoIcons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.brown,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  void _deleteUser(String id) async {
    bool result =
    await CardService.deleteCard(id);
    if (result) {
      setState(() {});
      Utils.snackBarSuccess(
          'Deleted successfully', context);
    } else {
      Utils.snackBarError('Someting is wrong', context);
    }
  }
}

