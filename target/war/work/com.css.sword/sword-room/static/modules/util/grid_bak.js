/**
 * 注意：该模块依赖JQuery与bootstrap
 * 表格配置
 * @param config
 Demo:
 {
    id:"DemoGirdDivId",                 //Grid容器ID
    pageSize:5,                         //一页多少条数据
    title:'人员信息列表',
    hidden:false,                       //表格是否可隐藏，只显示标题
    multi:true,                   //首列为单选[radio]还是多选[checkbox],默认checkbox
    pagination : true,                  //默认分页,
    cache:false,
    layout:[
        {name:"姓名",field:"Name",click:function(e){
            data = e.data;
        }},
        {name:"性别",field:"Sex",sort:true},
        {name:"电话",field:"Phone",style:"width:10%"},
        {name:"邮件",field:"Email"},
        {name:"地址",field:"Address",hidden:true,format:function(obj){console.log(obj);return "BJ"}}
    ],
    toolbar:[
        {name:"添加",icon:"fa fa-plus-circle",callback:function(event){console.log('添加')}},
        {name:"删除",icon:"fa fa-trash-o",callback:function(event){console.log('删除')}},
        {name:"查询",icon:"fa fa-search",callback:function(event){console.log(event.data)}},
        {name:"导出",icon:"fa fa-download",callback:function(event){console.log('导出')}}
    ],
    trEvent:[
        {type:"click",callback:function(event){}}
    ],
    data:[{Name:"张三",Sex:"男",Phone:"123456",Email:"",Address:"BJ"},{Name:"张三",Sex:"男",Phone:"123456",Email:"",Address:"BJ"}]
    //data:{type:"URL",value:""}                                //只要data值的类型数组都视为假分页，为对象视为真分页
    formData:{                                  //数据请求的额外参数
        name : 'value'
    },
    key:{                                //前后台字段名转换
        'data':'format'
    }
 }
 */

define(["jquery","css!PDUtilDir/css/grid.css","MCScrollbarDir/jquery.mCustomScrollbar.min",
    "MCScrollbarDir/jquery.mCustomScrollbar.concat.min",
    "css!MCScrollbarDir/jquery.mCustomScrollbar.min"],function($){
    var cache={};

    function initGrid(config){
        var _config = $.extend({
            pageSize: 10,
            pagination : true,
            trEvent: {},     //数据行事件
            realSort : false,
            sortParam:{
                field: null,
                order: null
            },
            key:{
                "allDataCount" : "dataCount",
                "curPageData" : "pageData"
            },
            layout:[],
            toolbar:[],
            data:[],
            cache : true
        },config);
        //兼容placeAt和id参数
        _config.placeAt=_config.placeAt||_config.id;
        _config.id=_config.id||_config.placeAt;
        //创建表格对象
        var grid = new Grid(_config);
        //添加缓存
        cache[_config.id] = grid;
        return grid;
    }

    initGrid.init = initGrid;

    initGrid.getGrid = function(id){
        return cache[id];
    };

    initGrid.dropCache = function(){
        cache={};
    };

    function Grid(config){
        this._config = config;
        //真分页时，后端返回数据类型结构为此结构即可
        this._pageInfo = {
            pageNumber:1,                      //默认当前为表格的第一页
            pageData:[],                 //当前页数据
            dataCount:0,                 //所有数据总条数
            pageCount:0                     //总页数
        };
        this.render(true);
    }
    
     //模块通用方法(扩展)
    Grid.fn = Grid.prototype = {
        //对象方法扩展API
        extend : function(object){
            if (typeof object === "object" && object.constructor === Object){
                $.extend(Grid.fn,object);
            }
        },

        setConfig : function(newConfig){
            $.extend(this._config,newConfig);
        },

        getGridPanel : function(){
            return this._$gridPanel?this._$gridPanel:$("#"+this._config.placeAt);
        },

        //初始化渲染表格
        render : function(type){
            if (!!type) {
                //grid HTML Structure
                var html = '<div class="s_grid_title"></div>'+
                           '<div class="s_grid_content'+(this._config.hidden?' hide':'')+'">'+
                               (this._config.toolbar.length?'<div class="s_grid_toolbar"></div>':'')+     //操作栏面板
                               '<div class="s_grid_table"></div>'+
                               '<div class="s_grid_pagination"></div>'+
                            '</div>';
                //获取 grid 对象, 
                this._$gridPanel = this.getGridPanel();
                this._$gridPanel.addClass("s_grid").empty().append(html);
            }

            //初始化 grid 各个部分
            this.renderTitle(type);
            this.renderToolbar(type);
            this.renderTable(type);
        },

        renderTitle : function(type){
            var $title = this._$gridPanel.children(".s_grid_title");
            if(!this._config.title){
                $title.empty().hide(); return false;
            }
            if(!!type){
                $title.empty().show();
                var html = '<span class="title"><i class="fa fa-table" style="color:#2898e0"></i></span>';
                if(typeof(this._config.hidden)!="undefined"){
                    html += '<i class="glyphicon'+(this._config.hidden?' glyphicon-plus-sign':' glyphicon-minus-sign')+'"></i>';
                    //表格内容显示隐藏控制
                    $title.on('click','.glyphicon',function(e){
                        $title.siblings(".s_grid_content").slideToggle();
                        $(this).toggleClass("glyphicon-plus-sign glyphicon-minus-sign");
                    });
                }
                $title.append(html);
            }
            $title.children(".title").text(this._config.title || '数据列表');
        },

        renderToolbar : function(type){
            var $toolbar = this._$gridPanel.find(".s_grid_toolbar");
            if(!!type){
                $toolbar.empty();
                if(!!this._config.toolbar&&this._config.toolbar.length>0){
                    var $ul = $('<ul></ul>');
                    for(var i = 0, length=this._config.toolbar.length;i<length;i++){
                        var item = this._config.toolbar[i];
                        $('<li '+(i==0?'class="first"':"")+'><a><i class="'+item.icon+'"></i>'+ item.name +'</a></li>')
                            .bind("click",this,item.callback)
                            .appendTo($ul);
                    }
                    $toolbar.append($ul);
                }
            }
        },

        renderTable : function(type){
            var $table = this._$gridPanel.find(".s_grid_table");
            if(!!type){
                $table.empty();
                $table.append('<div class="table-head"><table onselectstart="return false;" class="table table-hover"><thead></thead></table><div class="dragTrigger"></div></div>');
                $table.append('<div class="table-body"'+(this._config.tableBodyHeight?'style="height:'+this._config.tableBodyHeight:false)+
                            '"><table class="table table-hover"><thead></thead><tbody></tbody></table></div>');
                this.renderTableHead(type);
                this.renderTableBody(type);
                this.bindDraggableEvent();
            }
        },

        renderTableHead : function(type){
            var $tableHead = this._$gridPanel.find(".s_grid_table table thead");
            var _this = this;
            if(!!type){
                $tableHead.empty();
                //render head
                var html = "";
                if(!!_this._config.index){
                    html += '<th align="center" class="index noDrag" width="18px"></th>';
                }
                if(typeof _this._config.multi != "undefined"){
                    html += '<th align="center" class="fix noDrag" width="24px">'+(_this._config.multi?'<input type="checkbox">':'')+'</th>';
                }
                var layout = _this._config.layout;
                for(var i=0,item;item=layout[i++];){
                    html += '<th'+(item.align?' style="text-align:'+item.align+'"':'')+' width="'+(item.width?item.width:100/layout.length+'%')+'" class="'+item.field+'" title="'+item.name+'">'+item.name+(item.sort?'<i class="fa fa-sort"></i>':'')+'</th>';
                }
                $tableHead.append('<tr>'+html+'</tr>');
                this._$gridPanel.find(".s_grid_table .table-body thead th").removeAttr("class title").empty();
                //bindEvent
                var $tHead = this._$gridPanel.find(".s_grid_table .table-head thead"),
                    $tBody = this._$gridPanel.find(".s_grid_table .table-body tbody");
                $tHead.on("click","th",function(event){
                    var nodeName = event.target.nodeName,
                        field = null,
                        order = "desc";
                    if (nodeName=="INPUT") {
                        var checked = $(event.target).is(":checked");
                        $tBody.find("input").each(function(){
                            if (checked) {
                                this.checked=true;
                            } else {
                                $(this).removeAttr("checked");
                            }
                        });
                    } else if(nodeName=="I") {
                        field = this.className?this.className:null;
                        if(!!field){
                            $(this).siblings().children(".fa-sort").removeClass("fa-sort-desc fa-sort-asc");
                            if($(this).children(".fa-sort").is(".fa-sort-desc,.fa-sort-asc")){
                                $(this).children(".fa-sort").toggleClass("fa-sort-desc fa-sort-asc");
                            }else{
                                $(this).children(".fa-sort").toggleClass("fa-sort-desc");
                            }
                            order = $(this).children(".fa-sort").is(".fa-sort-desc")?"desc":"asc";
                            _this.sortTableData(field,order,_this._config.realSort);
                        }
                    }
                });
            }
        },

        renderTableBody : function(type){
            if(!!type){
                this.renderTableData(type);
            }
        },

        renderPagination : function(type){
            var $pagination = this._$gridPanel.find(".s_grid_pagination"),
                trHeight = this._$gridPanel.find(".s_grid_table .table-head thead th").outerHeight()+3;
            //数据少于一页时不创建分页栏
            this._pageInfo.pageCount = Math.ceil(this._pageInfo.dataCount/this._config.pageSize);
            if(this._pageInfo.pageCount<1||!this._config.pagination){ $pagination.empty().hide(); return false; }
            var _this = this;
            if(!!type){
                $pagination.empty().show();
                //render pagination
                var html = '<a title="第一页" class="GoToFirst"><i class="glyphicon glyphicon-step-backward"></i></a>'+
                            '<a title="上一页" class="GoToPrev"><i class="glyphicon glyphicon-chevron-left"></i></a>'+
                            '<span class="curPage"><input type="text" value="'+_this._pageInfo.pageNumber+'"/></span>'+
                            '<a title="下一页" class="GoToNext"><i class="glyphicon glyphicon-chevron-right"></i></a>'+
                            '<a title="最后一页" class="GoToEnd"><i class="glyphicon glyphicon-step-forward"></i></a>';
                /*
                for (var i = 1; i < _this._pageInfo.pageCount+1; i++) {
                    html += '<a class="'+(_this._pageInfo.pageNumber==i?'curPage':'')+'">'+i+'</a>';
                }
                */
                html += '<a title="刷新" class="refresh"><i class="glyphicon glyphicon-refresh"></i></a>';
                html += '<span class="dataCount">共'+_this._pageInfo.dataCount+'条</span>';
                html += '<span class="pageSize">每页<select>'+
                        '<option value="5">5</option>'+
                        '<option value="10">10</option>'+
                        '<option value="15">15</option>'+
                        '<option value="20">20</option>'+
                        '<option value="50">50</option>'+
                        '<option value="100">100</option>'+
                        '</select>条</span>';
                $pagination.append(html);
                $pagination.find(".pageSize select").val(_this._config.pageSize);
                !_this._config.tableBodyHeight?_this._$gridPanel.find(".s_grid_table .table-body").height(_this._config.pageSize*trHeight):false;
                _this.setPaginationStatus();
                if(!$pagination.data("bindEvent")){
                    $pagination.on("mouseup","a",function(){
                        if($(this).is(".disable")){return false}
                        var className = this.className.split()[0];
                        if(className.indexOf("GoTo")>-1){
                            var type = className.substring(4);
                            pageNumber = _this._pageInfo.pageNumber;
                            pageCount = _this._pageInfo.pageCount;
                            switch(type){
                                case 'First' :
                                    _this._pageInfo.pageNumber=1;
                                    break;
                                case 'End' :
                                    _this._pageInfo.pageNumber=pageCount;
                                    break;
                                case 'Prev' :
                                    if(pageNumber<=1){return false}
                                    _this._pageInfo.pageNumber=pageNumber-1;
                                    break;
                                case 'Next' :
                                    if(pageNumber>=pageCount){return false}
                                    _this._pageInfo.pageNumber=pageNumber+1;
                                    break;
                            }
                        }else if (className!="refresh"&&className!="curPage") {
                            _this._pageInfo.pageNumber = $(this).text()*1;
                        }else if (className=="refresh"){
                        }
                        _this.refresh();
                    }).on("blur","input",function(){
                        var pageNumber = Math.min($(this).val()*1,_this._pageInfo.pageCount);
                        _this._pageInfo.pageNumber = pageNumber>0?pageNumber:1;
                        _this.refresh();
                    }).on("change","select",function(){
                        _this._config.pageSize = $(this).val()*1;
                        _this._pageInfo.pageNumber = 1;
                        !_this._config.tableBodyHeight?_this._$gridPanel.find(".s_grid_table .table-body").height(_this._config.pageSize*trHeight):false;
                        _this.refresh();
                    });
                    $pagination.data("bindEvent",true);
                }
            } else {
                $pagination.find(".curPage").each(function(){
                    if(this.nodeName == 'A'){
                        //$(this).siblings(".curPage").removeClass("curPage").end().addClass("curPage");
                    }else if (this.nodeName == 'SPAN') {
                        $(this).children("input").val(_this._pageInfo.pageNumber);
                    }
                });
            }
        },

        setPaginationStatus : function(){
            var $pagination = this._$gridPanel.find(".s_grid_pagination");
            $pagination.children("a.disable").removeClass("disable");
            if(this._pageInfo.dataCount<=this._config.pageSize){
                $pagination.children("a").not(".refresh").addClass("disable");
            }
            if(this._pageInfo.pageNumber==1){
                $pagination.children("a.GoToFirst,a.GoToPrev").addClass("disable");
            }else if(this._pageInfo.pageNumber==this._pageInfo.pageCount){
                $pagination.children("a.GoToEnd,a.GoToNext").addClass("disable");
            }
        },

        renderTableData : function (type) { //type:true/false, 当前页所显示数据是否发生改变
            if(!!type){
                this.getData(this.renderData);
            }else{
                this.renderData(false);
            }
        },

        renderData : function(type){
            var $tableBody = this._$gridPanel.find(".s_grid_table .table-body tbody");
            $tableBody.empty().siblings("thead").find("input").removeAttr("checked");
            var _this = this;
            var rows = _this._pageInfo.pageData,
                baseIndex = (parseInt(_this._pageInfo.pageNumber)-1)*parseInt(_this._config.pageSize),
                $tr,trValue,tdValue;
            //render pagination
            this.renderPagination(true);
            //render tableData
            for (var i = 0,row; row = rows[i++];) {
                $tr = $("<tr></tr>");
                $tr.data("index",i-1);
                trValue = "";
                if(!!_this._config.index){
                    trValue += '<td align="center" class="index">'+(i+baseIndex)+'</td>';
                }
                if(typeof _this._config.multi != "undefined"){
                    trValue += '<td align="center"><input type="'+(_this._config.multi?'checkbox':'radio')+'" name="gridSelect"></td>';
                }
                for (var j=0,item;item=_this._config.layout[j++];) {
                    tdValue = row[item.field]===null||typeof row[item.field]=="undefined"?"":row[item.field];
                    tdValue = item.format?item.format({row:row}):tdValue;
                    trValue += '<td'+(item.align?' align="'+item.align+'"':'')+'>'+
                        (item.click?'<a'+(item.field?' class="'+item.field+'"':'')+'>'+tdValue+'</a>':tdValue)+'</td>';
                }
                $tr.append(trValue);
                $tr.children("td").each(function(){
                    $(this).attr("title",$(this).text());
                });
                $tableBody.append($tr);
            }
            //if(--i<_this._config.pageSize){
            //    var pageSize = _this._config.pageSize,
            //        colspan = _this._config.layout.length+1;
            //    for(j=i;j<pageSize;j++){
            //        $tableBody.append('<tr class="emptyRow"><td colspan="'+colspan+'">&nbsp;</td></tr>');
            //    }
            //}
            _this._layoutEventObj={};
            for (var i = 0, layout;layout=_this._config.layout[i++];) {
                if (!!layout.click) {
                    _this._layoutEventObj[layout.field]=layout.click;
                }
            }
            if(!$tableBody.data("bindEvent")){
                $tableBody.on("click","a",function(event){
                    event.stopPropagation();
                	if(this.className&&_this._layoutEventObj[this.className]){
	                    var rowData = _this._pageInfo.pageData[$(this).closest("tr").data("index")];
	                    event.data = {
	                        "row" : rowData
	                    };
	                    _this._layoutEventObj[this.className](event);
                	}
                }).on("click","tr", function (event) {
                    if(typeof _this._config.multi == "undefined"){return false;}
                    if(event.target.nodeName != "INPUT"){
                        toggleCheckbox($(this).find("input"));
                    }
                    if(!_this._config.multi){return true;}
                    var unCheckedNum = $tableBody.find("tr input").not(":checked").length;
                    var $checkAll = _this._$gridPanel.find(".s_grid_table .table-head thead input");
                    if(unCheckedNum==0){
                        $checkAll[0].checked=true;
                    }else if(unCheckedNum==1){
                        $checkAll.removeAttr("checked");
                    }
                });
                for(var k = 0; k < this._config.trEvent.length; k++){
                    (function(trEvent){
                        $tableBody.on(trEvent.type,"tr:not(.emptyRow)",function(event){
                            event.data = {
                                "row" : _this._pageInfo.pageData[$(this).data("index")]
                            };
                            trEvent.callback(event);
                        });
                    })(this._config.trEvent[k]);
                }
                $tableBody.data("bindEvent",true);
            }
        },

        getData : function(callback){
            if (this._config.data.type=="URL") {
                this.getAjaxData(callback);
            } else {
                this.getCurPageData(callback);
            }
        },
        
        getCurPageData : function (callback) {
            var data = this._config.data,
                pageNumber = this._pageInfo.pageNumber,
                pageSize = this._config.pageSize,
                curPageData=[],
                startIndex,endIndex;
            if(data.length>0){
                this._pageInfo.dataCount = data.length;
                startIndex = (pageNumber-1)*pageSize;
                endIndex = Math.min(pageNumber*pageSize,data.length);
                curPageData = data.slice(startIndex,endIndex);
            }
            this._pageInfo.pageData = curPageData;
            callback.call(this,true);
        },

        getAjaxData : function(callback){
            var _this = this;
            $.ajax({
                type: 'POST',
                url: _this._config.data.value,
                dataType: "json",
                data: $.extend({
                    "pageSize": _this._config.pageSize,
                    "pageNumber": _this._pageInfo.pageNumber
                },_this._config.formData,_this._config.sortParam),
                success: function(returnData){
                    if(typeof _this._config.key!="undefined"){
                        returnData = formatData(returnData,_this._config.key);
                    }
                    $.extend(_this._pageInfo,returnData);
                    callback.call(_this,true);
                    return true;
                },
                error:function(jqXHR,status,errorThrown){
                    console.log(errorThrown);
                    return false;
                }
            });
        },
        
        bindDraggableEvent : function () {
            var $tableHead = this._$gridPanel.find(".s_grid_table .table-head"),
                $tableBody = this._$gridPanel.find(".s_grid_table .table-body"),
                $dragTrigger = this._$gridPanel.find(".s_grid_table .table-head .dragTrigger"),
                $curNode=null;
            $tableHead.on("mouseleave","th",function(event){
                var eNode = this,
                    tNode = event.relatedTarget,
                    offsetLeft = 0;
                if(!!tNode&&tNode.nodeName=="TH"&&!$(tNode).is(".noDrag")&&!$(eNode).is(".noDrag")){
                    var curPosX = event.pageX,
                        triggerWidth = parseInt($dragTrigger.outerWidth());
                    $curNode = $($(eNode).index()>$(tNode).index()?tNode:eNode);
                    offsetLeft = parseInt($curNode.position().left)+parseInt($curNode.outerWidth())-triggerWidth/2;
                    $dragTrigger.css("left",offsetLeft+"px").show();
                    $tableHead.on("mousemove.trigger", function (evt) {
                        if(Math.abs(evt.pageX-curPosX)<triggerWidth/2){return false}
                        $tableHead.off("mousemove.trigger");
                        clearDragTrigger();
                    });
                }
            }).on("mouseleave", function () {
                $tableHead.off("mousemove");
                clearDragTrigger();
            });
            var lastTHWidth = $tableHead.find("table th:last").outerWidth();
            $dragTrigger.on("mousedown",function(event){
                var startPosX=0,endPosX=0;
                //setColWidth
                if(!$tableHead.parent().is(".fixed")){
                    $tableHead.add($tableBody).find("th").each(function(){
                        this.style.width=$(this).outerWidth()+"px";
                    });
                    $tableHead.parent().addClass("fixed");
                }
                var startWidth = $curNode.outerWidth(),
                    startLeft = parseInt($dragTrigger.css("left")),
                    tableWidth=$tableHead.find("table").outerWidth();
                startPosX = event.pageX;
                $tableHead.off("mousemove.trigger");
                $tableHead.on("mousemove.drag",function(evt){
                    var curWidth,offset;
                    endPosX = evt.pageX;
                    offset = endPosX-startPosX;
                    curWidth = startWidth+offset;
                    if(curWidth<30){
                        clearDragTrigger();
                        $tableHead.off("mousemove.drag");
                        return false;
                    }
                    $curNode[0].style.width=curWidth+"px";
                    $tableBody.find("thead th").get($curNode.index()).style.width=curWidth+"px";
                    //宽度变化
                    $dragTrigger.css("left",startLeft+offset);
                    $tableBody.add($tableHead).children("table").css("width",tableWidth+offset);
                    ////控制最后一列宽度
                    //if((tableWidth+offset)<$tableHead.outerWidth()){
                    //   $tableBody.add($tableHead).find("table th:last").each(function(){
                    //       this.style.width = $(this).outerWidth()+$tableHead.outerWidth()-(tableWidth+offset)+"px";
                    //   });
                    //}
                    //if((tableWidth+offset)>$tableHead.outerWidth()&&$tableHead.find("table th:last").outerWidth()>lastTHWidth){
                    //    $tableBody.add($tableHead).find("table th:last").each(function(){
                    //        this.style.width = $(this).outerWidth()+$tableHead.outerWidth()-(tableWidth+offset)+"px";
                    //    });
                    //}
                });
            });
            $tableHead.on("mouseup", function (event) {
                clearDragTrigger();
                $tableHead.off("mousemove.drag");
            });
            function clearDragTrigger(){
                $curNode=null;
                $dragTrigger.hide().css("left",0);
            }
        },
        sortTableData : function(field,order,type){
            if (arguments.length<2) {return false;}
            if (!!type) {
                $.extend(this._config.sortParam,{
                    field : field,
                    order : order
                });
                this.renderTableData(true);
            } else {
                this._pageInfo.pageData = sortData(this._pageInfo.pageData,field,order);
                this.renderTableData(false);
            }
        }
    };

    Grid.fn.extend({
        getSelectedRow : function(){
            var selectedArr = [];
            var _this = this;
            $tableBody = _this._$gridPanel.find(".s_grid_table tbody");
            $tableBody.find("input:checked").each(function(){
                var index = $(this).closest("tr").data("index");
                if (typeof index == "undefined") { return true;}
                selectedArr.push(_this._pageInfo.pageData[index]);
            });
            return selectedArr;
        },
        refresh : function(){
            if(!this._config.realSort){
                this._$gridPanel.find(".s_grid_table thead .fa-sort").removeClass("fa-sort-desc fa-sort-asc");
                this._config.sortParam={};
            }
            this.renderTableData(true);//pageData必须重新取值,所以为 true
            this.clearAllCheckedRow();
        },
        setData : function(callback){
            if (!this._config.data.type) {
                this._config.data = callback(this._config.data);
                this.refresh();
            }else{
                console.log("data retrived from database!")
            }
        },
        clearAllCheckedRow : function(){
            var $checkAll = this._$gridPanel.find(".s_grid_table .table-head thead input"),
                $checkedRow = this._$gridPanel.find(".s_grid_table .table-body tbody input:checked");
            $checkedRow.each(function(){
                $(this).removeAttr("checked");
            });
            $checkAll.removeAttr("checked");
        }
    });

    function toggleCheckbox($input){
        if (!$input.length) {return false}
        if($input.is(":checked")){
            $input.removeAttr("checked");
        }else{
            $input[0].checked = true;
        }
    }
    /* 
     * 排序函数
     * sortData
     */
    function sortData(data,field,order){
        var result = [];
        if (!data||data.length==0) {return data;}
        // sort data
        order=(order=="asc")?-1:1;
        result.push(data[0]); //向队列中推入第一个元素
        for(var i= 1,item;item=data[i];i++){
            var set= false;
            for(var j= 0,value;value=result[j];j++){
                if(item[field].localeCompare(value[field])==order){
                    result.splice(j,0,item);
                    set = true;
                    break;
                }
            }
            if(!set) result.push(item);
        }
        result = result.length>0?result:data; //测试逻辑
        return result;
    }

    /*
     * 转换数据格式
     * pageInfo
     */
    function formatData(data,format){
        var result={};
        //遍历替换列表
        for (var i in data ){
            if (data.hasOwnProperty(i)) {
                if(!!format[i]){
                    result[format[i]] = data[i];
                }else{
                    result[i] = data[i];
                }
            }
        }
        return result;
    }

    return initGrid;
});