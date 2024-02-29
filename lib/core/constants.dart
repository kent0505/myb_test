class Const {
  static String baseURL = 'http://178.20.41.98/api/v1';
  static String loginURL = '$baseURL/users/auth/';
  static String registerURL = '$baseURL/users/registration/';
  static String registerCheckURL = '$baseURL/users/check_registration/';
  static String registerGetCodeURL = '$baseURL/users/registration_get_code/';
  static String categoryURL = '$baseURL/categories/';
  static String blackListURL = '$baseURL/blacklist/user-list/';
  static String addToBlackListURL = '$baseURL/blacklist/';
  static String helpURL = '$baseURL/legal_help/consultation_requests/';
  static String appealURL = '$baseURL/users/contact-us/';
  static String phoneInfoURL = '$baseURL/callfilter_api/check-phone/';

  static String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
}
