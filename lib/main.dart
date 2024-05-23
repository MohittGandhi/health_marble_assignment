import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'dynamic_form.dart';
import 'form_store.dart';

void main() {
  GetIt.I.registerSingleton<FormStore>(FormStore());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GetIt.I<FormStore>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Watermeter Quarterly Check',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watermeter Quarterly Check'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              GetIt.I<FormStore>().submitForm(context);
            },
          ),
        ],
      ),
      body: DynamicForm(),
    );
  }
}
