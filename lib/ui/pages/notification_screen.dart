import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme.dart';
import '../widgets/text_util.dart';

class NotificationScreen extends StatefulWidget {
  _NotificationScreenState createState() => _NotificationScreenState();
  final String payload;
  NotificationScreen({required this.payload});
}

class _NotificationScreenState extends State<NotificationScreen> {
  String? _payload;
  initState() {
    super.initState();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Get.isDarkMode ? darkGreyClr : Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: TextUtil(
            title: _payload.toString().split('|')[0],
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Get.isDarkMode ? Colors.white : darkGreyClr,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Column(
              children: [
                TextUtil(
                  title: 'hello Besho',
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  color: Get.isDarkMode ? Colors.white : darkGreyClr,
                ),
                const SizedBox(height: 10),
                TextUtil(
                  title: 'i wish a great day',
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Get.isDarkMode ? Colors.grey.withOpacity(0.5) : darkGreyClr,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                margin: EdgeInsets.only(left: 30, right: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: primaryClr,
                ),
                child: ListView(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.text_format, size: 30, color: Colors.white),
                        const SizedBox(width: 30),
                        TextUtil(
                          title: 'Title',
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextUtil(
                      title: _payload.toString().split('|')[0],
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.description, size: 30, color: Colors.white),
                        const SizedBox(width: 30),
                        TextUtil(
                          title: 'Description',
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextUtil(
                      title: _payload.toString().split('|')[1],
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined, size: 30, color: Colors.white),
                        const SizedBox(width: 30),
                        TextUtil(
                          title: 'Date',
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextUtil(
                      title: _payload.toString().split('|')[2],
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
