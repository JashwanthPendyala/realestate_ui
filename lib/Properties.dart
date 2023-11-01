// import 'package:flutter/material.dart';
// import 'package:newapp/PropertyDetails.dart';
//
// class PropertiesPage extends StatefulWidget {
//   const PropertiesPage({Key? key}) : super(key: key);
//
//   @override
//   State<PropertiesPage> createState() => _PropertiesPageState();
// }

// class _PropertiesPageState extends State<PropertiesPage> {
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: SingleChildScrollView(
//           child: Container(
//             height: screenHeight *1,
//             child: GridView.count(
//               crossAxisCount: 2,
//               children: List.generate(6, (index) {
//                 int cardCount =index+1;
//                 return Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => PropertyDetails(id:index+1)),
//                         );
//                       },
//                       child: Card(
//                         elevation: 5,
//                         child: Column(
//                           children: [
//
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 'Property $cardCount',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newapp/PropertyDetails.dart';
class PropertiesPage extends StatefulWidget {
  @override
  _PropertiesPageState createState() => _PropertiesPageState();
}

class _PropertiesPageState extends State<PropertiesPage> {
  List properties = []; // This will hold the response from the API

  Future<void> fetchData() async {
    var url = Uri.parse('http://192.168.6.137:8080/property/getAllPropertyDetails'); // Replace with your actual API endpoint

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        // API call was successful
        List data = json.decode(response.body);
        setState(() {
          properties = data;
        });
      } else {
        // API call failed
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred during the API call
      print('Error: $e');
    }
  }
  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Container(
            height: screenHeight * 1,
            child: GridView.builder(
              itemCount: properties.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        // Navigate to PropertyDetails page with the property ID
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PropertyDetails(
                              id: properties[index]['id'],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 5,
                        child: Column(
                          children: [
                            // Use an image widget here
                            // Replace the placeholder image with your own logic
                            Image.asset(
                              "assets/images/man.png",
                              fit: BoxFit.contain,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                properties[index]['type'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}



