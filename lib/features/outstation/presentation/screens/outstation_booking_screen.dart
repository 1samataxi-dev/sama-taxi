import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sama_taxi/core/widgets/appbar.dart';
import 'package:sama_taxi/features/outstation/domain/models/outstation_booking_model.dart';
import 'package:sama_taxi/features/outstation/presentation/providers/outstation_booking_provider.dart';
import 'package:sama_taxi/features/taxify/presentation/widgets/category_options.dart';

class OutstationBookingScreen extends ConsumerStatefulWidget {
  const OutstationBookingScreen({super.key});

  @override
  ConsumerState<OutstationBookingScreen> createState() => _OutstationBookingScreenState();
}

class _OutstationBookingScreenState extends ConsumerState<OutstationBookingScreen> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _passengerController = TextEditingController();
  final TextEditingController _offerRateController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  @override
  void dispose() {
    _pickupController.dispose();
    _destinationController.dispose();
    _dateController.dispose();
    _passengerController.dispose();
    _offerRateController.dispose();
    _commentsController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Out Station',
        showBackButton: true,
    

      ),
   
      body: SingleChildScrollView(
       // padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           _buildLocationInputs(),
            const SizedBox(height: 8),
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Row(
                    spacing: 5,
                    mainAxisSize: MainAxisSize.min,
                   
                   
                    children: [
                     
                      Text(
                        'Fares Don\'t Include Tolls',
                        style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                       Icon(Icons.cabin,color: Colors.red,fontWeight: FontWeight.bold, size: 15),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
             Container
          (

            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [  Inputtitle(title: 'Select Option',),
          SizedBox
          (

            
  height: 140, // Set a fixed height or use LayoutBuilder for responsive height
  child: CategoriesOptionsScreen(),
),],
            ),
          ),
            
             //  _buildOptionsSection(),
                    const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child:Column(
              children: [
               
         //   const SizedBox(height: 16),
            _buildDateTimeField(),
            const SizedBox(height: 16),
            _buildPassengerField(),
            const SizedBox(height: 16),
            _buildOfferRateField(),
            const SizedBox(height: 16),
            _buildCommentsField(),
              ],
            )
          ),
              _buildPaymentMethod(),
                const SizedBox(height: 24),
            _buildBookNowButton(),
          
          //  _buildBookNowButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationInputs() {
    final bookingNotifier = ref.read(outstationBookingProvider.notifier);
    
    return Container(
     
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          TextFormField(
            controller: _pickupController,
            onChanged: (value) => bookingNotifier.updatePickupLocation(value),
            decoration: InputDecoration(
              hintText: 'Pickup Location',
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
              prefixIcon: const Icon(Icons.location_on, color: Colors.green),
              
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _destinationController,
            onChanged: (value) => bookingNotifier.updateDestination(value),
            decoration: InputDecoration(
              hintText: 'Enter Destination',
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
              prefixIcon: const Icon(Icons.add_location_alt, color: Colors.red),
              suffixIcon: IconButton(
                icon: const Icon(Icons.add_outlined, color: Colors.blue),
                onPressed: () {
                  // Handle add location
                },
             ),
            ),
          ),
            const SizedBox(height: 12),
        ],
      ),
    );
  }



  Widget _buildDateTimeField() {
    final bookingNotifier = ref.read(outstationBookingProvider.notifier);
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Inputtitle(title: 'Date & Time'),
        TextFormField(
          controller: _dateController,
          readOnly: true,
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2101),
            );
            if (picked != null) {
              final TimeOfDay? time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (time != null) {
                final dateTime = DateTime(
                  picked.year,
                  picked.month,
                  picked.day,
                  time.hour,
                  time.minute,
                );
                _dateController.text =
                    '${picked.day}/${picked.month}/${picked.year} at ${time.hour}:${time.minute}';
                bookingNotifier.updateDateTime(dateTime);
              }
            }
          },
        decoration: InputDecoration(
          hintText: 'Date And Time',
          prefixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
          suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
      ]
    );
  }

  Widget _buildPassengerField() {
    final bookingNotifier = ref.read(outstationBookingProvider.notifier);
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Inputtitle(title: 'Number Of Passenger'),
        TextFormField(
          controller: _passengerController,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            if (value.isNotEmpty) {
              bookingNotifier.updateNumberOfPassengers(int.tryParse(value) ?? 1);
            }
          },
      decoration: InputDecoration(
        hintText: 'Number Of Passenger',
        prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
        suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
        )
      ]
    );
  }

  Widget _buildOfferRateField() {
    final bookingNotifier = ref.read(outstationBookingProvider.notifier);
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Inputtitle(title: 'Enter Your Offer Rate'),
        TextFormField(
          controller: _offerRateController,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            if (value.isNotEmpty) {
              bookingNotifier.updateOfferRate(double.tryParse(value));
            } else {
              bookingNotifier.updateOfferRate(null);
            }
          },
      decoration: InputDecoration(
        hintText: 'Enter Your Offer Rate',
        labelText: 'Enter Fare Amount',
        prefix: const Text('\$ '),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
        )]
    );
  }

  Widget _buildCommentsField() {
    final bookingNotifier = ref.read(outstationBookingProvider.notifier);
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Inputtitle(title: 'Comments'),
        TextFormField(
          controller: _commentsController,
          onChanged: (value) => bookingNotifier.updateComments(value),
          maxLines: 3,
      decoration: InputDecoration(
        hintText: 'Comments',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    )]
    );
  }
  Widget _buildPaymentMethod() {
    final bookingState = ref.watch(outstationBookingProvider);
    final bookingNotifier = ref.read(outstationBookingProvider.notifier);
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Inputtitle(title: 'Payment Method'),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => bookingNotifier.updatePaymentMethod(PaymentMethod.cash),
                  child: Container(
                    height: 80,
                    width: 80,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: bookingState.paymentMethod == PaymentMethod.cash 
                          ? Colors.blue[50] 
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: bookingState.paymentMethod == PaymentMethod.cash 
                            ? Colors.blue 
                            : Colors.grey[300]!,
                        width: 1.5,
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.money, color: Colors.green, size: 20),
                        SizedBox(width: 8),
                        Text('Cash', style: TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () => bookingNotifier.updatePaymentMethod(PaymentMethod.qr),
                  child: Container(
                    height: 80,
                    width: 80,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: bookingState.paymentMethod == PaymentMethod.qr 
                          ? Colors.blue[50] 
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: bookingState.paymentMethod == PaymentMethod.qr 
                            ? Colors.blue 
                            : Colors.grey[300]!,
                        width: 1.5,
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.qr_code, color: Colors.blue, size: 20),
                        SizedBox(width: 8),
                        Text('QR-Payment', style: TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookNowButton() {
    final bookingNotifier = ref.read(outstationBookingProvider.notifier);
    
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () async {
          try {
            await bookingNotifier.submitBooking();
            // Show success message or navigate to success screen
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Booking submitted successfully!')),
              );
            }
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${e.toString()}')),
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Book Ride',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class Inputtitle extends StatelessWidget {
  final String title;
  const Inputtitle({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Text(
       title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
