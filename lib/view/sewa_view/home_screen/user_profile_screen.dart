import 'package:flutter/material.dart';
import 'package:todo_app/view/sewa_view/home_screen/user_screen.dart';


class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          
          children: [
            SizedBox(height: 100,),
            Hero(
              tag: "myTag",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  "assets/img.png",
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 100,),
            SizedBox(height: 100,),
            SizedBox(height: 100,),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>UserScreen()));
            }, child: Text("back"))
          ],
        ),
      ),
    );
  }
}
