import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('welcom'),
        backgroundColor: Color.fromARGB(255, 3, 107, 17),
      ),
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          // ignore: prefer_const_constructors
          Container(
            child: Container(
              height: 200,
              width: 300,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image(
                    image: NetworkImage(
                        'https://imgv3.fotor.com/images/homepage-feature-card/Fotor-AI-photo-enhancement-tool.jpg'),
                    fit: BoxFit.cover,
                    height: 200,
                    width: 300,
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.only(
                      top: 10,
                      bottom: 10,
                    ),
                    width: double.infinity,
                    child: Text(
                      'lovely Girl',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.black.withOpacity(0.4),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Scaffold(
          appBar: AppBar(
            leading: const Icon(Icons.menu),
            title: const Text('hello Ameen'),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.notification_add)),
              IconButton(onPressed: () {}, icon: Icon(Icons.lock_clock))
            ],
          ),
        ),
      ),
    );
  }
}
