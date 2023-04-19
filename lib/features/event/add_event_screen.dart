// a widget to add event with date, time, title and content

import 'package:flutter/material.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Create new task',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text Field to enter Task title
                TextFormField(
                  controller: taskNameController,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.task, color: Colors.indigoAccent),
                    hintText: 'Enter task',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[300],
                    ),

                    // give circular border
                    contentPadding: const EdgeInsets.all(20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                // Text Field to enter Task time
                TextFormField(
                  controller: taskTimeController,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_clock,
                        color: Colors.indigoAccent),
                    hintText: 'Enter Time',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[300],
                    ),

                    // give circular border
                    contentPadding: const EdgeInsets.all(20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                // To Pick the date from the calender
                ElevatedButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2024),
                    );
                  },
                  child: const Text(
                    'Pick Date',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),

                // Button to add the event to the hive local db
                ElevatedButton(
                  onPressed: () {
                    // add the event to the hive local db
                  },
                  child: const Text(
                    'Add Event',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
