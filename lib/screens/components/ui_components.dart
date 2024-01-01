import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../app_properties.dart';
import '../address/add_address_page.dart';

class ActionButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onTap;

  const ActionButton({
    Key? key,
    required this.buttonText,
    required this.onTap,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
            gradient: MAIN_BUTTON_GRADIENTS,
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

class CustomTextField extends StatelessWidget {
  final String placeholder_text;
  final void Function(String)? onChange;

  const CustomTextField({
    Key? key,
    required this.placeholder_text,
    required this.onChange,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
      ),
      child: TextField(
        decoration: InputDecoration(
            border: InputBorder.none, hintText: this.placeholder_text),
        onChanged: this.onChange,
      ),
    );
  }
}

class CustomDropDownField extends StatelessWidget {
  final List<String> input_list;
  final String placeholder_text;
  final void Function(String?) onChange;

  const CustomDropDownField({
    Key? key,
    required this.input_list,
    required this.placeholder_text,
    required this.onChange,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: this.placeholder_text,
        ),
        items: this.input_list.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: this.onChange,
        value: null, // Track the selected area
      ),
    );
  }
}