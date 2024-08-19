import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Landslide Detection System',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoginMode = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _toggleMode() {
    setState(() {
      _isLoginMode = !_isLoginMode;
    });
  }

  void _navigateToDetailsPage(BuildContext context) {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        (_isLoginMode || _confirmPasswordController.text.isNotEmpty)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailsPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Landslide Detection System'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _isLoginMode ? 'Login' : 'Sign Up',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                _isLoginMode ? _buildLoginForm() : _buildSignUpForm(),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _navigateToDetailsPage(context),
                  child: Text(_isLoginMode ? 'Login' : 'Sign Up'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _toggleMode,
                  child: Text(
                      _isLoginMode ? 'Switch to Sign Up' : 'Switch to Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
        ),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
      ],
    );
  }

  Widget _buildSignUpForm() {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
        ),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        TextField(
          controller: _confirmPasswordController,
          decoration: InputDecoration(labelText: 'Confirm Password'),
          obscureText: true,
        ),
      ],
    );
  }
}

class DetailsPage extends StatelessWidget {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();

  void _navigateToHomePage(BuildContext context) {
    if (_nameController.text.isNotEmpty &&
        _addressController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _locationController.text.isNotEmpty &&
        _phoneController.text.length == 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Details submitted successfully!')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields with valid data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        title: Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            ),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _navigateToHomePage(context);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _opacity = 1.0;
  bool _showContent = false;

  @override
  void initState() {
    super.initState();
    _startFadeOut();
  }

  void _startFadeOut() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _opacity = 0.0;
    });
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _showContent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Text('View Map'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapPage(),
                  ),
                );
              },
            ),
            // Add more menu items here
          ],
        ),
      ),
      body: Center(
        child: _showContent
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hello !!',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 16),
                  Text('Main content goes here.'),
                ],
              )
            : AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(seconds: 2),
                child: Text(
                  'Welcome to the Landslide Detection System',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
      ),
    );
  }
}

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('View Map'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            // Add more menu items here if needed
          ],
        ),
      ),
      body: WebView(
        initialUrl:
            'https://www.google.com/maps/d/u/0/embed?mid=1Q1a8akda8eH_D_HXuV970-U-_LjQVVw&ehbc=2E312F',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
