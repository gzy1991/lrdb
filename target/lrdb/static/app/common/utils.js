/**
 * 系统业务共用处理js
 * 
 * @author gaodsh@css.com.cn
 */
define([ "jquery" ], function($) {
	
	//时间处理
	function handleDate(year, month, day) {
		if (year != null && month != null && day != null) {//年月日都有
			return year + "-" + month + "-" + day;
		} else if (year != null && month != null && (day == null || day == "")) {//只有年月  没有日
			return year + "-" + month;
		} else if (year != null && (month == null||month=="") && (day == null || day == "")) {//只有年  没有月 没有 日
			return year ;
		} else {//年月日都没有
			return "";
		}
	}
	
	//选中文字
	function selectElement(element) {
		if (window.getSelection) {
			var sel = window.getSelection();
			sel.removeAllRanges();
			var range = document.createRange();
			range.selectNodeContents(element);
			sel.addRange(range);
		} else if (document.selection) {
			var textRange = document.body.createTextRange();
			textRange.moveToElementText(element);
			textRange.select();
		}
	}	
	
	//分开输入的年月日输入控制
	function sepDateInputCtrl($scope,yearId,monthId,dayId){
      	 if($("#"+yearId).val()!=""){//如果年份有值,则去掉月的disable或readonly属性
       		 if($("#"+yearId).val().length==4){//当四位年输入完成后在继续
        		 $("#"+monthId).attr("disabled",false);
        		 if($("#"+monthId).val()!=""){//如果月份有值,去掉日的disabled属性
        			 $("#"+dayId).attr("disabled",false);
        		 }else{//如果月份无值,清空日的值,并且增加日的disabled属性
            		 $("#"+dayId).val("");
            		 $("#"+dayId).attr("disabled","disabled");
        		 }
       		 }
    	 }else{//如果年份无值,则清空月和日,并加上readonly或disable属性
    		 $("#"+monthId).val("");
    		 $("#"+monthId).attr("disabled","disabled");
    		 $("#"+dayId).val("");
    		 $("#"+dayId).attr("disabled","disabled");
    	 }
	}
	
	return {
		handleDate:handleDate,
		selectElement:selectElement,
		sepDateInputCtrl:sepDateInputCtrl
	};



	
	
});
