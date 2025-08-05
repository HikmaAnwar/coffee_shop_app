import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/order.dart';
import '../providers/order_provider.dart';
import 'package:provider/provider.dart';

class OrderTrackingScreen extends StatelessWidget {
  final String orderId;

  const OrderTrackingScreen({Key? key, required this.orderId})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the order from provider
    final order = Provider.of<OrderProvider>(
      context,
      listen: false,
    ).orders.firstWhere((o) => o.id == orderId);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'CaféCanvas',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            fontFamily: 'Cursive',
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thank you for order!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Order number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    controller: TextEditingController(
                      text: order.id.substring(order.id.length - 2),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    order.id.substring(order.id.length - 2),
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Text(
                  'Pick-up time: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '${order.orderDate.hour}:${order.orderDate.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pick-up location: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Expanded(
                  child: Text(
                    'CaféCanvas Café\n123 Mocha Lane, Brewville',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'Order tracking',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            _buildTimeline(order),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Back Home',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeline(Order order) {
    // Define the steps and their status
    final steps = [
      {'label': 'Order placed', 'status': OrderStatus.pending},
      {'label': 'Preparing', 'status': OrderStatus.preparing},
      {'label': 'Order is ready', 'status': OrderStatus.ready},
    ];

    // Find the current step index
    int currentStep = 0;
    if (order.status == OrderStatus.ready) {
      currentStep = 2;
    } else if (order.status == OrderStatus.preparing) {
      currentStep = 1;
    } else {
      currentStep = 0;
    }

    return Column(
      children: List.generate(steps.length, (index) {
        final isActive = index <= currentStep;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primary : AppColors.shadow,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      isActive ? Icons.check : Icons.circle,
                      color: AppColors.white,
                      size: 14,
                    ),
                  ),
                ),
                if (index < steps.length - 1)
                  Container(
                    width: 2,
                    height: 40,
                    color: isActive ? AppColors.primary : AppColors.shadow,
                  ),
              ],
            ),
            SizedBox(width: 12),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                (steps[index]['label'] as String),
                style: TextStyle(
                  color: isActive ? AppColors.primary : AppColors.textSecondary,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
