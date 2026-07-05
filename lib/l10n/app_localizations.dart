import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Wadrop'**
  String get appName;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navStats.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get navStats;

  /// No description provided for @navWorkout.
  ///
  /// In en, this message translates to:
  /// **'Sport'**
  String get navWorkout;

  /// No description provided for @navAwards.
  ///
  /// In en, this message translates to:
  /// **'Awards'**
  String get navAwards;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get greetingEvening;

  /// No description provided for @greetingNight.
  ///
  /// In en, this message translates to:
  /// **'Stay hydrated'**
  String get greetingNight;

  /// No description provided for @greetingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s reach your water goal today.'**
  String get greetingSubtitle;

  /// No description provided for @dayStreak.
  ///
  /// In en, this message translates to:
  /// **'day streak'**
  String get dayStreak;

  /// No description provided for @cupsToday.
  ///
  /// In en, this message translates to:
  /// **'cups today'**
  String get cupsToday;

  /// No description provided for @ofGoal.
  ///
  /// In en, this message translates to:
  /// **'of goal'**
  String get ofGoal;

  /// No description provided for @mlLeftToGoal.
  ///
  /// In en, this message translates to:
  /// **'{amount} left to reach your goal'**
  String mlLeftToGoal(String amount);

  /// No description provided for @goalReachedBanner.
  ///
  /// In en, this message translates to:
  /// **'Goal reached — great job! 🎉'**
  String get goalReachedBanner;

  /// No description provided for @overGoalBanner.
  ///
  /// In en, this message translates to:
  /// **'{amount} over your goal 💪'**
  String overGoalBanner(String amount);

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @addDrink.
  ///
  /// In en, this message translates to:
  /// **'Add drink'**
  String get addDrink;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @todaysLog.
  ///
  /// In en, this message translates to:
  /// **'Today\'s log'**
  String get todaysLog;

  /// No description provided for @emptyLogTitle.
  ///
  /// In en, this message translates to:
  /// **'No drinks logged yet'**
  String get emptyLogTitle;

  /// No description provided for @emptyLogSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap a favorite or “Add drink” to start.'**
  String get emptyLogSubtitle;

  /// No description provided for @drinkWater.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get drinkWater;

  /// No description provided for @drinkCoffee.
  ///
  /// In en, this message translates to:
  /// **'Coffee'**
  String get drinkCoffee;

  /// No description provided for @drinkTea.
  ///
  /// In en, this message translates to:
  /// **'Tea'**
  String get drinkTea;

  /// No description provided for @drinkJuice.
  ///
  /// In en, this message translates to:
  /// **'Juice'**
  String get drinkJuice;

  /// No description provided for @drinkSoda.
  ///
  /// In en, this message translates to:
  /// **'Soda'**
  String get drinkSoda;

  /// No description provided for @drinkMilk.
  ///
  /// In en, this message translates to:
  /// **'Milk'**
  String get drinkMilk;

  /// No description provided for @drinkSparkling.
  ///
  /// In en, this message translates to:
  /// **'Sparkling'**
  String get drinkSparkling;

  /// No description provided for @drinkEnergy.
  ///
  /// In en, this message translates to:
  /// **'Energy'**
  String get drinkEnergy;

  /// No description provided for @addDrinkTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a drink'**
  String get addDrinkTitle;

  /// No description provided for @selectType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get selectType;

  /// No description provided for @selectAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get selectAmount;

  /// No description provided for @customAmount.
  ///
  /// In en, this message translates to:
  /// **'Custom amount'**
  String get customAmount;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @editFavorites.
  ///
  /// In en, this message translates to:
  /// **'Edit favorites'**
  String get editFavorites;

  /// No description provided for @newFavorite.
  ///
  /// In en, this message translates to:
  /// **'New favorite'**
  String get newFavorite;

  /// No description provided for @favoritesHint.
  ///
  /// In en, this message translates to:
  /// **'Long-press a favorite to remove it.'**
  String get favoritesHint;

  /// No description provided for @statsTitle.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statsTitle;

  /// No description provided for @rangeWeek.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get rangeWeek;

  /// No description provided for @rangeMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get rangeMonth;

  /// No description provided for @avgIntake.
  ///
  /// In en, this message translates to:
  /// **'Daily average'**
  String get avgIntake;

  /// No description provided for @totalIntake.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get totalIntake;

  /// No description provided for @goalCompletion.
  ///
  /// In en, this message translates to:
  /// **'Goal completion'**
  String get goalCompletion;

  /// No description provided for @bestDay.
  ///
  /// In en, this message translates to:
  /// **'Best day'**
  String get bestDay;

  /// No description provided for @daysMetGoal.
  ///
  /// In en, this message translates to:
  /// **'Days goal met'**
  String get daysMetGoal;

  /// No description provided for @intakeByType.
  ///
  /// In en, this message translates to:
  /// **'Intake by drink'**
  String get intakeByType;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'Not enough data yet'**
  String get noData;

  /// No description provided for @workoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Sport & Fitness'**
  String get workoutTitle;

  /// No description provided for @addWorkout.
  ///
  /// In en, this message translates to:
  /// **'Log a session'**
  String get addWorkout;

  /// No description provided for @workoutTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get workoutTypeLabel;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @intensity.
  ///
  /// In en, this message translates to:
  /// **'Intensity'**
  String get intensity;

  /// No description provided for @intensityLow.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get intensityLow;

  /// No description provided for @intensityMedium.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get intensityMedium;

  /// No description provided for @intensityHigh.
  ///
  /// In en, this message translates to:
  /// **'Intense'**
  String get intensityHigh;

  /// No description provided for @minutesShort.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get minutesShort;

  /// No description provided for @todaysWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Today\'s sessions'**
  String get todaysWorkouts;

  /// No description provided for @noWorkouts.
  ///
  /// In en, this message translates to:
  /// **'No sessions logged today'**
  String get noWorkouts;

  /// No description provided for @extraWater.
  ///
  /// In en, this message translates to:
  /// **'+{amount} water'**
  String extraWater(String amount);

  /// No description provided for @hydrationBonusTitle.
  ///
  /// In en, this message translates to:
  /// **'Hydration bonus'**
  String get hydrationBonusTitle;

  /// No description provided for @hydrationBonusDesc.
  ///
  /// In en, this message translates to:
  /// **'Your training today added {amount} to your goal.'**
  String hydrationBonusDesc(String amount);

  /// No description provided for @weeklyActivity.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get weeklyActivity;

  /// No description provided for @activeMinutes.
  ///
  /// In en, this message translates to:
  /// **'Active minutes'**
  String get activeMinutes;

  /// No description provided for @caloriesLabel.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get caloriesLabel;

  /// No description provided for @sessions.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get sessions;

  /// No description provided for @stepsTitle.
  ///
  /// In en, this message translates to:
  /// **'Steps & walking'**
  String get stepsTitle;

  /// No description provided for @steps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get steps;

  /// No description provided for @stepsUnit.
  ///
  /// In en, this message translates to:
  /// **'steps'**
  String get stepsUnit;

  /// No description provided for @walkDistance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get walkDistance;

  /// No description provided for @stepGoalOf.
  ///
  /// In en, this message translates to:
  /// **'of step goal'**
  String get stepGoalOf;

  /// No description provided for @stepGoal.
  ///
  /// In en, this message translates to:
  /// **'Daily step goal'**
  String get stepGoal;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// No description provided for @enableStepCounter.
  ///
  /// In en, this message translates to:
  /// **'Allow motion access to count your steps'**
  String get enableStepCounter;

  /// No description provided for @workoutStrength.
  ///
  /// In en, this message translates to:
  /// **'Strength'**
  String get workoutStrength;

  /// No description provided for @workoutCardio.
  ///
  /// In en, this message translates to:
  /// **'Cardio'**
  String get workoutCardio;

  /// No description provided for @workoutRunning.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get workoutRunning;

  /// No description provided for @workoutCycling.
  ///
  /// In en, this message translates to:
  /// **'Cycling'**
  String get workoutCycling;

  /// No description provided for @workoutSwimming.
  ///
  /// In en, this message translates to:
  /// **'Swimming'**
  String get workoutSwimming;

  /// No description provided for @workoutYoga.
  ///
  /// In en, this message translates to:
  /// **'Yoga'**
  String get workoutYoga;

  /// No description provided for @workoutWalking.
  ///
  /// In en, this message translates to:
  /// **'Walking'**
  String get workoutWalking;

  /// No description provided for @workoutHiit.
  ///
  /// In en, this message translates to:
  /// **'HIIT'**
  String get workoutHiit;

  /// No description provided for @workoutFootball.
  ///
  /// In en, this message translates to:
  /// **'Football'**
  String get workoutFootball;

  /// No description provided for @awardsTitle.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get awardsTitle;

  /// No description provided for @currentStreak.
  ///
  /// In en, this message translates to:
  /// **'Current streak'**
  String get currentStreak;

  /// No description provided for @bestStreak.
  ///
  /// In en, this message translates to:
  /// **'Best streak'**
  String get bestStreak;

  /// No description provided for @lifetimeWater.
  ///
  /// In en, this message translates to:
  /// **'Lifetime water'**
  String get lifetimeWater;

  /// No description provided for @daysTracked.
  ///
  /// In en, this message translates to:
  /// **'Days tracked'**
  String get daysTracked;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// No description provided for @locked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get locked;

  /// No description provided for @unlocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocked'**
  String get unlocked;

  /// No description provided for @badgeFirstSipTitle.
  ///
  /// In en, this message translates to:
  /// **'First Sip'**
  String get badgeFirstSipTitle;

  /// No description provided for @badgeFirstSipDesc.
  ///
  /// In en, this message translates to:
  /// **'Log your very first drink.'**
  String get badgeFirstSipDesc;

  /// No description provided for @badgeGoalGetterTitle.
  ///
  /// In en, this message translates to:
  /// **'Goal Getter'**
  String get badgeGoalGetterTitle;

  /// No description provided for @badgeGoalGetterDesc.
  ///
  /// In en, this message translates to:
  /// **'Reach your daily goal once.'**
  String get badgeGoalGetterDesc;

  /// No description provided for @badgeStreak3Title.
  ///
  /// In en, this message translates to:
  /// **'Getting Going'**
  String get badgeStreak3Title;

  /// No description provided for @badgeStreak3Desc.
  ///
  /// In en, this message translates to:
  /// **'Keep a 3-day streak.'**
  String get badgeStreak3Desc;

  /// No description provided for @badgeStreak7Title.
  ///
  /// In en, this message translates to:
  /// **'One Week Strong'**
  String get badgeStreak7Title;

  /// No description provided for @badgeStreak7Desc.
  ///
  /// In en, this message translates to:
  /// **'Keep a 7-day streak.'**
  String get badgeStreak7Desc;

  /// No description provided for @badgeStreak30Title.
  ///
  /// In en, this message translates to:
  /// **'Hydration Hero'**
  String get badgeStreak30Title;

  /// No description provided for @badgeStreak30Desc.
  ///
  /// In en, this message translates to:
  /// **'Keep a 30-day streak.'**
  String get badgeStreak30Desc;

  /// No description provided for @badgeAthleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Athlete'**
  String get badgeAthleteTitle;

  /// No description provided for @badgeAthleteDesc.
  ///
  /// In en, this message translates to:
  /// **'Log 10 sport sessions.'**
  String get badgeAthleteDesc;

  /// No description provided for @badgeOverachieverTitle.
  ///
  /// In en, this message translates to:
  /// **'Overachiever'**
  String get badgeOverachieverTitle;

  /// No description provided for @badgeOverachieverDesc.
  ///
  /// In en, this message translates to:
  /// **'Hit 150% of your goal in a day.'**
  String get badgeOverachieverDesc;

  /// No description provided for @badgeHydratedTitle.
  ///
  /// In en, this message translates to:
  /// **'Fully Hydrated'**
  String get badgeHydratedTitle;

  /// No description provided for @badgeHydratedDesc.
  ///
  /// In en, this message translates to:
  /// **'Drink 100 L in total.'**
  String get badgeHydratedDesc;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @sectionGoal.
  ///
  /// In en, this message translates to:
  /// **'Goal & units'**
  String get sectionGoal;

  /// No description provided for @dailyGoal.
  ///
  /// In en, this message translates to:
  /// **'Daily goal'**
  String get dailyGoal;

  /// No description provided for @unit.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unit;

  /// No description provided for @unitMl.
  ///
  /// In en, this message translates to:
  /// **'Milliliters (ml)'**
  String get unitMl;

  /// No description provided for @unitOz.
  ///
  /// In en, this message translates to:
  /// **'Ounces (oz)'**
  String get unitOz;

  /// No description provided for @sectionProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get sectionProfile;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @genderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get genderFemale;

  /// No description provided for @genderOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get genderOther;

  /// No description provided for @activityLevel.
  ///
  /// In en, this message translates to:
  /// **'Activity level'**
  String get activityLevel;

  /// No description provided for @activitySedentary.
  ///
  /// In en, this message translates to:
  /// **'Sedentary'**
  String get activitySedentary;

  /// No description provided for @activityModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get activityModerate;

  /// No description provided for @activityActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get activityActive;

  /// No description provided for @suggestGoal.
  ///
  /// In en, this message translates to:
  /// **'Suggest a goal from my profile'**
  String get suggestGoal;

  /// No description provided for @suggestedGoalMsg.
  ///
  /// In en, this message translates to:
  /// **'Suggested goal: {amount} per day'**
  String suggestedGoalMsg(String amount);

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @sectionAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get sectionAppearance;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @sectionReminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get sectionReminders;

  /// No description provided for @enableReminders.
  ///
  /// In en, this message translates to:
  /// **'Enable reminders'**
  String get enableReminders;

  /// No description provided for @reminderInterval.
  ///
  /// In en, this message translates to:
  /// **'Remind me every'**
  String get reminderInterval;

  /// No description provided for @hoursShort.
  ///
  /// In en, this message translates to:
  /// **'h'**
  String get hoursShort;

  /// No description provided for @activeHours.
  ///
  /// In en, this message translates to:
  /// **'Active hours'**
  String get activeHours;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @remindersNote.
  ///
  /// In en, this message translates to:
  /// **'Reminders are scheduled while the app is installed. Grant notification permission when asked.'**
  String get remindersNote;

  /// No description provided for @sectionData.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get sectionData;

  /// No description provided for @resetToday.
  ///
  /// In en, this message translates to:
  /// **'Reset today\'s log'**
  String get resetToday;

  /// No description provided for @clearAllData.
  ///
  /// In en, this message translates to:
  /// **'Clear all data'**
  String get clearAllData;

  /// No description provided for @clearConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear all data?'**
  String get clearConfirmTitle;

  /// No description provided for @clearConfirmMsg.
  ///
  /// In en, this message translates to:
  /// **'This permanently deletes all your logs, sessions and settings.'**
  String get clearConfirmMsg;

  /// No description provided for @sectionAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get sectionAbout;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @madeWith.
  ///
  /// In en, this message translates to:
  /// **'Made with 💧 for people who forget to drink.'**
  String get madeWith;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
