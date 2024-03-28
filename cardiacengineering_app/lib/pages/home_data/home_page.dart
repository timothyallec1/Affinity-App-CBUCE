import 'package:flutter/material.dart';
import 'package:jr_design_app/components/data_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/background_gradient_container.dart';
import '../../pages/dev_settings/settings_page.dart';
import 'rpm_page.dart';
import 'psi_page.dart';
import 'battery_page.dart';
import 'gpm_page.dart';
import 'record_now_page.dart';

typedef OnDataBoxPressedCallback = void Function(BuildContext context);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String blood_pressure = '0'; // Initialize blood pressure with '0'
  String bpm = '0'; // Initialize heart rate with '0'
  String flow_rate = '0'; // Initialize flow rate with '0'
  String power_consumption = '0'; // Initialize power consumption with '0'

  @override
  void initState() {
    super.initState();
    _initBloodPressureListener(); // Call function to listen for blood pressure changes
    _initHeartRateListener(); // Call function to listen for heart rate changes'
    _initFlowRateListener(); // Call function to listen for flow rate changes
    _initPowerConsumptionListener(); // Call function to listen for power consumption changes
  }

  void _initBloodPressureListener() {
    FirebaseFirestore.instance
        .collection('sensor_data')
        .doc('blood_pressure')
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        String mmHg =
            (snapshot.data() as Map<String, dynamic>)?['mmHg'] as String;
        if (mmHg != null) {
          setState(() {
            blood_pressure = mmHg; // Update blood pressure state variable
          });
        } else {
          setState(() {
            blood_pressure = 'Unknown'; // Set to 'Unknown' if mmHg is null
          });
        }
      }
    });
  }

  void _initHeartRateListener() {
    FirebaseFirestore.instance
        .collection('sensor_data')
        .doc('bpm')
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        String beatsPerMin = (snapshot.data()
            as Map<String, dynamic>)?['beats per minute'] as String;
        if (beatsPerMin != null) {
          setState(() {
            bpm = beatsPerMin; // Update blood pressure state variable
          });
        } else {
          setState(() {
            bpm = 'Unknown'; // Set to 'Unknown' if mmHg is null
          });
        }
      }
    });
  }

  void _initFlowRateListener() {
    FirebaseFirestore.instance
        .collection('sensor_data')
        .doc('flow_rate')
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        String litersPerMinute = (snapshot.data()
            as Map<String, dynamic>)?['liters per minute'] as String;
        if (litersPerMinute != null) {
          setState(() {
            flow_rate = litersPerMinute; // Update blood pressure state variable
          });
        } else {
          setState(() {
            flow_rate = 'Unknown'; // Set to 'Unknown' if mmHg is null
          });
        }
      }
    });
  }

  void _initPowerConsumptionListener() {
    FirebaseFirestore.instance
        .collection('sensor_data')
        .doc('power_consumption')
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        String wattsPerHour = (snapshot.data()
            as Map<String, dynamic>)?['watts per hour'] as String;
        if (wattsPerHour != null) {
          setState(() {
            power_consumption =
                wattsPerHour; // Update blood pressure state variable
          });
        } else {
          setState(() {
            power_consumption = 'Unknown'; // Set to 'Unknown' if mmHg is null
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 86.0),
            Image.asset(
              'assets/images/logo.png',
              height: 50.0,
            ),
            const SizedBox(width: 5.0),
            const Text(
              'Affinity',
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: IconButton(
              icon: const Icon(Icons.account_circle),
              iconSize: 50.0,
              onPressed: () {
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
        child: Center(
          child: Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).padding.top +
                      kToolbarHeight +
                      20), // Added space
              _buildDataBox(
                context,
                label: 'Blood Pressure',
                value: '15.6',
                iconPath: 'assets/images/Blood.png',
                iconSize: 50.0,
                labelFontSize: 20.0,
                valueFontSize: 20.0,
                borderRadius: 20.0,
                onPressed: (context) {
                  Navigator.pushNamed(context, '/PSIpage');
                },
              ),
              _buildDataBox(
                context,
                label: 'Heart Rate',
                value: '60.2',
                iconPath: 'assets/images/Heart.png',
                iconSize: 50.0,
                labelFontSize: 20.0,
                valueFontSize: 20.0,
                borderRadius: 20.0,
                onPressed: (context) {
                  Navigator.pushNamed(context, '/RPMpage');
                },
              ),
              _buildDataBox(
                context,
                label: 'Flow Rate',
                value: '97%',
                iconPath: 'assets/images/Flow.png',
                iconSize: 50.0,
                labelFontSize: 20.0,
                valueFontSize: 20.0,
                borderRadius: 20.0,
                onPressed: (context) {
                  Navigator.pushNamed(context, '/GPMpage');
                },
              ),
              _buildDataBox(
                context,
                label: 'Battery Life',
                value: '100',
                iconPath: 'assets/images/Battery.png',
                iconSize: 50.0,
                labelFontSize: 20.0,
                valueFontSize: 20.0,
                borderRadius: 20.0,
                onPressed: (context) {
                  Navigator.pushNamed(context, '/BatteryPage');
                },
              ),
              DataBox(
                label: 'Record Now',
                value: '',
                iconPath: 'assets/images/logo.png',
                onPressed: (context) {
                  Navigator.pushNamed(context, '/RecordNow');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
