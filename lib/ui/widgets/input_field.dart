import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../size_config.dart';
import 'text_util.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  Widget? widget;
  TextEditingController? controller;
  MyInputField({
    required this.title,
    required this.hint,
    this.widget,
    this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextUtil(
            title: title,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          Container(
            height: 52,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    autofocus: false,
                    cursorColor: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                    readOnly: widget != null ? true : false,
                    style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          color: context.theme.backgroundColor,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          color: context.theme.backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
                widget ?? Container(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
