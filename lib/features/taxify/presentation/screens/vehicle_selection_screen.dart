import 'package:flutter/material.dart';
import 'package:sama_taxi/core/navigation/app_router.dart';
import 'package:sama_taxi/features/taxify/presentation/screens/ride_in_progress_screen.dart';
import 'package:sama_taxi/features/taxify/presentation/screens/ride_request_screen.dart';

class VehicleSelectionScreen extends StatefulWidget {
  const VehicleSelectionScreen({super.key});

  @override
  State<VehicleSelectionScreen> createState() => _VehicleSelectionScreenState();
}

class _VehicleSelectionScreenState extends State<VehicleSelectionScreen> {
  int _selectedVehicleIndex = 1; // Default to Car
  bool _isCashSelected = true;
  final TextEditingController _fareController = TextEditingController();

  @override
  void dispose() {
    _fareController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Book a Ride',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pickup and Destination
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildLocationRow(Icons.circle_outlined, 'Current Location', Colors.green),
                const SizedBox(height: 16),
                _buildLocationRow(Icons.location_on_outlined, 'Destination', Colors.red),
              ],
            ),
          ),
          const SizedBox(height: 8),
          
          // Vehicle Type Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Vehicle Type',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildVehicleCard(0, 'Bike', 'assets/images/bike.png', '5:42pm', '2min away', Colors.red),
                    _buildVehicleCard(1, 'Car', 'assets/images/car.png', '5:42pm', '2min away', Colors.blue),
                    _buildVehicleCard(2, 'Auto', 'assets/images/auto.png', '5:42pm', '2min away', Colors.orange),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          
          // Offer Your Fare Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Offer Your Fare',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _fareController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter Fare Amount',
                    prefixIcon: const Icon(Icons.attach_money, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          
          // Payment Method Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Payment Method',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildPaymentMethodButton(true, 'Cash', Icons.money_off_csred_outlined),
                    const SizedBox(width: 12),
                    _buildPaymentMethodButton(false, 'QR-Payment', Icons.qr_code_scanner),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          
          // Book Ride Button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {

           //   context.pushRideInProgress();
                           Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const RideRequestBottomSheet(
      // driverName: 'John Doe',
      // carModel: 'Toyota Camry',
      // licensePlate: 'ABC123',
      // eta: '5 minutes',
    ),
  ),
);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.grey[600],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Book Ride',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationRow(IconData icon, String text, Color iconColor) {
    return Row(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const Icon(Icons.more_vert, color: Colors.grey),
      ],
    );
  }

  Widget _buildVehicleCard(int index, String type, String imagePath, String time, String distance, Color color) {
    final isSelected = _selectedVehicleIndex == index;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedVehicleIndex = index),
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? Border.all(color: color, width: 2) : null,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.info_outline, size: 14, color: Colors.grey),
                ),
                // In a real app, you would use an actual image asset
                Container(
                  width: 40,
                  height: 40,
                  color: color,
                  // child: Image.asset(imagePath, fit: BoxFit.contain),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              type,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              distance,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodButton(bool isCash, String text, IconData icon) {
    final isSelected = _isCashSelected == isCash;
    
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: () => setState(() => _isCashSelected = isCash),
        icon: Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
        label: Text(text, style: TextStyle(color: isSelected ? Colors.blue : Colors.grey)),
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue.withOpacity(0.1) : Colors.grey[100],
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: BorderSide(
            color: isSelected ? Colors.blue : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
