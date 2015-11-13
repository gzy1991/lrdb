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
    draggable:false,
    layout:[
        {name:"姓名",field:"name",click:function(e){
            data = e.data;
        }},
        {name:"性别",field:"sex",sort:true},
        {name:"电话",field:"phone"},
        {name:"邮件",field:"email"},
        {name:"地址",field:"address",format:function(obj){console.log(obj);return "BJ"}}
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
    queryParam:{                                  //数据请求的额外参数
        name : 'value'
    },
    key:{                                //前后台字段名转换
        'data':'format'
    },
    onSeletedChanged : function(status){},
    onSelectAll : function(status){}
 }
 */

define([
    "jquery",
    "PDUtilDir/util",
    "css!PDUtilDir/css/grid.css",
    "MCScrollbarDir/jquery.mCustomScrollbar.min",
    "MCScrollbarDir/jquery.mCustomScrollbar.concat.min",
    "css!MCScrollbarDir/jquery.mCustomScrollbar.min"],function($,Util){
    var cache={},trHeight=39;

    function initGrid(config){
        var _config = $.extend({
            pagination : true,
            //realSort : false,
            draggable:false,
            textEllipsis:true,
            key:{
                "allDataCount" : "dataCount",
                "curPageData" : "pageData"
            },
            queryParam:{},
            layout:[],
            toolbar:[],
            data:[],
            trEvent: {},     //数据行事件
            cache : true
        },config);
        //兼容placeAt和id参数
        _config.placeAt=_config.placeAt||_config.id;
        _config.id=_config.id||_config.placeAt;
        _config.pageSize = _config.pageSize||(_config.pagination?10:100);
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

    /*initGrid.dropCache = function(){
        cache={};
    };*/

    function Grid(config){
        this._config = config;
        //真分页时，后端返回数据类型结构为此结构即可
        this._pageInfo = {
            curPage:1,                      //默认当前为表格的第一页
            pageData:[],                    //当前页数据
            dataCount:0,                    //所有数据总条数
            pageCount:0                     //总页数
        };
        //排序参数
        this._sortParam = {
            field: "",
            order: ""
        };
        render(this);
    }
    

    Grid.fn = Grid.prototype;

    Grid.fn.getGridPanel = function(){
        return this._$gridPanel?this._$gridPanel:$("#"+this._config.placeAt);
    };

    Grid.fn.getSelectedRow = function(){
        var selectedArr = [];
        var _this = this;
        var $tableBody = _this._$gridPanel.find(".s_grid_table tbody");
        var baseIndex   = (parseInt(this._pageInfo.curPage)-1)*parseInt(this._config.pageSize);
        $tableBody.find("input:checked").each(function(){
            var index = $(this).closest("tr").data("index");
            if (typeof index == "undefined") { return true;}
            var row = _this._pageInfo.pageData[index-baseIndex-1];
            row["_index"] = index;
            selectedArr.push(row);
        });
        return selectedArr;
    };

    /**
     * 获取当前表格所有数据
     * 静态数据则返回初始化给予的数据
     * URL获取数据则返回当页数据（此处包含前端appendRow的数据）
     */
    /*Grid.fn.getData = function(){

    };*/

    Grid.fn.getSelectedRowIndex = function(){
        var arr = this.getSelectedRow();
        var result = [];
        for(var i= 0,row;row=arr[i++];){
            result.push(row["_index"])
        }
        return result;
    };

    /**
     * 获取表格当前页的数据
     * 剔除通过deletedRow方法删除的数据
     */
    Grid.fn.getCurPageData = function(){
        var arr = [];
        for(var i= 0,item;item=this._pageInfo.pageData[i++];){
            if(item["_changeType"]!="deleted"){
                arr.push(item);
            }
        }
        return arr;
    };

    Grid.fn.clearSelectedRow = function(){
        var $checkAll = this._$gridPanel.find(".s_grid_table .table-head thead input"),
            $checkedRow = this._$gridPanel.find(".s_grid_table .table-body tbody input:checked");
        $checkedRow.each(function(){
            $(this).removeAttr("checked");
        });
        $checkAll.removeAttr("checked");
        //此时所选数据为空
        onSeletedChanged(this,[]);
    };

    /**
     * 向表格中追加一行
     * @param row
     */
    Grid.fn.appendRow = function(row){
        var $tableBody  = this._$gridPanel.find(".s_grid_table .table-body tbody");
        var baseIndex   = (parseInt(this._pageInfo.curPage)-1)*parseInt(this._config.pageSize);
        var index       = this._pageInfo.pageData.length+1;
        $tableBody.append(createRow(this,row,baseIndex,index));
        row["_changeType"]="inserted";
        this._pageInfo.pageData.push(row);
    };
    /**
     * 删除指定index的行
     * @param index
     */
    Grid.fn.deleteRow = function(index){
        var $tableBody  = this._$gridPanel.find(".s_grid_table .table-body tbody");
        $tableBody.find(">tr").each(function(idx,element){
            var $element = $(element);
            if($element.data("index")==index){
                $element.remove();
            }
        });
        //索引、数据更新
        if(this._config.index){
            refreshIndex(this);
        }
        for(var i= 0,item;item=this._pageInfo.pageData[i++];){
            if(item["_index"]==index){
                if(item["_changeType"]=="inserted"){
                    //删除元素
                    this._pageInfo.pageData.splice(i-1,1);
                }else{
                    this._pageInfo.pageData[i-1]["_changeType"] = "deleted";
                }
            }
        }
    };
    /**
     * 更新某一行数据
     * @param param
     * param 参数包括下列属性：
     * index：要更新的行的索引。
     * row：新的行数据。
     */
    Grid.fn.updateRow = function(param){
        var _this = this;
        var $tableBody  = _this._$gridPanel.find(".s_grid_table .table-body tbody");
        var baseIndex   = (parseInt(_this._pageInfo.curPage)-1)*parseInt(_this._config.pageSize);
        //var index       = _this._pageInfo.pageData.length+1;
        $tableBody.find(">tr").each(function(idx,element){
            var $element = $(element);
            if($element.data("index")==param.index){
                //重新渲染该行
                $element.replaceWith(createRow(_this,param.row,baseIndex,idx+1));
                //更新状态位
                for(var i= 0,item;item=_this._pageInfo.pageData[i++];){
                    if(item["_index"]==param.index){
                        var ctype = item["_changeType"];
                        if(ctype!="inserted" && ctype!="deleted"){
                            item["_changeType"] = "updated";
                        }
                    }
                }
            }
        });
    };

    /**
     * 获取当页被修改的所有行
     * type参数表明修改的类型，可选值：inserted，deleted，updated等 。
     * 当没有传递type参数时，返回所有被修改的行。
     * @param type
     */
    Grid.fn.getChanges = function(type){
        var data = {
            "inserted":[],
            "deleted":[],
            "updated":[]
        };
        for(var i= 0,row;row=this._pageInfo.pageData[i++];){
            switch(row._changeType){
                case "inserted":
                    data.inserted.push(row);
                    break;
                case "deleted":
                    data.deleted.push(row);
                    break;
                case "updated":
                    data.updated.push(row);
                    break;
            }
        }
        return type ? data[type] : data.inserted.concat(data.updated,data.deleted);
    };

    /**
     * 表格刷新
     */
    Grid.fn.refresh = function(){
        renderTableBody(this);             //pageData必须重新取值,所以为 true
        //此时所选数据为空
        onSeletedChanged(this,[]);
    };

    /**
     * 重新加载表格
     * @param config 表格初始化对象
     */
    Grid.fn.reload = function(config){
        this._config = $.extend(this._config,config);
        //排序初始化
        this._$gridPanel.find(".s_grid_table thead .fa-sort").removeClass("fa-sort-desc fa-sort-asc");
        this._sortParam={
            field : "",
            order : ""
        };
        //分页信息初始化
        this._pageInfo = {
            curPage:1,                      //默认当前为表格的第一页
            pageData:[],                    //当前页数据
            dataCount:0,                    //所有数据总条数
            pageCount:0                     //总页数
        };
        this.refresh();
    };

    function render(grid){
        var _this = grid;
        //grid HTML Structure
        var html = '<div class="s_grid_title"></div>'+
            '<div class="s_grid_content"'+(_this._config.hidden?' style="display:none"':'')+'>'+
            (_this._config.toolbar.length?'<div class="s_grid_toolbar"><ul></ul></div>':'')+     //操作栏面板
            '<div class="s_grid_table"></div>'+
            '<div class="s_grid_pagination"></div>'+
            '</div>';
        //获取 grid 对象,
        _this._$gridPanel = _this.getGridPanel();
        _this._$gridPanel.addClass("s_grid").empty().append(html);
        _this._config.textEllipsis && _this._$gridPanel.addClass("s_grid_ellipsis");

        //初始化 grid 各个部分
        renderTitle(_this);
        renderToolbar(_this);
        renderTable(_this);
        //this.renderSearchPanel();
    }

    /**
     * 渲染表格标题
     * @param grid
     * @returns {boolean}
     */
    function renderTitle(grid){
        var _this = grid;
        var $title = _this._$gridPanel.children(".s_grid_title");
        if(!_this._config.title){
            $title.empty().hide(); return false;
        }
        $title.empty().show();
        //var html = '<span class="title"><i class="fa fa-table" style="color:#2898e0"></i></span>';
        var html = '<span class="title"></span>';
        if(typeof(_this._config.hidden)!="undefined"){
            html += '<i class="glyphicon'+(_this._config.hidden?' glyphicon-plus-sign':' glyphicon-minus-sign')+'"></i>';
            //表格内容显示隐藏控制
            $title.on('click','.glyphicon',function(e){
                $title.siblings(".s_grid_content").slideToggle();
                $(this).toggleClass("glyphicon-plus-sign glyphicon-minus-sign");
            });
        }
        $title.append(html);
        $title.children(".title").append(_this._config.title || '数据列表');
    }

    /**
     * 渲染表格操作栏
     * @param grid
     */
    function renderToolbar(grid){
        var _this = grid;
        var $toolbar = _this._$gridPanel.find(".s_grid_toolbar").empty();
        if(!!_this._config.toolbar&&_this._config.toolbar.length>0){
            var $ul = $("<ul></ul>");
            for(var i = 0, length=_this._config.toolbar.length;i<length;i++){
                var item = _this._config.toolbar[i];
                $('<li'+(item.id?' id="'+item.id+'"':'')+'><a><i class="'+item.icon+'"></i>'+ item.name +'</a></li>')
                    .bind("click",_this,item.callback)
                    .appendTo($ul);
            }
            $toolbar.append($ul);
        }
    }

    function renderTable(grid){
        var _this = grid;
        var $table = _this._$gridPanel.find(".s_grid_table").empty();
        $table.append('<div class="table-head"><table onselectstart="return false;" class="table table-hover"><thead></thead></table><div class="dragTrigger"></div></div>');
        $table.append('<div class="table-body" '+(_this._config.tableBodyHeight && 'style="height:'+_this._config.tableBodyHeight)+'><table class="table table-hover"><thead></thead><tbody></tbody></table></div>');
        renderTableHead(_this);
        renderTableBody(_this);
        _this._config.draggable?bindDraggableEvent(_this):false;
        //渲染纵向滚动条
        /*this._config.tableBodyHeight?$table.find(".table-body").mCustomScrollbar({
         axis:"y",
         theme: "minimal-dark",
         scrollInertia:500
         }):false;*/
        $table.find(".table-body").mCustomScrollbar({
            axis:"y",
            theme: "minimal-dark",
            scrollInertia:500
        });
    }

    function renderTableHead(grid){
        var _this = grid;
        var $tableHead = _this._$gridPanel.find(".s_grid_table table thead").empty();
        //render head
        var html = "";
        if(!!_this._config.index){
            html += '<th align="center" class="index noDrag" width="24px"></th>';
        }
        if(typeof _this._config.multi != "undefined"){
            html += '<th align="center" class="fix noDrag" width="24px">'+(_this._config.multi?'<input type="checkbox">':'')+'</th>';
        }
        var layout = _this._config.layout;
        for(var i=0,item;item=layout[i++];){
            html += '<th'+(item.align?' style="text-align:'+item.align+'"':'')+' width="'+(item.width?item.width:(100/layout.length+'%'))+'" class="'+item.field+'" title="'+item.name+'">'+item.name+(item.sort?'<i class="fa fa-sort"></i>':'')+'</th>';
        }
        $tableHead.append('<tr>'+html+'</tr>');
        _this._$gridPanel.find(".s_grid_table .table-body thead th").removeAttr("title").empty();
        //bindEvent
        var $tHead = _this._$gridPanel.find(".s_grid_table .table-head thead"),
            $tBody = _this._$gridPanel.find(".s_grid_table .table-body tbody");
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
                onSeletedChanged(_this);
                _this._config.onSelectAll?_this._config.onSelectAll(checked):false;
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
                    //sortTableData(_this,field,order);
                    //设置排序字段后重新渲染表格内容
                    $.extend(_this._sortParam,{
                        field : field,
                        order : order
                    });
                    renderTableBody(_this);
                    //触发onSeletedChanged事件
                    onSeletedChanged(_this,[]);
                }
            }
        });
    }

    function renderTableBody(grid){
        //renderTableData(grid,true);
        getData(grid,renderData);
        if(typeof(grid._config.onAfterRenderTableBody)=="function"){
            grid._config.onAfterRenderTableBody.apply(grid);
        }
    }

    function getData(grid,callback){
        var _this = grid;
        if (_this._config.data.type=="URL") {
            getAjaxData(_this,callback);
        } else {
            getCurPageData(_this,callback);
        }
    }

    function getCurPageData(grid,callback) {
        var _this = grid;
        var data = _this._config.data,
            curPage = _this._pageInfo.curPage,
            pageSize = _this._config.pageSize,
            curPageData=[],
            startIndex,endIndex;
        //判断是否需要对数据进行排序
        if(_this._sortParam && _this._sortParam.field && _this._sortParam.order){
            data = sortData(data,_this._sortParam.field,_this._sortParam.order);
        }
        if(data.length>0){
            _this._pageInfo.dataCount = data.length;
            startIndex = (curPage-1)*pageSize;
            endIndex = Math.min(curPage*pageSize,data.length);
            curPageData = data.slice(startIndex,endIndex);
        }
        _this._pageInfo.pageData = curPageData;
        callback.apply(_this,[_this]);
    }

    function getAjaxData(grid,callback){
        var _this = grid;
        var load = Util.loading({
            id:_this._config.placeAt,
            modal:false
        });
        load.show();
        $.ajax({
            type: 'POST',
            url: _this._config.data.value,
            dataType: "json",
            async:false,
            data: $.extend({
                "pageSize": _this._config.pageSize,
                //"pageNumber": _this._pageInfo.curPage,      //兼容0.9.4之前版本
                "curPage": _this._pageInfo.curPage
            },_this._config.queryParam,_this._sortParam),
            success: function(returnData){
                if(typeof _this._config.key!="undefined"){
                    returnData = formatData(returnData,_this._config.key);
                }
                $.extend(_this._pageInfo,returnData);
                callback.apply(_this,[_this]);
                load.close();
                return true;
            },
            error:function(jqXHR,status,errorThrown){
                load.close();
                console.log(errorThrown);
                return false;
            }
        });
    }

    function renderData(grid){
        var _this = grid;
        var $tableBody = _this._$gridPanel.find(".s_grid_table .table-body tbody");
        $tableBody.empty().siblings("thead").find("input").removeAttr("checked");
        //如果后端返回数据为null，则默认置为空数组
        var rows = _this._pageInfo.pageData || [],
            baseIndex = (parseInt(_this._pageInfo.curPage)-1)*parseInt(_this._config.pageSize);
        //render pagination
        renderPagination(_this);
        //render tableData
        for (var i = 0,row; row = rows[i++];) {
            $tableBody.append(createRow(_this,row,baseIndex,i));
        }
        //设置body高度
        trHeight = _this._config.textEllipsis?trHeight:_this._$gridPanel.find(".s_grid_table .table-body tbody tr").outerHeight();

        if(!_this._config.tableBodyHeight){
            var height = (_this._config.pagination?_this._config.pageSize:Math.min(_this._config.pageSize,rows.length))*trHeight
            height>0 && _this._$gridPanel.find(".s_grid_table .table-body").height(height);
        }
        //绑定事件
        if(!$tableBody.data("bindEvent")){
            _this._layoutEventObj={};
            for (var i = 0, layout;layout=_this._config.layout[i++];) {
                if (!!layout.click) {
                    _this._layoutEventObj[layout.field]=layout.click;
                }
            }
            $tableBody.on("click","a",function(event){
                event.stopPropagation();
                if(this.className&&_this._layoutEventObj[this.className]){
                    var index = $(this).closest("tr").data("index");
                    var baseIndex = (parseInt(_this._pageInfo.curPage)-1)*parseInt(_this._config.pageSize);
                    var rowData = _this._pageInfo.pageData[index-baseIndex-1];
                    rowData["_index"] = index;
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
                onSeletedChanged(_this);
            });
            for(var k = 0; k < _this._config.trEvent.length; k++){
                (function(trEvent){
                    $tableBody.on(trEvent.type,"tr",function(event){
                        var index   = $(this).data("index");
                        var baseIndex = (parseInt(_this._pageInfo.curPage)-1)*parseInt(_this._config.pageSize);
                        var row     = _this._pageInfo.pageData[index-baseIndex-1];
                        row["_index"] = index;
                        event.data  = {
                            "row" : row
                        };
                        trEvent.callback(event);
                    });
                })(_this._config.trEvent[k]);
            }
            $tableBody.data("bindEvent",true);
        }
    }

    /**
     * 向表格中追加一行数据
     * @param grid              表格对象
     * @param row               行数据
     * @param baseIndex         当前页的第一条从多少序号开始
     * @param index             当前行序号
     */
    var createRow = function(grid,row,baseIndex,index){
        var _this = grid;

        //渲染表格行前触发
        if(typeof(_this._config.onBeforeRenderRow)=="function"){
            //可对行数据进行处理
            row = _this._config.onBeforeRenderRow.apply(_this,[row]) || row;
        }

        var $tr = $("<tr></tr>"),tdValue;
        $tr.data("index",(index+baseIndex));
        row["_index"] = index+baseIndex;
        if(!!_this._config.index){
            $tr.append('<td align="center" class="index">'+(index+baseIndex)+'</td>');
        }
        if(typeof _this._config.multi != "undefined"){
            $tr.append('<td align="center" class="fix"><input type="'+(_this._config.multi?'checkbox':'radio')+'" name="s_gird_'+(_this._config.id)+'" '+(row["_checked"]?"checked":"")+'></td>');
        }
        for (var j=0,item,$td;item=_this._config.layout[j++];) {
            tdValue = row[item.field];
            tdValue = item.format?item.format({"row":row}):tdValue;
            tdValue = (tdValue || tdValue==0)?tdValue:"";
            $td = $('<td'+(item.align?' align="'+item.align+'"':'')+'></td>');
            item.click?function(){
                $td.append('<a'+(item.field?' class="'+item.field+'"':'')+'></a>');
                $td.children("a").append(tdValue);
            }():$td.append(tdValue);
            $tr.append($td);
        }
        $tr.children("td").each(function(){
            $(this).attr("title",$(this).text());
        });

        //渲染表格行后触发
        if(typeof(_this._config.onAfterRenderRow)=="function"){
            _this._config.onAfterRenderRow.apply($tr,[row]);
        }

        return $tr;
    };

    function renderPagination(grid){
        var _this = grid;
        var $pagination = _this._$gridPanel.find(".s_grid_pagination");
        //计算总页数
        _this._pageInfo.pageCount = Math.ceil(_this._pageInfo.dataCount/_this._config.pageSize);
        if(!_this._config.pagination){ $pagination.empty().hide(); return false; }

        $pagination.empty().show();
        //render pagination
        var html = '<a title="第一页" class="GoToFirst"><i class="glyphicon glyphicon-step-backward"></i></a>'+
            '<a title="上一页" class="GoToPrev"><i class="glyphicon glyphicon-chevron-left"></i></a>'+
            '<span class="curPage"><input type="text" value="'+_this._pageInfo.curPage+'"/></span>'+
            '<a title="下一页" class="GoToNext"><i class="glyphicon glyphicon-chevron-right"></i></a>'+
            '<a title="最后一页" class="GoToEnd"><i class="glyphicon glyphicon-step-forward"></i></a>';
        /*
         for (var i = 1; i < _this._pageInfo.pageCount+1; i++) {
         html += '<a class="'+(_this._pageInfo.curPage==i?'curPage':'')+'">'+i+'</a>';
         }
         */
        html += '<a title="刷新" class="refresh"><i class="glyphicon glyphicon-refresh"></i></a>';
        html += '<span class="dataCount">共<i class="num">'+_this._pageInfo.dataCount+'</i>条</span>';
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
        setPaginationStatus(_this);
        if(!$pagination.data("bindEvent")){
            $pagination.on("click","a",function(){
                if($(this).is(".disable")){return false}
                var className = this.className.split()[0];
                if(className.indexOf("GoTo")>-1){
                    var type = className.substring(4);
                    curPage = _this._pageInfo.curPage;
                    pageCount = _this._pageInfo.pageCount;
                    switch(type){
                        case 'First' :
                            _this._pageInfo.curPage=1;
                            break;
                        case 'End' :
                            _this._pageInfo.curPage=pageCount;
                            break;
                        case 'Prev' :
                            if(curPage<=1){return false}
                            _this._pageInfo.curPage=curPage-1;
                            break;
                        case 'Next' :
                            if(curPage>=pageCount){return false}
                            _this._pageInfo.curPage=curPage+1;
                            break;
                    }
                }else if (className!="refresh"&&className!="curPage") {
                    _this._pageInfo.curPage = $(this).text()*1;
                }else if (className=="refresh"){
                }
                _this.refresh();
            }).on("keydown","input",function(e){
                if(e.which!=13){return true}
                var curPage = Math.min($(this).val()*1,_this._pageInfo.pageCount);
                _this._pageInfo.curPage = curPage>0?curPage:1;
                _this.refresh();
            }).on("click","input",function(){
                $(this).select();
            }).on("blur","input",function(){
                $(this).val(_this._pageInfo.curPage);
            }).on("change","select",function(){
                _this._config.pageSize = $(this).val()*1;
                _this._pageInfo.curPage = 1;
                _this.refresh();
            });
            $pagination.data("bindEvent",true);
        }
    }

    function setPaginationStatus(grid){
        var _this = grid;
        var $pagination = _this._$gridPanel.find(".s_grid_pagination");
        $pagination.children("a.disable").removeClass("disable");
        if(_this._pageInfo.dataCount<=_this._config.pageSize){
            $pagination.children("a").not(".refresh").addClass("disable");
        }
        if(_this._pageInfo.curPage==1){
            $pagination.children("a.GoToFirst,a.GoToPrev").addClass("disable");
        }else if(_this._pageInfo.curPage==_this._pageInfo.pageCount){
            $pagination.children("a.GoToEnd,a.GoToNext").addClass("disable");
        }
    }

    function bindDraggableEvent(grid) {
        var _this = grid;
        var $gridTable = _this._$gridPanel.find(".s_grid_table"),
            $tableHead = $gridTable.find(".table-head"),
            $tableBody = $gridTable.find(".table-body"),
            $dragTrigger = $tableHead.find(".dragTrigger"),
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
        //var lastTHWidth = $tableHead.find("table th:last").outerWidth();
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
                if(curWidth<30||!$curNode){
                    clearDragTrigger();
                    $tableHead.off("mousemove.drag");
                    return false;
                }
                $curNode[0].style.width=curWidth+"px";
                $tableBody.find("thead th").get($curNode.index()).style.width=curWidth+"px";
                $dragTrigger.css("left",startLeft+offset);

                //宽度变化
                $tableBody.add($tableHead).find("table").css("width",tableWidth+offset);
                //$tableBody.parent().css("width",Math.max($tableBody.find("table").width(),$tableBody.closest(".s_grid_table").outerWidth()-2));
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
            //渲染横向滚动条
            $tableBody.parent(".s_grid_table").length?$gridTable.mCustomScrollbar({
                axis:"x",
                theme: "minimal-dark",
                scrollInertia:500
            }):false;
        });
        $tableHead.on("mouseup", function (event) {
            clearDragTrigger();
            $tableHead.off("mousemove.drag");
        });
        function clearDragTrigger(){
            $curNode=null;
            $dragTrigger.hide().css("left",0);
            //延迟计算横向滚动条wrap宽度,防止拖动时抖动问题
            !$tableBody.parent(".s_grid_table").length?$tableBody.parent().css("width",Math.max($tableBody.find("table").width(),$tableBody.closest(".s_grid_table").outerWidth()-2)):false;
        }
    }

    /*function sortTableData(grid,field,order,type){
        var _this = grid;
        if (!!type) {
            $.extend(_this._sortParam,{
                field : field,
                order : order
            });
            renderTableData(_this,true);
        } else {
            _this._pageInfo.pageData = sortData(_this._pageInfo.pageData,field,order);
            renderTableData(_this,false);
        }
        //此时所选数据为空
        onSeletedChanged(_this,[]);
    }*/

    /**
     * 如果传入最新数据则不重新取值（refresh方法中使用到第二个参数）
     * @param grid
     * @param row
     */
    function onSeletedChanged(grid,rows){
        var _this = grid;
        if(typeof(_this._config.onSeletedChanged)=="function"){
            _this._config.onSeletedChanged.apply(_this,[rows?rows:_this.getSelectedRow()]);
        }
    }

    /**
     * 重新渲染当前页序号
     * @param grid
     */
    function refreshIndex(grid){
        var baseIndex   = (parseInt(grid._pageInfo.curPage)-1)*parseInt(grid._config.pageSize);
        grid._$gridPanel.find(".s_grid_table .table-body tbody>tr").each(function(index,element){
            var i = baseIndex+index+1;
            $(element).children("td:first").attr("title",i).text(i);
        });
    }

    function toggleCheckbox($input){
        if (!$input.length) {return false}
        if($input.is(":checked")){
            $input.removeAttr("checked");
        }else{
            $input[0].checked = true;
        }
    }

    /**
     * 静态数据排序
     * @param data          要排序的数据
     * @param field         排序字段
     * @param order         asc为升序、desc为降序
     * @returns {*}
     */
    function sortData(data,field,order){
        var result = [];
        if (!data||data.length==0) {return data;}
        // sort data
        order=(order=="asc")?-1:1;
        result.push(data[0]); //向队列中推入第一个元素
        for(var i= 1,item;item=data[i];i++){
            var s= false;
            for(var j= 0,value;value=result[j];j++){
                if(item[field].toString().localeCompare(value[field].toString())==order){
                    result.splice(j,0,item);
                    s = true;
                    break;
                }
            }
            if(!s) result.push(item);
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