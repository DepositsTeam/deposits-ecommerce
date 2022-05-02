// ignore_for_file: deprecated_member_use, avoid_print


import 'package:deposits_ecommerce/deposits_ecommerce.dart';
import 'package:example/customer.dart';
import 'package:example/merchant.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            children: <Widget>[
              Container(
                  child: FlatButton(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 56,
                    color: Colors.blue, //Color(0xFF0DB9E9),
                    child: const Text('Continue as Merchant',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MerchantFlow(
                                  title: 'Merchant Flow',
                                )),
                      );
                    },
                  ),
                  margin: const EdgeInsets.only(top: (30.0))),
              Container(
                  child: FlatButton(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 56,
                    color: Colors.blue, //Color(0xFF0DB9E9),
                    child: const Text('Continue as Customer',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CustomerFlow(
                                  title: 'Customer Flow',
                                )),
                      );
                    },
                  ),
                  margin: const EdgeInsets.only(top: (30.0))),
              Container(
                  margin: const EdgeInsets.only(top: (30.0)),
                  child: FlatButton(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 56,
                    color: Colors.blue, //Color(0xFF0DB9E9),
                    child: const Text('Shop Context',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    onPressed: () async {
                      DepositsEcommerceContext depositsEcommerceContext =
                          DepositsEcommerceContext(
                              envMode: true,
                              depositsUserID: '546');
                      depositsEcommerceContext.setupShop(context);
                    },
                  )),
               Container(
                  margin: const EdgeInsets.only(top: (30.0)),
                  child: FlatButton(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 56,
                    color: Colors.blue, //Color(0xFF0DB9E9),
                    child: const Text('Show Shop Context',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    onPressed: () async {
                      DepositsEcommerceContext depositsEcommerceContext =
                          DepositsEcommerceContext(
                              envMode: true,
                              depositsUserID: '546',
                              merchantID: 1
                              );
                      depositsEcommerceContext.showShop(context,customerID: 1);
                    },
                  )),
               Container(
                  margin: const EdgeInsets.only(top: (30.0)),
                  child: FlatButton(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 56,
                    color: Colors.blue, //Color(0xFF0DB9E9),
                    child: const Text('Run APIs',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    onPressed: () async {
                      print("-----------------------------------------------------");
                      DepositsApi depositsApi = DepositsApi(apiKey: 'deposits-ecommerce-test', isProduction: false, isDebug: true);

                      print("======>>>>>>");
                      var categoryApiResponse = await depositsApi.getCategories();
                      print("categoryApiResponse $categoryApiResponse");

                      print("======>>>>>>");
                      var setUpShopApiResponse = await depositsApi.setupMerchant('233', 'demo shop', 'my demo shop', 'support@example.com', 'Electronics', '500443', 'Mina avenue', 'Dallas', 'Texas', 'USA');
                      print("setUpShopApiResponse $setUpShopApiResponse");

                      print("======>>>>>>");
                      var getMerchantApiResponse = await depositsApi.getMerchant('22');
                      print("getMerchantApiResponse $getMerchantApiResponse");

                      print("======>>>>>>");
                      var getMerchantInfoApiResponse = await depositsApi.getMerchantInfo('22');
                      print("getMerchantInfoApiResponse $getMerchantInfoApiResponse");

                      print("======>>>>>>");
                      var getSelectedMerchantsApiResponse = await depositsApi.getSelectedMerchants(['22']);
                      print("getSelectedMerchantsApiResponse $getSelectedMerchantsApiResponse");

                      print("======>>>>>>");
                      var updateMerchantApiResponse = await depositsApi.updateMerchant('22', 'demo shop', 'my demo shop', 'support@example.com', 'Electronics', '500443', 'Mina avenue', 'Dallas', 'Texas', 'USA');
                      print("updateMerchantApiResponse $updateMerchantApiResponse");

                      print("======>>>>>>");
                      var updateMerchantContactInfoApiResponse = await depositsApi.updateMerchantContactInfo('22', 'mysupport@example.com', '74 clinoda avenue, dave town');
                      print("updateMerchantContactInfoApiResponse $updateMerchantContactInfoApiResponse");

                      print("======>>>>>>");
                      var updateMerchantPolicyApiResponse = await depositsApi.updateMerchantPolicy('22', 'we allow return but only if item is not defected', 'when we ship an order can not be cancelled and we deliver straight to your door step');
                      print("updateMerchantPolicyApiResponse $updateMerchantPolicyApiResponse");

                      print("======>>>>>>");
                      var updateMerchantShippingAndTaxInfoApiResponse = await depositsApi.updateMerchantShippingAndTaxInfo('22', '893883HHHJH', '20%', '30');
                      print("updateMerchantShippingAndTaxInfoApiResponse $updateMerchantShippingAndTaxInfoApiResponse");

                      print("======>>>>>>");
                      var createAssetApiResponse = await depositsApi.createAsset('22', 'file/csdvhrufre.png', 'my product', 'front image for my product');
                      print("createAssetApiResponse $createAssetApiResponse");

                      print("======>>>>>>");
                      var createProductApiResponse = await depositsApi.createProduct('22', 'HGDYU7374743', 'my product', '34', 'my book to help you sell', '3', 'true', '', '3', '10', {}, {});
                      print("createProductApiResponse $createProductApiResponse");

                      // customer side
                      print("======>>>>>>");
                      var createCustomerApiResponse = await depositsApi.createCustomer('22','calmpress@gmail.com','james','Bova','null','null',{'address':'null'});
                      print("createCustomerApiResponse $createCustomerApiResponse");

                      print("======>>>>>>");
                      var findCustomerApiResponse = await depositsApi.findCustomer('22','calmpress@gmail.com');
                      print("findCustomerApiResponse $findCustomerApiResponse");
                      
                      print("======>>>>>>");
                      var getProductsApiResponse = await depositsApi.getProducts('22');
                      print("getProductsApiResponse $getProductsApiResponse");
                      
                      print("======>>>>>>");
                      var getProductApiResponse = await depositsApi.getProduct('22', '2');
                      print("getProductApiResponse $getProductApiResponse");
                      
                      print("======>>>>>>");
                      var getFeaturedProductsApiResponse = await depositsApi.getFeaturedProducts('22');
                      print("getFeaturedProductsApiResponse $getFeaturedProductsApiResponse");

                      print("-----------------------------------------------------");
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
