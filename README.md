
<img  src="https://assets.deposits.com/img/checkout/sdk-image.png"  height="36"  />

# Deposits Commerce SDK

[![pub package](https://img.shields.io/pub/v/flutter_stripe.svg)](https://pub.dev/packages/deposits_commerce)

The Deposits commerce SDK is an easy to embed commerce system for  allowing creators to setup and operate an online store without owning an e-commerce website. Empowering vendors to launch commerce feature without the engineering time at less the cost of building commerce capabilities internally. Shoppers can view products and checkout one item at a time from each vendor's store without leaving the application .

![deposits-one-click-checkout-flutter_cover](https://assets.deposits.com/img/checkout/sdk-banner.png)

## Installation

pubspec.yaml :

```sh
dependencies:

flutter:

sdk: flutter

deposits_ecommerce: <Latest version>

```

Terminal :

```sh
flutter pub add deposits_one_click_checkout
```

## Features

- Create Store.
- Customer Management
- Cart Management.
- Order Management.
- Products management.
- Categories.
- Shipping Address Management.
- Merchant management.
- Etc and more.
  
### Requirements

#### Android

This plugin requires several changes to be able to work on Android devices. Please make sure you follow all these steps:

1. Use Android 5.0 (API level 21) and above

2. Rebuild the app, as the above changes don't update with hot reload

#### iOS

Compatible with apps targeting iOS 10 or above.

#### Web

We do not support the web via this plugin for now

## Usage

The library provides a UI component for creating and managing stores and managing customers.

### Customer Management/Flow Example

```dart
    depositsCustomerWidget(
      context,
      merchantId: '1',
      customerID: '1',
      envMode: envMode,
      apiKey: apiKey ,
    )
```

### Merchant Management/Flow Example

```dart
    depositsMerchantWidget(
      context,
      ButtonConfig(buttonText: 'buttonText'),
      merchantID: '',
      apiKey: apiKey,
      envMode: envMode,
     )
````

 Parameter, [buttonText] is the name you want on the button

 Parameter [merchantID] is the id of the merchant(whom you want to display their products) provided by Deposits API when the merchant was created, e.g. `43cba34n65l`.

 Parameter [customerID] is the id of the customer which is the user about to buy/purchase something provided by the Deposits API when the customer was created, e.g. `98iei74uij`.

  Parameter [apiKey] is the key for the merchant provided byt Deposits API when the merchant was created, e.g. `deposits-ecommerce-test`.

 Parameter [`envMode`], tells the library if it should use the staging or the live environment.
  /// Useful if you are debuging or in development.

  The goal of Deposits Commerce SDK is to make building amazing Ecommerce apps with flutter and Deposits as easy as can be and help improve your workflow.

## Deposit Commerce SDK initialization

To initialize Deposit Ecommerce Customer Management/Flow in your Flutter app, use the `depositsCustomerWidget` and `depositsMerchantWidget` for Deposits Ecommerce Merchant Management/Flow

`depositsCustomerWidget` and `depositsMerchantWidget` offers `context`, `buttonConfig`, `initialScreen`, `envMode`, `merchantID` and `customerID`, `apiKey`. Only `apiKey`, `envMode` and `buttonConfig` (which has the following params : `amount` required, `textStyle`, `height`, `minwidth` , etc as customizable widgets ) is required. `envMode` is either true or false as a bool.

## Dart API

deposits

The library offers several methods to handle both customer and merchant related actions:

```dart
import 'package:deposits_ecommerce/deposits_ecommerce.dart';

DepositsApi depositsApi = DepositsApi(
    apiKey: 'deposits-ecommerce-test', 
    isProduction: false, 
    isDebug: true
);

===================Merchant External API's===================
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


===================Customer External API's===================
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

```

The example app offers examples on how to use these methods.

## Run the example app

- Navigate to the example folder `cd example`

- Install the dependencies

- `flutter pub get`

- Set up env vars for the flutter app and a local backend.

- [Get your test API keys](https://console.deposits.dev)

- [Get your live API keys](https://console.deposits.com)

- Start the example

- Terminal 1: `flutter run`

## Contributing

Only members of the deposits team can contribute to this. You can create an issue if you find a bug or have any challenge using this SDK.
