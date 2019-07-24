

function loadManagerOrg() {
	var defaultMngOrg = '<option value> </option>';
	var url = "./manage";
	$.ajax({
	    url: url,
	    type: "GET",
	    dataType: "json",
	    success : function(msg) {
	        if(msg.result === "success") {
	            var bridgeList = msg.bridgeList;
	            var content = "";
	            
	            content += defaultMngOrg;
	            for(var i=0, len=bridgeList.length; i < len; i++)                    
	            {
	                var bridge = bridgeList[i];
	                content += '<option value>' + bridge.mng_org + '</option>';
	            }
	            
	            $('#mngOrgList').html(content);
	        }
	    },
	    error : function(request, status, error) {
	        console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
	    }
	});
}

