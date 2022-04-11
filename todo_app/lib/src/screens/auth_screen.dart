import 'package:flutter/material.dart';
import 'package:todo_app/src/classes/auth_controller.dart';
import 'package:todo_app/src/screens/todo_screen.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _authController,
      builder: (context, Widget? w) {
        if (_authController.currentUser == null) {
          return AuthScreen(_authController);
        } else {
          return TodoScreen(_authController);
        }
      },
    );
  }
}

class AuthScreen extends StatefulWidget {
  final AuthController auth;
  const AuthScreen(this.auth, {Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _unCon = TextEditingController(),
      _passCon = TextEditingController();
  AuthController get _auth => widget.auth;
  String prompts = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.lightGreen,
            ],
          )),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  onChanged: () {
                    _formKey.currentState?.validate();
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.assignment_turned_in_outlined,
                            size: 45,
                          ),
                          Text(
                            'TodoLista',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Manage everything from grocery lists to work-related tasks and more.',
                        style: TextStyle(
                          fontSize: 9,
                          letterSpacing: 1,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16),
                      ),
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.people, color: Colors.white),
                          errorStyle: const TextStyle(
                              color: Color(0xFFB71C1C),
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintText: 'Username',
                          hintStyle: const TextStyle(color: Colors.white38),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                        controller: _unCon,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.vpn_key_outlined,
                              color: Colors.white),
                          errorStyle: const TextStyle(
                              color: Color(0xFFB71C1C),
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Colors.white38),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                        controller: _passCon,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            prompts,
                            style: const TextStyle(
                                color: Color(0xFFB71C1C),
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          )),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed:
                                    (_formKey.currentState?.validate() ?? false)
                                        ? () {
                                            bool result = _auth.login(
                                                _unCon.text, _passCon.text);
                                            if (!result) {
                                              setState(() {
                                                prompts =
                                                    'Error: Username or password may be incorrect or the user has not been registered yet.';
                                              });
                                            }
                                          }
                                        : null,
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    minimumSize: const Size(145, 45),
                                    primary:
                                        (_formKey.currentState?.validate() ??
                                                false)
                                            ? Colors.black
                                            : Colors.grey),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account?",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextButton(
                                    onPressed:
                                        (_formKey.currentState?.validate() ??
                                                false)
                                            ? () {
                                                String result = _auth.register(
                                                    _unCon.text, _passCon.text);
                                                setState(() {
                                                  prompts = result;
                                                });
                                              }
                                            : null,
                                    style: ElevatedButton.styleFrom(
                                        primary: (_formKey.currentState
                                                    ?.validate() ??
                                                false)
                                            ? Colors.black
                                            : Colors.grey),
                                    child: const Text(
                                      'Register',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
