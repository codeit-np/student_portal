import 'dart:convert';
import 'package:codeit/controller/auth_controller.dart';
import 'package:codeit/utils/app_color.dart';
import 'package:codeit/utils/app_strings.dart';
import 'package:codeit/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool _isLoadingCountries = true;
  String? _selectedCountryCca2;
  String? countryCode;
  List<Map<String, String>> _countryCodes = [];

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  Future<void> _fetchCountries() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://restcountries.com/v3.1/all?fields=name,cca2,idd,flag',
        ),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Map<String, String>> loadedCountries = [];

        for (var country in data) {
          final cca2 = country['cca2']?.toString() ?? '';
          if (country['idd'] != null &&
              country['idd']['root'] != null &&
              cca2.isNotEmpty) {
            final String root = country['idd']['root'].toString();
            final List<dynamic>? suffixes = country['idd']['suffixes'];
            final String flag = country['flag']?.toString() ?? '';
            final String name = country['name']?['common']?.toString() ?? '';

            String code = root;
            if (suffixes != null && suffixes.isNotEmpty) {
              if (suffixes.length == 1) {
                code = '$root${suffixes[0]}';
              }
            }

            loadedCountries.add({
              'code': code,
              'flag': flag,
              'name': name,
              'cca2': cca2,
            });
          }
        }

        loadedCountries.sort((a, b) => a['name']!.compareTo(b['name']!));
        setState(() {
          _countryCodes = loadedCountries;
          final nepal = _countryCodes.where((c) => c['cca2'] == 'NP').toList();
          if (nepal.isNotEmpty) {
            _selectedCountryCca2 = nepal.first['cca2'];
          } else if (_countryCodes.isNotEmpty) {
            _selectedCountryCca2 = _countryCodes.first['cca2'];
          }
          _isLoadingCountries = false;
        });
      } else {
        setState(() {
          _isLoadingCountries = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoadingCountries = false;
      });
      debugPrint('Error fetching countries: $e');
    }
  }

  Future<void> _showCountryPicker() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _CountryPickerModal(
          countries: _countryCodes,
          onCountrySelected: (String cca2) {
            setState(() {
              _selectedCountryCca2 = cca2;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<FormState>();
    var authController = Get.find<AuthController>();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),

                child: Form(
                  key: key,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Logo Section
                      Image.asset(AppStrings.logo, width: 200),
                      16.verticalSpace,

                      // Title Text
                      const Text(
                        "Create a Student Account",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      8.verticalSpace,
                      const Text(
                        "Join Code IT Student Portal",
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColor.subtitleColor,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Form Fields
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: authController.name,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hint: Text("Enter you full name"),
                          label: Text("Full Name"),
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "full name required" : null,
                      ),
                      20.verticalSpace,

                      TextFormField(
                        controller: authController.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hint: Text("Enter you email address"),
                          label: Text("Email Address"),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "email required" : null,
                      ),
                      20.verticalSpace,

                      TextFormField(
                        controller: authController.whatsApp,
                        keyboardType: TextInputType.phone,
                        validator: (value) =>
                            value!.isEmpty ? "WhatsApp No. required" : null,

                        decoration:
                            InputDecoration(
                              hint: Text("Enter your WhatsApp No"),
                              label: Text("WhatsApp Number"),
                            ).copyWith(
                              prefixIcon: Container(
                                padding: const EdgeInsets.only(
                                  left: 12.0,
                                  right: 8.0,
                                ),
                                margin: const EdgeInsets.only(right: 8.0),
                                decoration: const BoxDecoration(
                                  color: Color(
                                    0xFFF3F4F6,
                                  ), // Light gray background for the prefix
                                ),
                                child: _isLoadingCountries
                                    ? const SizedBox(
                                        width: 10,
                                        height: 10,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1,
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: _showCountryPicker,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (_selectedCountryCca2 !=
                                                null) ...[
                                              Text(
                                                _countryCodes.firstWhere(
                                                  (c) =>
                                                      c['cca2'] ==
                                                      _selectedCountryCca2,
                                                  orElse: () => {
                                                    'flag': '',
                                                    'code': '',
                                                  },
                                                )['flag']!,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                _countryCodes.firstWhere(
                                                  (c) =>
                                                      c['cca2'] ==
                                                      _selectedCountryCca2,
                                                  orElse: () => {
                                                    'flag': '',
                                                    'code': '',
                                                  },
                                                )['code']!,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF374151),
                                                ),
                                              ),
                                            ],
                                            const Icon(
                                              Icons.arrow_drop_down,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                            ),
                      ),
                      20.verticalSpace,

                      Obx((){
                        return   TextFormField(
                        controller: authController.password,
                        obscureText: authController.obsecure.value,
                        decoration: InputDecoration(
                          label: Text("Password"),
                          hint: Text("Enter you password"),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(onPressed: (){
                            authController.visibility();
                          }, icon: authController.obsecure.value == true ?  Icon(Icons.visibility_off) : Icon(Icons.visibility)),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "password required" : null,
                      );
                      }),
                     
                      const SizedBox(height: 24),

                      // Create Account Button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (key.currentState!.validate()) {
                              Loader.show(context);
                              await authController.register();
                              Loader.hide();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryOrange,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 16,
                              
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Sign In Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF4B5563),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.off(LoginView());
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                               color: AppColor.primaryOrange
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),

                      // Footer
                      const Text(
                        "© 2026 Code IT. All rights reserved.",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        const Text(
          ' *',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint, Color borderColor) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFF9CA3AF),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFF36F21), width: 1.5),
      ),
      isDense: true,
    );
  }
}

class _CountryPickerModal extends StatefulWidget {
  final List<Map<String, String>> countries;
  final Function(String) onCountrySelected;

  const _CountryPickerModal({
    required this.countries,
    required this.onCountrySelected,
  });

  @override
  State<_CountryPickerModal> createState() => _CountryPickerModalState();
}

class _CountryPickerModalState extends State<_CountryPickerModal> {
  List<Map<String, String>> _filteredCountries = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredCountries = widget.countries;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCountries(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCountries = widget.countries;
      } else {
        _filteredCountries = widget.countries
            .where(
              (country) =>
                  country['name']!.toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
                  country['code']!.contains(query),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var authController = Get.find<AuthController>();
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterCountries,
              decoration: InputDecoration(
                hintText: 'Search country or code',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredCountries.length,
              itemBuilder: (context, index) {
                final country = _filteredCountries[index];
                return ListTile(
                  leading: Text(
                    country['flag']!,
                    style: const TextStyle(fontSize: 24),
                  ),
                  title: Text(country['name']!),
                  trailing: Text(country['code']!),
                  onTap: () {
                    authController.setCountryCode(country['code']!);
                    widget.onCountrySelected(country['cca2']!);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
