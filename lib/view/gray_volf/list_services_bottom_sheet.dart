import 'package:flutter/material.dart';
import 'package:todo_app/helper/eleveted_button.dart';
import 'package:todo_app/view/full_auth_screen/widgets/custom_textfield_widget.dart';
import 'package:todo_app/view/full_auth_screen/widgets/label.dart';

class ListServicesBottomSheet extends StatefulWidget {
   ListServicesBottomSheet({super.key});

  @override
  State<ListServicesBottomSheet> createState() => _ListServicesBottomSheetState();
}

class _ListServicesBottomSheetState extends State<ListServicesBottomSheet> {
  final TextEditingController _serviceTitleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();
  late TextEditingController _categoryController;

   final List<String> services = [
     "Painting",
     "Repair",
     "Cleaning",
     "Washing",
   ];



  @override
  void initState() {
    super.initState();
    _categoryController = TextEditingController(
      text: services.first,
    );
  }

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: height*0.85,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 5,
                width: 85,
                decoration: BoxDecoration(
                  color: Color(0xFFDCDCDC),
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
              const SizedBox(height: 50,),
              Text(
                  "List your Service",
                  style: textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 24
                  ),
              ),
              const SizedBox(height: 50,),
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey.shade300
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.cloud_upload, size: 50,),
                    const SizedBox(height: 10,),
                    Center(
                      child: Text("Upload Image"),
                    ),
                  ],
                )
              ),
              const SizedBox(height: 50,),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Service Title", style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 20,),
              CustomTextFieldWidget(
                  controller: _serviceTitleController,
                  hintText: "Repair 1955 Oldsmobile Super 88 Engine Rebuild"
              ),
              const SizedBox(height: 30,),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Task description", style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 20,),
              CustomTextFieldWidget(
                  controller: _descriptionController,
                  maxLine: 4,
                  hintText: "I'm looking for a skilled and experienced mechanic to help rebuild the engine of my 1955 Oldsmobile Super 88. The vehicle is a classic and needs careful handling. The engine has not been started in several years and may require a full teardown and rebuild, including inspection of pistons, crankshaft, valves, and fuel system.",
                  hintColor : Color(0xFF202020)
              ),
              const SizedBox(height: 50,),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppLabel(text: "Category"),
                        const SizedBox(height: 8),
                        CustomTextFieldWidget(
                          controller: _categoryController,
                          hintText: "",
                          isReadOnly: true,
                          suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined, color: Color(0xFF1863F8),),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 20),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppLabel(text: "Price"),
                        const SizedBox(height: 8),
                        CustomTextFieldWidget(
                          controller: _priceController,
                          hintText: "899",
                          isReadOnly: true,
                          prefixIcon: Icon(Icons.monetization_on,)
                        ),
                      ],
                    ),
                  ),


                ],
              ),
              const SizedBox(height: 50,),
              Row(
                children: [
                  Expanded(child: customElevatedButton(
                      text: "Cancel",
                      onPressed: (){},
                    backgroundColor: Colors.white,
                    textStyle: textTheme.labelMedium,
                    elevation: 3
                  )),
                  const SizedBox(width: 20,),
                  Expanded(child: customElevatedButton(
                      text: "List Service",
                      onPressed: (){},
                      backgroundColor: Color(0xFF1863F8),
                    elevation: 0
                  )),
                ],
              ),
              const SizedBox(height: 50,),

            ],
          ),
        ),
      ),
    );
  }
}
