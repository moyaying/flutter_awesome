import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_awesome_app/pages/common/common.dart';
import 'package:flutter_awesome_app/pages/login/authentication/authentication.dart';
import 'package:flutter_awesome_app/pages/login/page/login_page.dart';
import 'package:flutter_awesome_app/pages/login/user_repository/user_repository.dart';
import 'package:flutter_awesome_app/pages/tabbars_frame.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LauncherPage extends StatelessWidget {
  final UserRepository userRepository;

  LauncherPage({this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationSuccess) {
          return TabBarsFrame();
        }
        if (state is AuthenticationFailure) {
          return LoginPage(userRepository: userRepository);
        }
        if (state is AuthenticationInProgress) {
          return Scaffold(body: LoadingIndicator());
        }

        return Scaffold(
          body: Center(
            child: Text('Splash Screen'),
          ),
        );
      },
    );
  }
}
