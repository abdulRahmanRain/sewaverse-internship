import 'package:flutter/material.dart';



class AnimationDemoScreen extends StatefulWidget {
  const AnimationDemoScreen({super.key});

  @override
  State<AnimationDemoScreen> createState() => _AnimationDemoScreenState();
}

class _AnimationDemoScreenState extends State<AnimationDemoScreen> {
  bool containerChanged = false;
  bool opacityChanged = false;
  bool alignChanged = false;
  bool paddingChanged = false;
  bool positionChanged = false;
  bool textChanged = false;
  bool isCenter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Independent Animations")),
      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 20),

            // AnimatedContainer
            AnimatedContainer(
              duration: const Duration(seconds: 1),

              width: containerChanged ? 250 : 150,
              height: containerChanged ? 250 : 150,

              alignment: Alignment.center,

              decoration: BoxDecoration(
                color: containerChanged ? Colors.blue : Colors.red,
                border: Border.all(width: 3, color: Colors.black),
                borderRadius: BorderRadius.circular(containerChanged ? 40 : 10),
              ),

              transform: containerChanged
                  ? Matrix4.rotationZ(0.2)
                  : Matrix4.rotationZ(0.0),

              curve: Curves.bounceIn,

              onEnd: () {
                print("Animation Finished");
              },

              child: const Text(
                "AnimatedContainer",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  containerChanged = !containerChanged;
                });
              },
              child: const Text("Change Container"),
            ),

            const SizedBox(height: 20),

            // AnimatedOpacity
            AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: opacityChanged ? 1.0 : 0.2,
              curve: Curves.bounceInOut,
              child: Container(
                width: 200,
                height: 100,
                color: Colors.green,
                child: const Center(
                  child: Text(
                    "AnimatedOpacity",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  opacityChanged = !opacityChanged;
                });
              },
              child: const Text("Change Opacity"),
            ),

            const SizedBox(height: 20),

            // AnimatedAlign
            Container(
              width: 300,
              height: 150,
              color: Colors.grey.shade300,
              child: AnimatedAlign(
                duration: const Duration(seconds: 1),
                alignment: alignChanged
                    ? Alignment.topRight
                    : Alignment.bottomLeft,
                child: const FlutterLogo(size: 50),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  alignChanged = !alignChanged;
                });
              },
              child: const Text("Change Align"),
            ),

            const SizedBox(height: 20),


            AnimatedPadding(
              duration: const Duration(seconds: 1),
              padding: EdgeInsets.all(paddingChanged ? 30 : 5),
              child: Container(
                height: 80,
                color: Colors.purple,
                child: const Center(
                  child: Text(
                    "AnimatedPadding",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  paddingChanged = !paddingChanged;
                });
              },
              child: const Text("change Padding"),
            ),

            const SizedBox(height: 20),


            Container(
              height: 150,
              width: 300,
              color: Colors.black12,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(seconds: 1),
                    top: positionChanged ? 20 : 80,
                    left: positionChanged ? 200 : 20,
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  positionChanged = !positionChanged;
                });
              },
              child: const Text(" change Position"),
            ),

            const SizedBox(height: 20),


            AnimatedDefaultTextStyle(
              duration: const Duration(seconds: 1),
              style: TextStyle(
                fontSize: textChanged ? 30 : 16,
                color: textChanged ? Colors.red : Colors.black,
                fontWeight: FontWeight.bold,
              ),
              child: const Text("Animation Text Style"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  textChanged = !textChanged;
                });
              },
              child: const Text(" change text style Text Style"),
            ),

            const SizedBox(height: 30),

            // positioned
            Container(
              width: 350,
              height: 250,
              color: Colors.grey.shade200,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    left: isCenter ? 150 : 20,
                    top: isCenter ? 150 : 20,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInCubic,

                    onEnd: () {
                      print('Position animation complete!');
                    },

                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isCenter = !isCenter;
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "on Tap",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}