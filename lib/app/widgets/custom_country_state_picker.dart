import 'dart:convert';
import 'package:deposits_ecommerce/app/common/values/strings.dart';
import 'package:deposits_ecommerce/app/model/general_model/city_model.dart' as CityModel;
import 'package:deposits_ecommerce/app/model/general_model/country_model.dart' as CountryModel;
import 'package:deposits_ecommerce/app/model/general_model/state_model.dart' as StateModel;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

// ignore: must_be_immutable
class CountryStateCityPicker extends StatefulWidget {
  TextEditingController country;
  TextEditingController state;
  TextEditingController city;
  InputBorder? textFieldInputBorder;
  FormFieldValidator<String?>? countryValidator, stateValidator, cityValidator;

  CountryStateCityPicker({required this.country, required this.state, required this.city, this.textFieldInputBorder, this.countryValidator, this.stateValidator, this.cityValidator});

  @override
  _CountryStateCityPickerState createState() => _CountryStateCityPickerState();
}

class _CountryStateCityPickerState extends State<CountryStateCityPicker> {
  List<CountryModel.CountryModel> _countryList=[];
  List<StateModel.StateModel> _stateList=[];
  List<CityModel.CityModel> _cityList=[];

  List<CountryModel.CountryModel> _countrySubList=[];
  List<StateModel.StateModel> _stateSubList=[];
  List<CityModel.CityModel> _citySubList=[];
  String _title='';

  @override
  void initState() {
    super.initState();
    _getCountry();
  }

  Future<void> _getCountry()async{
    _countryList.clear();
    var jsonString = await rootBundle.loadString('packages/deposits_ecommerce/lib/app/common/assets/country.json');
    List<dynamic> body = json.decode(jsonString);
    setState(() {
      _countryList = body.map((dynamic item) => CountryModel.CountryModel.fromJson(item)).toList();
      _countrySubList=_countryList;
    });
  }

  Future<void> _getState(String countryId)async{
    _stateList.clear();
    _cityList.clear();
    List<StateModel.StateModel> _subStateList=[];
    var jsonString = await rootBundle.loadString('packages/deposits_ecommerce/lib/app/common/assets/state.json');
    List<dynamic> body = json.decode(jsonString);

    _subStateList = body.map((dynamic item) => StateModel.StateModel.fromJson(item)).toList();
    _subStateList.forEach((element) {
      if(element.countryId==countryId){
        setState(() {
          _stateList.add(element);
        });
      }
    });
    _stateSubList=_stateList;
  }

  Future<void> _getCity(String stateId)async{
    _cityList.clear();
    List<CityModel.CityModel> _subCityList=[];
    var jsonString = await rootBundle.loadString('packages/deposits_ecommerce/lib/app/common/assets/city.json');
    List<dynamic> body = json.decode(jsonString);

    _subCityList = body.map((dynamic item) => CityModel.CityModel.fromJson(item)).toList();
    _subCityList.forEach((element) {
      if(element.stateId==stateId){
        setState(() {
          _cityList.add(element);
        });
      }
    });
    _citySubList = _cityList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///Country TextField
        TextFormField(
          controller: widget.country,
          validator: (value) => value == null ? Strings.fieldCantBeEmpty : null,
          onTap: (){
            setState(()=>_title='Country');
            _showDialog(context);
          },
          decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              hintText: 'Select Country',
              hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF8895A7)),
              suffixIcon:const Icon(Icons.keyboard_arrow_down_rounded,
              color: Color(0xFFC0C4C9),),
              border: widget.textFieldInputBorder?? const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(
                borderSide:  BorderSide(color: Color(0xFFC0C4C9)),
              ),
              enabledBorder:const OutlineInputBorder(
                borderSide:  BorderSide(color: Color(0xFFC0C4C9)),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide:  BorderSide(color: Color(0xFFC0C4C9)),
              )
          ),
          readOnly: false,
        ),
        const SizedBox(height: 20.0),
           ///State TextField
        TextFormField(
          controller: widget.state,
           validator: widget.stateValidator,
          onTap: (){
            setState(()=>_title='State');
            if(widget.country.text.isNotEmpty)
            _showDialog(context);
            else _showSnackBar('Select Country');
          },
          decoration: InputDecoration(
              isDense: true,
              hintText: 'Select State',
              contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF8895A7)),
              suffixIcon:const Icon(Icons.keyboard_arrow_down_rounded,
              color: Color(0xFFC0C4C9),),
              border: widget.textFieldInputBorder?? const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(
                borderSide:  BorderSide(color: Color(0xFFC0C4C9)),
              ),
              enabledBorder:const OutlineInputBorder(
                borderSide:  BorderSide(color: Color(0xFFC0C4C9)),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide:  BorderSide(color: Color(0xFFC0C4C9)),
              )
          ),//Color(0xFFC0C4C9)
          readOnly: false,
        ),
        const SizedBox(height: 20.0),
         ///City TextField
        TextFormField(
          controller: widget.city,
           validator: widget.cityValidator,
          onTap: (){
            setState(()=>_title='City');
            if(widget.state.text.isNotEmpty)
              _showDialog(context);
            else _showSnackBar('Select City');
          },
          decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              hintText: 'Select City',
              hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF8895A7)),
              suffixIcon:const Icon(Icons.keyboard_arrow_down_rounded,
              color: Color(0xFFC0C4C9),),
              border: widget.textFieldInputBorder?? const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(
                borderSide:  BorderSide(color: Color(0xFFC0C4C9)),
              ),
              enabledBorder:const OutlineInputBorder(
                borderSide:  BorderSide(color: Color(0xFFC0C4C9)),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide:  BorderSide(color: Color(0xFFC0C4C9)),
              )
          ),
          readOnly: false,
        ),
      
       const SizedBox(height: 10.0),
      ],
    );
  }

  void _showDialog(BuildContext context){
    TextEditingController _controller=TextEditingController();
    TextEditingController _controller2=TextEditingController();
    TextEditingController _controller3=TextEditingController();

    showGeneralDialog(
      barrierLabel: _title,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (context,__,___){
        return Material(
          color: Colors.transparent,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return Align(
                alignment: Alignment.topCenter,
                child:  Container(
                  height: MediaQuery.of(context).size.height*.7,
                  margin: EdgeInsets.only(top: 60, left: 12, right: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(_title,style: TextStyle(color:Colors.grey.shade800,
                          fontSize: 17,fontWeight: FontWeight.w500)),
                      SizedBox(height: 10),
                      ///Text Field
                      TextField(
                        controller: _title=='Country'
                            ? _controller
                            : _title=='State'
                            ? _controller2
                            : _controller3,
                        onChanged: (val){
                          setState(() {
                            if(_title=='Country'){
                              _countrySubList = _countryList.where((element) =>
                                  element.name.toLowerCase().contains(_controller.text.toLowerCase())).toList();
                            }
                            else if(_title=='State'){
                              _stateSubList = _stateList.where((element) =>
                                  element.name.toLowerCase().contains(_controller2.text.toLowerCase())).toList();
                            }
                            else if(_title=='City'){
                              _citySubList = _cityList.where((element) =>
                                  element.name.toLowerCase().contains(_controller3.text.toLowerCase())).toList();
                            }
                          });
                        },
                        style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 16.0
                        ),
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: "Search here...",
                            contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 5),
                            isDense: true,
                            prefixIcon: Icon(Icons.search)
                        ),
                      ),
                      ///Dropdown Items
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                            itemCount: _title=='Country'
                                ? _countrySubList.length
                                : _title=='State'
                                ? _stateSubList.length
                                : _citySubList.length,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context,index){
                              return InkWell(
                                onTap: ()async{
                                  setState((){
                                    if(_title=="Country"){
                                      widget.country.text= _countrySubList[index].name;
                                      _getState(_countrySubList[index].id);
                                      _countrySubList=_countryList;
                                      widget.state.clear();
                                      widget.city.clear();
                                    }
                                    else if(_title=='State'){
                                      widget.state.text= _stateSubList[index].name;
                                      _getCity(_stateSubList[index].id);
                                      _stateSubList = _stateList;
                                      widget.city.clear();
                                    }
                                    else if(_title=='City'){
                                      widget.city.text= _citySubList[index].name;
                                      _citySubList = _cityList;
                                    }
                                  });
                                  _controller.clear();
                                  _controller2.clear();
                                  _controller3.clear();
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 20.0,left: 10.0,right: 10.0),
                                  child: Text(
                                      _title=='Country'
                                          ? _countrySubList[index].name
                                          : _title=='State'
                                          ? _stateSubList[index].name
                                          :_citySubList[index].name,
                                      style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 16.0
                                      )),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          if(_title=='City' && _citySubList.isEmpty){
                            widget.city.text= _controller3.text;
                          }
                          _countrySubList=_countryList;
                          _stateSubList = _stateList;
                          _citySubList = _cityList;

                          _controller.clear();
                          _controller2.clear();
                          _controller3.clear();
                          Navigator.pop(context);
                        },
                        child: Text('Close'),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      transitionBuilder: (_,anim,__,child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, -1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  void _showSnackBar(String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
          content: Text(message,
              textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white,fontSize: 16.0)))
    );
  }
}