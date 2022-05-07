import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class Dashboard extends StatefulWidget {
  final String merchantID;
  Dashboard({Key? key, required this.merchantID}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DashboardController controller = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: controller,
      builder: (controller) {
        if (!Storage.hasData(Constants.merchantID)) {
          Storage.saveValue(Constants.merchantID, widget.merchantID);
        }

        return Scaffold(
            body: SafeArea(
              child: IndexedStack(
                index: controller.tabIndex.value,
                children: [
                  HomeMenu(merchantID: widget.merchantID),
                  EcomPayments(
                    merchantID: widget.merchantID,
                  ),
                  Products(
                    merchantID: widget.merchantID,
                  ),
                  ShopSettings(),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
                unselectedItemColor: AppColors.doveGray,
                selectedItemColor: AppColors.activButtonColor(),
                onTap: controller.changeTabIndex,
                currentIndex: controller.tabIndex.value,
                showSelectedLabels: true,
                iconSize: 20,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                backgroundColor: AppColors.white,
                elevation: 0,
                items: [
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(AppImages.home,
                          color: controller.tabIndex.value == 0
                              ? AppColors.activButtonColor()
                              : AppColors.doveGray,
                          package: 'deposits_ecommerce'),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AppImages.payments,
                        package: 'deposits_ecommerce',
                        color: controller.tabIndex.value == 1
                            ? AppColors.activButtonColor()
                            : AppColors.doveGray,
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AppImages.products,
                        package: 'deposits_ecommerce',
                        color: controller.tabIndex.value == 2
                            ? AppColors.activButtonColor()
                            : AppColors.doveGray,
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AppImages.settings,
                        package: 'deposits_ecommerce',
                        color: controller.tabIndex.value == 3
                            ? AppColors.activButtonColor()
                            : AppColors.doveGray,
                      ),
                      label: ''),
                ]));
      },
    );
  }
}
