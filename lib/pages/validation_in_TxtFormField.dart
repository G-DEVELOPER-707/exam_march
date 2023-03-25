import 'package:flutter/material.dart';

class Validation extends StatefulWidget {
  const Validation({Key? key}) : super(key: key);

  @override
  State<Validation> createState() => _ValidationState();
}

class _ValidationState extends State<Validation> {
  final TextEditingController _textEditingController=TextEditingController();
  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Form validation example"),),
    body: Padding(padding: EdgeInsets.all(16),
    child: Form(key:_formKey,child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          controller: _textEditingController,
          decoration: InputDecoration(
            hintText:"Eneter your name",
            labelText: "Name",
            border: OutlineInputBorder(),
          ),
          validator: (value){
            if(value==null||value.isEmpty){
              return "Please Enter Your Name";
            }
            return null;
          },
        ),
        ElevatedButton(onPressed: (){if(_formKey.currentState!.validate()){
        showModalBottomSheet(context: context, builder: (context){
          return Container();
        });}
        }, child: Text("Finish"))
      ],
    )),),);
  }
}
