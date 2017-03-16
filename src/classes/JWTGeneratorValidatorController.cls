public with sharing class JWTGeneratorValidatorController {

	@AuraEnabled
	public static String getJWTToken(String consumerKey, String certName, Integer tokenValidity){
    	JWTGenerator jwGen = new JWTGenerator();
    	return jwGen.getJWTToken(consumerKey,certName,Integer.valueOf(tokenValidity),getClaims());
    }

    @AuraEnabled
    public static String getAccessToken(String consumerKey, String certName, Integer tokenValidity) {
    	JWTGenerator jwGen = new JWTGenerator();
    	return jwGen.getAccessToken(consumerKey,certName,Integer.valueOf(tokenValidity),getClaims());

    }

    private static Map <String,Object> getClaims(){
    	Map <String,Object> claims = new Map < String, Object > ();
        claims.put('scope', 'full');
        return claims;
    }

}