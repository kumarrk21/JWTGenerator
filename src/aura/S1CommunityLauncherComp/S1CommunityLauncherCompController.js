({
	doInit : function(cmp, evt, helper) {
		if(window.location.pathname!='/visualEditor/appBuilder.app'){
			helper.getToken(cmp,evt)
		}
	},
    
    launchCommunity : function(cmp,evt,helper){
        helper.launchCommunity(cmp,evt)
    }
})