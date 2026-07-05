// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Wadrop';

  @override
  String get navHome => 'Accueil';

  @override
  String get navStats => 'Stats';

  @override
  String get navWorkout => 'Sport';

  @override
  String get navAwards => 'Trophées';

  @override
  String get navSettings => 'Réglages';

  @override
  String get greetingMorning => 'Bonjour';

  @override
  String get greetingAfternoon => 'Bon après-midi';

  @override
  String get greetingEvening => 'Bonsoir';

  @override
  String get greetingNight => 'Restez hydraté';

  @override
  String get greetingSubtitle =>
      'Atteignons votre objectif d\'eau aujourd\'hui.';

  @override
  String get dayStreak => 'jours de suite';

  @override
  String get cupsToday => 'verres aujourd\'hui';

  @override
  String get ofGoal => 'de l\'objectif';

  @override
  String mlLeftToGoal(String amount) {
    return 'il reste $amount pour atteindre votre objectif';
  }

  @override
  String get goalReachedBanner => 'Objectif atteint — bravo ! 🎉';

  @override
  String overGoalBanner(String amount) {
    return '$amount au-dessus de l\'objectif 💪';
  }

  @override
  String get favorites => 'Favoris';

  @override
  String get addDrink => 'Ajouter';

  @override
  String get undo => 'Annuler';

  @override
  String get todaysLog => 'Journal du jour';

  @override
  String get emptyLogTitle => 'Aucune boisson enregistrée';

  @override
  String get emptyLogSubtitle =>
      'Touchez un favori ou « Ajouter » pour commencer.';

  @override
  String get drinkWater => 'Eau';

  @override
  String get drinkCoffee => 'Café';

  @override
  String get drinkTea => 'Thé';

  @override
  String get drinkJuice => 'Jus';

  @override
  String get drinkSoda => 'Soda';

  @override
  String get drinkMilk => 'Lait';

  @override
  String get drinkSparkling => 'Pétillante';

  @override
  String get drinkEnergy => 'Énergie';

  @override
  String get addDrinkTitle => 'Ajouter une boisson';

  @override
  String get selectType => 'Type';

  @override
  String get selectAmount => 'Quantité';

  @override
  String get customAmount => 'Quantité libre';

  @override
  String get add => 'Ajouter';

  @override
  String get cancel => 'Annuler';

  @override
  String get editFavorites => 'Modifier les favoris';

  @override
  String get newFavorite => 'Nouveau favori';

  @override
  String get favoritesHint => 'Appui long sur un favori pour le supprimer.';

  @override
  String get statsTitle => 'Statistiques';

  @override
  String get rangeWeek => 'Semaine';

  @override
  String get rangeMonth => 'Mois';

  @override
  String get avgIntake => 'Moyenne / jour';

  @override
  String get totalIntake => 'Total';

  @override
  String get goalCompletion => 'Objectif atteint';

  @override
  String get bestDay => 'Meilleur jour';

  @override
  String get daysMetGoal => 'Jours réussis';

  @override
  String get intakeByType => 'Par type de boisson';

  @override
  String get noData => 'Pas encore assez de données';

  @override
  String get workoutTitle => 'Sport & Fitness';

  @override
  String get addWorkout => 'Ajouter une séance';

  @override
  String get workoutTypeLabel => 'Activité';

  @override
  String get duration => 'Durée';

  @override
  String get intensity => 'Intensité';

  @override
  String get intensityLow => 'Légère';

  @override
  String get intensityMedium => 'Modérée';

  @override
  String get intensityHigh => 'Intense';

  @override
  String get minutesShort => 'min';

  @override
  String get todaysWorkouts => 'Séances du jour';

  @override
  String get noWorkouts => 'Aucune séance aujourd\'hui';

  @override
  String extraWater(String amount) {
    return '+$amount d\'eau';
  }

  @override
  String get hydrationBonusTitle => 'Bonus d\'hydratation';

  @override
  String hydrationBonusDesc(String amount) {
    return 'Vos séances d\'aujourd\'hui ajoutent $amount à votre objectif.';
  }

  @override
  String get weeklyActivity => 'Cette semaine';

  @override
  String get activeMinutes => 'Minutes actives';

  @override
  String get caloriesLabel => 'Calories';

  @override
  String get sessions => 'Séances';

  @override
  String get stepsTitle => 'Pas & marche';

  @override
  String get steps => 'Pas';

  @override
  String get stepsUnit => 'pas';

  @override
  String get walkDistance => 'Distance';

  @override
  String get stepGoalOf => 'de l\'objectif de pas';

  @override
  String get stepGoal => 'Objectif de pas / jour';

  @override
  String get height => 'Taille';

  @override
  String get enableStepCounter => 'Autoriser le mouvement pour compter vos pas';

  @override
  String get workoutStrength => 'Musculation';

  @override
  String get workoutCardio => 'Cardio';

  @override
  String get workoutRunning => 'Course';

  @override
  String get workoutCycling => 'Vélo';

  @override
  String get workoutSwimming => 'Natation';

  @override
  String get workoutYoga => 'Yoga';

  @override
  String get workoutWalking => 'Marche';

  @override
  String get workoutHiit => 'HIIT';

  @override
  String get workoutFootball => 'Football';

  @override
  String get awardsTitle => 'Trophées';

  @override
  String get currentStreak => 'Série actuelle';

  @override
  String get bestStreak => 'Meilleure série';

  @override
  String get lifetimeWater => 'Eau cumulée';

  @override
  String get daysTracked => 'Jours suivis';

  @override
  String get days => 'jours';

  @override
  String get locked => 'Verrouillé';

  @override
  String get unlocked => 'Débloqué';

  @override
  String get badgeFirstSipTitle => 'Première Gorgée';

  @override
  String get badgeFirstSipDesc => 'Enregistrez votre première boisson.';

  @override
  String get badgeGoalGetterTitle => 'Objectif Atteint';

  @override
  String get badgeGoalGetterDesc => 'Atteignez votre objectif une fois.';

  @override
  String get badgeStreak3Title => 'En Route';

  @override
  String get badgeStreak3Desc => 'Tenez une série de 3 jours.';

  @override
  String get badgeStreak7Title => 'Une Semaine';

  @override
  String get badgeStreak7Desc => 'Tenez une série de 7 jours.';

  @override
  String get badgeStreak30Title => 'Héros de l\'Eau';

  @override
  String get badgeStreak30Desc => 'Tenez une série de 30 jours.';

  @override
  String get badgeAthleteTitle => 'Athlète';

  @override
  String get badgeAthleteDesc => 'Enregistrez 10 séances de sport.';

  @override
  String get badgeOverachieverTitle => 'Dépassement';

  @override
  String get badgeOverachieverDesc =>
      'Atteignez 150 % de l\'objectif en un jour.';

  @override
  String get badgeHydratedTitle => 'Bien Hydraté';

  @override
  String get badgeHydratedDesc => 'Buvez 100 L au total.';

  @override
  String get settingsTitle => 'Réglages';

  @override
  String get sectionGoal => 'Objectif & unités';

  @override
  String get dailyGoal => 'Objectif quotidien';

  @override
  String get unit => 'Unité';

  @override
  String get unitMl => 'Millilitres (ml)';

  @override
  String get unitOz => 'Onces (oz)';

  @override
  String get sectionProfile => 'Profil';

  @override
  String get weight => 'Poids';

  @override
  String get gender => 'Sexe';

  @override
  String get genderMale => 'Homme';

  @override
  String get genderFemale => 'Femme';

  @override
  String get genderOther => 'Autre';

  @override
  String get activityLevel => 'Niveau d\'activité';

  @override
  String get activitySedentary => 'Sédentaire';

  @override
  String get activityModerate => 'Modéré';

  @override
  String get activityActive => 'Actif';

  @override
  String get suggestGoal => 'Proposer un objectif selon mon profil';

  @override
  String suggestedGoalMsg(String amount) {
    return 'Objectif suggéré : $amount par jour';
  }

  @override
  String get apply => 'Appliquer';

  @override
  String get sectionAppearance => 'Apparence';

  @override
  String get theme => 'Thème';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get language => 'Langue';

  @override
  String get sectionReminders => 'Rappels';

  @override
  String get enableReminders => 'Activer les rappels';

  @override
  String get reminderInterval => 'Me rappeler toutes les';

  @override
  String get hoursShort => 'h';

  @override
  String get activeHours => 'Heures actives';

  @override
  String get from => 'De';

  @override
  String get to => 'À';

  @override
  String get remindersNote =>
      'Les rappels sont planifiés tant que l\'app est installée. Autorisez les notifications si demandé.';

  @override
  String get sectionData => 'Données';

  @override
  String get resetToday => 'Réinitialiser le jour';

  @override
  String get clearAllData => 'Effacer toutes les données';

  @override
  String get clearConfirmTitle => 'Tout effacer ?';

  @override
  String get clearConfirmMsg =>
      'Cela supprime définitivement journaux, séances et réglages.';

  @override
  String get sectionAbout => 'À propos';

  @override
  String get version => 'Version';

  @override
  String get madeWith => 'Fait avec 💧 pour ceux qui oublient de boire.';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get support => 'Assistance';

  @override
  String get save => 'Enregistrer';

  @override
  String get delete => 'Supprimer';

  @override
  String get remove => 'Retirer';

  @override
  String get close => 'Fermer';

  @override
  String get ok => 'OK';

  @override
  String get reset => 'Réinitialiser';
}
