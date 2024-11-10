import 'package:dentalscanpro/view_models/controller/reminder/reminder_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dentalscanpro/model/reminder.dart';
import 'package:intl/intl.dart';

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final TextEditingController _customReminderController = TextEditingController();
  final ReminderController _reminderController = Get.put(ReminderController()); // Pass user ID
  bool isSelectionMode = false; // Track selection mode
  Set<String> selectedReminderIds = {}; // Set of selected reminder IDs

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Reminders',
        style: TextStyle(fontWeight: FontWeight.bold),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, 
                color: const Color.fromARGB(255, 0, 0, 0), 
                size: 28), // Customize icon color and size
          onPressed: () {
            Get.back(); // Go back to the previous screen
          },
        ),
        actions: [
          if (isSelectionMode)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                if (selectedReminderIds.isNotEmpty) {
                  // Delete the selected reminders
                  _deleteSelectedReminders();
                }
              },
            ),
          IconButton(
            icon: Icon(isSelectionMode ? Icons.cancel : Icons.delete),
            onPressed: () {
              setState(() {
                isSelectionMode = !isSelectionMode;
                selectedReminderIds.clear(); // Clear selection when exiting selection mode
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: _reminderController.reminders.length,
                  itemBuilder: (context, index) {
                    var reminder = _reminderController.reminders[index];
                    bool isSelected = selectedReminderIds.contains(reminder.id);

                    return ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Card(
                        elevation: 1,
                        color: Colors.blue[50],
                        child: ListTile(
                          title: Text(reminder.title),
                          subtitle: Text('Time: ${DateFormat('d-MMM-y h:mm a').format(reminder.time)}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Edit Reminder Button
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _showEditReminderDialog(context, reminder);
                                },
                              ),
                              // Enable/Disable Switch
                              Switch(
                                activeColor: Colors.white,
                                activeTrackColor: Colors.lightBlue[200],
                                inactiveTrackColor: Colors.white,
                                inactiveThumbColor: Colors.lightBlue[200],
                                trackOutlineColor: MaterialStateColor.resolveWith((states) => Colors.lightBlue[200]!),
                                value: reminder.isEnabled,
                                onChanged: (bool value) {
                                  // Update reminder's isEnabled state
                                  _reminderController.updateReminder(
                                      reminder.copyWith(isEnabled: value));
                                },
                              ),
                            ],
                          ),
                          // Handle tap for selection
                          onTap: () {
                            if (isSelectionMode) {
                              setState(() {
                                if (isSelected) {
                                  selectedReminderIds.remove(reminder.id!);
                                } else {
                                  selectedReminderIds.add(reminder.id!);
                                }
                              });
                            }
                          },
                          // Highlight selected reminders
                          tileColor: isSelected ? Colors.lightBlue[300] : null,
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            const SizedBox(height: 20),
            // Add Custom Reminder Button
            ElevatedButton(
              onPressed: () {
                _showCustomReminderDialog(context);
              },
              child: const Text('Add Reminder'),
            ),
          ],
        ),
      ),
    );
  }


  // Delete selected reminders
  void _deleteSelectedReminders() async {
    for (String reminderId in selectedReminderIds) {
      await _reminderController.deleteReminder(reminderId);
    }

    setState(() {
      isSelectionMode = false;
      selectedReminderIds.clear();
    });

    Get.snackbar('Success', 'Selected reminders deleted successfully.');
  }

// Function to show a dialog for editing a reminder
void _showEditReminderDialog(BuildContext context, Reminder reminder) {
  DateTime selectedDateTime = reminder.time; // Default to current reminder's time
  List<String> prebuiltReminders = ['Brush Teeth', 'Mouthwash Reminder', 'Doctor Appointment', 'Custom'];
  String selectedReminderTitle = reminder.title;
  bool isCustomSelected = prebuiltReminders.contains(reminder.title) ? false : true; // Check if current title is custom

  TextEditingController titleController = TextEditingController(
    text: isCustomSelected ? reminder.title : '', // Set the text only if it's a custom reminder
  );

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder( // Use StatefulBuilder to manage dialog's state
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Edit Reminder'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Dropdown for prebuilt reminder names including "Custom"
                DropdownButton<String>(
                  value: isCustomSelected ? 'Custom' : selectedReminderTitle,
                  items: prebuiltReminders.map((String reminder) {
                    return DropdownMenuItem<String>(
                      value: reminder,
                      child: Text(reminder),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedReminderTitle = newValue ?? prebuiltReminders[0];
                      isCustomSelected = selectedReminderTitle == 'Custom'; // Enable custom input if "Custom" is selected
                    });
                  },
                ),
                const SizedBox(height: 10),
                // Enable custom reminder input only if "Custom" is selected
                if (isCustomSelected)
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Custom Reminder Name'),
                  ),
                const SizedBox(height: 10),
                // DateTime Picker Button (Combined Date & Time)
                ElevatedButton(
                  onPressed: () async {
                    // First show Date Picker
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDateTime,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      // Then show Time Picker
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          selectedDateTime = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                        });
                      }
                    }
                  },
                  child: Text('Select Date & Time: ${DateFormat('yMMMd h:mm a').format(selectedDateTime)}'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // Determine reminder title based on user input
                  String reminderTitle = isCustomSelected && titleController.text.isNotEmpty
                      ? titleController.text
                      : selectedReminderTitle;

                  // Update the reminder with selected title and datetime
                  var updatedReminder = reminder.copyWith(
                    title: reminderTitle,
                    time: selectedDateTime,
                  );
                  _reminderController.updateReminder(updatedReminder);

                  titleController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog without saving
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      );
    },
  );
}

// Function to show custom reminder dialog
void _showCustomReminderDialog(BuildContext context) {
  DateTime selectedDateTime = DateTime.now(); // Default to current date and time
  List<String> prebuiltReminders = ['Brush Teeth', 'Mouthwash Reminder', 'Doctor Appointment', 'Custom'];
  String selectedReminderTitle = prebuiltReminders[0]; 
  bool isCustomSelected = false;  

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder( // Use StatefulBuilder to manage dialog's state
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Add Reminder'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Dropdown for prebuilt reminder names including "Custom"
                DropdownButton<String>(
                  value: selectedReminderTitle,
                  items: prebuiltReminders.map((String reminder) {
                    return DropdownMenuItem<String>(
                      value: reminder,
                      child: Text(reminder),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedReminderTitle = newValue ?? prebuiltReminders[0];
                      isCustomSelected = selectedReminderTitle == 'Custom'; // Enable custom input if "Custom" is selected
                    });
                  },
                ),
                const SizedBox(height: 10),
                // Enable custom reminder input only if "Custom" is selected
                if (isCustomSelected)
                  TextField(
                    controller: _customReminderController,
                    decoration: const InputDecoration(labelText: 'Custom Reminder Name'),
                  ),
                const SizedBox(height: 10),
                // DateTime Picker Button (Combined Date & Time)
                ElevatedButton(
                  onPressed: () async {
                    // First show Date Picker
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDateTime,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      // Then show Time Picker
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          selectedDateTime = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                        });
                      }
                    }
                  },
                  child: Text('Select Date & Time: ${DateFormat('yMMMd h:mm a').format(selectedDateTime)}'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // Determine reminder title based on user input
                  String reminderTitle = isCustomSelected && _customReminderController.text.isNotEmpty
                      ? _customReminderController.text
                      : selectedReminderTitle;

                  // Add the reminder with selected title and datetime
                  var newReminder = Reminder(
                    title: reminderTitle,
                    time: selectedDateTime,
                  );
                  _reminderController.addReminder(newReminder);

                  _customReminderController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          );
        },
      );
    },
  );
}

// Function to let the user pick a date and time
Future<DateTime?> _selectDateTime(BuildContext context) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2101),
  );

  if (selectedDate != null) {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      return DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
    }
  }
  return null;
}
}
