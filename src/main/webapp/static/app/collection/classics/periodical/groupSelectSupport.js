/**
 * @author zhanglei@css.com.cn
 */
define(['jquery', 'PDUtilDir/grid', 'PDUtilDir/util', 'LrdbCommonDir/dict', 'PDUtilDir/dialog'],
    function ($, Grid, Util, Dict, Dialog) {
        var result = {};
        var groupSelectGrid;
        var options = {
            $compile: '',
            $scope: '',
            itemName: ''
        };
        var groupSelectGridInit = function ($compile, $scope) {
            var config = {
                id: 'groupSelectGrid',
                placeAt: 'groupSelectGrid',
                pageSize: 10,
                index: "checkbox",
                multi: true,
                layout: [{name: '标题', field: 'resourceTitle'},
                    {name: '资源类型', field: 'resourceType'},
                    {name: '操作人', field: 'modifyMember'},
                    {name: '所属机构', field: 'modifyDep'},
                    {name: '操作时间', field: 'modifyTime'},
                    {name: '业务类型', field: 'modifyType'}
                ],
                toolbar: [
                    {
                        name: '查询', icon: 'fa fa-search', callback: function () {
                        $scope.groupSelect.entity.query();
                    }
                    },
                    {
                        name: '重置', icon: 'fa fa-repeat', callback: function () {
                        $scope.groupSelect.entity.queryGroupName = '';
                        $scope.$digest();
                    }
                    }],
                data: {
                    type: 'URL',
                    value: getServer() + '/static/app/collection/classics/periodical/data/modifyHistoryRecsList.json'
                },
                format: {},
                trEvent: [{
                    type: 'dblclick', callback: function (e) {
                        $scope.periodical.entity.supervisorUnit =
                            $scope.periodical.entity.supervisorUnit === '' || $scope.periodical.entity.supervisorUnit === undefined ? e.data.row.resourceTitle : $scope.periodical.entity.supervisorUnit + ";  " + e.data.row.resourceTitle;
                        $scope.$digest();
                    }
                }]
            };
            groupSelectGrid = Grid(config);
        };

        result.instance = function (option) {
            options = $.extend(options, option);
            groupSelectDialog(options.$compile, options.$scope)
        };

        var pushgroupSelect = function ($scope) {
            var exist = 0;
            var selected = groupSelectGrid.getSelectedRow();
            var tmpArr = $scope.periodical.entity.supervisorUnit === '' || $scope.periodical.entity.supervisorUnit === undefined ? [] : $scope.periodical.entity.supervisorUnit.split(";");
            if (selected.length) {
                for (var i = 0; i < selected.length; i++) {
                    for (var j = 0; j < tmpArr.length; j++) {
                        if (selected[i].resourceTitle == tmpArr[j]) {
                            exist = 1;
                            break;
                        }
                    }
                    if (exist) {
                        break;
                    }
                }
                if (exist) {
                    Util.alert('包含已关联资源');
                    return false;
                } else {
                    for (var k = 0; k < selected.length; k++) {
                        $scope.periodical.entity.supervisorUnit =
                            $scope.periodical.entity.supervisorUnit === '' || $scope.periodical.entity.supervisorUnit === undefined ? selected[k].resourceTitle : $scope.periodical.entity.supervisorUnit + ";" + selected[k].resourceTitle;
                    }
                    $scope.$digest();
                    Util.alert('添加关联成功');
                    return true;
                }
            } else {
                Util.alert('未勾选资源');
                return false;
            }
        };

        var groupSelectDialog = function ($compile, $scope) {
            var dialog = Dialog({
                id: 'groupSelectId',
                title: '期刊栏目编辑',
                drag: true,
                $compile: $compile,
                $scope: $scope,
                url: getServer() + '/static/app/collection/classics/periodical/views/groupSelect.html',
                //modal:{backdrop:'static'},//则点击空白不自动关闭
                buttons: [
                    {
                        name: '确定',
                        callback: function (dialog) {
                            if (pushgroupSelect($scope))
                                dialog.hide();
                        }
                    }
                ],
                afterLoad: function () {
                    groupSelectGridInit($compile, $scope);
                    //validate();//调用校验
                }
            });
            //可以通过返回的dialog对象调用相关方法
            dialog.setBody(getServer() + '/static/app/collection/classics/periodical/views/groupSelect.html');
            dialog.show();
        };
        return result;
    }
);