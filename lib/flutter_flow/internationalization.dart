import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'hi', 'kn', 'ta'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? hiText = '',
    String? knText = '',
    String? taText = '',
  }) =>
      [enText, hiText, knText, taText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Login
  {
    'hqj4mlho': {
      'en': 'Our DevOps Portal 2.0',
      'hi': 'टीसीएस पोर्टल 2.0',
      'kn': 'TCS ಪೋರ್ಟಲ್ 2.0',
      'ta': 'டிசிஎஸ் போர்டல் 2.0',
    },
    'xv7gi3zl': {
      'en': 'Welcome Back',
      'hi': 'वापसी पर स्वागत है',
      'kn': 'ಮರಳಿ ಸ್ವಾಗತ',
      'ta': 'மீண்டும் வரவேற்கிறோம்',
    },
    'ya0ld0h8': {
      'en': 'Fill out the information below in order to access your account.',
      'hi': 'अपने खाते तक पहुंचने के लिए नीचे दी गई जानकारी भरें।',
      'kn': 'ನಿಮ್ಮ ಖಾತೆಯನ್ನು ಪ್ರವೇಶಿಸಲು ಕೆಳಗಿನ ಮಾಹಿತಿಯನ್ನು ಭರ್ತಿ ಮಾಡಿ.',
      'ta': 'உங்கள் கணக்கை அணுக, கீழே உள்ள தகவலை நிரப்பவும்.',
    },
    '563iotbe': {
      'en': 'Email',
      'hi': 'ईमेल',
      'kn': 'ಇಮೇಲ್',
      'ta': 'மின்னஞ்சல்',
    },
    '1xlu6cdv': {
      'en': 'Password',
      'hi': 'पासवर्ड',
      'kn': 'ಪಾಸ್ವರ್ಡ್',
      'ta': 'கடவுச்சொல்',
    },
    'z34n2vjg': {
      'en': 'Sign In',
      'hi': 'दाखिल करना',
      'kn': 'ಸೈನ್ ಇನ್ ಮಾಡಿ',
      'ta': 'உள்நுழையவும்',
    },
    'ruinthqu': {
      'en': 'Or sign in with',
      'hi': 'या साइन इन करें',
      'kn': 'ಅಥವಾ ಇದರೊಂದಿಗೆ ಸೈನ್ ಇನ್ ಮಾಡಿ',
      'ta': 'அல்லது உடன் உள்நுழையவும்',
    },
    'msxn3vz3': {
      'en': 'Continue with Google',
      'hi': 'Google के साथ जारी रखें',
      'kn': 'Google ನೊಂದಿಗೆ ಮುಂದುವರಿಯಿರಿ',
      'ta': 'Google உடன் தொடரவும்',
    },
    'edqoo2w5': {
      'en': 'Continue with Apple',
      'hi': 'एप्पल के साथ जारी रखें',
      'kn': 'Apple ನೊಂದಿಗೆ ಮುಂದುವರಿಸಿ',
      'ta': 'ஆப்பிள் உடன் தொடரவும்',
    },
    's2adq3e3': {
      'en': 'Don\'t have an account?  ',
      'hi': 'क्या आपके पास खाता नहीं है?',
      'kn': 'ಖಾತೆ ಇಲ್ಲವೇ?',
      'ta': 'கணக்கு இல்லையா?',
    },
    'ptkgv4id': {
      'en': 'Sign Up here',
      'hi': 'यहां साइन अप करें',
      'kn': 'ಇಲ್ಲಿ ಸೈನ್ ಅಪ್ ಮಾಡಿ',
      'ta': 'இங்கே பதிவு செய்யவும்',
    },
    '2ccy2ye2': {
      'en': 'Home',
      'hi': 'घर',
      'kn': 'ಮನೆ',
      'ta': 'வீடு',
    },
  },
  // dashboard
  {
    'lco1bxy5': {
      'en': 'TCS Bancs Portal',
      'hi': 'आईसीआईसीआई बैंक पोर्टल',
      'kn': 'ICICI ಬ್ಯಾಂಕ್ ಪೋರ್ಟಲ್',
      'ta': 'ஐசிஐசிஐ வங்கி போர்டல்',
    },
    'i7fotc4b': {
      'en': 'Platform Navigation',
      'hi': 'प्लेटफ़ॉर्म नेविगेशन',
      'kn': 'ಪ್ಲಾಟ್‌ಫಾರ್ಮ್ ನ್ಯಾವಿಗೇಷನ್',
      'ta': 'பிளாட்ஃபார்ம் வழிசெலுத்தல்',
    },
    '2f9sb0m6': {
      'en': 'Dashboard',
      'hi': 'डैशबोर्ड',
      'kn': 'ಡ್ಯಾಶ್‌ಬೋರ್ಡ್',
      'ta': 'டாஷ்போர்டு',
    },
    'vgg4sfzb': {
      'en': 'Chats',
      'hi': 'चैट',
      'kn': 'ಚಾಟ್‌ಗಳು',
      'ta': 'அரட்டைகள்',
    },
    'rrt7aoaj': {
      'en': 'Projects',
      'hi': 'परियोजनाओं',
      'kn': 'ಯೋಜನೆಗಳು',
      'ta': 'திட்டங்கள்',
    },
    'ts1h28v4': {
      'en': 'Settings',
      'hi': 'सेटिंग्स',
      'kn': 'ಸೆಟ್ಟಿಂಗ್‌ಗಳು',
      'ta': 'அமைப்புகள்',
    },
    'pm5u7l0f': {
      'en': 'Notifications',
      'hi': 'सूचनाएं',
      'kn': 'ಅಧಿಸೂಚನೆಗಳು',
      'ta': 'அறிவிப்புகள்',
    },
    'wmi7q08i': {
      'en': '12',
      'hi': '12',
      'kn': '12',
      'ta': '12',
    },
    '8ko79c5y': {
      'en': 'Billing',
      'hi': 'बिलिंग',
      'kn': 'ಬಿಲ್ಲಿಂಗ್',
      'ta': 'பில்லிங்',
    },
    '9uzpelwv': {
      'en': 'Explore',
      'hi': 'अन्वेषण करना',
      'kn': 'ಅನ್ವೇಷಿಸಿ',
      'ta': 'ஆராயுங்கள்',
    },
    'hy9ebx9f': {
      'en': 'Overview',
      'hi': 'अवलोकन',
      'kn': 'ಅವಲೋಕನ',
      'ta': 'கண்ணோட்டம்',
    },
    'c8jls3cl': {
      'en': 'Below is a company overview',
      'hi': 'नीचे कंपनी का अवलोकन दिया गया है',
      'kn': 'ಕೆಳಗೆ ಕಂಪನಿಯ ಅವಲೋಕನವಿದೆ',
      'ta': 'கீழே ஒரு நிறுவனத்தின் கண்ணோட்டம் உள்ளது',
    },
    '034vjbnr': {
      'en': 'Mahesh',
      'hi': 'महेश',
      'kn': 'ಮಹೇಶ್',
      'ta': 'மகேஷ்',
    },
    'vkn8xuxg': {
      'en': 'mahesh@camsonline.com',
      'hi': 'महेश@camsonline.com',
      'kn': 'mahesh@camsonline.com',
      'ta': 'mahesh@camsonline.com',
    },
    'ny6kp950': {
      'en': 'Order Value',
      'hi': 'ऑर्डर मूल्य',
      'kn': 'ಆರ್ಡರ್ ಮೌಲ್ಯ',
      'ta': 'ஆர்டர் மதிப்பு',
    },
    '07nekto8': {
      'en': '₹47,67,402',
      'hi': '₹47,67,402',
      'kn': '₹47,67,402',
      'ta': '₹47,67,402',
    },
    'wx3qfa5f': {
      'en': 'Portfolios Managed',
      'hi': 'प्रबंधित पोर्टफोलियो',
      'kn': 'ಪೋರ್ಟ್ಫೋಲಿಯೊಗಳನ್ನು ನಿರ್ವಹಿಸಲಾಗಿದೆ',
      'ta': 'போர்ட்ஃபோலியோக்கள் நிர்வகிக்கப்படுகின்றன',
    },
    'gw9oynx0': {
      'en': '300',
      'hi': '300',
      'kn': '300',
      'ta': '300',
    },
    'topqgc0z': {
      'en': 'Total Orders',
      'hi': 'कुल ऑर्डर',
      'kn': 'ಒಟ್ಟು ಆದೇಶಗಳು',
      'ta': 'மொத்த ஆர்டர்கள்',
    },
    'd7z0o3pw': {
      'en': '2,208',
      'hi': '2,208',
      'kn': '2,208',
      'ta': '2,208',
    },
    'xpyffwr0': {
      'en': 'Total Orders',
      'hi': 'कुल ऑर्डर',
      'kn': 'ಒಟ್ಟು ಆದೇಶಗಳು',
      'ta': 'மொத்த ஆர்டர்கள்',
    },
    'kiybps0l': {
      'en': '2,208',
      'hi': '2,208',
      'kn': '2,208',
      'ta': '2,208',
    },
    '0mbpi4ej': {
      'en': 'Outstanding Balance',
      'hi': 'बकाया राशि',
      'kn': 'ಅತ್ಯುತ್ತಮ ಬ್ಯಾಲೆನ್ಸ್',
      'ta': 'சிறந்த இருப்பு',
    },
    'b38q5lm9': {
      'en': '₹5,29,204',
      'hi': '₹5,29,204',
      'kn': '₹5,29,204',
      'ta': '₹5,29,204',
    },
    'wq4r1lan': {
      'en': '55%',
      'hi': '55%',
      'kn': '55%',
      'ta': '55%',
    },
    '132m0exa': {
      'en': 'Outstanding Balance',
      'hi': 'बकाया राशि',
      'kn': 'ಅತ್ಯುತ್ತಮ ಬ್ಯಾಲೆನ್ಸ್',
      'ta': 'சிறந்த இருப்பு',
    },
    '2lz6dj0b': {
      'en': '₹5,29,204',
      'hi': '₹5,29,204',
      'kn': '₹5,29,204',
      'ta': '₹5,29,204',
    },
    'rhfi4qoc': {
      'en': '55%',
      'hi': '55%',
      'kn': '55%',
      'ta': '55%',
    },
    '60mrp3ss': {
      'en': 'Network Requests',
      'hi': 'नेटवर्क अनुरोध',
      'kn': 'ನೆಟ್‌ವರ್ಕ್ ವಿನಂತಿಗಳು',
      'ta': 'நெட்வொர்க் கோரிக்கைகள்',
    },
    'j47mf6gn': {
      'en': 'You’re using 80% of available requests.',
      'hi': 'आप उपलब्ध अनुरोधों में से 80% का उपयोग कर रहे हैं।',
      'kn': 'ನೀವು ಲಭ್ಯವಿರುವ 80% ವಿನಂತಿಗಳನ್ನು ಬಳಸುತ್ತಿರುವಿರಿ.',
      'ta': 'கிடைக்கும் கோரிக்கைகளில் 80% பயன்படுத்துகிறீர்கள்.',
    },
    'h378rn6l': {
      'en': '562k',
      'hi': '562कि',
      'kn': '562ಕೆ',
      'ta': '562k',
    },
    'clmtjgtj': {
      'en': 'You’ve almost reached your limit',
      'hi': 'आप लगभग अपनी सीमा तक पहुँच चुके हैं',
      'kn': 'ನೀವು ಬಹುತೇಕ ನಿಮ್ಮ ಮಿತಿಯನ್ನು ತಲುಪಿರುವಿರಿ',
      'ta': 'உங்கள் வரம்பை கிட்டத்தட்ட அடைந்துவிட்டீர்கள்',
    },
    'lwltwnb0': {
      'en':
          'You have used 80% of your available requests. Upgrade plan to make more network requests.',
      'hi':
          'आपने अपने उपलब्ध अनुरोधों में से 80% का उपयोग कर लिया है। अधिक नेटवर्क अनुरोध करने के लिए योजना को अपग्रेड करें।',
      'kn':
          'ನಿಮ್ಮ ಲಭ್ಯವಿರುವ ವಿನಂತಿಗಳಲ್ಲಿ 80% ಅನ್ನು ನೀವು ಬಳಸಿದ್ದೀರಿ. ಹೆಚ್ಚಿನ ನೆಟ್‌ವರ್ಕ್ ವಿನಂತಿಗಳನ್ನು ಮಾಡಲು ಯೋಜನೆಯನ್ನು ಅಪ್‌ಗ್ರೇಡ್ ಮಾಡಿ.',
      'ta':
          'உங்கள் கிடைக்கக்கூடிய கோரிக்கைகளில் 80% பயன்படுத்தியுள்ளீர்கள். மேலும் நெட்வொர்க் கோரிக்கைகளைச் செய்ய, திட்டத்தை மேம்படுத்தவும்.',
    },
    'yof5fr65': {
      'en': 'Transaction History',
      'hi': 'ट्रांजेक्शन इतिहास',
      'kn': 'ವಹಿವಾಟಿನ ಇತಿಹಾಸ',
      'ta': 'பரிவர்த்தனை வரலாறு',
    },
    'zenc5ydd': {
      'en': 'Create tables and ui elements that work below.',
      'hi': 'नीचे काम करने वाली तालिकाएँ और UI तत्व बनाएँ।',
      'kn': 'ಕೆಳಗೆ ಕೆಲಸ ಮಾಡುವ ಕೋಷ್ಟಕಗಳು ಮತ್ತು ui ಅಂಶಗಳನ್ನು ರಚಿಸಿ.',
      'ta': 'கீழே வேலை செய்யும் அட்டவணைகள் மற்றும் ui கூறுகளை உருவாக்கவும்.',
    },
    '59vskifg': {
      'en': 'Add New',
      'hi': 'नया जोड़ो',
      'kn': 'ಹೊಸದನ್ನು ಸೇರಿಸಿ',
      'ta': 'புதியதைச் சேர்க்கவும்',
    },
    'caun1viu': {
      'en': 'Transaction Type',
      'hi': 'लेन-देन का प्रकार',
      'kn': 'ವಹಿವಾಟಿನ ಪ್ರಕಾರ',
      'ta': 'பரிவர்த்தனை வகை',
    },
    'fy5m7tnc': {
      'en': 'Assigned User',
      'hi': 'निर्दिष्ट उपयोगकर्ता',
      'kn': 'ನಿಯೋಜಿತ ಬಳಕೆದಾರ',
      'ta': 'ஒதுக்கப்பட்ட பயனர்',
    },
    'n46y490v': {
      'en': 'Contract Amount',
      'hi': 'अनुबंध राशि',
      'kn': 'ಒಪ್ಪಂದದ ಮೊತ್ತ',
      'ta': 'ஒப்பந்தத் தொகை',
    },
    'or0d5llc': {
      'en': 'Status',
      'hi': 'स्थिति',
      'kn': 'ಸ್ಥಿತಿ',
      'ta': 'நிலை',
    },
    'wxursbg6': {
      'en': 'Actions',
      'hi': 'कार्रवाई',
      'kn': 'ಕ್ರಿಯೆಗಳು',
      'ta': 'செயல்கள்',
    },
    'ifwn3qlp': {
      'en': 'Debit',
      'hi': 'खर्चे में लिखना',
      'kn': 'ಡೆಬಿಟ್',
      'ta': 'பற்று',
    },
    's0z77nxo': {
      'en': 'Rahul',
      'hi': 'राहुल',
      'kn': 'ರಾಹುಲ್',
      'ta': 'ராகுல்',
    },
    'peagp9xg': {
      'en': 'Business Name',
      'hi': 'व्यवसाय का नाम',
      'kn': 'ವ್ಯಾಪಾರದ ಹೆಸರು',
      'ta': 'வணிகப் பெயர்',
    },
    'c2biy6vi': {
      'en': '₹2,100',
      'hi': '₹2,100',
      'kn': '₹2,100',
      'ta': '₹2,100',
    },
    '18apepu0': {
      'en': 'Paid',
      'hi': 'चुकाया गया',
      'kn': 'ಪಾವತಿಸಲಾಗಿದೆ',
      'ta': 'செலுத்தப்பட்டது',
    },
    'wuuw7w8j': {
      'en': 'Credit',
      'hi': 'श्रेय',
      'kn': 'ಕ್ರೆಡಿಟ್',
      'ta': 'கடன்',
    },
    '0aj5hb6w': {
      'en': 'Mahesh',
      'hi': 'महेश',
      'kn': 'ಮಹೇಶ್',
      'ta': 'மகேஷ்',
    },
    'byvnlwog': {
      'en': 'Business Name',
      'hi': 'व्यवसाय का नाम',
      'kn': 'ವ್ಯಾಪಾರದ ಹೆಸರು',
      'ta': 'வணிகப் பெயர்',
    },
    'zsgsrh40': {
      'en': '₹2,100',
      'hi': '₹2,100',
      'kn': '₹2,100',
      'ta': '₹2,100',
    },
    '21upawcz': {
      'en': 'Paid',
      'hi': 'चुकाया गया',
      'kn': 'ಪಾವತಿಸಲಾಗಿದೆ',
      'ta': 'செலுத்தப்பட்டது',
    },
    'z8q8tbx9': {
      'en': 'Debit',
      'hi': 'खर्चे में लिखना',
      'kn': 'ಡೆಬಿಟ್',
      'ta': 'பற்று',
    },
    '1wre9bqj': {
      'en': 'Mahesh',
      'hi': 'महेश',
      'kn': 'ಮಹೇಶ್',
      'ta': 'மகேஷ்',
    },
    '2juuud2e': {
      'en': 'Business Name',
      'hi': 'व्यवसाय का नाम',
      'kn': 'ವ್ಯಾಪಾರದ ಹೆಸರು',
      'ta': 'வணிகப் பெயர்',
    },
    'ddeaukf2': {
      'en': '₹2,100',
      'hi': '₹2,100',
      'kn': '₹2,100',
      'ta': '₹2,100',
    },
    'a8kqsgho': {
      'en': 'Paid',
      'hi': 'चुकाया गया',
      'kn': 'ಪಾವತಿಸಲಾಗಿದೆ',
      'ta': 'செலுத்தப்பட்டது',
    },
    '4oxpvdbt': {
      'en': 'Credit',
      'hi': 'श्रेय',
      'kn': 'ಕ್ರೆಡಿಟ್',
      'ta': 'கடன்',
    },
    'brairclg': {
      'en': 'Mahesh',
      'hi': 'महेश',
      'kn': 'ಮಹೇಶ್',
      'ta': 'மகேஷ்',
    },
    'whi9t9h4': {
      'en': 'Business Name',
      'hi': 'व्यवसाय का नाम',
      'kn': 'ವ್ಯಾಪಾರದ ಹೆಸರು',
      'ta': 'வணிகப் பெயர்',
    },
    'erppjcf2': {
      'en': '₹2,100',
      'hi': '₹2,100',
      'kn': '₹2,100',
      'ta': '₹2,100',
    },
    'p1088y3j': {
      'en': 'Paid',
      'hi': 'चुकाया गया',
      'kn': 'ಪಾವತಿಸಲಾಗಿದೆ',
      'ta': 'செலுத்தப்பட்டது',
    },
    'jkp2ccs4': {
      'en': 'Debit',
      'hi': 'खर्चे में लिखना',
      'kn': 'ಡೆಬಿಟ್',
      'ta': 'பற்று',
    },
    'a2id91y5': {
      'en': 'Nancy',
      'hi': 'नैंसी',
      'kn': 'ನ್ಯಾನ್ಸಿ',
      'ta': 'நான்சி',
    },
    'fowygx0o': {
      'en': 'Business Name',
      'hi': 'व्यवसाय का नाम',
      'kn': 'ವ್ಯಾಪಾರದ ಹೆಸರು',
      'ta': 'வணிகப் பெயர்',
    },
    '20rsmqf5': {
      'en': '₹2,100',
      'hi': '₹2,100',
      'kn': '₹2,100',
      'ta': '₹2,100',
    },
    '1c5oa6ud': {
      'en': 'Pending',
      'hi': 'लंबित',
      'kn': 'ಬಾಕಿಯಿದೆ',
      'ta': 'நிலுவையில் உள்ளது',
    },
    'yv04jv1v': {
      'en': 'Credit',
      'hi': 'श्रेय',
      'kn': 'ಕ್ರೆಡಿಟ್',
      'ta': 'கடன்',
    },
    'u7dy0c2c': {
      'en': 'Nancy',
      'hi': 'नैंसी',
      'kn': 'ನ್ಯಾನ್ಸಿ',
      'ta': 'நான்சி',
    },
    'ufhhkku1': {
      'en': 'Business Name',
      'hi': 'व्यवसाय का नाम',
      'kn': 'ವ್ಯಾಪಾರದ ಹೆಸರು',
      'ta': 'வணிகப் பெயர்',
    },
    '2yugondi': {
      'en': '₹2,100',
      'hi': '₹2,100',
      'kn': '₹2,100',
      'ta': '₹2,100',
    },
    'tz0xml52': {
      'en': 'Pending',
      'hi': 'लंबित',
      'kn': 'ಬಾಕಿಯಿದೆ',
      'ta': 'நிலுவையில் உள்ளது',
    },
    '7tqlqip4': {
      'en': 'Debit',
      'hi': 'खर्चे में लिखना',
      'kn': 'ಡೆಬಿಟ್',
      'ta': 'பற்று',
    },
    '12vhfmov': {
      'en': 'Nancy',
      'hi': 'नैंसी',
      'kn': 'ನ್ಯಾನ್ಸಿ',
      'ta': 'நான்சி',
    },
    '23thq10q': {
      'en': 'Business Name',
      'hi': 'व्यवसाय का नाम',
      'kn': 'ವ್ಯಾಪಾರದ ಹೆಸರು',
      'ta': 'வணிகப் பெயர்',
    },
    'bp9bbdd5': {
      'en': '₹2,100',
      'hi': '₹2,100',
      'kn': '₹2,100',
      'ta': '₹2,100',
    },
    '8pe3ll6o': {
      'en': 'Pending',
      'hi': 'लंबित',
      'kn': 'ಬಾಕಿಯಿದೆ',
      'ta': 'நிலுவையில் உள்ளது',
    },
    'p6x7ruu3': {
      'en': 'Card Header',
      'hi': 'कार्ड हेडर',
      'kn': 'ಕಾರ್ಡ್ ಹೆಡರ್',
      'ta': 'அட்டை தலைப்பு',
    },
    '0t1gu2t6': {
      'en': 'Create tables and ui elements that work below.',
      'hi': 'नीचे काम करने वाली तालिकाएँ और UI तत्व बनाएँ।',
      'kn': 'ಕೆಳಗೆ ಕೆಲಸ ಮಾಡುವ ಕೋಷ್ಟಕಗಳು ಮತ್ತು ui ಅಂಶಗಳನ್ನು ರಚಿಸಿ.',
      'ta': 'கீழே வேலை செய்யும் அட்டவணைகள் மற்றும் ui கூறுகளை உருவாக்கவும்.',
    },
    '6sitgb0z': {
      'en': 'Add New',
      'hi': 'नया जोड़ो',
      'kn': 'ಹೊಸದನ್ನು ಸೇರಿಸಿ',
      'ta': 'புதியதைச் சேர்க்கவும்',
    },
    '3xncd50z': {
      'en': 'Work Type',
      'hi': 'कार्य प्रकार',
      'kn': 'ಕೆಲಸದ ಪ್ರಕಾರ',
      'ta': 'வேலை வகை',
    },
    'xdiahh6c': {
      'en': 'Assigned User',
      'hi': 'निर्दिष्ट उपयोगकर्ता',
      'kn': 'ನಿಯೋಜಿತ ಬಳಕೆದಾರ',
      'ta': 'ஒதுக்கப்பட்ட பயனர்',
    },
    'ei5d3ki2': {
      'en': 'Contract Amount',
      'hi': 'अनुबंध राशि',
      'kn': 'ಒಪ್ಪಂದದ ಮೊತ್ತ',
      'ta': 'ஒப்பந்தத் தொகை',
    },
    'j5czzbhn': {
      'en': 'Status',
      'hi': 'स्थिति',
      'kn': 'ಸ್ಥಿತಿ',
      'ta': 'நிலை',
    },
    'nqqsxfso': {
      'en': 'Actions',
      'hi': 'कार्रवाई',
      'kn': 'ಕ್ರಿಯೆಗಳು',
      'ta': 'செயல்கள்',
    },
    '8nybi71i': {
      'en': 'Design Work',
      'hi': 'डिजायन का काम',
      'kn': 'ವಿನ್ಯಾಸ ಕೆಲಸ',
      'ta': 'வடிவமைப்பு வேலை',
    },
    'xlsx5i3v': {
      'en': 'Randy Peterson',
      'hi': 'रैंडी पीटरसन',
      'kn': 'ರಾಂಡಿ ಪೀಟರ್ಸನ್',
      'ta': 'ராண்டி பீட்டர்சன்',
    },
    'clqylebl': {
      'en': 'Business Name',
      'hi': 'व्यवसाय का नाम',
      'kn': 'ವ್ಯಾಪಾರದ ಹೆಸರು',
      'ta': 'வணிகப் பெயர்',
    },
    'ixmmiyoq': {
      'en': '\$2,100',
      'hi': '\$2,100',
      'kn': '\$2,100',
      'ta': '\$2,100',
    },
    'kpfdgvyw': {
      'en': 'Paid',
      'hi': 'चुकाया गया',
      'kn': 'ಪಾವತಿಸಲಾಗಿದೆ',
      'ta': 'செலுத்தப்பட்டது',
    },
    'nnxs8j7s': {
      'en': 'Design Work',
      'hi': 'डिजायन का काम',
      'kn': 'ವಿನ್ಯಾಸ ಕೆಲಸ',
      'ta': 'வடிவமைப்பு வேலை',
    },
    'nmgh41k7': {
      'en': 'Randy Peterson',
      'hi': 'रैंडी पीटरसन',
      'kn': 'ರಾಂಡಿ ಪೀಟರ್ಸನ್',
      'ta': 'ராண்டி பீட்டர்சன்',
    },
    'g910gchk': {
      'en': 'Business Name',
      'hi': 'व्यवसाय का नाम',
      'kn': 'ವ್ಯಾಪಾರದ ಹೆಸರು',
      'ta': 'வணிகப் பெயர்',
    },
    '0ntvsyz3': {
      'en': '\$2,100',
      'hi': '\$2,100',
      'kn': '\$2,100',
      'ta': '\$2,100',
    },
    '0kv159jb': {
      'en': 'Paid',
      'hi': 'चुकाया गया',
      'kn': 'ಪಾವತಿಸಲಾಗಿದೆ',
      'ta': 'செலுத்தப்பட்டது',
    },
    'omnqcisn': {
      'en': 'Design Work',
      'hi': 'डिजायन का काम',
      'kn': 'ವಿನ್ಯಾಸ ಕೆಲಸ',
      'ta': 'வடிவமைப்பு வேலை',
    },
    'sb1kvij1': {
      'en': 'Randy Peterson',
      'hi': 'रैंडी पीटरसन',
      'kn': 'ರಾಂಡಿ ಪೀಟರ್ಸನ್',
      'ta': 'ராண்டி பீட்டர்சன்',
    },
    'e9d267j8': {
      'en': 'Business Name',
      'hi': 'व्यवसाय का नाम',
      'kn': 'ವ್ಯಾಪಾರದ ಹೆಸರು',
      'ta': 'வணிகப் பெயர்',
    },
    'mtziy10u': {
      'en': '\$2,100',
      'hi': '\$2,100',
      'kn': '\$2,100',
      'ta': '\$2,100',
    },
    'ac0ydr0t': {
      'en': 'Paid',
      'hi': 'चुकाया गया',
      'kn': 'ಪಾವತಿಸಲಾಗಿದೆ',
      'ta': 'செலுத்தப்பட்டது',
    },
    'leilvbaj': {
      'en': 'Design Work',
      'hi': 'डिजायन का काम',
      'kn': 'ವಿನ್ಯಾಸ ಕೆಲಸ',
      'ta': 'வடிவமைப்பு வேலை',
    },
    'ylruvqri': {
      'en': 'Randy Peterson',
      'hi': 'रैंडी पीटरसन',
      'kn': 'ರಾಂಡಿ ಪೀಟರ್ಸನ್',
      'ta': 'ராண்டி பீட்டர்சன்',
    },
    'wmju7dmp': {
      'en': 'Business Name',
      'hi': 'व्यवसाय का नाम',
      'kn': 'ವ್ಯಾಪಾರದ ಹೆಸರು',
      'ta': 'வணிகப் பெயர்',
    },
    '1rx52qcu': {
      'en': '\$2,100',
      'hi': '\$2,100',
      'kn': '\$2,100',
      'ta': '\$2,100',
    },
    '123aq2sy': {
      'en': 'Paid',
      'hi': 'चुकाया गया',
      'kn': 'ಪಾವತಿಸಲಾಗಿದೆ',
      'ta': 'செலுத்தப்பட்டது',
    },
    '4l9z84gt': {
      'en': 'Design Work',
      'hi': 'डिजायन का काम',
      'kn': 'ವಿನ್ಯಾಸ ಕೆಲಸ',
      'ta': 'வடிவமைப்பு வேலை',
    },
    'mvpz5mxi': {
      'en': 'Randy Peterson',
      'hi': 'रैंडी पीटरसन',
      'kn': 'ರಾಂಡಿ ಪೀಟರ್ಸನ್',
      'ta': 'ராண்டி பீட்டர்சன்',
    },
    'i6rkrygf': {
      'en': 'Business Name',
      'hi': 'व्यवसाय का नाम',
      'kn': 'ವ್ಯಾಪಾರದ ಹೆಸರು',
      'ta': 'வணிகப் பெயர்',
    },
    'ozfordm2': {
      'en': '\$2,100',
      'hi': '\$2,100',
      'kn': '\$2,100',
      'ta': '\$2,100',
    },
    'av0vljjg': {
      'en': 'Pending',
      'hi': 'लंबित',
      'kn': 'ಬಾಕಿಯಿದೆ',
      'ta': 'நிலுவையில் உள்ளது',
    },
    'bgqexkvr': {
      'en': 'Design Work',
      'hi': 'डिजायन का काम',
      'kn': 'ವಿನ್ಯಾಸ ಕೆಲಸ',
      'ta': 'வடிவமைப்பு வேலை',
    },
    'hmgazkt0': {
      'en': 'Randy Peterson',
      'hi': 'रैंडी पीटरसन',
      'kn': 'ರಾಂಡಿ ಪೀಟರ್ಸನ್',
      'ta': 'ராண்டி பீட்டர்சன்',
    },
    'dpa0oq2v': {
      'en': 'Business Name',
      'hi': 'व्यवसाय का नाम',
      'kn': 'ವ್ಯಾಪಾರದ ಹೆಸರು',
      'ta': 'வணிகப் பெயர்',
    },
    'xzrupm8j': {
      'en': '\$2,100',
      'hi': '\$2,100',
      'kn': '\$2,100',
      'ta': '\$2,100',
    },
    '919nigmp': {
      'en': 'Pending',
      'hi': 'लंबित',
      'kn': 'ಬಾಕಿಯಿದೆ',
      'ta': 'நிலுவையில் உள்ளது',
    },
    '7hzgil4a': {
      'en': 'Design Work',
      'hi': 'डिजायन का काम',
      'kn': 'ವಿನ್ಯಾಸ ಕೆಲಸ',
      'ta': 'வடிவமைப்பு வேலை',
    },
    'mtcnhz21': {
      'en': 'Randy Peterson',
      'hi': 'रैंडी पीटरसन',
      'kn': 'ರಾಂಡಿ ಪೀಟರ್ಸನ್',
      'ta': 'ராண்டி பீட்டர்சன்',
    },
    '3hkd685d': {
      'en': 'Business Name',
      'hi': 'व्यवसाय का नाम',
      'kn': 'ವ್ಯಾಪಾರದ ಹೆಸರು',
      'ta': 'வணிகப் பெயர்',
    },
    '8umd8iyr': {
      'en': '\$2,100',
      'hi': '\$2,100',
      'kn': '\$2,100',
      'ta': '\$2,100',
    },
    'm1xafkpq': {
      'en': 'Pending',
      'hi': 'लंबित',
      'kn': 'ಬಾಕಿಯಿದೆ',
      'ta': 'நிலுவையில் உள்ளது',
    },
    's7bjws61': {
      'en': 'Home',
      'hi': 'घर',
      'kn': 'ಮನೆ',
      'ta': 'வீடு',
    },
  },
  // Miscellaneous
  {
    'a0tyii5u': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
    '5u68s6ai': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
    '5qh3ebd0': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
    'vhu590dc': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
    'cqgi7nts': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
    'ao6ckt7p': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
    'iimf6lv1': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
    'hu2rgfq1': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
    '3onp2lml': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
    'wdax4vuz': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
    'braj64nj': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
    'epl9r0x6': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
    '8bi8r6qg': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
    'z4qbdmkb': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
    'qasj0lkd': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
    'ud9cf57t': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
    'hzkibd4u': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
    'u2rgoykp': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
    '1313blb6': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
    '5rvz264d': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
    '1wzl4fvj': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
    'vyexxgn6': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
    'ak98rfis': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
    'e4bqvi50': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
    'b4rxiuul': {
      'en': '',
      'hi': '',
      'kn': '',
      'ta': '',
    },
  },
].reduce((a, b) => a..addAll(b));
