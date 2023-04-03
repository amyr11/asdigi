import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class AddChild extends StatefulWidget {
  const AddChild({super.key});

  @override
  State<AddChild> createState() => _AddChildState();
}

class _AddChildState extends State<AddChild> {
  TextEditingController date = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select an option'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextButton(
                  child: Text("Use Camera"),
                  onPressed: () async {
                    final pickedFile =
                        await _picker.pickImage(source: ImageSource.camera);
                    setState(() {
                      _image = File(pickedFile!.path);
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
                      _image = File(pickedFile!.path);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Child",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(children: [
              Container(
                  height: 150,
                  width: 150,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: _image == null
                      ? Image.network(
                          "https://childmind.org/wp-content/uploads/2021/07/our-impact-header-half-r.jpg",
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          _image!,
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
                  decoration: const InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                    labelText: "Name",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: date,
                  decoration: InputDecoration(
                    helperText: 'MM/DD/YYYY',
                    isDense: true,
                    border: const OutlineInputBorder(),
                    labelText: "Birth Date",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_month_sharp),
                      tooltip: 'Date',
                      onPressed: () async {
                        DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));

                        if (selectedDate != null) {
                          setState(() {
                            date.text =
                                DateFormat('MM/dd/yyyy').format(selectedDate);
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            FilledButton(
              onPressed: () => {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
