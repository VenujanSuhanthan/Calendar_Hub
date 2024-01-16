// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:number_to_words_english/number_to_words_english.dart';

void main() async {
  //notification initialization and requesting permission
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedPageIndex = 0;
  Map<int, Event> events = {};
  List<Event> event = [];
  Map<int, Widget> list = {};
  DateTime dt = DateTime(2000, 1, 1);
  bool loggedin = false;
  String log = "";
  MaterialApp m = const MaterialApp();

  Map<String, String> account = {"Venujan": "password"};
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final locController = TextEditingController();
  final userController = TextEditingController();
  final passController = TextEditingController();
  final newuserController = TextEditingController();
  final newpassController = TextEditingController();
  late DateTime d;
  int n = 0;
  String value1 = "None";
  List<String> items1 = [
    "None",
    "Every Day",
    "Every Week",
    "Every Month",
    "Every Year"
  ];
  String value2 = "None";
  List<String> items2 = ["None", "Birthday", "Holiday", "Work", "Fun"];
  void add() {
    //Future addition of recurring Events
    /* int limit = 0;
    int interval = 0;
    switch (value1) {
      case "None":
        {
          limit = 1;
          interval = 0;
        }
      case "Every Day":
        {
          limit = 30;
          interval = 1;
        }
      case "Every Week":
        {
          limit = 10;
          interval = 7;
        }
      case "Every Month":
        {
          limit = 12;
          interval = 30;
        }
      case "Every Year":
        {
          limit = 10;
          interval = 365;
        }
    }

    for (int i = 0; i < limit; i++) {
      int day = dt.day + (i * interval) % 30;
      int month = (dt.month + (i * interval) / 30) as int;
      int year = (dt.year + (month) / 12) as int;
      if (month > 12) {
        month = month % 12;
      }
      DateTime d = DateTime(year, month, day);
      Event x = Event(
          child: Text("${nameController.text}\n${descController.text}"),
          dateTime: CalendarDateTime(
              year: d.year,
              month: d.month,
              day: d.day,
              calendarType: CalendarType.GREGORIAN));
      event.add(x);
      events[n] = x;
      list[n] = userWidget(n);
      n++;
    }*/

    Event x = Event(
        child: Text(
            "${nameController.text}\n${descController.text}\n${locController.text}\n",
            style: const TextStyle(fontSize: 18, color: Colors.black)),
        dateTime: CalendarDateTime(
            year: dt.year,
            month: dt.month,
            day: dt.day,
            calendarType: CalendarType.GREGORIAN));
    event.add(x);
    events[n] = x;
    list[n] = userWidget(n);
    n++;
    setState(() {});
  }

  void remove(int index) {
    event.remove(events[index]);
    events.remove(index);
    list.remove(index);
    setState(() {});
    n--;
  }

  Widget userWidget(int n) {
    DateTime now = DateTime.now();

    return Dismissible(
        direction: DismissDirection.endToStart,
        onDismissed: (DismissDirection direction) {
          remove(n);
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: const Icon(Icons.delete_forever),
        ),
        key: UniqueKey(),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                    child: Text(
                      nameController.text,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                    child: Text(
                      descController.text,
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                    child: Text(
                      "At ${locController.text}",
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                    child: Text(
                      "On ${dt.month}/${dt.day}/${dt.year}",
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                    child: Text(
                      "In ${dt.difference(now).inDays} days & ${dt.difference(now).inHours % 24} hours",
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                child: icon(),
              ),
              const Divider(
                height: 2.0,
                color: Colors.grey,
              ),
              Expanded(
                  child: NoteThumbnail(
                id: n,
                color: const Color.fromARGB(255, 255, 255, 255),
                title: "Event ${NumberToWordsEnglish.convert(n + 1)}",
              )),
            ],
          ),
        ));
  }

  Icon icon() {
    late Icon i;
    switch (value2) {
      case "None":
        {
          i = const Icon(Icons.check_box_outline_blank);
        }
      case "Birthday":
        {
          i = const Icon(Icons.cake);
        }
      case "Holiday":
        {
          i = const Icon(Icons.celebration);
        }
      case "Work":
        {
          i = const Icon(Icons.work);
        }
      case "Fun":
        {
          i = const Icon(Icons.sports_esports);
        }
    }
    return i;
  }

  void change() {
    if (!loggedin) {
      m = MaterialApp(
          title: 'Calendar Hub',
          home: Scaffold(
              appBar: AppBar(
                title: const Text("Calendar Hub"),
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: userController,
                          decoration:
                              const InputDecoration(labelText: 'Username'),
                        ),
                        const SizedBox(height: 16.0),
                        TextField(
                          controller: passController,
                          obscureText: true,
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                        ),
                        const SizedBox(height: 24.0),
                        SizedBox(
                            width: 100,
                            child: ElevatedButton(
                              onPressed: login,
                              child: const Text(
                                'Login',
                                style: TextStyle(height: 1),
                              ),
                            )),
                        SizedBox(
                          width: 500,
                          height: 50,
                          child: Text(
                            log,
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        const SizedBox(
                          height: 24.0,
                          child: Text(
                            "Create New Account",
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        TextField(
                          controller: newuserController,
                          decoration: const InputDecoration(
                              hintText: "Enter New Username"),
                        ),
                        const SizedBox(height: 24.0),
                        TextField(
                          controller: newpassController,
                          decoration: const InputDecoration(
                              hintText: "Enter New Password"),
                        ),
                        const SizedBox(height: 24.0),
                        SizedBox(
                            width: 100,
                            child: ElevatedButton(
                              onPressed: create,
                              child: const Text('Create',
                                  style: TextStyle(height: 1)),
                            )),
                      ],
                    ),
                  ),
                ],
              )));
    } else {
      m = MaterialApp(
        title: 'Calendar Hub',
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Calendar Hub"),
            actions: [
              ElevatedButton(
                onPressed: logout,
                child: const Icon(Icons.logout_rounded),
              )
            ],
          ),
          body: [
            EventCalendar(
              calendarType: CalendarType.GREGORIAN,
              events: event,
              calendarOptions: CalendarOptions(
                  toggleViewType: true,
                  headerMonthBackColor: Colors.lightGreen,
                  headerMonthShadowColor: Colors.greenAccent),
              headerOptions: HeaderOptions(
                  weekDayStringType: WeekDayStringTypes.FULL,
                  monthStringType: MonthStringTypes.FULL,
                  headerTextColor: const Color.fromARGB(255, 255, 255, 255),
                  navigationColor: Colors.white,
                  resetDateColor: Colors.white),
              eventOptions: EventOptions(
                  emptyText: "Empty for Now",
                  emptyIcon: Icons.hourglass_full_outlined,
                  emptyIconColor: Colors.black,
                  emptyTextColor: Colors.black),
              dayOptions: DayOptions(
                  weekDaySelectedColor: Colors.red,
                  selectedBackgroundColor: Colors.red,
                  eventCounterViewType: DayEventCounterViewType.DOT,
                  disableFadeEffect: false),
            ),
            Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(
                                hintText: 'Enter the name of the event',
                                labelText: 'Event Name'),
                          ),
                          TextFormField(
                            controller: descController,
                            decoration: const InputDecoration(
                                fillColor: Color.fromARGB(255, 255, 255, 255),
                                hintText: 'Enter description of the event',
                                labelText: 'Description'),
                          ),
                          TextFormField(
                            controller: locController,
                            decoration: const InputDecoration(
                                fillColor: Color.fromARGB(255, 255, 255, 255),
                                hintText: 'Enter location of the event',
                                labelText: 'Location'),
                          ),
                          Container(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            height: 75,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.date,
                              initialDateTime:
                                  DateTime(dt.year, dt.month, dt.day),
                              onDateTimeChanged: (DateTime newDateTime) {
                                dt = newDateTime;
                              },
                              use24hFormat: false,
                              minuteInterval: 1,
                            ),
                          ),
                          Row(children: [
                            const SizedBox(
                              width: 100,
                            ),
                            DropdownButton(
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                              value: value1,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: items1.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  value1 = newValue!;
                                });
                              },
                            ),
                            const SizedBox(
                              width: 100,
                            ),
                            DropdownButton(
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                              value: value2,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: items2.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  value2 = newValue!;
                                });
                              },
                            )
                          ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    width: 100,
                                    child: ElevatedButton(
                                      onPressed: add,
                                      child: const Text(
                                        'Add',
                                        style: TextStyle(height: 1),
                                      ),
                                    )),
                              ])
                        ]))),
                SizedBox(
                    height: 120,
                    width: 400,
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        scrollDirection: Axis.vertical,
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return list[index];
                        }))
              ],
            ),
          ][selectedPageIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: selectedPageIndex,
            onDestinationSelected: (int index) {
              setState(() {
                selectedPageIndex = index;
              });
            },
            destinations: const <NavigationDestination>[
              NavigationDestination(
                selectedIcon: Icon(Icons.calendar_month_sharp),
                icon: Icon(Icons.calendar_month_outlined),
                label: 'Calendar',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.edit_calendar_sharp),
                icon: Icon(Icons.edit_calendar_outlined),
                label: 'Events',
              ),
            ],
          ),
        ),
      );
    }
  }

  void login() {
    if (account.containsKey(userController.text) &&
        account[userController.text] == passController.text) {
      loggedin = true;
      log = "Succesful login";
      change();
    } else {
      log = "Incorrect Username or Password";
    }
    setState(() {});
  }

  void logout() {
    loggedin = false;
    change();
    setState(() {});
  }

  //New Account Code
  void create() {
    account[newuserController.text] = newpassController.text;
  }

  @override
  Widget build(BuildContext context) {
    change();
    return m;
  }
}

//Reminder Code: Inspiration from https://maneesha-erandi.medium.com/add-a-reminder-to-your-app-with-flutter-local-notifications-dfb2e5120499
class NoteThumbnail extends StatefulWidget {
  final int id;
  final Color color;
  final String title;

  const NoteThumbnail({
    Key? key,
    required this.id,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  _NoteThumbnailState createState() => _NoteThumbnailState();
}

class _NoteThumbnailState extends State<NoteThumbnail> {
  DateTime selectedDate = DateTime.now();
  DateTime fullDate = DateTime.now();

  Future<DateTime> _selectDate(BuildContext context) async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        initialDate: selectedDate,
        lastDate: DateTime(2100));
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate),
      );
      if (time != null) {
        setState(() {
          fullDate = DateTimeField.combine(date, time);
        });
      }
      return DateTimeField.combine(date, time);
    } else {
      return selectedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
              "${fullDate.month}/${fullDate.day}/${fullDate.year} ${fullDate.hour}:${fullDate.minute}:${fullDate.second}"),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text("Add reminder"))
        ],
      ),
    );
  }
}
