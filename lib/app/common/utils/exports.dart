//third party libs
export 'package:get/get.dart';
export 'package:flutter/services.dart';
export 'package:get_storage/get_storage.dart';
export 'package:flutter/material.dart';
export 'package:flutter_spinkit/flutter_spinkit.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:image_picker/image_picker.dart';
export 'dart:typed_data';
export 'dart:convert';
export 'package:flutter_dotenv/flutter_dotenv.dart';
export 'package:uuid/uuid.dart';
export 'package:http_parser/http_parser.dart';
export 'package:mime/mime.dart';
export 'package:flutter_typeahead/flutter_typeahead.dart';


export 'package:deposits_ecommerce/app/modules/deposits_ecommerce.dart';
//app commons
//global
export 'package:deposits_ecommerce/app/common/global/shop_button.dart';
export 'package:deposits_ecommerce/app/common/global/deposits_ecommerce_controller.dart';
export 'package:deposits_ecommerce/app/widgets/custom_country_state_picker.dart';

//storage
export 'package:deposits_ecommerce/app/common/storage/storage.dart';

//google places
export 'package:deposits_ecommerce/app/modules/customer/google_search/address_search.dart';
export 'package:deposits_ecommerce/app/modules/customer/google_search/place_service.dart';

//utils
export 'package:deposits_ecommerce/app/common/utils/exports.dart';
export 'package:deposits_ecommerce/app/common/utils/utils.dart';
export 'package:deposits_ecommerce/app/common/utils/extensions.dart';
export 'package:deposits_ecommerce/app/common/utils/button_config.dart';
export 'package:deposits_ecommerce/app/common/utils/validation.dart';
export 'package:deposits_ecommerce/app/common/utils/uppercase_formatter.dart';

//values
export 'package:deposits_ecommerce/app/common/values/app_colors.dart';
export 'package:deposits_ecommerce/app/common/values/app_spacing.dart';
export 'package:deposits_ecommerce/app/common/values/app_images.dart';
export 'package:deposits_ecommerce/app/common/values/app_text_style.dart';
export 'package:deposits_ecommerce/app/common/values/dimens.dart';
export 'package:deposits_ecommerce/app/common/values/theme.dart';
export 'package:deposits_ecommerce/app/common/values/strings.dart';
export 'package:deposits_ecommerce/app/common/values/constants.dart';

//model
//general model
export 'package:deposits_ecommerce/app/model/general_model/data_source.dart';
export 'package:deposits_ecommerce/app/model/general_model/payments_source.dart';
export 'package:deposits_ecommerce/app/model/common/asset.dart';

//common
export 'package:deposits_ecommerce/app/model/common/merchant.dart';
export 'package:deposits_ecommerce/app/model/common/shipping_address.dart';
export 'package:deposits_ecommerce/app/model/common/product.dart';
export 'package:deposits_ecommerce/app/model/common/customer.dart';
export 'package:deposits_ecommerce/app/model/common/order.dart';

//customer model
export 'package:deposits_ecommerce/app/model/customer_model/shipping_address/shipping_address_response.dart';
export 'package:deposits_ecommerce/app/model/customer_model/shipping_address/all_shipping_address_response.dart';
export 'package:deposits_ecommerce/app/model/customer_model/get_products/get_products_response.dart';
export 'package:deposits_ecommerce/app/model/merchant_model/customer/all_customers_response.dart';
export 'package:deposits_ecommerce/app/model/customer_model/order_checkout/order_checkout_response.dart';
export 'package:deposits_ecommerce/app/model/customer_model/order_checkout/all_orders_response.dart';

//merchant model
export 'package:deposits_ecommerce/app/model/merchant_model/product/product_categories/product_categories.dart';
export 'package:deposits_ecommerce/app/model/merchant_model/assets/asset_response/aseet_response.dart';
export 'package:deposits_ecommerce/app/model/merchant_model/merchant_response/merchant_response.dart';
export 'package:deposits_ecommerce/app/model/merchant_model/delete/delete_response.dart';
export 'package:deposits_ecommerce/app/model/merchant_model/merchant_response/all_merchants.dart';
export 'package:deposits_ecommerce/app/model/merchant_model/merchant_response/get_merchant_email_response.dart';
export 'package:deposits_ecommerce/app/model/merchant_model/setup_merchant/setup_merchant_response.dart';

export 'package:deposits_ecommerce/app/modules/merchant/all_merchant/all_merchants_controller.dart';
export 'package:deposits_ecommerce/app/modules/merchant/all_customers/all_customers.dart';
export 'package:deposits_ecommerce/app/modules/merchant/create_customer/create_customer.dart';
export 'package:deposits_ecommerce/app/modules/merchant/create_customer/create_customer_controller.dart';
export 'package:deposits_ecommerce/app/modules/merchant/all_customers/all_customers_controller.dart';
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/view_shop_user/view_shop_item_detail/view_shop_item_detail.dart';
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/view_shop_user/view_shops/view_shops.dart';
export 'package:deposits_ecommerce/app/model/merchant_model/assets/get_all/get_all_assets_response.dart';
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/view_shop_user/view_shop_item_detail/view_shop_item_detail_controller.dart';

//modules
//customer
//shop item details
export 'package:deposits_ecommerce/app/modules/customer/shop/shop_item_detail/shop_item_detail.dart';
export 'package:deposits_ecommerce/app/modules/customer/shop/shop_item_detail/shop_item_detail_controller.dart';
//shop
export 'package:deposits_ecommerce/app/modules/customer/shop/shops/shops.dart';
export 'package:deposits_ecommerce/app/modules/customer/shop/shops/shops_controller.dart';
//add delivery address
export 'package:deposits_ecommerce/app/modules/customer/address/add_delivery_address/add_delivery_address.dart';
export 'package:deposits_ecommerce/app/modules/customer/address/add_delivery_address/add_delivery_address_controller.dart';
//delivery address
export 'package:deposits_ecommerce/app/modules/customer/address/delivery_address/delivery_address.dart';
export 'package:deposits_ecommerce/app/modules/customer/address/delivery_address/delivery_address_controller.dart';
//success page
export 'package:deposits_ecommerce/app/modules/customer/successful_mgs/successful_mgs.dart';
export 'package:deposits_ecommerce/app/modules/customer/successful_mgs/successful_mgs_controller.dart';
//edit address
export 'package:deposits_ecommerce/app/modules/customer/address/edit_address/edit_address.dart';
export 'package:deposits_ecommerce/app/modules/customer/address/edit_address/edit_address_controller.dart';

//merchant
//set up shop
export 'package:deposits_ecommerce/app/modules/merchant/setup_shop/setup_shop.dart';
export 'package:deposits_ecommerce/app/modules/merchant/setup_shop/setup_shop_controller.dart';
//dashboard
export 'package:deposits_ecommerce/app/modules/merchant/dashboard/dashboard.dart';
export 'package:deposits_ecommerce/app/modules/merchant/dashboard/dashboard_controller.dart';
export 'package:deposits_ecommerce/app/modules/merchant/dashboard/dashboard_binding.dart';
//home menu
export 'package:deposits_ecommerce/app/modules/merchant/home_menu/home_menu.dart';
export 'package:deposits_ecommerce/app/modules/merchant/home_menu/home_menu_controller.dart';
//payments
export 'package:deposits_ecommerce/app/modules/merchant/payments_menu/payments/epayments.dart';
export 'package:deposits_ecommerce/app/modules/merchant/payments_menu/payments/epayments_controller.dart';
//products
export 'package:deposits_ecommerce/app/modules/merchant/products_menu/products/products.dart';
export 'package:deposits_ecommerce/app/modules/merchant/products_menu/products/products_controller.dart';
//settings menu
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/shop_settings/shop_settings.dart';
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/shop_settings/shop_settings_controller.dart';
//shop detail
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/shop_details/shop_details/shop_detail.dart';
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/shop_details/shop_details/shop_detail_controller.dart';
//edit shot detail
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/shop_details/edit_shop_detail/edit_shop_detail.dart';
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/shop_details/edit_shop_detail/edit_shop_detail_controller.dart';
//shipping policy
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/shipping_policy/shipping_policy/shipping_policy.dart';
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/shipping_policy/shipping_policy/shipping_policy_controller.dart';
//edit shipping policies
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/shipping_policy/edit_shipping_policy/edit_shipping_policy.dart';
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/shipping_policy/edit_shipping_policy/edit_shipping_policy_controller.dart';
//support
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/support/support.dart';
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/support/support_controller.dart';
//contact address
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/contact_address/contact_address/contact_address.dart';
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/contact_address/contact_address/contact_address_controller.dart';
//tax fee
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/tax_fees/tax_fees/tax_fee.dart';
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/tax_fees/tax_fees/tax_fee_controller.dart';
//edit tax fee
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/tax_fees/edit_tax_fees/edit_tax_fees.dart';
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/tax_fees/edit_tax_fees/edit_tax_fees_controller.dart';
//edit contact address
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/contact_address/edit_contact_address/edit_contact_address.dart';
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/contact_address/edit_contact_address/edit_contact_address_controller.dart';
//add tax fee
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/tax_fees/add_tax_fees/add_tax_fees.dart';
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/tax_fees/add_tax_fees/add_tax_fees_controller.dart';
//delete account
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/delete_account/delete_account.dart';
export 'package:deposits_ecommerce/app/modules/merchant/settings_menu/delete_account/delete_account_controller.dart';
//all payments
export 'package:deposits_ecommerce/app/modules/merchant/payments_menu/all_payments/all_payments.dart';
export 'package:deposits_ecommerce/app/modules/merchant/payments_menu/all_payments/all_payments_controller.dart';

export 'package:deposits_ecommerce/app/services/dio_client.dart';

//merchant products
//product details
export 'package:deposits_ecommerce/app/modules/merchant/products_menu/product_details/product_details.dart';
export 'package:deposits_ecommerce/app/modules/merchant/products_menu/product_details/product_details_controller.dart';

//paymentDetail
export 'package:deposits_ecommerce/app/modules/merchant/payments_menu/payment_details/payment_details.dart';
export 'package:deposits_ecommerce/app/modules/merchant/payments_menu/payment_details/payment_details_controller.dart';

//edit product
export 'package:deposits_ecommerce/app/modules/merchant/products_menu/edit_product/edit_product.dart';
export 'package:deposits_ecommerce/app/modules/merchant/products_menu/edit_product/edit_product_controller.dart';

//add products
export 'package:deposits_ecommerce/app/modules/merchant/products_menu/add_products/add_product.dart';
export 'package:deposits_ecommerce/app/modules/merchant/products_menu/add_products/add_product_controller.dart';

//asset gallery
export 'package:deposits_ecommerce/app/modules/merchant/products_menu/gallery/gallery.dart';
export 'package:deposits_ecommerce/app/modules/merchant/products_menu/gallery/gallery_controller.dart';

//widgets
export 'package:deposits_ecommerce/app/widgets/custom_elevated_button.dart';
export 'package:deposits_ecommerce/app/widgets/custom_rich_text_widget.dart';
export 'package:deposits_ecommerce/app/widgets/custom_text_field_widget.dart';
export 'package:deposits_ecommerce/app/widgets/custom_inkwell_widget.dart';
export 'package:deposits_ecommerce/app/widgets/custom_back_button.dart';
export 'package:deposits_ecommerce/app/widgets/custom_close_button.dart';
export 'package:deposits_ecommerce/app/widgets/custom_appbar_widget.dart';
export 'package:deposits_ecommerce/app/widgets/custom_text.dart';
export 'package:deposits_ecommerce/app/widgets/custom_text_button.dart';
export 'package:deposits_ecommerce/app/widgets/custom_row_text_widget.dart';
export 'package:deposits_ecommerce/app/widgets/custom_horizontal_line.dart';
export 'package:deposits_ecommerce/app/widgets/custom_text_tag.dart';
export 'package:deposits_ecommerce/app/widgets/custom_product_tag.dart';
export 'package:deposits_ecommerce/app/widgets/custom_image.dart';
export 'package:deposits_ecommerce/app/widgets/custom_listtile_widget.dart';
export 'package:deposits_ecommerce/app/widgets/custom_listtile_checkbox_widget.dart';
export 'package:deposits_ecommerce/app/widgets/custom_checkbox_widget.dart';
export 'package:deposits_ecommerce/app/widgets/custom_image_loader.dart';
export 'package:deposits_ecommerce/app/widgets/custom_safearea.dart';
export 'package:deposits_ecommerce/app/widgets/custom_image_card.dart';
export 'package:deposits_ecommerce/app/widgets/custom_internet_retry.dart';
export 'package:deposits_ecommerce/app/widgets/custom_dropdown.dart';
