public with sharing class JWTGenerator {
	
	@AuraEnabled
	public static String getAccessToken(String consumerKey, String certName){
		System.debug('consumerKey is :' + consumerKey);
		System.debug('certName is :' + certName);
		String accessToken;
		String userName = UserInfo.getUserName();
		String baseUrl = 'https://login.salesforce.com';

		Auth.JWT jwt = new Auth.JWT();
		jwt.setSub(userName);
		System.debug('User Name is :' + userName);
		
		//Check if Sandbox (Communities excluded)
		List<Organization> org = [Select Id, IsSandbox FROM Organization];
		if(org.size()>0){
			if(org[0].IsSandbox){
				baseUrl = 'https://test.salesforce.com';
			}
		}
		jwt.setAud(baseUrl);
		jwt.setValidityLength(600);
		System.debug('Base URL is ' + baseUrl);
		jwt.setIss(consumerKey);

		Map<String, Object> claims = new Map<String, Object>();
		claims.put('scope','full');
		jwt.setAdditionalClaims(claims);
		System.debug('Validity Length is ' + jwt.getValidityLength());
		System.debug('JSON payload is ' + jwt.toJSONString());

		Auth.JWS jws = new Auth.JWS(jwt, certName);
		String token = jws.getCompactSerialization();
		System.debug('Compact Serialization is ' + token);
		String tokenEndPoint = baseUrl + '/services/oauth2/token';
		System.debug('tokenEndPoint URL is ' + tokenEndPoint);
		Auth.JWTBearerTokenExchange bearer = new Auth.JWTBearerTokenExchange(tokenEndpoint, jws);
		System.debug('bearer is ' +  bearer);
		System.debug('HTTP response is ' + bearer.getHttpResponse());
		System.debug('Grant type is ' + bearer.getGrantType());
		accessToken = bearer.getAccessToken();
		return accessToken;
	}
}