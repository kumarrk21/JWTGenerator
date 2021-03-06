({
    getToken: function(cmp, evt) {
    	var self = this
        cmp.set('v.isError', false)
        var apexMethod = cmp.get('c.getAccessToken');
        apexMethod.setParams({
            loginUrl: cmp.get('v.communityURL'),
            consumerKey: cmp.get('v.appConsumerKey'),
            certName: cmp.get('v.certName'),
            tokenValidity: cmp.get('v.JWTValidity')
        });
        apexMethod.setCallback(this, function(response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                var accessToken = response.getReturnValue()
                cmp.set('v.accessToken', accessToken);
                self.launchCommunity(cmp, evt)
            } else {
                var errMessage = 'Error in Apex: Check Apex Debug Logs';
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        errMessage = 'Error in Apex: ' + errors[0].message;
                    }
                }
                cmp.set('v.isError', true)
                cmp.set('v.errMessage', errMessage);

            }
        });
        $A.enqueueAction(apexMethod);
    },

    launchCommunity: function(cmp, evt) {
        var urlEvent = $A.get("e.force:navigateToURL");
        var url = cmp.get('v.communityURL') + '/secur/frontdoor.jsp?sid=' + cmp.get('v.accessToken') + '&retURL=' + cmp.get('v.commLandingPage')
        console.log('community url is ', url)
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire();
        cmp.set('v.showLaunchButton', true)
    }


})