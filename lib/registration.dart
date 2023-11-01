import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
class RegisterPage extends StatefulWidget {
  const RegisterPage();

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final aadharFormatter = FilteringTextInputFormatter.digitsOnly;

  final nameController = TextEditingController();
  final panController = TextEditingController();
  final aadharController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordControlller = TextEditingController();
  Future<void> _submitForm() async {
    print(_formKey.currentState!.validate());
    if (_formKey.currentState!.validate()) {
      // Access the data using the controllers
      final name = nameController.text;
      final pan = panController.text;
      final aadhar = aadharController.text;
      final email = emailController.text;
      final mobile = mobileController.text;
      final password = passwordControlller.text;
      // TODO: Replace the URL with your API endpoint
      print("Entered");
      var url = Uri.parse('http://192.168.6.137:8080/customerRegistration/create');
      var response = await http.post(
        url,
        body: jsonEncode({
          'applicantName': name,
          'panDetails': pan,
          'aadharDetails': aadhar,
          'email': email,
          'mobileNumber': mobile,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      print(response.statusCode);
      if (response.statusCode == 201) {
        // API call was successful
        var jsonResponse = jsonDecode(response.body);
        // Handle the response here
        print('API Response: $jsonResponse');
        print( response.statusCode);
      } else {
        // API call failed
        print('Request failed with status: ${response.statusCode}.');
      }
    }
  }
  InputDecoration buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(25.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(25.0),
      ),
    );
  }

  TextFormField buildTextFormField(String label, List<TextInputFormatter> inputFormatters, TextInputType keyboardType, String? Function(String?)? validator, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: buildInputDecoration(label),
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page',style: TextStyle(color: Colors.black87),),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Colors.grey, // Set the primary color to gray
                Colors.white, // Set the secondary color to white
              ],
              begin: Alignment.center,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildTextFormField(
                  'Name of the Applicant(s)',
                  [],
                  TextInputType.text,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name';
                    }
                    return null;
                  },
                  nameController,
                ),
                SizedBox(height: 16),
                buildTextFormField(
                  'PAN details',
                  [],
                  TextInputType.text,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter PAN details';
                    }
                    return null;
                  },
                  panController,
                ),
                SizedBox(height: 16),
                buildTextFormField(
                  'Aadhar details with Mask',
                  [LengthLimitingTextInputFormatter(14), aadharFormatter, AadharMaskFormatter()],
                  TextInputType.number,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Aadhar details';
                    }
                    return null;
                  },
                  aadharController,
                ),
                SizedBox(height: 16),
                buildTextFormField(
                  'Email',
                  [],
                  TextInputType.emailAddress,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  emailController,
                ),
                SizedBox(height: 16),
                buildTextFormField(
                  'Mobile Number(s)',
                  [],
                  TextInputType.phone,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a mobile number';
                    }
                    return null;
                  },
                  mobileController,
                ), SizedBox(height: 16),
                buildTextFormField(
                  'Password',
                  [],
                  TextInputType.visiblePassword,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  passwordControlller,
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Access the data using the controllers
                        print('Name: ${nameController.text}');
                        print('PAN: ${panController.text}');
                        print('Aadhar: ${aadharController.text}');
                        print('Email: ${emailController.text}');
                        print('Mobile: ${mobileController.text}');
                        print('Password: ${passwordControlller.text}');
                        // Call your API here
                        _submitForm();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text('Submit'),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(10, 0),
                      primary: Colors.grey, // Background color
                      onPrimary: Colors.white, // Text color
                      elevation: 4,
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

class AadharMaskFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;

    if (newText.length == 5 || newText.length == 10) {
      newText += ' ';
    }
    return newValue.copyWith(text: newText);
  }
}