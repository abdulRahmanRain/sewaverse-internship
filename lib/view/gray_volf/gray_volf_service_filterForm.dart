import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/view/full_auth_screen/widgets/custom_textfield_widget.dart';

import '../../helper/eleveted_button.dart';
import 'gray_volf_home_screen.dart';


class GrayVolfServiceFilterform extends StatefulWidget {
  const GrayVolfServiceFilterform({super.key});

  @override
  State<GrayVolfServiceFilterform> createState() => _GrayVolfServiceFilterformState();
}

class _GrayVolfServiceFilterformState extends State<GrayVolfServiceFilterform> {
  late TextEditingController _citySearchController;
  String? _selectedCity;
  int _selectedWorkType = 0;
  int _selectedTimeIndex = 0;

  final List<String> categories = ["Painting", "Cleaning", "Engine", "Gardening","other"];
  final List<String> timeFilters = ["Today","This Week", "This Months",];
  final List<String> cities = ["Delhi", "Mumbai", "Bangalore", "Kolkata", "Chennai"];

  @override
  void initState() {
    super.initState();
    _citySearchController = TextEditingController();
    _selectedCity = cities.first;
  }

  @override
  void dispose() {
    _citySearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 85,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCDCDC),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 50),

              Text(
                "City",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 2,
                width: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF1863F8),
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
              const SizedBox(height: 20),


             CustomTextFieldWidget(
                 controller: _citySearchController,
                 hintText: "Search Events...",
                 prefixIcon: Icon(Icons.circle, color: Color(0xFF1863F8),),
             ),


              if (_selectedCity != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _selectedCity!,
                          style: const TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            setState(() => _selectedCity = null);
                          },
                          child: const Icon(
                            Icons.close,
                            size: 18,
                            color: Color(0xFF999999),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 50),


              Text(
                "Category",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 2,
                width: 60,
                decoration: BoxDecoration(
                    color: const Color(0xFF1863F8),
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
              const SizedBox(height: 20),

              Wrap(
                spacing: 8, // Horizontal spacing
                runSpacing: 8, // Vertical spacing
                children: List.generate(
                  categories.length,
                      (index) {
                    return workCard(
                      bgColor: _selectedWorkType == index
                          ? const Color(0xFF1863F8)
                          : Colors.white,
                      textColor: _selectedWorkType == index
                          ? Colors.white
                          : const Color(0xFFC1C1C1),
                      text: categories[index],
                      border: Border.all(color: Colors.grey.shade300),
                      onTap: () {
                        setState(() {
                          _selectedWorkType = index;
                        });
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 28),

              Text(
                "Time",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 2,
                width: 60,
                decoration: BoxDecoration(
                    color: const Color(0xFF1863F8),
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
              const SizedBox(height: 20),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  timeFilters.length,
                      (index) {
                    return workCard(
                      bgColor: _selectedTimeIndex == index
                          ? const Color(0xFF1863F8)
                          : Colors.white,
                      textColor: _selectedTimeIndex == index
                          ? Colors.white
                          : const Color(0xFFC1C1C1),
                      text: timeFilters[index],
                      border: Border.all(color: Colors.grey.shade300),
                      onTap: () {
                        setState(() {
                          _selectedTimeIndex = index;
                        });
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 36),

              // Action Buttons
              const SizedBox(height: 50,),
              Row(
                children: [
                  Expanded(child: customElevatedButton(
                      text: "Cancel",
                      onPressed: (){
                        context.pop();
                      },
                      backgroundColor: Colors.white,
                      textStyle: textTheme.labelMedium,
                      elevation: 3
                  )),
                  const SizedBox(width: 20,),
                  Expanded(child: customElevatedButton(
                      text: "Apply",
                      onPressed: (){},
                      backgroundColor: Color(0xFF1863F8),
                      elevation: 0
                  )),
                ],
              ),
              const SizedBox(height: 120,),
            ],
          ),
        ),
      ),
    );
  }
}