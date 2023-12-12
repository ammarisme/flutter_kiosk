import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app_properties.dart';
import '../address/add_address_page.dart';

class ActionButton extends StatelessWidget{

  final String buttonText;
  final VoidCallback? onTap;

  const ActionButton({
    Key? key,
    required this.buttonText,
    required this.onTap,
  }) : super(key: key);



  Widget build(BuildContext context){
    return InkWell(
      onTap: this.onTap,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text(this.buttonText,
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );
  }
}