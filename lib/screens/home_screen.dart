import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remainderapp/screens/add_medicine_screen.dart';
import '../models/medicine.dart'; // Import the Medicine class from models/medicine.dart
import '../services/notification_service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine Reminder'),
      ),
      body: Consumer<MedicineProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.medicines.length,
            itemBuilder: (context, index) {
              final medicine = provider.medicines[index];
              return ListTile(
                title: Text(medicine.name),
                subtitle: Text('Quantity: ${medicine.quantity} at ${medicine.time}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMedicineScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class MedicineProvider with ChangeNotifier {
  List<Medicine> _medicines = [];

  List<Medicine> get medicines => _medicines;

  void addMedicine(Medicine medicine) {
    _medicines.add(medicine); // Ensure Medicine here refers to the correct class
    NotificationService().scheduleNotification(medicine);
    notifyListeners();
  }
}
