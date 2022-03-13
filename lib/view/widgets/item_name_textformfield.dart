import 'package:flutter/material.dart';
import '../../service/firebase_dataservice/add_items.dart';

class ItemNameTextFormField extends StatelessWidget {
  final TextEditingController controller;
  ItemNameTextFormField({
    required this.controller,
    Key? key,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.1,
          right: MediaQuery.of(context).size.width * 0.1),
      height: MediaQuery.of(context).size.height * 0.1,
      child: Form(
        key: _formKey,
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          controller: controller,
          autofocus: false,
          cursorColor: Colors.grey.withOpacity(0.8),
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    await AddItems().addItem(
                      controller.text,
                    );
                  }
                },
                child: const Icon(Icons.send, color: Color(0xFFF66A68))),
            suffixIconColor: Colors.orange,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.8)),
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: 'Name Item',
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.8)),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            enabledBorder: (OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.8)),
                borderRadius: const BorderRadius.all(Radius.circular(20)))),
          ),
        ),
      ),
    );
  }
}
