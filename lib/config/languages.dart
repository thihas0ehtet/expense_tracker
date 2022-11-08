import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'mm_Uni': {
          'setting': 'ပြင်ဆင်ချက်',
          'reports': 'အစီရင်ခံစာများ',
          'categories': 'အမျိုးအစားများ',
          'category': 'အမျိုးအစား',
          "exitTitle": "ဆော့ဝဲမှာ ထွက်ခြင်း",
          "exitBody": "ဆော့ဝဲမှာ ထွက်မှာသေချာပါသလား",
          "save": "သိမ်းဆည်းမည်",
          "date": "ရက်စွဲ",
          'currency': 'ငွေကြေးစနစ်',
          'language': 'ဘာသာစကား',
          "ok": "ပြုလုပ်မည်",
        },
        'en_US': {
          'setting': 'Setting',
          'reports': 'Reports',
          'categories': 'Categories',
          'category': 'Category',
          "exitTitle": "Are you sure?",
          "exitBody": "Do you want to exit an App?",
          "save": "Save",
          "date": "Date",
          "about": "App Information",
          'currency': 'Currency',
          'language': 'Language',
          "ok": "OK",
        },
      };
}
