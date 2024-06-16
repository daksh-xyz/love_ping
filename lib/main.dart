import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';

/// Created by GP
/// 2020/11/25.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.deepPurple[200],
        body: Stack(
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.width / 2,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 126, 87, 194),
                      ),
                      child: IconButton(
                          enableFeedback: true,
                          onPressed: () {
                            HapticFeedback.lightImpact();
                          },
                          icon: const Icon(
                            CupertinoIcons.heart_fill,
                            color: Colors.white,
                            size: 56,
                          )),
                    ),
                  )
                ]),
            _buildBottomDrawer(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomDrawer(BuildContext context) {
    return BottomDrawer(
      header: _buildBottomDrawerHead(context),
      body: _buildBottomDrawerBody(context),
      headerHeight: _headerHeight,
      drawerHeight: _bodyHeight,
      color: const Color.fromARGB(255, 126, 87, 194),
      controller: _controller,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 60,
          spreadRadius: 5,
          offset: const Offset(2, -6), // changes position of shadow
        ),
      ],
    );
  }

  Widget _buildBottomDrawerHead(BuildContext context) {
    return SwipeDetector(
      onSwipeUp: (offset) {
        setState(() {
          isOpen = !isOpen;
          isOpen ? _controller.open() : _controller.close();
        });
      },
      onSwipeDown: (offset) {
        setState(() {
          isOpen = false;
          _controller.close();
        });
      },
      child: SizedBox(
        width: double.infinity,
        height: _headerHeight,
        child: IconButton(
            onPressed: () {
              setState(() {
                isOpen = !isOpen;
              });
              isOpen ? _controller.open() : _controller.close();
            },
            splashRadius: 1,
            icon: isOpen
                ? const Icon(
                    CupertinoIcons.chevron_down,
                    color: Colors.white,
                  )
                : const Icon(
                    CupertinoIcons.chevron_up,
                    color: Colors.white,
                  )),
      ),
    );
  }

  Widget _buildBottomDrawerBody(BuildContext context) {
    return SwipeDetector(
        onSwipeDown: (offset) {
          setState(() {
            isOpen = !isOpen;
          });
          isOpen ? _controller.open() : _controller.close();
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: _bodyHeight,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: const TextField(
                  maxLines: null,
                  expands: true,
                ),
              ),
            ),
          ]),
        ));
  }

  final double _headerHeight = 80.0;
  final double _bodyHeight = 500;
  final BottomDrawerController _controller = BottomDrawerController();
  bool isOpen = false;
}
