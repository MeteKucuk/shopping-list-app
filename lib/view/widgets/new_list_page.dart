import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';
import '../../service/firebase_dataservice/create_list.dart';
import '../../utils/constant.dart';
import '../addproduct.dart';
import '../navigatescreen.dart';

class NewListPage extends StatefulWidget {
  const NewListPage({Key? key}) : super(key: key);

  @override
  _NewListPageState createState() => _NewListPageState();
}

class _NewListPageState extends State<NewListPage> {
  TextStyle textStyle =
      TextStyle(color: Colors.grey[800], fontSize: 18, fontFamily: 'Gilroy');
  final DatePickerController _controller = DatePickerController();
  final _formKey = GlobalKey<FormState>();
  final HomeController homeController = Get.find<HomeController>();

  final TextEditingController _listNameController = TextEditingController();
  DateTime _selectedValue = DateTime.now();

  @override
  Widget build(BuildContext context) {
    double padding = MediaQuery.of(context).size.width * 0.05;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(double.parse(padding.toString())),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          NavigateScreen.navigationController.jumpToTab(0);

                          NavigateScreen.navigationController.index = 0;
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Shopping  List ',
                    style: kStyleText,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('New List', style: textStyle),
                      TextFormField(
                        controller: _listNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration:
                            const InputDecoration(hintText: 'List Name'),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Set to Date',
                        style: textStyle,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DatePicker(
                        DateTime.now(),
                        width: 60,
                        height: 80,
                        controller: _controller,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: Colors.black,
                        selectedTextColor: Colors.white,
                        onDateChange: (date) {
                          // New date selected

                          setState(() {
                            _selectedValue = date;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Add Shopping Friend', style: textStyle),
                      Form(
                          child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Search friends registered gmail',
                            suffixIcon: Icon(Icons.people_alt_sharp)),
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await CreateList()
                          .createList(_listNameController.text, _selectedValue);

                      homeController.listNameChanged(_listNameController.text);
                      NavigateScreen.navigationController.jumpToTab(1);

                      NavigateScreen.navigationController.index = 1;
                      Get.to(() => const AddProduct());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF7066),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                          child: Text(
                        'Create List',
                        style: kStyleButton,
                      )),
                      height: 70,
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
