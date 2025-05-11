// lib/features/auth/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  // ... other controllers

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                items: const [
                  DropdownMenuItem(value: 'general', child: Text('Fan/General User')),
                  DropdownMenuItem(value: 'coach', child: Text('Team Manager/Coach')),
                ],
                onChanged: (value) => setState(() {}),
                decoration: const InputDecoration(labelText: 'Account Type'),
              ),
              // Conditionally show form fields based on user type
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value!.contains('@') ? null : 'Invalid email',
              ),
              // ... other fields
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _handleSignup,
                child: const Text('CREATE ACCOUNT'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSignup() {
    if (_formKey.currentState!.validate()) {
      // TODO: Realm user creation
      context.go('/login');
    }
  }
}