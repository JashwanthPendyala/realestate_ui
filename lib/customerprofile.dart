import 'package:flutter/cupertino.dart';

class CustomerProfilePage extends StatefulWidget {
  const CustomerProfilePage({super.key});

  @override
  State<CustomerProfilePage> createState() => _CustomerProfilePage();
}

class _CustomerProfilePage extends State<CustomerProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset("assets/images/build1.png"),
    );
  }
}
