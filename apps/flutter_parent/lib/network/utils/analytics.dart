// Copyright (C) 2020 - present Instructure, Inc.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, version 3 of the License.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_crashlytics/flutter_crashlytics.dart';
import 'package:flutter_parent/utils/debug_flags.dart';

/// Event names
/// The naming scheme for the majority of these is found in a google doc so that we can be consistent
/// across the platforms.
class AnalyticsEventConstants {
  static const LOGIN_FAILURE = 'login_failure';
  static const LOGIN_SUCCESS = 'login_success';
  static const TOKEN_REFRESH_FAILURE = 'token_refresh_failure';
  static const TOKEN_REFRESH_FAILURE_TOKEN_NOT_VALID = 'token_refresh_failure_token_not_valid';
  static const TOKEN_REFRESH_FAILURE_NO_SECRET = 'token_refresh_failure_no_secret';

  static const LOGOUT = 'logout';
  static const SWITCH_USERS = 'switch_users';
  static const HELP_LOGIN = 'help_login';
  static const HELP_DOMAIN_SEARCH = 'help_domain_search';
  static const ADD_STUDENT_MANAGE_STUDENTS = 'add_student_manage_students';
  static const ADD_STUDENT_DASHBOARD = 'add_student_dashboard';
  static const REMINDER_ASSIGNMENT_CREATE = 'reminder_assignment';
  static const REMINDER_EVENT_CREATE = 'reminder_event';
  static const DARK_MODE_ON = 'dark_mode_on';
  static const DARK_MODE_OFF = 'dark_mode_off';
  static const HC_MODE_ON = 'hc_mode_on';
  static const HC_MODE_OFF = 'hc_mode_off';
  static const DARK_WEB_MODE_ON = 'dark_web_mode_on';
  static const DARK_WEB_MODE_OFF = 'dark_web_mode_off';
}

/// (Copied from canvas-api-2, make sure to stay in sync)
///
/// PARAMS
/// Due to the limits on custom params, we will mostly be using a mapping of the pre-defined params,
/// mappings will be recorded below. Make sure we are only using params where the data is relevant.
///
/// [DOMAIN_PARAM] -> AFFILIATION
/// [USER_CONTEXT_ID] -> CHARACTER
/// [CANVAS_CONTEXT_ID] -> GROUP_ID
/// [ASSIGNMENT_ID]/DISCUSSION/ETC ID -> ITEM_ID
///   There is also ITEM_CATEGORY if the event is vague regarding the type of item
/// [SCREEN_OF_ORIGIN] -> ORIGIN
///   Used when events can originate from multiple locations
///
class AnalyticsParamConstants {
  static const DOMAIN_PARAM = 'affiliation';
  static const USER_CONTEXT_ID = 'character';
  static const CANVAS_CONTEXT_ID = 'group_id';
  static const ASSIGNMENT_ID = 'item_id';
  static const SCREEN_OF_ORIGIN = 'origin';
}

class Analytics {
  FirebaseAnalytics get _analytics => FirebaseAnalytics();

  /// Set the current screen in Firebase Analytics
  void setCurrentScreen(String screenName) async {
    if (kReleaseMode) {
      await _analytics.setCurrentScreen(screenName: screenName);
    }

    if (DebugFlags.isDebug) {
      print('currentScreen: $screenName');
    }
  }

  /// Log an event to Firebase analytics (only ini release mode).
  /// If isDebug, it will also print to the console
  void logEvent(String event, {Map<String, dynamic> extras = const {}}) async {
    if (kReleaseMode) {
      await _analytics.logEvent(name: event, parameters: extras);
    }

    if (DebugFlags.isDebug) {
      print('logEvent: $event - $extras');
    }
  }

  /// Logs a message to crashlytics to help when looking over crash logs (only in release mode).
  /// If isDebug, it will also print to the console
  void logMessage(String message) {
    if (kReleaseMode) {
      FlutterCrashlytics().log(message);
    }

    if (DebugFlags.isDebug) {
      print(message);
    }
  }
}
