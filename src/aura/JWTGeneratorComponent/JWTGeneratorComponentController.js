({
	getToken : function(cmp, event, helper) {
		var apexMethod = cmp.get('c.getAccessToken');
		apexMethod.setParams({consumerKey:cmp.get('v.ckey')});
		apexMethod.setCallback(this,function(response){
            var state = response.getState();
            if(state == 'SUCCESS'){
            	console.log('Response is ', response);
            	cmp.set('v.accessToken',response.getReturnValue());
            }else{
            	console.log('Error Response is ', response);
                cmp.set('v.accessToken','Error! Check Console Log');
            }
        });
        $A.enqueueAction(apexMethod);
	}
})