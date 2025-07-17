import 'dart:convert';

String cleanErrorMessage(String message) {
  // Remove all [Something] or [Something][line: N] patterns
  return message.replaceAll(RegExp(r'\[[^\]]*\](\[line: \d+\])?'), '').trim();
}

String? extractSapErrorMessage(Map<String, dynamic> response) {
  try {
    // 0. If the repo already extracted an error, return it
    if (response['error'] is String && response['error'].isNotEmpty) {
      return cleanErrorMessage(response['error']);
    }
    // 1. Try to extract from data.errorMessage
    final errorString = response['data']?['errorMessage'];
    if (errorString is String) {
      // 2. Look for JSON part after "SAP Response:"
      final sapResponseIndex = errorString.indexOf('SAP Response:');
      if (sapResponseIndex != -1) {
        final jsonStart =
            errorString
                .substring(sapResponseIndex + 'SAP Response:'.length)
                .trim();

        // 3. Parse JSON string
        final parsed = json.decode(jsonStart);
        final msg = parsed['error']?['message'];
        if (msg is String && msg.isNotEmpty) {
          return cleanErrorMessage(msg);
        }
        return msg;
      }

      // 4. Fallback: Try to extract JSON manually from the first "{" and parse
      final firstBrace = errorString.indexOf('{');
      if (firstBrace != -1) {
        final potentialJson = errorString.substring(firstBrace).trim();
        final parsed = json.decode(potentialJson);
        final msg = parsed['error']?['message'];
        if (msg is String && msg.isNotEmpty) {
          return cleanErrorMessage(msg);
        }
        return msg;
      }
    }

    // 5. Try from top-level message field if needed
    final msg = response['message'];
    if (msg is String && msg.contains('SAP Response:')) {
      final sapIndex = msg.indexOf('SAP Response:');
      final jsonStart = msg.substring(sapIndex + 'SAP Response:'.length).trim();
      final parsed = json.decode(jsonStart);
      final errorMsg = parsed['error']?['message'];
      if (errorMsg is String && errorMsg.isNotEmpty) {
        return cleanErrorMessage(errorMsg);
      }
      return errorMsg;
    }
  } catch (e) {
    print('Error parsing SAP error message: $e');
  }

  return null;
}
