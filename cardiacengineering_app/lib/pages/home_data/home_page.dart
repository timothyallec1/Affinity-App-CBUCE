// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:jr_design_app/pages/dev_settings/test_chart.dart';
import '../dev_settings/settings_page.dart'; // Import the settingsPage.dart
import 'rpm_page.dart';
import 'psi_page.dart';

import 'battery_page.dart';

import 'gpm_page.dart';

import '../../components/background_gradient_container.dart';

typedef OnDataBoxPressedCallback = void Function(BuildContext context);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents bottom overflow
      extendBodyBehindAppBar: true, // Extend the body behind the app bar
      appBar: AppBar(
        // basically the header
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove app bar elevation
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
                width: 86.0), // Add some space between the logo and text
            Image.asset(
              'assets/images/logo.png',
              height: 50.0,
            ),
            const SizedBox(
                width: 5.0), // Add some space between the logo and text
            const Text(
              'Affinity',
              style: TextStyle(
                fontSize: 30.0,
              ),
// Add some space between the logo and text
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
                right: 30.0), // Adjust the left padding as needed
            child: IconButton(
              icon: const Icon(Icons.account_circle),
              iconSize: 50.0, // Adjust the size as needed
              onPressed: () {
                // Navigate to the settings page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ),
        ],
      ),
      body: BackgroundGradientContainer(
        // custom class to have gradient already
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 150.0), // Move down to below the app bar
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width /
                  //       4, // or specify a fixed width
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       // Navigate to the settings page
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => const RPMpage()),
                  //       );
                  //     },
                  //     child:
                  //         _buildDataBox(context, label: 'RPM', value: '1000'),
                  //   ),
                  // ),
                  _buildDataBox(
                    context,
                    label: 'RPM',
                    value: '1000',
                    onPressed: (context) {
                      Navigator.pushNamed(context, '/RPMpage');
                    },
                  ),
                  _buildDataBox(
                    context,
                    label: 'PSI',
                    value: '50',
                    onPressed: (context) {
                      Navigator.pushNamed(context, '/PSIpage');
                    },
                  ),
                  _buildDataBox(
                    context,
                    label: 'Battery',
                    value: '96%',
                    onPressed: (context) {
                      Navigator.pushNamed(context, '/BatteryPage');
                    },
                  ),
                  _buildDataBox(
                    context,
                    label: 'GPM',
                    value: '100',
                    onPressed: (context) {
                      Navigator.pushNamed(context, '/GPMpage');
                    },
                  ),
                  // _buildDataBox(context, label: 'RPM', value: '1000'),
                  // _buildDataBox(context, label: 'RPM', value: '1000'),
                  // _buildDataBox(context, label: 'RPM', value: '1000'),
                ],
              ),
            ),
            const SizedBox(height: 20.0), // Add some space
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey[200],
                ),
                margin: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Placeholder for graph with dropdown
                    // Replace this with your actual graph widget
                    const SizedBox(height: 20.0),
                    const Text(
                      'Graph with Dropdown',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 20.0),
                    // Dropdown placeholder
                    DropdownButton<String>(
                      items: ['Data 1', 'Data 2', 'Data 3'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        // Handle dropdown value change
                      },
                      hint: const Text('Select Data'),
                    ),
                    const SizedBox(height: 20.0),
                    // Graph placeholder
                    Expanded(
                      child: Center(
                        // uncomment for test chart link
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const testChart()),
                            );
                          },
                          style: ButtonStyle(
                            // Add the animation controller
                            animationDuration:
                                const Duration(milliseconds: 200),
                            // Shrink on press
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors
                                      .white10; // Shrink and visually indicate press
                                }
                                return Colors
                                    .transparent; // Use default overlay color
                              },
                            ),
                            // Scale the button down slightly on press
                            padding:
                                MaterialStateProperty.resolveWith<EdgeInsets>(
                              (states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0);
                                }
                                return const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 12.0);
                              },
                            ),
                          ),
                          child: const Text('Go to testChart'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataBox(BuildContext context,
      {required String label,
      required String value,
      required OnDataBoxPressedCallback onPressed}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Navigate to the desired page using the provided callback
          onPressed(context);
        },
        child: Container(
          //width: MediaQuery.of(context).size.width / 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.grey[200],
          ),
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5.0),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}