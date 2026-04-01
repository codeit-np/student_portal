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
import 'package:gap/gap.dart';

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

  // ==================== YOUR ORIGINAL LOGIC (UNCHANGED) ====================
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
        setState(() => _isLoadingCountries = false);
      }
    } catch (e) {
      setState(() => _isLoadingCountries = false);
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
            setState(() => _selectedCountryCca2 = cca2);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: LayoutBuilder(
          builder:(context, constraints) {
            final width = constraints.maxWidth;
            if(width < 600){
              return  _buildMobileUI(formKey, authController, context);
      
            }else if(width < 1024){
              return _buildMobileUI(formKey, authController, context);
            }else{
              return _buildDesktopUI(formKey, authController, context);
            }
          },
        )
        
       
      ),
    );
  }

// Mobile UI
  Center _buildMobileUI(GlobalKey<FormState> formKey, AuthController authController, BuildContext context) {
    return Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                // Logo
                Image.asset(AppStrings.logo, width: 180.w),
                Gap(32.h),

                // Header
                Text(
                  "Create a Student Account",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                Gap(8.h),
                Text(
                  "Join Code IT Student Portal",
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColor.subtitleColor ?? Colors.grey.shade600,
                  ),
                ),
                Gap(40.h),

                // Form Card
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // Full Name
                      TextFormField(
                        controller: authController.name,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: 'Enter your full name',
                          labelText: 'Full Name',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (value) => value!.trim().isEmpty
                            ? "Full name required"
                            : null,
                      ),
                      Gap(16),

                      // Email
                      TextFormField(
                        controller: authController.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          labelText: 'Email address',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (value) =>
                            value!.trim().isEmpty ? "Email required" : null,
                      ),
                      Gap(16),

                      // WhatsApp Number
                      TextFormField(
                        controller: authController.whatsApp,
                        keyboardType: TextInputType.phone,
                        validator: (value) => value!.trim().isEmpty
                            ? "WhatsApp No. required"
                            : null,
                        decoration:
                            InputDecoration(
                              hintText: 'Enter your WhatsApp no',
                              labelText: 'WhatsApp No.',
                              prefixIcon: Icon(Icons.email_outlined),
                            ).copyWith(
                              prefixIcon: Container(
                                margin: EdgeInsets.only(right: 12),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF3F4F6),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12.r),
                                    bottomLeft: Radius.circular(12.r),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: _isLoadingCountries
                                      ? null
                                      : _showCountryPicker,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (_selectedCountryCca2 != null) ...[
                                        Text(
                                          _countryCodes.firstWhere(
                                            (c) =>
                                                c['cca2'] ==
                                                _selectedCountryCca2,
                                            orElse: () => {'flag': '🇳🇵'},
                                          )['flag']!,
                                          style: TextStyle(fontSize: 22),
                                        ),
                                        Gap(6.w),
                                        Text(
                                          _countryCodes.firstWhere(
                                            (c) =>
                                                c['cca2'] ==
                                                _selectedCountryCca2,
                                            orElse: () => {'code': '+977'},
                                          )['code']!,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
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
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 16.h,
                              ),
                            ),
                      ),
                      Gap(16),

                      // Password
                      Obx(
                        () => TextFormField(
                          controller: authController.password,
                          obscureText: authController.obsecure.value,
                          decoration:
                              InputDecoration(
                                hintText: 'Enter your Password',
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.email_outlined),
                              ).copyWith(
                                suffixIcon: IconButton(
                                  onPressed: authController.visibility,
                                  icon: Icon(
                                    authController.obsecure.value
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                ),
                              ),
                          validator: (value) =>
                              value!.isEmpty ? "Password required" : null,
                        ),
                      ),
                      Gap(16),

                      // Create Account Button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              Loader.show(context);
                              await authController.register();
                              Loader.hide();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryOrange,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Gap(12),

                // Already have account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.off(() => const LoginView()),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColor.primaryOrange,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }

// Desktop UI
  Center _buildTabUI(GlobalKey<FormState> formKey, AuthController authController, BuildContext context) {
    return Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                // Logo
                Image.asset(AppStrings.logo, width: 220),
                Gap(32.h),

                // Header
                Text(
                  "Create a Student Account",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                Gap(8.h),
                Text(
                  "Join Code IT Student Portal",
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColor.subtitleColor ?? Colors.grey.shade600,
                  ),
                ),
                Gap(40.h),

                // Form Card
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // Full Name
                      TextFormField(
                        controller: authController.name,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: 'Enter your full name',
                          labelText: 'Full Name',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (value) => value!.trim().isEmpty
                            ? "Full name required"
                            : null,
                      ),
                      Gap(16),

                      // Email
                      TextFormField(
                        controller: authController.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          labelText: 'Email address',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (value) =>
                            value!.trim().isEmpty ? "Email required" : null,
                      ),
                      Gap(16),

                      // WhatsApp Number
                      TextFormField(
                        controller: authController.whatsApp,
                        keyboardType: TextInputType.phone,
                        validator: (value) => value!.trim().isEmpty
                            ? "WhatsApp No. required"
                            : null,
                        decoration:
                            InputDecoration(
                              hintText: 'Enter your WhatsApp no',
                              labelText: 'WhatsApp No.',
                              prefixIcon: Icon(Icons.email_outlined),
                            ).copyWith(
                              prefixIcon: Container(
                                margin: EdgeInsets.only(right: 12),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF3F4F6),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12.r),
                                    bottomLeft: Radius.circular(12.r),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: _isLoadingCountries
                                      ? null
                                      : _showCountryPicker,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (_selectedCountryCca2 != null) ...[
                                        Text(
                                          _countryCodes.firstWhere(
                                            (c) =>
                                                c['cca2'] ==
                                                _selectedCountryCca2,
                                            orElse: () => {'flag': '🇳🇵'},
                                          )['flag']!,
                                          style: TextStyle(fontSize: 22),
                                        ),
                                        Gap(6.w),
                                        Text(
                                          _countryCodes.firstWhere(
                                            (c) =>
                                                c['cca2'] ==
                                                _selectedCountryCca2,
                                            orElse: () => {'code': '+977'},
                                          )['code']!,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
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
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 16.h,
                              ),
                            ),
                      ),
                      Gap(16),

                      // Password
                      Obx(
                        () => TextFormField(
                          controller: authController.password,
                          obscureText: authController.obsecure.value,
                          decoration:
                              InputDecoration(
                                hintText: 'Enter your Password',
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.email_outlined),
                              ).copyWith(
                                suffixIcon: IconButton(
                                  onPressed: authController.visibility,
                                  icon: Icon(
                                    authController.obsecure.value
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                ),
                              ),
                          validator: (value) =>
                              value!.isEmpty ? "Password required" : null,
                        ),
                      ),
                      Gap(16),

                      // Create Account Button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              Loader.show(context);
                              await authController.register();
                              Loader.hide();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryOrange,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Gap(12),

                // Already have account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.off(() => const LoginView()),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColor.primaryOrange,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }


// Desktop UI
  Center _buildDesktopUI(GlobalKey<FormState> formKey, AuthController authController, BuildContext context) {
    return Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                // Logo
                Image.asset(AppStrings.logo, width: 220),
                Gap(32.h),

                // Header
                Text(
                  "Create a Student Account",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                Gap(8.h),
                Text(
                  "Join Code IT Student Portal",
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColor.subtitleColor ?? Colors.grey.shade600,
                  ),
                ),
                Gap(40.h),

                // Form Card
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // Full Name
                      TextFormField(
                        controller: authController.name,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: 'Enter your full name',
                          labelText: 'Full Name',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (value) => value!.trim().isEmpty
                            ? "Full name required"
                            : null,
                      ),
                      Gap(16),

                      // Email
                      TextFormField(
                        controller: authController.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          labelText: 'Email address',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (value) =>
                            value!.trim().isEmpty ? "Email required" : null,
                      ),
                      Gap(16),

                      // WhatsApp Number
                      TextFormField(
                        controller: authController.whatsApp,
                        keyboardType: TextInputType.phone,
                        validator: (value) => value!.trim().isEmpty
                            ? "WhatsApp No. required"
                            : null,
                        decoration:
                            InputDecoration(
                              hintText: 'Enter your WhatsApp no',
                              labelText: 'WhatsApp No.',
                              prefixIcon: Icon(Icons.email_outlined),
                            ).copyWith(
                              prefixIcon: Container(
                                margin: EdgeInsets.only(right: 12),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF3F4F6),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12.r),
                                    bottomLeft: Radius.circular(12.r),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: _isLoadingCountries
                                      ? null
                                      : _showCountryPicker,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (_selectedCountryCca2 != null) ...[
                                        Text(
                                          _countryCodes.firstWhere(
                                            (c) =>
                                                c['cca2'] ==
                                                _selectedCountryCca2,
                                            orElse: () => {'flag': '🇳🇵'},
                                          )['flag']!,
                                          style: TextStyle(fontSize: 22),
                                        ),
                                        Gap(6.w),
                                        Text(
                                          _countryCodes.firstWhere(
                                            (c) =>
                                                c['cca2'] ==
                                                _selectedCountryCca2,
                                            orElse: () => {'code': '+977'},
                                          )['code']!,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
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
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 16.h,
                              ),
                            ),
                      ),
                      Gap(16),

                      // Password
                      Obx(
                        () => TextFormField(
                          controller: authController.password,
                          obscureText: authController.obsecure.value,
                          decoration:
                              InputDecoration(
                                hintText: 'Enter your Password',
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.email_outlined),
                              ).copyWith(
                                suffixIcon: IconButton(
                                  onPressed: authController.visibility,
                                  icon: Icon(
                                    authController.obsecure.value
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                ),
                              ),
                          validator: (value) =>
                              value!.isEmpty ? "Password required" : null,
                        ),
                      ),
                      Gap(16),

                      // Create Account Button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              Loader.show(context);
                              await authController.register();
                              Loader.hide();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryOrange,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Gap(12),

                // Already have account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.off(() => const LoginView()),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColor.primaryOrange,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }

  // Modern Input Decoration
  InputDecoration _modernDecoration({
    required String label,
    required String hint,
    IconData? icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: icon != null ? Icon(icon, color: Colors.grey.shade600) : null,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: AppColor.primaryOrange, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      filled: true,
      fillColor: Colors.white,
    );
  }
}

// ==================== COUNTRY PICKER MODAL (Slightly Cleaner UI) ====================
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
      _filteredCountries = query.isEmpty
          ? widget.countries
          : widget.countries
                .where(
                  (c) =>
                      c['name']!.toLowerCase().contains(query.toLowerCase()) ||
                      c['code']!.contains(query),
                )
                .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.r),
            child: TextField(
              controller: _searchController,
              onChanged: _filterCountries,
              decoration: InputDecoration(
                hintText: 'Search country or code',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredCountries.length,
              itemBuilder: (context, index) {
                final country = _filteredCountries[index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 4.h,
                  ),
                  leading: Text(
                    country['flag']!,
                    style: TextStyle(fontSize: 26),
                  ),
                  title: Text(country['name']!),
                  trailing: Text(
                    country['code']!,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
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
