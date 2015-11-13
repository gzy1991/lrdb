define(['jquery', 'PDUtilDir/inputSelect', 'LrdbUtilDir/searchBlock', 'PDUtilDir/typeahead'], function ($, InputSelect, SearchBlock, typeahead) {
    //自定义HTML标签
    return {
        directives: [
            {
                /**
                 * 用法：
                 * <input type="text" id="keyword"  lar-select="" lar-option="--不限--"  lar-model="">
                 * lar-select 下拉框数据
                 * lar-option 提供额外选择项(如：不限、请选择、不限等)
                 * lar-multi  是否多选，默认单选
                 * lar-search-able 是否显示搜索框，默认不显示
                 * lar-model    要绑定的数据(字符串，数组)都支持
                 * 说明：
                 *     字符串以默认以逗号隔开，如('1003,1002,1001')
                 * @todo 读取数据可以统一在指令方法中开发
                 * @author gaodsh@css.com.cn
                 */
                name: 'larSelect',
                func: function () {
                    return {
                        restrict: 'A',
                        scope: {
                            larModel: '=',
                            larSelect: '='
                        },
                        link: function (scope, element, attr, ctrls) {
                            var option = attr.larOption;
                            var config = {
                                id: attr.id,
                                multi: attr.larMulti ? attr.larMulti : false,
                                simpleData: true,
                                data: [],
                                initData: [''],
                                key: {
                                    id: 'id',
                                    name: 'name',
                                    data: 'data'
                                },
                                searchAble: attr.larSearchAble ? attr.larSearchAble : false,
                                callback: function (data, objArr) {
                                    scope.larModel = _setVal(scope.larModel, data, config);
                                    scope.$digest();
                                }
                            };
                            var select = InputSelect(config);
                            var defOption = {id: '', name: option};
                            scope.$watch('larSelect', function () {
                                var data = scope.larSelect;
                                if (data && option) {
                                    if (data.length > 0 && data[0].id === '') {
                                        data.splice(0, 1);
                                    }
                                    data.unshift(defOption);
                                } else if (!option && data && data.length > 0 && data[0].id === '') {
                                    data.splice(0, 1);
                                }
                                select.config.initData = _initDate(scope.larModel, select.config);
                                select.refreshPanel(data);
                            });
                            
                            scope.$watch('larModel', function () {
                            	var data = scope.larSelect;
                                if (data && option) {
                                    if (data.length > 0 && data[0].id === '') {
                                        data.splice(0, 1);
                                    }
                                    data.unshift(defOption);
                                } else if (!option && data && data.length > 0 && data[0].id === '') {
                                    data.splice(0, 1);
                                }
                            	select.config.initData = _initDate(scope.larModel, select.config);
                                select.refreshPanel(data);
                            });

                            function _setVal(larModel, data, config) {
                            	if(larModel !== null){
	                                if (_isArray(scope.larModel)) {
	                                    return data;
	                                } else if (_isString(scope.larModel)) {
	                                    if (config.multi) {
	                                        return data.join(',');
	                                    }
	                                    return data[0];
	                                }
                            	}
                                return data[0];
                            }

                            function _initDate(larModel, config) {
                            	if(larModel !== null){
                            		if (_isArray(larModel)) {
                                        return larModel;
                                    } else if (_isString(larModel)) {
                                        if (config.multi) {
                                            return larModel.replace(/\s/g, '').split(',');
                                        }
                                        return [larModel];
                                    }
                            	}
                                return [''];
                            }

                            function _isArray(obj) {
                                return (typeof obj == 'object') && obj.constructor == Array;
                            }

                            function _isString(str) {
                                return (typeof str == 'string') && str.constructor == String;
                            }

                        }
                    };
                }
            },
            {
                name: 'larSearchBlock',
                func: function () {
                    return {
                        restrict: 'A',
                        link: function (scope, element, attr) {
                            var id = element[0].id?element[0].id:"larSearchBlock"+Math.floor(Math.random()*1000000);
                            element[0].id=id;
                            /*var id = attr.id;
                            if (!id) {
                                throw 'larSearchBlock没有定义ID';
                            }*/
                            SearchBlock.init(id);
                        }
                    };
                }
            },
            {
                /**
                 * 用法：
                 * <input type="text" id="keyword"  lar-Typeahead=""  ng-model="">
                 * 根据输入, 推荐匹配结果
	             * config = {
	             * 		key : {},      //键值转换接口(包括id,data,request,response)
	             * 		multi : false,      //单选1多选表示位, 默认false为单选
	             * 		data : url/json,         //url数据接口地址
	             * }
                 * @author zhanglei@css.com.cn 
                 */
                name: 'larTypeahead', 
                func: function () {
                    return {
                    	require: 'ngModel',
                        restrict: 'A',
                        scope: {
                            larTypeahead: '='
                        },
                        link: function (scope, element, attr, ctrls) {
                            var config = {};
                            var id = element[0].id?element[0].id:"larInput"+Math.floor(Math.random()*1000000);
                            element[0].id=id;
                            scope.$watch('larTypeahead', function () {
                            	var config = scope.larTypeahead;
                            	if(!config||!config.data||config.data.length==0){return false;}
                            	if(typeof config.data === 'string'){
                            		_setData(config.data);
                            	}else if(typeof config.data === 'object' && config.data.constructor === Array){
                            		config = $.extend({
   	                            		id : id, //需要渲染input的ID
   		                                data : null, //数据源
   		                                lazyMatch : true, //延迟匹配
   		                                filter : true,  //进行前端筛选
   		                                key: {
   		                                    id : 'id', //数据字段ID
   		                                    data : 'data' //数据字段内容
   		                                },
   		                                callback : function() {
   		                                }
   	                                }, scope.larTypeahead);
                                    var Typeahead = typeahead(config);
                            	}
                            },true);
                            
                            function _setData(url){
                            	$.ajax({
                                    url : url,
                                    type : "POST",
                                    dataType : "json",
                                    success : function(data){
                                    	scope.$apply(function () {
                                    		scope.larTypeahead.data = data;
                                        });
                                    },
                                    error : function(){
                                        console.log("larTypeahead Init Failed");
                                    }
                                });
                            }
                        }
                    };
                }
            }

        ]
    };
});