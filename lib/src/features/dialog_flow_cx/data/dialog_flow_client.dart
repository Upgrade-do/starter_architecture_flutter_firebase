import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/dialogflow/v3.dart' as df;
import 'package:http/http.dart' as http;

class AuthClient {
  static const _scopes = [df.DialogflowApi.dialogflowScope];
  static var _dialogFlowApi ;

  static Future<df.DialogflowApi> getDialogflowApi() async {
 
        // Load the service account JSON file from assets
        final serviceAccountJson = await rootBundle.loadString('assets/key.json');
        final credentials = ServiceAccountCredentials.fromJson(json.decode(serviceAccountJson));
        debugPrint(' SERVICE JSON: \n $serviceAccountJson');
        
        final client = await clientViaServiceAccount(credentials, _scopes);
 
    
        // Specify the base URL for the correct region
        const endpoint = 'https://us-dialogflow.googleapis.com/'; // {us-central1}
        _dialogFlowApi = df.DialogflowApi(client, rootUrl: endpoint);
        return _dialogFlowApi;
  }

  // Use service account credentials to obtain oauth credentials.
static Future<AccessCredentials?> obtainCredentials() async {
        // Load the service account JSON file from assets
        try {
        final serviceAccountJson =  ServiceAccountCredentials.fromJson('assets/key.json');
        // final credentials = ServiceAccountCredentials.fromJson(json.decode(serviceAccountJson));

        var client = http.Client();
        AccessCredentials credentials =
          await obtainAccessCredentialsViaServiceAccount(serviceAccountJson, _scopes, client);

        client.close();
        return credentials;

        } catch (e) {
          debugPrint(e.toString());
        }

}
}

class ChatbotClient {
  final String projectId;
  final String agentId;
  final String location;

  ChatbotClient({required this.projectId, required this.agentId, required this.location});

  Future<String> sendMessage(String sessionId, String message) async {
    final dialogflow = await AuthClient.obtainCredentials();
    final sessionPath = 'projects/$projectId/locations/$location/agents/$agentId/sessions/$sessionId';
    final queryInput = df.GoogleCloudDialogflowCxV3QueryInput(languageCode: 'en',
      text: df.GoogleCloudDialogflowCxV3TextInput(text: message),
    );

     print(dialogflow.toString());
    // final response = await dialogflow.projects.locations.agents.sessions.detectIntent(
    //   df.GoogleCloudDialogflowCxV3DetectIntentRequest(queryInput: queryInput),
    //   sessionPath,
    // );

    // final queryResult = response.queryResult;
    // if (queryResult != null && queryResult.responseMessages != null && queryResult.responseMessages!.isNotEmpty) {
    //   return queryResult.responseMessages!.first.text!.text!.first;
    // } else {
    //   return 'No response from chatbot';
    // }

    return 'dialog flow ${dialogflow}';
  }

    Future<String> detectIntent(String projectId, String sessionId, String text) async {
    final sessionPath = 'projects/$projectId/locations/global/agent/sessions/$sessionId';
    final request = df.GoogleCloudDialogflowCxV3DetectIntentRequest(
      queryInput: df.GoogleCloudDialogflowCxV3QueryInput(
        text: df.GoogleCloudDialogflowCxV3TextInput(text: text),
      ),
    );

    final response = await AuthClient._dialogFlowApi.projects.locations.agent.sessions
        .detectIntent(request, sessionPath);
    return response.queryResult?.fulfillmentText ?? 'No response';
  }
}