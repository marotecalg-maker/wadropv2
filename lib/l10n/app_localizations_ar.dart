// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'وَدْروب';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navStats => 'إحصائيات';

  @override
  String get navWorkout => 'رياضة';

  @override
  String get navAwards => 'إنجازات';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get greetingMorning => 'صباح الخير';

  @override
  String get greetingAfternoon => 'مساء الخير';

  @override
  String get greetingEvening => 'مساء الخير';

  @override
  String get greetingNight => 'حافظ على ترطيبك';

  @override
  String get greetingSubtitle => 'لنحقق هدفك من الماء اليوم.';

  @override
  String get dayStreak => 'يوم متتالٍ';

  @override
  String get cupsToday => 'كوب اليوم';

  @override
  String get ofGoal => 'من الهدف';

  @override
  String mlLeftToGoal(String amount) {
    return 'بقي $amount للوصول إلى هدفك';
  }

  @override
  String get goalReachedBanner => 'تم بلوغ الهدف — أحسنت! 🎉';

  @override
  String overGoalBanner(String amount) {
    return '$amount فوق هدفك 💪';
  }

  @override
  String get favorites => 'المفضلة';

  @override
  String get addDrink => 'إضافة';

  @override
  String get undo => 'تراجع';

  @override
  String get todaysLog => 'سجل اليوم';

  @override
  String get emptyLogTitle => 'لا مشروبات مسجّلة بعد';

  @override
  String get emptyLogSubtitle => 'اضغط على مفضّلة أو «إضافة» للبدء.';

  @override
  String get drinkWater => 'ماء';

  @override
  String get drinkCoffee => 'قهوة';

  @override
  String get drinkTea => 'شاي';

  @override
  String get drinkJuice => 'عصير';

  @override
  String get drinkSoda => 'مشروب غازي';

  @override
  String get drinkMilk => 'حليب';

  @override
  String get drinkSparkling => 'ماء غازي';

  @override
  String get drinkEnergy => 'طاقة';

  @override
  String get addDrinkTitle => 'إضافة مشروب';

  @override
  String get selectType => 'النوع';

  @override
  String get selectAmount => 'الكمية';

  @override
  String get customAmount => 'كمية مخصّصة';

  @override
  String get add => 'إضافة';

  @override
  String get cancel => 'إلغاء';

  @override
  String get editFavorites => 'تعديل المفضلة';

  @override
  String get newFavorite => 'مفضّلة جديدة';

  @override
  String get favoritesHint => 'اضغط مطوّلًا على مفضّلة لحذفها.';

  @override
  String get statsTitle => 'الإحصائيات';

  @override
  String get rangeWeek => 'أسبوع';

  @override
  String get rangeMonth => 'شهر';

  @override
  String get avgIntake => 'المعدّل اليومي';

  @override
  String get totalIntake => 'الإجمالي';

  @override
  String get goalCompletion => 'نسبة الهدف';

  @override
  String get bestDay => 'أفضل يوم';

  @override
  String get daysMetGoal => 'أيام تحقيق الهدف';

  @override
  String get intakeByType => 'حسب نوع المشروب';

  @override
  String get noData => 'لا توجد بيانات كافية بعد';

  @override
  String get workoutTitle => 'الرياضة واللياقة';

  @override
  String get addWorkout => 'تسجيل حصّة';

  @override
  String get workoutTypeLabel => 'النشاط';

  @override
  String get duration => 'المدّة';

  @override
  String get intensity => 'الشدّة';

  @override
  String get intensityLow => 'خفيفة';

  @override
  String get intensityMedium => 'متوسطة';

  @override
  String get intensityHigh => 'عالية';

  @override
  String get minutesShort => 'د';

  @override
  String get todaysWorkouts => 'حصص اليوم';

  @override
  String get noWorkouts => 'لا حصص مسجّلة اليوم';

  @override
  String extraWater(String amount) {
    return '+$amount ماء';
  }

  @override
  String get hydrationBonusTitle => 'مكافأة الترطيب';

  @override
  String hydrationBonusDesc(String amount) {
    return 'أضافت تمارينك اليوم $amount إلى هدفك.';
  }

  @override
  String get weeklyActivity => 'هذا الأسبوع';

  @override
  String get activeMinutes => 'دقائق النشاط';

  @override
  String get caloriesLabel => 'السعرات';

  @override
  String get sessions => 'الحصص';

  @override
  String get stepsTitle => 'الخطوات والمشي';

  @override
  String get steps => 'خطوات';

  @override
  String get stepsUnit => 'خطوة';

  @override
  String get walkDistance => 'المسافة';

  @override
  String get stepGoalOf => 'من هدف الخطوات';

  @override
  String get stepGoal => 'هدف الخطوات اليومي';

  @override
  String get height => 'الطول';

  @override
  String get enableStepCounter => 'اسمح بالوصول للحركة لعدّ خطواتك';

  @override
  String get workoutStrength => 'كمال أجسام';

  @override
  String get workoutCardio => 'كارديو';

  @override
  String get workoutRunning => 'جري';

  @override
  String get workoutCycling => 'دراجة';

  @override
  String get workoutSwimming => 'سباحة';

  @override
  String get workoutYoga => 'يوغا';

  @override
  String get workoutWalking => 'مشي';

  @override
  String get workoutHiit => 'تمارين متقطّعة';

  @override
  String get workoutFootball => 'كرة القدم';

  @override
  String get awardsTitle => 'الإنجازات';

  @override
  String get currentStreak => 'التتابع الحالي';

  @override
  String get bestStreak => 'أفضل تتابع';

  @override
  String get lifetimeWater => 'إجمالي الماء';

  @override
  String get daysTracked => 'أيام التتبّع';

  @override
  String get days => 'يوم';

  @override
  String get locked => 'مقفل';

  @override
  String get unlocked => 'مفتوح';

  @override
  String get badgeFirstSipTitle => 'أول رشفة';

  @override
  String get badgeFirstSipDesc => 'سجّل أول مشروب لك.';

  @override
  String get badgeGoalGetterTitle => 'بلوغ الهدف';

  @override
  String get badgeGoalGetterDesc => 'حقّق هدفك اليومي مرّة.';

  @override
  String get badgeStreak3Title => 'انطلاقة';

  @override
  String get badgeStreak3Desc => 'حافظ على تتابع 3 أيام.';

  @override
  String get badgeStreak7Title => 'أسبوع كامل';

  @override
  String get badgeStreak7Desc => 'حافظ على تتابع 7 أيام.';

  @override
  String get badgeStreak30Title => 'بطل الترطيب';

  @override
  String get badgeStreak30Desc => 'حافظ على تتابع 30 يومًا.';

  @override
  String get badgeAthleteTitle => 'رياضي';

  @override
  String get badgeAthleteDesc => 'سجّل 10 حصص رياضية.';

  @override
  String get badgeOverachieverTitle => 'تجاوز الهدف';

  @override
  String get badgeOverachieverDesc => 'ابلغ 150% من هدفك في يوم.';

  @override
  String get badgeHydratedTitle => 'ترطيب كامل';

  @override
  String get badgeHydratedDesc => 'اشرب 100 لتر إجمالًا.';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get sectionGoal => 'الهدف والوحدات';

  @override
  String get dailyGoal => 'الهدف اليومي';

  @override
  String get unit => 'الوحدة';

  @override
  String get unitMl => 'ملليلتر (ml)';

  @override
  String get unitOz => 'أونصة (oz)';

  @override
  String get sectionProfile => 'الملف الشخصي';

  @override
  String get weight => 'الوزن';

  @override
  String get gender => 'الجنس';

  @override
  String get genderMale => 'ذكر';

  @override
  String get genderFemale => 'أنثى';

  @override
  String get genderOther => 'آخر';

  @override
  String get activityLevel => 'مستوى النشاط';

  @override
  String get activitySedentary => 'قليل الحركة';

  @override
  String get activityModerate => 'متوسط';

  @override
  String get activityActive => 'نشيط';

  @override
  String get suggestGoal => 'اقترح هدفًا حسب ملفي';

  @override
  String suggestedGoalMsg(String amount) {
    return 'الهدف المقترح: $amount يوميًا';
  }

  @override
  String get apply => 'تطبيق';

  @override
  String get sectionAppearance => 'المظهر';

  @override
  String get theme => 'السمة';

  @override
  String get themeSystem => 'النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get language => 'اللغة';

  @override
  String get sectionReminders => 'التذكيرات';

  @override
  String get enableReminders => 'تفعيل التذكيرات';

  @override
  String get reminderInterval => 'ذكّرني كل';

  @override
  String get hoursShort => 'س';

  @override
  String get activeHours => 'ساعات النشاط';

  @override
  String get from => 'من';

  @override
  String get to => 'إلى';

  @override
  String get remindersNote =>
      'تُجدول التذكيرات طالما التطبيق مثبّت. امنح إذن الإشعارات عند الطلب.';

  @override
  String get sectionData => 'البيانات';

  @override
  String get resetToday => 'إعادة ضبط اليوم';

  @override
  String get clearAllData => 'مسح كل البيانات';

  @override
  String get clearConfirmTitle => 'مسح كل البيانات؟';

  @override
  String get clearConfirmMsg =>
      'سيحذف هذا نهائيًا جميع السجلات والحصص والإعدادات.';

  @override
  String get sectionAbout => 'حول';

  @override
  String get version => 'الإصدار';

  @override
  String get madeWith => 'صُنع بـ 💧 لمن ينسى أن يشرب.';

  @override
  String get save => 'حفظ';

  @override
  String get delete => 'حذف';

  @override
  String get remove => 'إزالة';

  @override
  String get close => 'إغلاق';

  @override
  String get ok => 'حسنًا';

  @override
  String get reset => 'إعادة ضبط';
}
