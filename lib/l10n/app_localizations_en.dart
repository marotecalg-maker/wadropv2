// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Wadrop';

  @override
  String get navHome => 'Home';

  @override
  String get navStats => 'Stats';

  @override
  String get navWorkout => 'Sport';

  @override
  String get navAwards => 'Awards';

  @override
  String get navSettings => 'Settings';

  @override
  String get greetingMorning => 'Good morning';

  @override
  String get greetingAfternoon => 'Good afternoon';

  @override
  String get greetingEvening => 'Good evening';

  @override
  String get greetingNight => 'Stay hydrated';

  @override
  String get greetingSubtitle => 'Let\'s reach your water goal today.';

  @override
  String get dayStreak => 'day streak';

  @override
  String get cupsToday => 'cups today';

  @override
  String get ofGoal => 'of goal';

  @override
  String mlLeftToGoal(String amount) {
    return '$amount left to reach your goal';
  }

  @override
  String get goalReachedBanner => 'Goal reached — great job! 🎉';

  @override
  String overGoalBanner(String amount) {
    return '$amount over your goal 💪';
  }

  @override
  String get favorites => 'Favorites';

  @override
  String get addDrink => 'Add drink';

  @override
  String get undo => 'Undo';

  @override
  String get todaysLog => 'Today\'s log';

  @override
  String get emptyLogTitle => 'No drinks logged yet';

  @override
  String get emptyLogSubtitle => 'Tap a favorite or “Add drink” to start.';

  @override
  String get drinkWater => 'Water';

  @override
  String get drinkCoffee => 'Coffee';

  @override
  String get drinkTea => 'Tea';

  @override
  String get drinkJuice => 'Juice';

  @override
  String get drinkSoda => 'Soda';

  @override
  String get drinkMilk => 'Milk';

  @override
  String get drinkSparkling => 'Sparkling';

  @override
  String get drinkEnergy => 'Energy';

  @override
  String get addDrinkTitle => 'Add a drink';

  @override
  String get selectType => 'Type';

  @override
  String get selectAmount => 'Amount';

  @override
  String get customAmount => 'Custom amount';

  @override
  String get add => 'Add';

  @override
  String get cancel => 'Cancel';

  @override
  String get editFavorites => 'Edit favorites';

  @override
  String get newFavorite => 'New favorite';

  @override
  String get favoritesHint => 'Long-press a favorite to remove it.';

  @override
  String get statsTitle => 'Statistics';

  @override
  String get rangeWeek => 'Week';

  @override
  String get rangeMonth => 'Month';

  @override
  String get avgIntake => 'Daily average';

  @override
  String get totalIntake => 'Total';

  @override
  String get goalCompletion => 'Goal completion';

  @override
  String get bestDay => 'Best day';

  @override
  String get daysMetGoal => 'Days goal met';

  @override
  String get intakeByType => 'Intake by drink';

  @override
  String get noData => 'Not enough data yet';

  @override
  String get workoutTitle => 'Sport & Fitness';

  @override
  String get addWorkout => 'Log a session';

  @override
  String get workoutTypeLabel => 'Activity';

  @override
  String get duration => 'Duration';

  @override
  String get intensity => 'Intensity';

  @override
  String get intensityLow => 'Light';

  @override
  String get intensityMedium => 'Moderate';

  @override
  String get intensityHigh => 'Intense';

  @override
  String get minutesShort => 'min';

  @override
  String get todaysWorkouts => 'Today\'s sessions';

  @override
  String get noWorkouts => 'No sessions logged today';

  @override
  String extraWater(String amount) {
    return '+$amount water';
  }

  @override
  String get hydrationBonusTitle => 'Hydration bonus';

  @override
  String hydrationBonusDesc(String amount) {
    return 'Your training today added $amount to your goal.';
  }

  @override
  String get weeklyActivity => 'This week';

  @override
  String get activeMinutes => 'Active minutes';

  @override
  String get caloriesLabel => 'Calories';

  @override
  String get sessions => 'Sessions';

  @override
  String get stepsTitle => 'Steps & walking';

  @override
  String get steps => 'Steps';

  @override
  String get stepsUnit => 'steps';

  @override
  String get walkDistance => 'Distance';

  @override
  String get stepGoalOf => 'of step goal';

  @override
  String get stepGoal => 'Daily step goal';

  @override
  String get height => 'Height';

  @override
  String get enableStepCounter => 'Allow motion access to count your steps';

  @override
  String get workoutStrength => 'Strength';

  @override
  String get workoutCardio => 'Cardio';

  @override
  String get workoutRunning => 'Running';

  @override
  String get workoutCycling => 'Cycling';

  @override
  String get workoutSwimming => 'Swimming';

  @override
  String get workoutYoga => 'Yoga';

  @override
  String get workoutWalking => 'Walking';

  @override
  String get workoutHiit => 'HIIT';

  @override
  String get workoutFootball => 'Football';

  @override
  String get awardsTitle => 'Achievements';

  @override
  String get currentStreak => 'Current streak';

  @override
  String get bestStreak => 'Best streak';

  @override
  String get lifetimeWater => 'Lifetime water';

  @override
  String get daysTracked => 'Days tracked';

  @override
  String get days => 'days';

  @override
  String get locked => 'Locked';

  @override
  String get unlocked => 'Unlocked';

  @override
  String get badgeFirstSipTitle => 'First Sip';

  @override
  String get badgeFirstSipDesc => 'Log your very first drink.';

  @override
  String get badgeGoalGetterTitle => 'Goal Getter';

  @override
  String get badgeGoalGetterDesc => 'Reach your daily goal once.';

  @override
  String get badgeStreak3Title => 'Getting Going';

  @override
  String get badgeStreak3Desc => 'Keep a 3-day streak.';

  @override
  String get badgeStreak7Title => 'One Week Strong';

  @override
  String get badgeStreak7Desc => 'Keep a 7-day streak.';

  @override
  String get badgeStreak30Title => 'Hydration Hero';

  @override
  String get badgeStreak30Desc => 'Keep a 30-day streak.';

  @override
  String get badgeAthleteTitle => 'Athlete';

  @override
  String get badgeAthleteDesc => 'Log 10 sport sessions.';

  @override
  String get badgeOverachieverTitle => 'Overachiever';

  @override
  String get badgeOverachieverDesc => 'Hit 150% of your goal in a day.';

  @override
  String get badgeHydratedTitle => 'Fully Hydrated';

  @override
  String get badgeHydratedDesc => 'Drink 100 L in total.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get sectionGoal => 'Goal & units';

  @override
  String get dailyGoal => 'Daily goal';

  @override
  String get unit => 'Unit';

  @override
  String get unitMl => 'Milliliters (ml)';

  @override
  String get unitOz => 'Ounces (oz)';

  @override
  String get sectionProfile => 'Profile';

  @override
  String get weight => 'Weight';

  @override
  String get gender => 'Gender';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get genderOther => 'Other';

  @override
  String get activityLevel => 'Activity level';

  @override
  String get activitySedentary => 'Sedentary';

  @override
  String get activityModerate => 'Moderate';

  @override
  String get activityActive => 'Active';

  @override
  String get suggestGoal => 'Suggest a goal from my profile';

  @override
  String suggestedGoalMsg(String amount) {
    return 'Suggested goal: $amount per day';
  }

  @override
  String get apply => 'Apply';

  @override
  String get sectionAppearance => 'Appearance';

  @override
  String get theme => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get language => 'Language';

  @override
  String get sectionReminders => 'Reminders';

  @override
  String get enableReminders => 'Enable reminders';

  @override
  String get reminderInterval => 'Remind me every';

  @override
  String get hoursShort => 'h';

  @override
  String get activeHours => 'Active hours';

  @override
  String get from => 'From';

  @override
  String get to => 'To';

  @override
  String get remindersNote =>
      'Reminders are scheduled while the app is installed. Grant notification permission when asked.';

  @override
  String get sectionData => 'Data';

  @override
  String get resetToday => 'Reset today\'s log';

  @override
  String get clearAllData => 'Clear all data';

  @override
  String get clearConfirmTitle => 'Clear all data?';

  @override
  String get clearConfirmMsg =>
      'This permanently deletes all your logs, sessions and settings.';

  @override
  String get sectionAbout => 'About';

  @override
  String get version => 'Version';

  @override
  String get madeWith => 'Made with 💧 for people who forget to drink.';

  @override
  String get privacyPolicy => 'Privacy policy';

  @override
  String get support => 'Support';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get remove => 'Remove';

  @override
  String get close => 'Close';

  @override
  String get ok => 'OK';

  @override
  String get reset => 'Reset';
}
