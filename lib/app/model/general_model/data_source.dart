class DataSource{
  final int? itemId;
  final String? itemName;
  final String? itemDescription;
  final String? itemDetail;
  final List<String>? itemImages;
  final double? amount;
  final String? status;

  DataSource({
    this.itemId,
    this.itemName,
    this.itemDescription,
    this.itemDetail,
    this.itemImages,
    this.amount,
    this.status
  });
}

 List<DataSource> dataSourceList = [
   DataSource(
     itemId: 1,
      itemName: 'Shirt',
      itemDescription: 'Product name & attributes  in full details',
      itemDetail: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sagittis, tortor at faucibus tempor, nunc mauris luctus dui.',
      itemImages: [
      'https://cdn-images.farfetch-contents.com/16/35/33/40/16353340_33073712_1000.jpg',
      'https://cdn-images.farfetch-contents.com/16/35/33/40/16353340_33073713_1000.jpg',
      'https://cdn-images.farfetch-contents.com/16/35/33/40/16353340_33075065_1000.jpg'
      ],
      amount: 314,
      status: 'Available'
    ),
    DataSource(
     itemId: 2,
      itemName: 'Shirt',
      itemDescription: 'Product name & attributes  in full details',
      itemDetail: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sagittis, tortor at faucibus tempor, nunc mauris luctus dui.',
      itemImages: [
      'https://cdn-images.farfetch-contents.com/17/55/94/20/17559420_36757562_1000.jpg',
      'https://cdn-images.farfetch-contents.com/17/55/94/20/17559420_36755661_1000.jpg',
      'https://cdn-images.farfetch-contents.com/17/55/94/20/17559420_36756518_1000.jpg',
      ],
      amount: 314,
      status: 'Out of Stock'
    ),
    DataSource(
     itemId: 3,
      itemName: 'Shoe',
      itemDescription: 'Product name & attributes  in full details',
      itemDetail: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sagittis, tortor at faucibus tempor, nunc mauris luctus dui.',
      itemImages: [
      'https://cdn-images.farfetch-contents.com/15/56/09/38/15560938_28045952_1000.jpg',
      'https://cdn-images.farfetch-contents.com/15/56/09/38/15560938_28045951_1000.jpg',
      'https://cdn-images.farfetch-contents.com/15/56/09/38/15560938_28045954_1000.jpg',
      'https://cdn-images.farfetch-contents.com/15/56/09/38/15560938_28045953_1000.jpg'
     ],
      amount: 314,
      status: 'Available'
    ),
    DataSource(
     itemId: 4,
      itemName: 'Shirt',
      itemDescription: 'Product name & attributes  in full details',
      itemDetail: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sagittis, tortor at faucibus tempor, nunc mauris luctus dui.',
      itemImages: [
        'https://cdn-images.farfetch-contents.com/15/43/00/94/15430094_27879298_1000.jpg',
        'https://cdn-images.farfetch-contents.com/15/43/00/94/15430094_27879303_1000.jpg',
        'https://cdn-images.farfetch-contents.com/15/43/00/94/15430094_27879302_1000.jpg'
     ],
      amount: 314,
      status: 'Out of Stock'
    ),
    DataSource(
     itemId: 5,
      itemName: 'Shirt',
      itemDescription: 'Product name & attributes  in full details',
      itemDetail: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sagittis, tortor at faucibus tempor, nunc mauris luctus dui.',
      itemImages: [
      'https://cdn-images.farfetch-contents.com/17/40/35/61/17403561_37376461_1000.jpg',
      'https://cdn-images.farfetch-contents.com/17/40/35/61/17403561_37376459_1000.jpg',
      'https://cdn-images.farfetch-contents.com/17/40/35/61/17403561_37373966_1000.jpg',
      ],
      amount: 314,
      status: 'Available'
    ),
    DataSource(
     itemId: 6,
      itemName: 'Shoe',
      itemDescription: 'Product name & attributes  in full details',
      itemDetail: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sagittis, tortor at faucibus tempor, nunc mauris luctus dui.',
      itemImages: [
      'https://cdn-images.farfetch-contents.com/17/41/70/39/17417039_37328995_1000.jpg',
      'https://cdn-images.farfetch-contents.com/17/41/70/39/17417039_37328996_1000.jpg',
      'https://cdn-images.farfetch-contents.com/17/41/70/39/17417039_37330744_1000.jpg',
      'https://cdn-images.farfetch-contents.com/17/41/70/39/17417039_37328997_1000.jpg'
      ],
      amount: 314,
      status: 'Available'
    ),
 ];