import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../widgets/button.dart';
import '../widgets/text_util.dart';
import '../widgets/task_tile.dart';

import '../size_config.dart';
import '../theme.dart';
import 'add_task_page.dart';
import '../../controlers/task_controller.dart';
import '../../model/task.dart';
import '../../services/notification_service.dart';
import '../../services/theme_service.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotifyHelper notifyHelper;
  @override
  initState() {
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    _taskController.getTasks();
    super.initState();
  }

  final TaskController _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Get.isDarkMode ? darkGreyClr : Colors.white,
        appBar: _appBar(),
        body: Column(
          children: [
            _addTaskBar(),
            _addDateBar(),
            const SizedBox(height: 8),
            _showTasks(),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          ThemeSurvace().switchTheme();
        },
        icon: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
          size: 24,
          color: Get.isDarkMode ? Colors.white : darkGreyClr,
        ),
      ),
      elevation: 0,
      backgroundColor: Get.isDarkMode ? darkGreyClr : context.theme.backgroundColor,
      actions: [
        IconButton(
          icon: Icon(
            Icons.cleaning_services_outlined,
            size: 24,
            color: Get.isDarkMode ? Colors.white : darkGreyClr,
          ),
          onPressed: () {
            _taskController.deleteAllTask();
            NotifyHelper().cancelAllNotification();
          },
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Icon(Icons.account_circle_rounded, size: 24, color: Get.isDarkMode ? Colors.white : darkGreyClr),
        ),
      ],
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 10,
        top: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextUtil(
                title: 'sep',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Get.isDarkMode ? Colors.white : darkGreyClr,
              ),
              TextUtil(
                title: DateFormat.yMMMMd().format(DateTime.now()),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Get.isDarkMode ? Colors.white : darkGreyClr,
              ),
            ],
          ),
          MyButton(
            text: '+ Add Task',
            onTap: () async {
              await Get.to(() => AddTask());
            },
          ),
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 6, left: 20),
      child: DatePicker(
        _selectedDate,
        initialSelectedDate: _selectedDate,
        width: 70,
        height: 100,
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dayTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        monthTextStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        dateTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        onDateChange: (newDate) {
          setState(() {
            _selectedDate = newDate;
          });
        },
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(() {
        if (TaskController().taskList.isEmpty) {
          return _noTaskMsg();
        } else {
          return RefreshIndicator(
            onRefresh: refresh,
            child: ListView.builder(
                scrollDirection: SizeConfig.orientation == Orientation.landscape ? Axis.horizontal : Axis.vertical,
                itemCount: _taskController.taskList.length,
                itemBuilder: (BuildContext context, int index) {
                  var task = _taskController.taskList[index];

                  if (task.repeat == 'daily' || task.date == DateFormat.yMd().format(_selectedDate) || (task.repeat == 'weekly' && _selectedDate.difference(DateFormat.yMd().parse(task.date!)).inDays % 7 == 0) || (task.repeat == 'monthly' && _selectedDate.day == DateFormat.yMd().parse(task.date!).day)) {
                    var hour = task.startTime.toString().split(':')[0];
                    var min = task.startTime.toString().split(':')[1];
                    NotifyHelper().scheduledNotification(int.parse(hour), int.parse(min), task);

                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 1200),
                      child: SlideAnimation(
                        horizontalOffset: 300,
                        child: FadeInAnimation(
                          child: Expanded(
                            child: InkWell(
                              onTap: () {
                                showBottomSheet(context, task);
                              },
                              child: TaskTile(task),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return _noTaskMsg();
                  }
                }),
          );
        }
      }),
    );
  }

  _noTaskMsg() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: refresh,
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SizeConfig.orientation == Orientation.landscape ? const SizedBox(height: 5) : const SizedBox(height: 120),
                SvgPicture.asset(
                  'images/task.svg',
                  color: primaryClr.withOpacity(0.6),
                  height: 90,
                  semanticsLabel: 'Taask',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Text("You do not have any tasks yet \n add new tasks to make tour day productive",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode ? Colors.white : darkGreyClr,
                      ),
                      textAlign: TextAlign.center),
                ),
                SizeConfig.orientation == Orientation.landscape ? const SizedBox(height: 120) : const SizedBox(height: 180),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buidBottomSheet({required String label, required Function() onTap, required Color clr, bool isClose = false}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            width: 2,
            color: isClose
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : clr,
          ),
          color: isClose ? Colors.transparent : clr,
        ),
      ),
    );
  }

  showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Column(
          children: [
            Flexible(
              child: Container(
                width: 120,
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
                ),
              ),
            ),
            const SizedBox(height: 20),
            task.isCompleted == 1
                ? Container()
                : _buidBottomSheet(
                    label: 'Task Completed',
                    clr: primaryClr,
                    onTap: () {
                      _taskController.makeTaskComplete(task.id!);
                      NotifyHelper().cancelNotification(task);
                      Get.back();
                    }),
            _buidBottomSheet(
                label: 'Delete Task',
                clr: primaryClr,
                onTap: () {
                  _taskController.deleteTask(task);
                  NotifyHelper().cancelNotification(task);

                  Get.back();
                }),
            Divider(color: Get.isDarkMode ? Colors.grey : darkGreyClr),
            _buidBottomSheet(
                label: 'Cancel',
                clr: primaryClr,
                onTap: () {
                  Get.back();
                }),
            const SizedBox(height: 20),
          ],
        ),
      ),
      //),
    );
  }

  Future<void> refresh() async {
    _taskController.getTasks();
  }
}
