import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis/dialogflow/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/dialogflow/v3.dart' as df;
import 'package:http/http.dart' as http;

class AuthClient {
  static const _scopes = [df.DialogflowApi.cloudPlatformScope];

  static Future<dynamic> getDialogflowApi() async {
    try {
      final serviceAccountJson = await rootBundle.loadString('assets/key.json');
      final credentials =
          ServiceAccountCredentials.fromJson(json.decode(serviceAccountJson));
      // debugPrint(' SERVICE JSON: \n $serviceAccountJson');
      final client = await clientViaServiceAccount(credentials, _scopes);

      // Specify the base URL for the correct region
      const endpoint =
          'https://us-central1-dialogflow.googleapis.com/'; // {us-central1}
      return df.DialogflowApi(client, rootUrl: endpoint);
    } catch (e) {
      // debugPrint(' SERVICE JSON: \n $e');
      final ServerRequestFailedException error =
          e as ServerRequestFailedException;
      debugPrint(' SERVICE JSON API ERROR: \n ${error.message}');
    }
    // Load the service account JSON file from assets
  }
}

class ChatbotClient {
  final String projectId;
  final String agentId;
  final String location;

  ChatbotClient(
      {required this.projectId, required this.agentId, required this.location});

  Future<String> sendMessage(String sessionId, String message) async {
    final dialogflow = await AuthClient.getDialogflowApi();
    final sessionPath =
        'projects/$projectId/locations/$location/agents/$agentId/sessions/$sessionId';
    final queryInput = df.GoogleCloudDialogflowCxV3QueryInput(
      languageCode: 'en',
      text: df.GoogleCloudDialogflowCxV3TextInput(text: message),
    );

    final response =
        await dialogflow.projects.locations.agents.sessions.detectIntent(
      df.GoogleCloudDialogflowCxV3DetectIntentRequest(queryInput: queryInput),
      sessionPath,
    );
    final queryResult = response.queryResult;
    if (queryResult != null &&
        queryResult.responseMessages != null &&
        queryResult.responseMessages!.isNotEmpty) {
      // debugPrint(response.queryResult.responseMessages[0].text);
      return queryResult.responseMessages!.first.text!.text!.first;
    } else {
      return 'No response from chatbot';
    }
  }
}
