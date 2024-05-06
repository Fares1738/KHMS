// ignore_for_file: file_names, library_private_types_in_public_api, avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:khms/Controller/checkInController.dart';
import 'package:khms/View/Common/appBar.dart';
import 'package:file_picker/file_picker.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  _CheckInPageState createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  final CheckInController _controller = CheckInController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passportController = TextEditingController();
  final _checkInDateController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _nationalityController = TextEditingController();
  final _doBController = TextEditingController();
  final _iCController = TextEditingController();
  final _matricController = TextEditingController();

  File? _frontMatricPic;
  File? _backMatricPic;
  File? _passportMyKadPic;

  Future<void> _pickFile(int buttonIndex) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);

      setState(() {
        if (buttonIndex == 1) {
          _frontMatricPic = file;
        } else if (buttonIndex == 2) {
          _backMatricPic = file;
        } else if (buttonIndex == 3) {
          _passportMyKadPic = file;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(30)
                  .add(const EdgeInsets.only(bottom: 100)),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Check In",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                        labelText: "First Name",
                        prefixIcon: Icon(Icons.person)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                        labelText: "Last Name", prefixIcon: Icon(Icons.person)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _passportController,
                    decoration: const InputDecoration(
                        labelText: "Passport/MyKad No.",
                        prefixIcon: Icon(Icons.document_scanner)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _checkInDateController,
                    decoration: const InputDecoration(
                        labelText: "Check In Date",
                        prefixIcon: Icon(Icons.calendar_today)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _phoneNoController,
                    decoration: const InputDecoration(
                        labelText: "Phone No.", prefixIcon: Icon(Icons.phone)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _nationalityController,
                    decoration: const InputDecoration(
                        labelText: "Nationality", prefixIcon: Icon(Icons.flag)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _doBController,
                    decoration: const InputDecoration(
                        labelText: "Date of Birth",
                        prefixIcon: Icon(Icons.calendar_today)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _iCController,
                    decoration: const InputDecoration(
                        labelText: "UTM I/C No.",
                        prefixIcon: Icon(Icons.document_scanner)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _matricController,
                    decoration: const InputDecoration(
                        labelText: "Matric Number",
                        prefixIcon: Icon(Icons.numbers)),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    // Add the row for buttons
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center the buttons
                    children: [
                      _buildUploadButton("Upload Front Matric Card", 1),
                      _buildUploadButton("Upload Back Matric Card", 2),
                    ],
                  ),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center the buttons
                    children: [
                      if (_frontMatricPic != null)
                        Image.file(_frontMatricPic!, height: 250),
                      const SizedBox(width: 10),
                      if (_backMatricPic != null)
                        Image.file(_backMatricPic!, height: 250),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildUploadButton("Upload Passport/MyKad", 3),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_passportMyKadPic != null)
                        Image.file(_passportMyKadPic!, height: 300),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Button
                  ElevatedButton(
                    onPressed: () {
                      _controller.submitCheckInApplication(
                        context,
                        _firstNameController.text,
                        _lastNameController.text,
                        _passportController.text,
                        _checkInDateController.text,
                        _phoneNoController.text,
                        _nationalityController.text,
                        _matricController.text,
                        _iCController.text,
                        _doBController.text,
                        _frontMatricPic,
                        _backMatricPic,
                        _passportMyKadPic,
                      );
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadButton(String label, int buttonIndex) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10), // Spacing between buttons
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 85,
          child: TextButton(
            onPressed: () => _pickFile(buttonIndex),
            child: Text(
              label,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passportController.dispose();
    _checkInDateController.dispose();
    _phoneNoController.dispose();
    _nationalityController.dispose();
    _doBController.dispose();
    _iCController.dispose();
    _matricController.dispose();
    super.dispose();
  }
}