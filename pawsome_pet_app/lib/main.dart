import 'package:flutter/material.dart';

void main() {
  runApp(const PetDaycareApp());
}

// Helper function to format date without intl package
String formatDate(DateTime date) {
  final months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  return '${months[date.month - 1]} ${date.day}, ${date.year}';
}

class PetDaycareApp extends StatelessWidget {
  const PetDaycareApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pawsome Pet Daycare & Grooming',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// 1 & 2 & 3 & 4: Login Form with Validation and GlobalKey
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitLogin() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Welcome to Pawsome! 🐾')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RegistrationPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pawsome - Login'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.pets, size: 80, color: Colors.purple),
                const SizedBox(height: 24),
                const Text(
                  'Welcome to Pawsome',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Pet Daycare & Grooming',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Email must contain @';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscurePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _submitLogin,
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistrationPage()),
                    );
                  },
                  child: const Text('New pet parent? Register here'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 6: Registration Form with name, email, password, confirm password
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitRegistration() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account Created Successfully! 🎉')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BookingFormPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Join Our Pet Family',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Email must contain @';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitRegistration,
                  child: const Text(
                    'CREATE ACCOUNT',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 5, 7, 8, 9, 10: Complete Booking Form with all input types
class BookingFormPage extends StatefulWidget {
  const BookingFormPage({Key? key}) : super(key: key);

  @override
  State<BookingFormPage> createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _petNameController = TextEditingController();
  final _specialNotesController = TextEditingController();
  final _emergencyContactController = TextEditingController();

  // Form fields
  String _selectedService = 'Daycare Only';
  String _petType = 'Dog';
  String _petSize = 'Small';
  bool _needsFeeding = false;
  bool _hasVaccination = true;
  bool _needsMedication = false;
  DateTime? _dropOffDate;
  TimeOfDay? _dropOffTime;
  DateTime? _pickUpDate;
  TimeOfDay? _pickUpTime;

  // Local list to store bookings
  final List<Map<String, dynamic>> _bookings = [];

  final List<String> _services = [
    'Daycare Only',
    'Grooming Only',
    'Daycare + Grooming',
    'Overnight Boarding',
    'Training Session'
  ];
  final List<String> _petTypes = ['Dog', 'Cat', 'Rabbit', 'Bird', 'Other'];
  final List<String> _petSizes = ['Small', 'Medium', 'Large', 'Extra Large'];

  @override
  void dispose() {
    _petNameController.dispose();
    _specialNotesController.dispose();
    _emergencyContactController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isDropOff) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (picked != null) {
      setState(() {
        if (isDropOff) {
          _dropOffDate = picked;
        } else {
          _pickUpDate = picked;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isDropOff) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isDropOff) {
          _dropOffTime = picked;
        } else {
          _pickUpTime = picked;
        }
      });
    }
  }

  void _submitBooking() {
    if (_formKey.currentState!.validate()) {
      if (_dropOffDate == null || _dropOffTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select drop-off date and time')),
        );
        return;
      }

      final booking = {
        'petName': _petNameController.text,
        'service': _selectedService,
        'petType': _petType,
        'petSize': _petSize,
        'needsFeeding': _needsFeeding,
        'hasVaccination': _hasVaccination,
        'needsMedication': _needsMedication,
        'dropOffDate': formatDate(_dropOffDate!),
        'dropOffTime': _dropOffTime!.format(context),
        'pickUpDate':
            _pickUpDate != null ? formatDate(_pickUpDate!) : 'Same Day',
        'pickUpTime':
            _pickUpTime != null ? _pickUpTime!.format(context) : 'TBD',
        'emergencyContact': _emergencyContactController.text,
        'specialNotes': _specialNotesController.text,
        'status': 'Pending',
        'totalCost': _calculateCost(),
      };

      setState(() {
        _bookings.add(booking);
        _clearForm();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Booking Created! Your pet is in good paws! 🐾'),
        ),
      );
    }
  }

  String _calculateCost() {
    double cost = 0;
    switch (_selectedService) {
      case 'Daycare Only':
        cost = 500;
        break;
      case 'Grooming Only':
        cost = 800;
        break;
      case 'Daycare + Grooming':
        cost = 1200;
        break;
      case 'Overnight Boarding':
        cost = 1500;
        break;
      case 'Training Session':
        cost = 1000;
        break;
    }

    if (_petSize == 'Large') cost += 200;
    if (_petSize == 'Extra Large') cost += 400;
    if (_needsFeeding) cost += 150;
    if (_needsMedication) cost += 200;

    return '₱${cost.toStringAsFixed(2)}';
  }

  void _clearForm() {
    _petNameController.clear();
    _specialNotesController.clear();
    _emergencyContactController.clear();
    _dropOffDate = null;
    _dropOffTime = null;
    _pickUpDate = null;
    _pickUpTime = null;
    _selectedService = 'Daycare Only';
    _petType = 'Dog';
    _petSize = 'Small';
    _needsFeeding = false;
    _hasVaccination = true;
    _needsMedication = false;
  }

  void _captureEmergencyContact() {
    if (_emergencyContactController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Emergency Contact Saved: ${_emergencyContactController.text}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Pet Care'),
        actions: [
          IconButton(
            icon: const Icon(Icons.folder_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DocumentTrackerPage(bookings: _bookings),
                ),
              );
            },
            tooltip: 'View All Bookings',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pet Information',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // 1: Simple TextFormField
              TextFormField(
                controller: _petNameController,
                decoration: const InputDecoration(
                  labelText: 'Pet Name',
                  prefixIcon: Icon(Icons.pets),
                  border: OutlineInputBorder(),
                  hintText: 'e.g., Buddy, Whiskers',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your pet\'s name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 7: Dropdown for Pet Type
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: DropdownButtonFormField<String>(
                  value: _petType,
                  decoration: const InputDecoration(
                    labelText: 'Pet Type',
                    prefixIcon: Icon(Icons.category),
                    border: OutlineInputBorder(),
                  ),
                  items: _petTypes.map((String type) {
                    return DropdownMenuItem(value: type, child: Text(type));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _petType = newValue!;
                    });
                  },
                ),
              ),

              // 7: Dropdown for Pet Size
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: DropdownButtonFormField<String>(
                  value: _petSize,
                  decoration: const InputDecoration(
                    labelText: 'Pet Size',
                    prefixIcon: Icon(Icons.straighten),
                    border: OutlineInputBorder(),
                  ),
                  items: _petSizes.map((String size) {
                    return DropdownMenuItem(value: size, child: Text(size));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _petSize = newValue!;
                    });
                  },
                ),
              ),

              const Text(
                'Service Selection',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // 7: Dropdown for Service
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: DropdownButtonFormField<String>(
                  value: _selectedService,
                  decoration: const InputDecoration(
                    labelText: 'Select Service',
                    prefixIcon: Icon(Icons.spa),
                    border: OutlineInputBorder(),
                  ),
                  items: _services.map((String service) {
                    return DropdownMenuItem(
                        value: service, child: Text(service));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedService = newValue!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'Schedule',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // 8: Date and Time Pickers - Drop Off
              const Text(
                'Drop-Off',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.calendar_today),
                      label: Text(_dropOffDate == null
                          ? 'Select Date'
                          : formatDate(_dropOffDate!)),
                      onPressed: () => _selectDate(context, true),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.access_time),
                      label: Text(_dropOffTime == null
                          ? 'Select Time'
                          : _dropOffTime!.format(context)),
                      onPressed: () => _selectTime(context, true),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 8: Pick Up Date and Time
              const Text(
                'Pick-Up (Optional)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.calendar_today),
                      label: Text(_pickUpDate == null
                          ? 'Select Date'
                          : formatDate(_pickUpDate!)),
                      onPressed: () => _selectDate(context, false),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.access_time),
                      label: Text(_pickUpTime == null
                          ? 'Select Time'
                          : _pickUpTime!.format(context)),
                      onPressed: () => _selectTime(context, false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              const Text(
                'Additional Services',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // 5: Checkbox - Feeding
              CheckboxListTile(
                title: const Text('Needs Feeding'),
                subtitle: const Text('We\'ll provide meals (+₱150)'),
                value: _needsFeeding,
                onChanged: (bool? value) {
                  setState(() {
                    _needsFeeding = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),

              // 5: Checkbox - Medication
              CheckboxListTile(
                title: const Text('Needs Medication'),
                subtitle:
                    const Text('We\'ll administer prescribed meds (+₱200)'),
                value: _needsMedication,
                onChanged: (bool? value) {
                  setState(() {
                    _needsMedication = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),

              // 5: Switch - Vaccination Status
              SwitchListTile(
                title: const Text('Vaccination Up to Date'),
                subtitle: const Text('Required for daycare services'),
                value: _hasVaccination,
                onChanged: (bool value) {
                  setState(() {
                    _hasVaccination = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // 9: TextField with Controller - Emergency Contact
              TextField(
                controller: _emergencyContactController,
                decoration: const InputDecoration(
                  labelText: 'Emergency Contact Number',
                  prefixIcon: Icon(Icons.phone_in_talk),
                  border: OutlineInputBorder(),
                  hintText: '+63 XXX XXX XXXX',
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Save Contact'),
                  onPressed: _captureEmergencyContact,
                ),
              ),
              const SizedBox(height: 16),

              // Special Notes
              TextFormField(
                controller: _specialNotesController,
                decoration: const InputDecoration(
                  labelText: 'Special Notes',
                  prefixIcon: Icon(Icons.note_alt),
                  border: OutlineInputBorder(),
                  hintText: 'Allergies, behaviors, preferences...',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 8),

              // Cost Display
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Estimated Cost:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _calculateCost(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check_circle),
                  label: const Text(
                    'BOOK NOW',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: _submitBooking,
                ),
              ),
              const SizedBox(height: 24),

              // 10: Display submitted bookings
              if (_bookings.isNotEmpty) ...[
                const Divider(thickness: 2),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Your Bookings',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DocumentTrackerPage(bookings: _bookings),
                          ),
                        );
                      },
                      child: const Text('View All'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _bookings.length > 3 ? 3 : _bookings.length,
                  itemBuilder: (context, index) {
                    final booking = _bookings[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.pets,
                                        color: Colors.purple),
                                    const SizedBox(width: 8),
                                    Text(
                                      booking['petName'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Chip(
                                  label: Text(booking['status']),
                                  backgroundColor: Colors.orange.shade100,
                                ),
                              ],
                            ),
                            const Divider(),
                            _buildInfoRow('Service:', booking['service']),
                            _buildInfoRow('Pet Type:',
                                '${booking['petType']} (${booking['petSize']})'),
                            _buildInfoRow('Drop-Off:',
                                '${booking['dropOffDate']} at ${booking['dropOffTime']}'),
                            _buildInfoRow('Pick-Up:',
                                '${booking['pickUpDate']} at ${booking['pickUpTime']}'),
                            _buildInfoRow('Cost:', booking['totalCost']),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                  icon: const Icon(Icons.payment),
                                  label: const Text('Pay Now'),
                                  onPressed: () {
                                    _showPaymentDialog(context, booking);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _showPaymentDialog(BuildContext context, Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pet: ${booking['petName']}'),
            Text('Service: ${booking['service']}'),
            const SizedBox(height: 16),
            Text(
              'Total: ${booking['totalCost']}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 16),
            const Text('Payment methods:'),
            const Text('• GCash'),
            const Text('• PayMaya'),
            const Text('• Credit/Debit Card'),
            const Text('• Cash on arrival'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Payment processed successfully! 💳'),
                ),
              );
            },
            child: const Text('Proceed to Pay'),
          ),
        ],
      ),
    );
  }
}

// Document Tracker Page with Payment Processing
class DocumentTrackerPage extends StatefulWidget {
  final List<Map<String, dynamic>> bookings;

  const DocumentTrackerPage({Key? key, required this.bookings})
      : super(key: key);

  @override
  State<DocumentTrackerPage> createState() => _DocumentTrackerPageState();
}

class _DocumentTrackerPageState extends State<DocumentTrackerPage> {
  String _filterStatus = 'All';
  final List<String> _statusFilters = [
    'All',
    'Pending',
    'Confirmed',
    'Completed',
    'Cancelled'
  ];

  List<Map<String, dynamic>> get filteredBookings {
    if (_filterStatus == 'All') return widget.bookings;
    return widget.bookings
        .where((booking) => booking['status'] == _filterStatus)
        .toList();
  }

  void _updateBookingStatus(int index, String newStatus) {
    setState(() {
      widget.bookings[index]['status'] = newStatus;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Status updated to $newStatus')),
    );
  }

  void _processPayment(BuildContext context, Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const Text('Process Payment'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Booking Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Divider(),
              _buildPaymentInfoRow('Pet Name:', booking['petName']),
              _buildPaymentInfoRow('Service:', booking['service']),
              _buildPaymentInfoRow(
                  'Pet Info:', '${booking['petType']} (${booking['petSize']})'),
              _buildPaymentInfoRow('Drop-Off:', booking['dropOffDate']),
              _buildPaymentInfoRow('Time:', booking['dropOffTime']),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      booking['totalCost'],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Select Payment Method:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.account_balance_wallet,
                    color: Colors.blue),
                title: const Text('GCash'),
                dense: true,
                onTap: () {
                  Navigator.pop(dialogContext);
                  _confirmPayment('GCash');
                },
              ),
              ListTile(
                leading: const Icon(Icons.payment, color: Colors.green),
                title: const Text('PayMaya'),
                dense: true,
                onTap: () {
                  Navigator.pop(dialogContext);
                  _confirmPayment('PayMaya');
                },
              ),
              ListTile(
                leading: const Icon(Icons.credit_card, color: Colors.orange),
                title: const Text('Credit/Debit Card'),
                dense: true,
                onTap: () {
                  Navigator.pop(dialogContext);
                  _confirmPayment('Credit Card');
                },
              ),
              ListTile(
                leading: const Icon(Icons.money, color: Colors.green),
                title: const Text('Cash on Arrival'),
                dense: true,
                onTap: () {
                  Navigator.pop(dialogContext);
                  _confirmPayment('Cash');
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmPayment(String method) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Payment Successful!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Payment method: $method'),
            const SizedBox(height: 16),
            const Text(
              'You will receive a confirmation email shortly.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Payment via $method completed! 🎉'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Tracker'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              setState(() {
                _filterStatus = value;
              });
            },
            itemBuilder: (context) => _statusFilters
                .map((status) => PopupMenuItem(
                      value: status,
                      child: Text(status),
                    ))
                .toList(),
          ),
        ],
      ),
      body: widget.bookings.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.folder_open, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No bookings yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your pet care bookings will appear here',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredBookings.length,
              itemBuilder: (context, index) {
                final booking = filteredBookings[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.purple.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.pets,
                                      color: Colors.purple),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      booking['petName'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${booking['petType']} • ${booking['petSize']}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(booking['status']),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                booking['status'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 24),
                        _buildDetailRow(
                            Icons.spa, 'Service', booking['service']),
                        _buildDetailRow(Icons.calendar_today, 'Drop-Off',
                            '${booking['dropOffDate']} at ${booking['dropOffTime']}'),
                        _buildDetailRow(Icons.event, 'Pick-Up',
                            '${booking['pickUpDate']} at ${booking['pickUpTime']}'),
                        if (booking['emergencyContact'].isNotEmpty)
                          _buildDetailRow(Icons.phone, 'Emergency',
                              booking['emergencyContact']),
                        if (booking['specialNotes'].isNotEmpty)
                          _buildDetailRow(
                              Icons.note, 'Notes', booking['specialNotes']),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              booking['totalCost'],
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                              ),
                            ),
                            Row(
                              children: [
                                OutlinedButton.icon(
                                  icon: const Icon(Icons.edit, size: 18),
                                  label: const Text('Status'),
                                  onPressed: () {
                                    _showStatusDialog(
                                        widget.bookings.indexOf(booking));
                                  },
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.payment, size: 18),
                                  label: const Text('Pay'),
                                  onPressed: () =>
                                      _processPayment(context, booking),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.add),
        label: const Text('New Booking'),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Confirmed':
        return Colors.blue;
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showStatusDialog(int bookingIndex) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Booking Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children:
              ['Pending', 'Confirmed', 'Completed', 'Cancelled'].map((status) {
            return ListTile(
              title: Text(status),
              leading: Icon(
                Icons.circle,
                color: _getStatusColor(status),
                size: 16,
              ),
              onTap: () {
                _updateBookingStatus(bookingIndex, status);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
