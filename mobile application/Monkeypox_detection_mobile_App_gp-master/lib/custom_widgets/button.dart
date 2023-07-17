import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget{
  final VoidCallback Onpressed;
  final String text;
  final double Height,width;
  final Color clr;
  const DefaultButton({Key ?key , required this.Onpressed,
    required this.text,
    required this.clr,
    required this.Height,required this.width
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(

        child: MaterialButton(onPressed: Onpressed,

          height: Height,
          child: Text(text,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
          color: clr,
          minWidth: width,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
        )
    );
  }





}