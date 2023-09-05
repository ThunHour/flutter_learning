List<Language> languageList = [
  Language(),
  Khmer(),
  Chinese(),
];

class Language {
  String get appName => "Food App";
  String get changeToDark => "Change To Dark Mode";
  String get changeToLight => "Change To Light Mode";
  String get detailPageName => "Detail Page";
  String get counter => "Counter";
  String get settings => "Settings";
  String get changeLanguage => "ប្តូរទៅភាសាខ្មែរ";
}

class Khmer implements Language {
  @override
  String get appName => "កម្មវិធីកម៉្មង់អាហារ";

  @override
  String get changeToDark => "ប្តូរទៅងងឹត";

  @override
  String get changeToLight => "ប្តូរទៅភ្លឺ";

  @override
  String get counter => "ចំនួនរាប់";

  @override
  String get detailPageName => "ទំព័រលម្អិត";

  @override
  String get settings => "កែប្រែ";

  @override
  String get changeLanguage => "换成中文";
}

class Chinese implements Language{
  @override
  String get appName => "食物应用程序";

  @override
  String get changeLanguage => "Change To English";

  @override
  String get changeToDark => "变暗";

  @override
  String get changeToLight => "变光";

  @override
  String get counter => "柜台";

  @override
  String get detailPageName => "详细页面";

  @override
  String get settings => "设置";
}