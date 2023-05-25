import 'package:flutter/material.dart';
import 'package:waist_app/screens/mishtari/mistari_page_form.dart';

import '../../widgets/arrowButton.dart';
import '../contactUs.dart';

class NewOrder extends StatefulWidget {
  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration:const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            'assets/background.png',
          ),
        ),
      ),
      child: Column(
        children: [
        const  SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            const  SizedBox(
                width: 30,
              ),
           const   Text(
                'طلب جديد',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ArrowButton()
            ],
          ),
        const  SizedBox(
            height: 80,
          ),
          Row(
            children: [
              Expanded(
                  child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MistariPage(),
                      ));
                },
                child: Container(
                  child: Image(image: AssetImage('assets/Group 85.png')),
                ),
              )),
              Expanded(
                  child: Container(
                child: Image(image: AssetImage('assets/Group 84.png')),
              ))
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                child: Image(image: AssetImage('assets/Group 89.png')),
              )),
              Expanded(
                  child: Container(
                child: Image(image: AssetImage('assets/Group 88.png')),
              ))
            ],
          )
        ],
      ),
    ));
  }
}
