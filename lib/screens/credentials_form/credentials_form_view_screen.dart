import 'package:flutter/material.dart';

import 'credentials_form_constants.dart';

import 'package:ekmajstro_trejnisto/utils/utils.dart';
import 'package:ekmajstro_trejnisto/components/components.dart';

class CredentialsFormViewScreen extends StatefulWidget {
  const CredentialsFormViewScreen({super.key});

  @override
  State<CredentialsFormViewScreen> createState() =>
      _CredentialsFormViewScreenState();
}

class _CredentialsFormViewScreenState extends State<CredentialsFormViewScreen> {
  Map<String, String> _credentials = {};

  @override
  void initState() {
    super.initState();

    loadCredentials();
  }

  loadCredentials() {
    getCredentials().then((credentials) {
      if (!mounted) return;
      setState(() {
        _credentials = credentials;
      });
    });
  }

  updateCredentials() {
    saveCredentials(_credentials).then((_) {
      showMessage(
        SAVE_CREDENTIALS_SUCCESS_MESSAGE,
        context,
      );
    }).catchError((error) {
      showMessage(
        SAVE_CREDENTIALS_ERROR_MESSAGE,
        context,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  [
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                  _credentials.keys
                      .map<Widget>(
                        (key) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Text(
                                  getCredentialLabel(key),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: TextField(
                                  controller: TextEditingController(
                                    text: getCredentialField(key)
                                        .getValue(_credentials),
                                  ),
                                  onChanged: (newValue) {
                                    getCredentialField(key)
                                        .setValue(_credentials, newValue);
                                  },
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    hintText:
                                        "Ingrese ${getCredentialLabel(key)}",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  [
                    Center(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                          textStyle: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                        ),
                        onPressed: updateCredentials,
                        child: Text(
                          SAVE_CREDENTIALS,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ]
                ].expand((x) => x).toList(),
              ),
            ),
          ),
        ),
        const FABEkmajstroComponent(),
      ],
    );
  }
}
