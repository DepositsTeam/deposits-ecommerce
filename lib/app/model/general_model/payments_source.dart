class PaymentSource{
  final int? itemId;
  final double? amount;
  final String? productName;
  final String? productImage;
  final String? paymentId;
  final String? paymentType;
  final String? time;
  final String? deliveryAddress;
  final String? orderStatus;
  final String? from;

  PaymentSource({
    this.itemId,
    this.amount,
    this.productName,
    this.productImage,
    this.paymentId,
    this.paymentType,
    this.time,
    this.deliveryAddress,
    this.orderStatus,
    this.from
  });
}

 List<PaymentSource> paymentSourceList = [
   PaymentSource(
     itemId: 1,
     amount: 12.25,
     productName: 'Nike Dri-FIT NY vs. NY (Black) - 2XL',
     productImage: 'https://cdn-images.farfetch-contents.com/16/35/33/40/16353340_33073712_1000.jpg',
     paymentId: '#68869499484',
     paymentType: 'DEUTDFJKDKD',
     time: '1:34pm',
     deliveryAddress: '33 Meadow, 04605, Ellisworth',
     orderStatus: 'Pending',
     from: 'From Johnalves@gmail.com'
    ),
      PaymentSource(
     itemId: 2,
     amount: 12.25,
     productName: 'Addida Dri-FIT NY vs. NY (Black) - 2XL',
     productImage: 'https://cdn-images.farfetch-contents.com/16/35/33/40/16353340_33073712_1000.jpg',
     paymentId: '#68869499484',
     paymentType: 'DEUTDFJKDKD',
     time: '1:34pm',
     deliveryAddress: '33 Meadow, 04605, Ellisworth',
     orderStatus: 'Pending',
     from: 'From Johnalves@gmail.com'
    ),
      PaymentSource(
     itemId: 4,
     amount: 12.25,
     productName: 'Puma Dri-FIT NY vs. NY (Black) - 2XL',
     productImage: 'https://cdn-images.farfetch-contents.com/16/35/33/40/16353340_33073712_1000.jpg',
     paymentId: '#68869499484',
     paymentType: 'DEUTDFJKDKD',
     time: '1:34pm',
     deliveryAddress: '33 Meadow, 04605, Ellisworth',
     orderStatus: 'Pending',
     from: 'From Johnalves@gmail.com'
    ),
      PaymentSource(
     itemId: 5,
     amount: 12.25,
     productName: 'Rebokk Dri-FIT NY vs. NY (Black) - 2XL',
     productImage: 'https://cdn-images.farfetch-contents.com/16/35/33/40/16353340_33073712_1000.jpg',
     paymentId: '#68869499484',
     paymentType: 'DEUTDFJKDKD',
     time: '1:34pm',
     deliveryAddress: '33 Meadow, 04605, Ellisworth',
     orderStatus: 'Pending',
     from: 'From Johnalves@gmail.com'
    ),
      PaymentSource(
     itemId: 6,
     amount: 12.25,
     productName: 'Versace Dri-FIT NY vs. NY (Black) - 2XL',
     productImage: 'https://cdn-images.farfetch-contents.com/16/35/33/40/16353340_33073712_1000.jpg',
     paymentId: '#68869499484',
     paymentType: 'DEUTDFJKDKD',
     time: '1:34pm',
     deliveryAddress: '33 Meadow, 04605, Ellisworth',
     orderStatus: 'Pending',
     from: 'From Johnalves@gmail.com'
    ),
 ];