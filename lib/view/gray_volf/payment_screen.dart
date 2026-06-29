import 'package:flutter/material.dart';
import 'package:todo_app/helper/eleveted_button.dart';
import 'package:todo_app/view/gray_volf/provider_list_screen.dart';

import '../full_auth_screen/widgets/custom_grayvolf_back.dart';



class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPaymentMethod = 'card';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // top bar
                Row(
                  children: [
                    Expanded(
                      child: CustomGrayvolfBack(
                        logoPath: "assets/grayvolf.png",
                        onBackPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),

                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProviderListScreen()));
                      },
                      child: CircleAvatar(
                        radius: 30,
                        child: ClipOval(
                          child: Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3qjP_5gAvJ8N215_VIWF_Y6UiWirqtE39yVI--POgD5l2PV7Uo3Y7gw9-&s=10",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.person_rounded);
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 20,),

                // Credit Card
                _buildCreditCard(),
                const SizedBox(height: 20),

                // Payment Method Text
                Align(
                  alignment: Alignment.center,
                    child: _buildPaymentMethodSection(),
                ),
                const SizedBox(height: 16),

                // Coupon Banner
                _buildCouponBanner(),
                const SizedBox(height: 16),

                // Google Pay Option
                _buildGooglePayOption(),
                const SizedBox(height: 20),

                // Order Breakdown
                _buildOrderBreakdown(),
                const SizedBox(height: 20),

                // Pay Now Button
                _buildPayNowButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreditCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6B7280), Color(0xFF4B5563)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'HDFC BANK',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                  ),
                ),
                const Text(
                  'VISA',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '4008  ****  ****  8006',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber[600],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.contactless,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'SUFIYAN JIN',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Text(
                  'Valid',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 20,),
                Text(
                  '07/36',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 40,),
                Text(
                  'CVV',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 20,),
                Text(
                  '•••',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '---- Or Pay with',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'Font Family',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    height: 1.0,
                    letterSpacing: 0.0,
                    color: Color(0xFF808080),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.asset(
                  'assets/UPI.png',
                  height: 24,
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                child: Text(
                  '----',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    height: 1.0,
                    letterSpacing: 0.0,
                    color: Color(0xFF808080),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCouponBanner() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Color(0xFF17A9F8),
            Color(0xFF108ED2),
            Color(0xFF4B55E0),
            Color(0xFF5059D3),
            Color(0xFF2117D7),
          ]
        )
      ),
      child: Column(
        children: [
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Flat 50% Off Coupon Applied',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.check_circle, color: Colors.white, size: 20),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(8),bottomLeft: Radius.circular(8)),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Use "LA50" for 50% Off',
                  style:  TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    height: 1.4,
                    letterSpacing: 0.1,
                    color: Color(0xFF202020),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Use "LA30" for 30% Off Minimum Order Value 1499/-',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGooglePayOption() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF8F8FF),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ]
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        children: [
          Image.asset(
            'assets/images.png',
            height: 24,
            fit: BoxFit.contain,
            ),
          const SizedBox(width: 6),
          Text("Pay", style: TextStyle(fontSize: 16,color: Color(0xFF808080) ),),
          const SizedBox(width: 12),
          const Text(
            'upiayment@okicici',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          Radio<String>(
            value: 'googlepay',
            groupValue: selectedPaymentMethod,
            onChanged: (value) {
              setState(() => selectedPaymentMethod = value!);
            },
            activeColor: const Color(0xFF3B82F6),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderBreakdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6,vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0xFF17A9F8),
              Color(0xFF108ED2),
              Color(0xFF4B55E0),
              Color(0xFF5059D3),
              Color(0xFF2117D7),
            ]
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: const Text(
              'Order Breakdown!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                _buildBreakdownRow(
                  'Total Order Value (Before Tax)',
                  '₹ 500',
                ),
                const SizedBox(height: 6),
                _buildBreakdownRow(
                  'Coupon Discount (Before Tax 50%)',
                  '₹-250',
                  valueColor: Colors.green,
                ),
                const SizedBox(height: 6),
                _buildBreakdownRow(
                  'Platform Fee (Fixed)*',
                  '₹ 25',
                ),
                const SizedBox(height: 6),
                _buildBreakdownRow(
                  'GST (SGST 9%)',
                  '₹ 24.75',
                ),
                const SizedBox(height: 6),
                _buildBreakdownRow(
                  'GST (CGST 9%)',
                  '₹ 24.75',
                ),
                const SizedBox(height: 16),
                _buildBreakdownRow(
                  'Total Payable Amount (After Tax)',
                  '₹ 324.50',
                  isTotal: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow(
      String label,
      String value, {
        bool isTotal = false,
        Color valueColor = Colors.black87,
      }) {
    return Container(
      padding: EdgeInsetsGeometry.all(8),
      decoration: BoxDecoration(
        color: Color(0xFFF6F6F9)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 14 : 13,
              color: Colors.grey[700],
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16 : 13,
              color: valueColor,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayNowButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: customElevatedButton(text: "Pay Now", onPressed: (){}, backgroundColor: Color(0xFF1863F8))
    );
  }
}