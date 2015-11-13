define([], function(){
	var DateUtil = {
    	/**
    	 * 计算两个日期字符串之间的所有日期字符串
    	 * 返回所有日期字符串数组
    	 */
    	minus : function(start, end) {
    		var dateArr = [];
        	if (end) {
        		var sDate = DateUtil.parseDate(start);
        		var eDate = DateUtil.parseDate(end);
        		var milli = eDate.getTime() - sDate.getTime();
        		var days = milli / 1000 / 60 / 60 / 24;
        		for (var i=0; i<=days; i++) {
        			var date = new Date();
        			date.setTime(sDate.getTime());
        			date.setDate(sDate.getDate() + i);
        			dateArr.push(
        					DateUtil.toDouble(date.getFullYear()) + "-" + 
        					DateUtil.toDouble(date.getMonth() + 1) + "-" + 
        					DateUtil.toDouble(date.getDate()))
        		}
        	} else {
        		dateArr.push(start);
        	}
        	return dateArr;
    	},
    	/**
    	 * 通过日期字符串返回对应的日期
    	 */
    	parseDate : function(dateStr) {
    		var dateArr = dateStr.split("-");
    		var year = dateArr[0];
    		var month = dateArr[1] - 1;
    		var day = dateArr[2];
    		
    		var date = new Date();
    		date.setFullYear(year);
    		date.setMonth(month);
    		date.setDate(day);
    		date.setHours(0);
    		date.setMinutes(0);
    		date.setSeconds(0);
    		date.setMilliseconds(0);
    		
    		//console.log(date.toString());
    		return date;
    	},
    	/**
    	 * 将10以下数字前面补0
    	 */
    	toDouble : function(n) {
    		if (n < 10) {
    			return "0" + n;
    		}
    		return n;
    	}
    }
	
	return DateUtil;
})
