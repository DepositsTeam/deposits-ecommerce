import 'package:deposits_ecommerce/deposits_ecommerce.dart';
import 'package:flutter_switch/flutter_switch.dart';

class MerchantFlow extends StatefulWidget {
 const MerchantFlow({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MerchantFlow> createState() => _MerchantFlowState();
}

class _MerchantFlowState extends State<MerchantFlow> {
  bool isSwitched = false;
  var envMode = false;
  var apiKey = dotenv.env['apiKeyLive']!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Center(
         child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
            children:  <Widget>[
              const SizedBox(height: 30,),
              const Text(
                'E-commerce SDK Test (Merchant Flow).',
                style: TextStyle(fontSize:18, fontWeight: FontWeight.w700 ),
              ),
                 Container(
                  margin: const EdgeInsets.only(top: (10.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Use in DEVELOPMENT',
                        style: TextStyle(color: Colors.black, fontSize: 16),
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
              const SizedBox(height: 30,),
              depositsMerchantWidget(
                context,
                const ButtonConfig(buttonText: 'Shop',textStyle: TextStyle(color: Colors.black),
                ),
              merchantID: '',
              apiKey: apiKey,
              envMode: envMode,
                // initialScreen: const MerchantFlow(title: 'E-commerce SDK Test (Merchant Flow)')
              ),
            ],
          ),
        ),
      ),
    );
  }
}