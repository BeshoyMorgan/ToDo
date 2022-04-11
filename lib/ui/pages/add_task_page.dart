import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import 'package:todo/controlers/task_controller.dart';
import '../theme.dart';
import '../widgets/text_util.dart';
import '../widgets/input_field.dart';
import '../widgets/button.dart';
import 'package:todo/model/task.dart';

class AddTask extends StatefulWidget {
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm a').format(DateTime.now().add(const Duration(minutes: 15))).toString();

  int _selectedRemined = 5;
  List<int> reminedList = [
    5,
    10,
    15,
    20
  ];

  String _selectedRepaeat = 'none';
  List<String> repeatList = [
    'none',
    'daily',
    'weekly',
    'monthly'
  ];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextUtil(
                  title: 'Add Task',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
                MyInputField(
                  title: 'Title',
                  hint: 'Enter title here',
                  controller: _titleController,
                ),
                MyInputField(
                  title: 'Note',
                  hint: 'Enter title here',
                  controller: _noteController,
                ),
                MyInputField(
                  title: 'Date',
                  hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                    onPressed: () => getData(),
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyInputField(
                        title: 'Start Date',
                        hint: _startTime,
                        widget: IconButton(
                          onPressed: () => getTime(isStartTime: true),
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: MyInputField(
                        title: 'End Date',
                        hint: _endTime,
                        widget: IconButton(
                          onPressed: () => getTime(isStartTime: false),
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                MyInputField(
                  title: 'Remined',
                  hint: '$_selectedRemined minutes early',
                  widget: Row(
                    children: [
                      DropdownButton(
                        dropdownColor: Colors.blueGrey,
                        items: reminedList
                            .map((val) => DropdownMenuItem(
                                  value: val,
                                  child: Text('$val minutes early',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      )),
                                ))
                            .toList(),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 4,
                        underline: Container(height: 0),
                        onChanged: (int? newVal) {
                          setState(() {
                            _selectedRemined = newVal!;
                          });
                        },
                      ),
                      const SizedBox(height: 7),
                    ],
                  ),
                ),
                MyInputField(
                  title: 'Repeat',
                  hint: '$_selectedRepaeat',
                  widget: Row(
                    children: [
                      DropdownButton(
                        dropdownColor: Colors.blueGrey,
                        items: repeatList
                            .map((val) => DropdownMenuItem(
                                  value: val,
                                  child: Text('$val',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      )),
                                ))
                            .toList(),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 4,
                        underline: Container(height: 0),
                        onChanged: (String? newVal) {
                          setState(() {
                            _selectedRepaeat = newVal!;
                          });
                        },
                      ),
                      const SizedBox(height: 7),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _column(),
                    MyButton(
                      text: 'Create Task',
                      onTap: () {
                        _vaidateDate();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Custom AppBar
  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(Icons.arrow_back_ios),
      ),
      elevation: 0,
      backgroundColor: Get.isDarkMode ? darkGreyClr : context.theme.backgroundColor,
      actions: [
        Icon(Icons.account_circle_rounded, size: 24, color: Get.isDarkMode ? Colors.white : darkGreyClr),
        const SizedBox(width: 20),
      ],
    );
  }

  Column _column() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextUtil(
          title: 'Color',
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Get.isDarkMode ? Colors.white : darkGreyClr,
        ),
        const SizedBox(height: 8),
        Wrap(
          children: [
            ...List<Widget>.generate(
              3,
              (index) => InkWell(
                onTap: () {
                  setState(() {
                    _selectedColor = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    child: _selectedColor == index
                        ? Icon(
                            Icons.done,
                            size: 16,
                            color: Colors.white,
                          )
                        : null,
                    backgroundColor: index == 0
                        ? primaryClr
                        : index == 1
                            ? pinkClr
                            : orangeClr,
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  _vaidateDate() {
    if (!_titleController.text.isEmpty && !_noteController.text.isEmpty) {
      addTaskToDB();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        'Required',
        'ALL FIELDS ARE REQUIRED',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: pinkClr,
        icon: Icon(Icons.warning_amber_rounded, color: Colors.red),
      );
    }
  }

  addTaskToDB() async {
    int value = await _taskController.addTask(
      task: Task(
        title: _titleController.text,
        note: _noteController.text,
        isCompleted: 0,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        color: _selectedColor,
        remind: _selectedRemined,
        repeat: _selectedRepaeat,
      ),
    );
  }

  getData() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null)
      setState(() => _selectedDate = pickedDate);
    else
      print('null');
  }

  getTime({required bool isStartTime}) async {
    TimeOfDay? pickedtime = await showTimePicker(
      context: context,
      initialTime: isStartTime ? TimeOfDay.fromDateTime(DateTime.now()) : TimeOfDay.fromDateTime(DateTime.now().add((const Duration(minutes: 15)))),
    );
    if (isStartTime) {
      if (pickedtime != null) setState(() => _startTime = pickedtime.format(context));
    } else if (!isStartTime) {
      if (pickedtime != null) setState(() => _endTime = pickedtime.format(context));
    } else
      print('null or somerthing eror');
  }
}
