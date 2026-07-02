import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/config/app_route_path.dart';
import 'package:todo_app/helper/eleveted_button.dart';
import 'package:todo_app/view/full_auth_screen/widgets/label.dart';
import 'package:todo_app/view/gray_volf/payment_screen.dart';

class ServiceInformationScreen extends StatefulWidget {
  final String? serviceImageUrl;
  final String? providerImageUrl;
  final String? providerName;
  final String? description;
  final String? location;

  const ServiceInformationScreen({
    super.key,
    required this.serviceImageUrl,
    required this.providerImageUrl,
    required this.providerName,
    required this.description,
    required this.location,
  });

  @override
  State<ServiceInformationScreen> createState() => _ServiceInformationScreenState();
}

class _ServiceInformationScreenState extends State<ServiceInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          SizedBox(
            height: 300,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              child: widget.serviceImageUrl != null
                  ? Image.network(
                widget.serviceImageUrl!,
                fit: BoxFit.cover,
              )
                  : const Icon(Icons.broken_image_outlined, size: 100),
            ),
          ),

          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 360, left: 20, right: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppLabel(text: "Service Information"),
                const SizedBox(height: 30),
                Text(
                  "Repair 1955 Oldsmobile Super 88 Engine Rebuild",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF202020),
                    height: 36 / 28,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "${widget.description}",
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF747688),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 50,),
                Divider(color: Color(0xFF1863F8),endIndent: 0,),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Icon(Icons.monetization_on_outlined),
                    const SizedBox(width: 15,),
                    Text("899", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),),
                    Spacer(),
                    customElevatedButton(text: "Book", onPressed: (){
                      context.go("${AppRoutePath.grayHomeScreen}/${AppRoutePath.paymentScreen}");
                    },elevation: 0)
                  ],
                ),
                const SizedBox(height: 150,),
              ],
            ),
          ),


          Positioned(
            top: 260,
            left: 15,
            right: 15,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(50),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey.shade200,
                    child: widget.providerImageUrl != null
                        ? ClipOval(
                      child: Image.network(
                        widget.providerImageUrl!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    )
                        : const Icon(Icons.person),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.providerName ?? "",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF202020),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "${widget.location}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF202020),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    height: 40,
                    child: customElevatedButton(
                      text: "Follow",
                      onPressed: () {},
                      elevation: 0,
                      backgroundColor: const Color(0xFF1863F8),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
              left: 20,
              child: InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: const Color(0xFFDCDCDC),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Color(0xFF1863F8),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
