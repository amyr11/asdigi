import 'package:asdigi/helpers/storage_services.dart';
import 'package:asdigi/models/milestone.dart';
import 'package:asdigi/screens/answer_milestones_checklist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import '../helpers/auth_services.dart';
import '../models/child.dart';

class AddChild extends StatefulWidget {
  const AddChild({super.key});

  @override
  State<AddChild> createState() => _AddChildState();
}

class _AddChildState extends State<AddChild> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? childImage;
  String? childName;
  DateTime? childBirthdate;
  String? nameErrorText;
  String? dateErrorText;

  void goToAnswerChecklist(BuildContext context,
      {required List<MilestoneChecklistItem> checklist,
      required void Function() onSubmit}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnswerMilestoneChecklistPage(
          allMilestones: checklist,
          onSubmit: onSubmit,
        ),
      ),
    );
  }

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Select an option',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextButton(
                  child: Text("Use Camera"),
                  onPressed: () async {
                    final pickedFile =
                        await _picker.pickImage(source: ImageSource.camera);
                    setState(() {
                      childImage = File(pickedFile!.path);
                    });
                    Navigator.of(context).pop();
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                TextButton(
                  child: Text('Use gallery'),
                  onPressed: () async {
                    final pickedFile =
                        await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      childImage = File(pickedFile!.path);
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool validateFields() {
    bool validName = validateName();
    bool validDate = validateDate();
    return validName && validDate;
  }

  bool validateName() {
    bool isValid = true;

    setState(() {
      nameErrorText = null;
    });

    if (childName == null) {
      setState(() {
        nameErrorText = 'Name cannot be empty';
      });
      isValid = false;
    }

    return isValid;
  }

  bool validateDate() {
    bool isValid = true;

    setState(() {
      dateErrorText = null;
    });

    if (dateController.text.isNotEmpty) {
      try {
        childBirthdate = DateFormat('MM/dd/yyyy').parse(dateController.text);
      } catch (e) {
        dateErrorText = 'Invalid date';
      }
    } else {
      dateErrorText = 'Date cannot be empty';
    }

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height -
                (MediaQuery.of(context).padding.top +
                    appBar.preferredSize.height),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Add Child',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Kindly add your child\'s details for us to better understand their needs.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Stack(children: [
                      Container(
                          height: 150,
                          width: 150,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: childImage == null
                              ? Image.network(
                                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  childImage!,
                                  fit: BoxFit.cover,
                                )),
                      Padding(
                        padding: const EdgeInsets.only(top: 100, left: 100),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                              )
                            ],
                            shape: BoxShape.circle,
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: IconButton(
                            onPressed: () => {_showDialog()},
                            icon: const Icon(Icons.camera_alt),
                          ),
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 40,
                    ),
                    Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          onEditingComplete: () => validateName(),
                          onChanged: (value) {
                            setState(() {
                              childName = value;
                            });
                          },
                          decoration: InputDecoration(
                            errorText: nameErrorText,
                            isDense: true,
                            border: const OutlineInputBorder(),
                            labelText: "Name",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: dateController,
                          onEditingComplete: () => validateDate(),
                          decoration: InputDecoration(
                            errorText: dateErrorText,
                            helperText: 'MM/DD/YYYY',
                            isDense: true,
                            border: const OutlineInputBorder(),
                            labelText: "Birth Date",
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_month_sharp),
                              tooltip: 'Date',
                              onPressed: () async {
                                await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                ).then(
                                  (value) {
                                    if (value != null) {
                                      setState(() {
                                        dateController.text =
                                            DateFormat('MM/dd/yyyy')
                                                .format(value);
                                        childBirthdate = value;
                                      });
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () async {
                            bool isValid = validateFields();
                            if (isValid) {
                              Child newChild = Child(
                                name: childName!,
                                birthDate: childBirthdate!,
                              );
                              List<MilestoneChecklistItem> checklist =
                                  await MilestoneChecklistItem
                                      .getChecklistForAge(
                                Child.getNearestAge(
                                  age: newChild.ageInMonths,
                                  availableAges: await MilestoneOverviewItem
                                      .getUniqueAges(),
                                ),
                              );
                              goToAnswerChecklist(
                                context,
                                checklist: checklist,
                                onSubmit: () async {
                                  DocumentReference<Map<String, dynamic>>
                                      childDocRef =
                                      await Child.uploadToFirestore(
                                    name: newChild.name,
                                    birthDate: newChild.birthDate,
                                    image: childImage,
                                  );
                                  await MilestoneChecklistItem
                                      .uploadToFireStore(
                                    childID: childDocRef.id,
                                    checklist: checklist,
                                  );
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              );
                            }
                          },
                          child: Row(
                            children: const [
                              Text("Next: Milestone Checklist"),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.arrow_forward_ios, size: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
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
}
