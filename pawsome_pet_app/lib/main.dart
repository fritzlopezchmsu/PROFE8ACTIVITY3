import 'package:flutter/material.dart';

void main() {
  runApp(const PetDaycareApp());
}

// Helper function to format date without intl package
String formatDate(DateTime date) {
  final months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  return '${months[date.month - 1]} ${date.day}, ${date.year}';
}

// Global list to store registered users
class UserDatabase {
  static final List<Map<String, String>> _users = [];

  static void addUser(String email, String password, String name, String phone) {
    _users.add({
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
    });
  }

  static bool userExists(String email) {
    return _users.any((user) => user['email'] == email);
  }

  static bool validateUser(String email, String password) {
    return _users.any(
      (user) => user['email'] == email && user['password'] == password,
    );
  }

  static Map<String, String>? getUser(String email) {
    try {
      return _users.firstWhere((user) => user['email'] == email);
    } catch (e) {
      return null;
    }
  }
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
      home: const WelcomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Welcome Page - Choose Login or Register
class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.shade400, Colors.purple.shade800],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.pets,
                    size: 120,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Welcome to Pawsome',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Pet Daycare & Grooming Services',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegistrationPage()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'REGISTER',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      // Check if user exists in database
      if (!UserDatabase.userExists(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account not found. Please register first.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Validate credentials
      if (!UserDatabase.validateUser(email, password)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Incorrect password. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Login successful
      final user = UserDatabase.getUser(email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Welcome back, ${user!['name']}! 🐾')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BookingFormPage(userName: user['name']!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                  'Welcome Back',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistrationPage()),
                    );
                  },
                  child: const Text('Don\'t have an account? Register here'),
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
      final email = _emailController.text.trim();
      final password = _passwordController.text;
      final name = _nameController.text.trim();
      final phone = _phoneController.text.trim();

      // Check if user already exists
      if (UserDatabase.userExists(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email already registered. Please login instead.'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      // Register new user
      UserDatabase.addUser(email, password, name, phone);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account Created Successfully! Please login. 🎉'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Account'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create Your Account',
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
                    'REGISTER',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text('Already have an account? Login here'),
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
  final String userName;
  
  const BookingFormPage({Key? key, required this.userName}) : super(key: key);

  @override
  State<BookingFormPage> createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _petNameController = TextEditingController();
  final _specialNotesController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _otherPetTypeController = TextEditingController();

  // Form fields
  String _selectedService = 'Daycare Only';
  String _petType = 'Dog';
  String _petSize = 'Small';
  bool _needsFeeding = false;
  bool _hasVaccination = true;
  bool _needsMedication = false;
  DateTime? _dropOffDate;
  TimeOfDay? _dropOffTime;
  DateTime? _returnDate;
  TimeOfDay? _returnTime;

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
    _otherPetTypeController.dispose();
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
          _returnDate = picked;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isDropOff) async {
    // Get current time
    final now = TimeOfDay.now();
    final selectedDate = isDropOff ? _dropOffDate : _returnDate;
    
    // Check if selected date is today
    final isToday = selectedDate != null &&
        selectedDate.year == DateTime.now().year &&
        selectedDate.month == DateTime.now().month &&
        selectedDate.day == DateTime.now().day;

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // Validate time is between 10 AM and 8 PM
      if (picked.hour < 10 || picked.hour >= 20) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a time between 10:00 AM and 8:00 PM'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // If it's today, check if the selected time hasn't passed
      if (isToday) {
        final pickedMinutes = picked.hour * 60 + picked.minute;
        final nowMinutes = now.hour * 60 + now.minute;
        
        if (pickedMinutes <= nowMinutes) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Cannot select past time. Current time is ${now.format(context)}. Please select a future time.',
              ),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 4),
            ),
          );
          return;
        }
      }

      setState(() {
        if (isDropOff) {
          _dropOffTime = picked;
        } else {
          _returnTime = picked;
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

      // Validate "Other" pet type has custom input
      if (_petType == 'Other' && _otherPetTypeController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please specify your pet type'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final actualPetType = _petType == 'Other' 
          ? _otherPetTypeController.text.trim() 
          : _petType;

      final booking = {
        'petName': _petNameController.text,
        'service': _selectedService,
        'petType': actualPetType,
        'petSize': _petSize,
        'needsFeeding': _needsFeeding,
        'hasVaccination': _hasVaccination,
        'needsMedication': _needsMedication,
        'dropOffDate': formatDate(_dropOffDate!),
        'dropOffTime': _dropOffTime!.format(context),
        'pickUpDate': _returnDate != null
            ? formatDate(_returnDate!)
            : 'Same Day',
        'pickUpTime':
            _returnTime != null ? _returnTime!.format(context) : 'TBD',
        'emergencyContact': _emergencyContactController.text,
        'specialNotes': _specialNotesController.text,
        'paymentStatus': 'Unpaid',
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
    _otherPetTypeController.clear();
    _dropOffDate = null;
    _dropOffTime = null;
    _returnDate = null;
    _returnTime = null;
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

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const WelcomePage()),
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Pet Care - Hello, ${widget.userName}!'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.folder_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DocumentTrackerPage(bookings: _bookings),
                ),
              );
            },
            tooltip: 'View All Bookings',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Logout',
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
                      if (_petType != 'Other') {
                        _otherPetTypeController.clear();
                      }
                    });
                  },
                ),
              ),

              // Text field for "Other" pet type
              if (_petType == 'Other')
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: TextFormField(
                    controller: _otherPetTypeController,
                    decoration: const InputDecoration(
                      labelText: 'Specify Pet Type',
                      prefixIcon: Icon(Icons.pets),
                      border: OutlineInputBorder(),
                      hintText: 'e.g., Hamster, Guinea Pig, Ferret',
                    ),
                    validator: (value) {
                      if (_petType == 'Other' && (value == null || value.isEmpty)) {
                        return 'Please specify your pet type';
                      }
                      return null;
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
                    return DropdownMenuItem(value: service, child: Text(service));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedService = newValue!;
                    });
                  },
                ),
              ),

              const Text(
                'Schedule (10:00 AM - 8:00 PM)',
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

              // 8: Return Date and Time
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
                      label: Text(_returnDate == null
                          ? 'Select Date'
                          : formatDate(_returnDate!)),
                      onPressed: () => _selectDate(context, false),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.access_time),
                      label: Text(_returnTime == null
                          ? 'Select Time'
                          : _returnTime!.format(context)),
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
                subtitle: const Text('We\'ll administer prescribed meds (+₱200)'),
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
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: booking['paymentStatus'] == 'Paid'
                                        ? Colors.green
                                        : Colors.orange,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    booking['paymentStatus'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            _buildInfoRow('Service:', booking['service']),
                            _buildInfoRow(
                                'Pet Type:',
                                '${booking['petType']} (${booking['petSize']})'),
                            _buildInfoRow('Drop-Off:',
                                '${booking['dropOffDate']} at ${booking['dropOffTime']}'),
                            _buildInfoRow('Pick-Up:',
                                '${booking['pickUpDate']} at ${booking['pickUpTime']}'),
                            _buildInfoRow('Cost:', booking['totalCost']),
                            const SizedBox(height: 8),
                            if (booking['paymentStatus'] == 'Unpaid')
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton.icon(
                                    icon: const Icon(Icons.payment, size: 18),
                                    label: const Text('Pay Now'),
                                    onPressed: () {
                                      _showPaymentDialog(context, booking, index);
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

  void _showPaymentDialog(BuildContext context, Map<String, dynamic> booking, int index) {
    String? selectedPaymentMethod;
    
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text('Select Payment Method'),
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
                  const SizedBox(height: 20),
                  const Text(
                    'Choose Payment Method:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  RadioListTile<String>(
                    title: const Text('GCash'),
                    subtitle: const Text('Mobile wallet payment'),
                    secondary: const Icon(Icons.phone_android, color: Colors.blue),
                    value: 'GCash',
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setDialogState(() {
                        selectedPaymentMethod = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('PayMaya'),
                    subtitle: const Text('Digital payment'),
                    secondary: const Icon(Icons.account_balance_wallet, color: Colors.green),
                    value: 'PayMaya',
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setDialogState(() {
                        selectedPaymentMethod = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Credit/Debit Card'),
                    subtitle: const Text('Visa, Mastercard, etc.'),
                    secondary: const Icon(Icons.credit_card, color: Colors.orange),
                    value: 'Credit Card',
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setDialogState(() {
                        selectedPaymentMethod = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Cash on Arrival'),
                    subtitle: const Text('Pay when you arrive'),
                    secondary: const Icon(Icons.money, color: Colors.green),
                    value: 'Cash',
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setDialogState(() {
                        selectedPaymentMethod = value;
                      });
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
              ElevatedButton(
                onPressed: selectedPaymentMethod == null
                    ? null
                    : () {
                        Navigator.pop(dialogContext);
                        _confirmPayment(selectedPaymentMethod!, booking, index);
                      },
                child: const Text('Continue'),
              ),
            ],
          );
        },
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

  void _confirmPayment(String method, Map<String, dynamic> booking, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Payment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please confirm your payment details:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildPaymentInfoRow('Payment Method:', method),
            _buildPaymentInfoRow('Amount:', booking['totalCost']),
            _buildPaymentInfoRow('Pet:', booking['petName']),
            _buildPaymentInfoRow('Service:', booking['service']),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.orange.shade700),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      method == 'Cash'
                          ? 'Please bring exact amount on arrival'
                          : 'You will be redirected to payment gateway',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.orange.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
              _processPayment(method, booking, index);
            },
            child: const Text('Confirm & Pay'),
          ),
        ],
      ),
    );
  }

  void _processPayment(String method, Map<String, dynamic> booking, int index) {
    // Update payment status
    setState(() {
      _bookings[index]['paymentStatus'] = 'Paid';
      _bookings[index]['paymentMethod'] = method;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 16),
            const Text(
              'Payment Successful!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Payment Method: $method'),
            const SizedBox(height: 8),
            Text(
              'Amount: ${booking['totalCost']}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
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
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 45),
            ),
            child: const Text('Done'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
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
              itemCount: widget.bookings.length,
              itemBuilder: (context, index) {
                final booking = widget.bookings[index];
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
                                color: booking['paymentStatus'] == 'Paid'
                                    ? Colors.green
                                    : Colors.orange,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                booking['paymentStatus'],
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
                        if (booking['paymentStatus'] == 'Paid')
                          _buildDetailRow(Icons.payment, 'Paid via',
                              booking['paymentMethod'] ?? 'N/A'),
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
                            if (booking['paymentStatus'] == 'Unpaid')
                              ElevatedButton.icon(
                                icon: const Icon(Icons.payment, size: 18),
                                label: const Text('Pay Now'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  // This will trigger the payment in the main page
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
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
}
