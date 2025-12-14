import 'package:flutter/material.dart';
import 'package:sama_taxi/core/widgets/index.dart';
import 'package:sama_taxi/features/auth/presentation/widgets/login_form.dart';

class AuthContent extends StatelessWidget {
  const AuthContent({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) => SlideInAnimation(
    begin: const Offset(0, 0.2),
    delay: const Duration(milliseconds: 700),
    child:  LoginForm(),
  );
}
