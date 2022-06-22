import 'package:deposits_ecommerce/deposits_ecommerce.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CustomerFlow extends StatefulWidget {
  const CustomerFlow({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CustomerFlow> createState() => _CustomerFlowState();
}

class _CustomerFlowState extends State<CustomerFlow> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  bool isEmailEntered = false;
  bool isSwitched = false;
  var envMode = false;
  var apiKey = dotenv.env['apiKeyLive']!;
  int id = 1;
  String radioSelectedColor = 'FF0DB9E9';

  void toggle() {
    setState(() {
      isEmailEntered = !isEmailEntered;
    });
    if (isSwitched) {
      setState(() {
        apiKey = dotenv.env['apiKeySandbox']!;
        envMode = true;
      });
    } else {
      setState(() {
        apiKey = dotenv.env['apiKeyLive']!;
        envMode = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'E-commerce SDK Test (Customer Flow).',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                isEmailEntered
                    ? Container()
                    : Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: (10.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Use in DEVELOPMENT',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                FlutterSwitch(
                                  value: isSwitched,
                                  activeColor: Colors.green,
                                  showOnOff: true,
                                  onToggle: (value) {
                                    setState(() {
                                      isSwitched = value;
                                    });
                                    if (isSwitched) {
                                      setState(() {
                                        apiKey = dotenv.env['apiKeySandbox']!;
                                        envMode = true;
                                      });
                                    } else {
                                      setState(() {
                                        apiKey = dotenv.env['apiKeyLive']!;
                                        envMode = false;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: (15.0)),
                            child: const Text(
                              'SELECT CUSTOMIZATION COLOR',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: (2.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      value: 1,
                                      groupValue: id,
                                      activeColor:
                                          Color(int.parse("0xFF0DB9E9")),
                                      onChanged: (val) {
                                        setState(() {
                                          radioSelectedColor = 'FF0DB9E9';
                                          id = 1;
                                        });
                                      },
                                    ),
                                    const Text(
                                      'BLUE',
                                      style: TextStyle(fontSize: 17.0),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 2,
                                      groupValue: id,
                                      activeColor: Colors.purple,
                                      onChanged: (val) {
                                        setState(() {
                                          radioSelectedColor = 'FFA020F0';
                                          id = 2;
                                        });
                                      },
                                    ),
                                    const Text(
                                      'PURPLE',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 3,
                                      groupValue: id,
                                      activeColor: Colors.red,
                                      onChanged: (val) {
                                        setState(() {
                                          radioSelectedColor = 'FFFF0000';
                                          id = 3;
                                        });
                                      },
                                    ),
                                    const Text(
                                      'RED',
                                      style: TextStyle(fontSize: 17.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                isEmailEntered
                    ? Container()
                    : Container(
                        child: FlatButton(
                          minWidth: MediaQuery.of(context).size.width,
                          height: 56,
                          color: Color(int.parse(
                              "0x$radioSelectedColor")), //Color(0xFF0DB9E9),
                          child: const Text('Proceed',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              toggle();
                            }
                          },
                        ),
                        margin: const EdgeInsets.only(top: (30.0))),
                const SizedBox(
                  height: 30,
                ),
                Visibility(
                    visible: isEmailEntered,
                    child: depositsCustomerWidget(
                      context,
                      merchantId: '1',
                      customerID: '1',
                      customColor: radioSelectedColor,
                      envMode: envMode,
                      apiKey: apiKey,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
