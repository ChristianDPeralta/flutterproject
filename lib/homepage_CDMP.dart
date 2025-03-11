import 'package:flutter/material.dart';
import 'page1.dart';
import 'page2.dart';

class HomePage_CDMP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context); 
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/test.png', width: 150, height: 150, fit: BoxFit.cover),
            SizedBox(height: 20),
            Text(
              'Welcome to the Home Page!',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Page1())),
              child: Text('Go to Page 1'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Page2())),
              child: Text('Go to Page 2'),
            ),
          ],
        ),
      ),
    );
  }
}
