import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'form_store.dart';

class DynamicForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Object',
            ),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Zahler nummer *',
            ),
          ),
          Expanded(
            child: Consumer<FormStore>(
              builder: (context, formStore, child) {
                return ListView.builder(
                  itemCount: formStore.components.length,
                  itemBuilder: (context, index) {
                    return DynamicFormComponent(index: index);
                  },
                );
              },
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: GetIt.I<FormStore>().addComponent,
            child: Text('ADD'),
          ),
        ],
      ),
    );
  }
}

class DynamicFormComponent extends StatelessWidget {
  final int index;

  DynamicFormComponent({required this.index});

  @override
  Widget build(BuildContext context) {
    var formStore = GetIt.I<FormStore>();
    var component = formStore.components[index];

    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Label',
              style: TextStyle(fontSize: 15),
            ),
            TextField(
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
              ),
              onChanged: (value) {
                component.label = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Info-Text',
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
              style: TextStyle(fontSize: 15),
            ),
            TextField(
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
              ),
              onChanged: (value) {
                component.infoText = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text('Settings:'),
                Checkbox(
                  value: component.settings['Required'],
                  onChanged: (bool? value) {
                    component.updateSetting('Required');
                    formStore.notifyListeners();
                  },
                ),
                Text('Required'),
                Checkbox(
                  value: component.settings['Readonly'],
                  onChanged: (bool? value) {
                    component.updateSetting('Readonly');
                    formStore.notifyListeners();
                  },
                ),
                Text('Readonly'),
                Checkbox(
                  value: component.settings['Hidden Field'],
                  onChanged: (bool? value) {
                    component.updateSetting('Hidden Field');
                    formStore.notifyListeners();
                  },
                ),
                Text('Hidden Field'),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    formStore.removeComponent(index);
                  },
                  child: Text('Remove'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Done'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
