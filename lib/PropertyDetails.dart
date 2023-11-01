import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PropertyDetails extends StatefulWidget {
  final int id;

  const PropertyDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<PropertyDetails> createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  Map<String, dynamic>? propertyData;
  @override
  void initState() {
    super.initState();
    print("init fetch api call");
    fetchPropertyData(widget.id).then((value) {
      setState(() {
        propertyData = value;
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }

  Future<Map<String, dynamic>> fetchPropertyData(id) async {
   int id = widget.id;
    final response = await http.get(Uri.parse('http://192.168.6.137:8080/property/getPropertyDetailsById?id=+$id'));
   print(response.body);
   print(response.statusCode);
    if (response.statusCode == 200) {

      return json.decode(response.body);
    } else {
      throw Exception('Failed to load property');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Properties'),
      ),
      body: propertyData != null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Unit Number: ${propertyData!["unitNumber"]}'),
            Text('Category: ${propertyData!["category"]}'),
            Text('Carpet Area: ${propertyData!["carpetArea"]}'),
            Text('Facing: ${propertyData!["facing"]}'),
            Text('Type: ${propertyData!["type"]}'),
            Text('No Of Car Parking: ${propertyData!["noOfCarParking"]}'),
            Text('Unit Price: ${propertyData!["unitPrice"]}'),
            Text('Car Parking: ${propertyData!["carParking"]}'),
            // Add more Text widgets for other fields as needed
          ],
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
