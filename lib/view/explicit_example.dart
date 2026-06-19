import 'package:flutter/material.dart';

class ExplicitExample extends StatefulWidget {
  const ExplicitExample({super.key});

  @override
  State<ExplicitExample> createState() => _ExplicitExampleState();
}

class _ExplicitExampleState extends State<ExplicitExample>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> sizeAnimation;
  late Animation<Color?> colorAnimation;
  late Animation<double> opacityAnimation;
  late Animation<Alignment> alignAnimation;
  late Animation<EdgeInsets> paddingAnimation;
  late Animation<Offset> positionAnimation;
  late Animation<double> textSizeAnimation;
  late Animation<double> heartTweenAnimation;
  late Animation<Color?> heartColor;



  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(seconds: 1),);

    final curvedAnimation = CurvedAnimation(
      parent: controller, curve: Curves.easeInOut,
    );

    sizeAnimation = Tween<double>(begin: 150, end: 250,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.bounceInOut));

    colorAnimation = ColorTween(begin: Colors.green,
      end: Colors.black,).animate(curvedAnimation);

    opacityAnimation = Tween<double>(begin: 0.2, end: 1.0,
    ).animate(curvedAnimation);

    alignAnimation = AlignmentTween(begin: Alignment.bottomLeft, end: Alignment.topRight,
    ).animate(curvedAnimation);

    paddingAnimation = EdgeInsetsTween(begin: const EdgeInsets.all(5), end: const EdgeInsets.all(30),
    ).animate(curvedAnimation);

    positionAnimation = Tween<Offset>(begin: const Offset(20, 80), end: const Offset(220, 20),
    ).animate(curvedAnimation);

    textSizeAnimation = Tween<double>(begin: 16, end: 30,
    ).animate(curvedAnimation);

    heartTweenAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 50,
          end: 70,
        ),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 70,
          end: 50,
        ),
        weight: 50,
      ),
    ]).animate(curvedAnimation);

    heartColor = ColorTween(begin: Colors.grey.shade400,
      end: Colors.red,).animate(curvedAnimation);
  }



  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explicit Animation Demo"),
        actions: [
          IconButton(onPressed: (){
            controller.stop();
          }, icon: Icon(Icons.not_started))
        ],
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                Container(
                  width: sizeAnimation.value,
                  height: sizeAnimation.value,
                  decoration: BoxDecoration(
                    color: colorAnimation.value,
                    borderRadius: BorderRadius.circular(10,),
                  ),
                  child: const Center(
                    child: Text(
                      "Container",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Opacity(
                  opacity: opacityAnimation.value,
                  child: Container(
                    width: 220,
                    height: 100,
                    color: Colors.green,
                    child: const Center(
                      child: Text(
                        "Opacity",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  width: 300,
                  height: 150,
                  color: Colors.grey.shade300,
                  child: Align(
                    alignment: alignAnimation.value,
                    child: const FlutterLogo(size: 50),
                  ),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: paddingAnimation.value,
                  child: Container(
                    height: 80,
                    color: Colors.purple,
                    child: const Center(
                      child: Text(
                        "Padding",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  width: 320,
                  height: 150,
                  color: Colors.black12,
                  child: Stack(
                    children: [
                      Positioned(
                        left: positionAnimation.value.dx,
                        top: positionAnimation.value.dy,
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "Animated Text",
                  style: TextStyle(
                    fontSize: textSizeAnimation.value,
                    fontWeight: FontWeight.bold,
                    color: Color.lerp(
                      Colors.black,
                      Colors.red,
                      controller.value,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                IconButton(
                    onPressed: (){
                      if (controller.isCompleted) {
                        controller.reverse();
                      } else {
                        controller.forward();
                      }
                    },
                    icon: Icon(Icons.heart_broken,size: heartTweenAnimation.value,color: heartColor.value,)
                ),

                ElevatedButton(
                  onPressed: (){
                    if (controller.isCompleted) {
                      controller.reverse();
                    } else {
                      controller.forward();
                    }
                  },
                  child: const Text("Start Animation"),
                ),

                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: (){
                    controller.repeat();
                  },
                  child: const Text("repeat"),
                ),

                const SizedBox(height: 30),



                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}