import 'package:flutter/material.dart';

class FormStore extends ChangeNotifier {
  List<FormComponent> components = [FormComponent()];

  void addComponent() {
    components.add(FormComponent());
    notifyListeners();
  }

  void removeComponent(int index) {
    if (components.length > 1) {
      components.removeAt(index);
      notifyListeners();
    }
  }

  void submitForm(BuildContext context) {
    // Create the content for the dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Form Submission'),
          content: SingleChildScrollView(
            child: ListBody(
              children: components.asMap().entries.map((entry) {
                int index = entry.key;
                FormComponent component = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Component ${index + 1}:'),
                    Text('Label: ${component.label}'),
                    Text('Info-Text: ${component.infoText}'),
                    Text('Settings: ${component.getSelectedSetting()}'),
                    SizedBox(height: 16),
                  ],
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class FormComponent {
  String label = '';
  String infoText = '';
  Map<String, bool> settings = {
    'Required': false,
    'Readonly': false,
    'Hidden Field': false,
  };

  String getSelectedSetting() {
    return settings.entries
        .firstWhere((entry) => entry.value,
            orElse: () => MapEntry('None', false))
        .key;
  }

  void updateSetting(String key) {
    settings.updateAll((k, v) => false);
    settings[key] = true;
  }
}
