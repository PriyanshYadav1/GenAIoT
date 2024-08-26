// Credentials for MSAL Auth
final _clientId = '6fd20d17-de8d-4a86-ade1-7646d14a60d4';
final _tenantId = 'c8401f36-1f3c-4dba-b027-b707446a396d';
late final _authority =
    'https://login.microsoftonline.com/$_tenantId/oauth2/v2.0/authorize';
final _scopes = <String>['https://graph.microsoft.com/user.read'];
