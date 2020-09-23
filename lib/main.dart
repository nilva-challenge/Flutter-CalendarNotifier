import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/injection_container.dart' as di;
import 'features/google_calender/presentation/bloc/calender_bloc.dart';
import 'features/google_calender/presentation/pages/calender_page.dart';

main() async {
  await di.init();
  runApp(Root());
}

class Root extends StatelessWidget {
  const Root({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CalenderBloc>(
      create: (_) => di.sl(),
      child: MaterialApp(
        title: 'Calendar App',
        theme: ThemeData.dark().copyWith(
          accentColor: Colors.amber,
        ),
        home: CalenderPage(),
      ),
    );
  }
}
