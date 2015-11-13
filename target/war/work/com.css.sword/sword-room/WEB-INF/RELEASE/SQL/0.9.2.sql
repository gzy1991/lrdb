#组织机构相关
ALTER TABLE org_dept DROP manager;
ALTER TABLE org_dept DROP manager_code;
ALTER TABLE org_dept DROP leader;
ALTER TABLE org_dept DROP leader_code;
ALTER TABLE org_dept DROP deleted;
ALTER TABLE org_dept add leader_uuid VARCHAR(32);
#页面定制相关
ALTER TABLE pd_web_pageinfo add theme VARCHAR(50);
#菜单相关
ALTER TABLE pd_web_menu add menu_service VARCHAR(300);
INSERT INTO `pd_web_menu` VALUES ('1afd2ac483c6416bab290d7c80f5c733', '侧边栏', '2', '44d7a7d2f90c4f709cb39dcd0ade7bc2', '2', '', '侧边栏', 'static/core/examples/common.html', '1', 'slidebar', 'ep_slidebar', 'static/core/examples/util/slidebar/slidebarCtrl','');
INSERT INTO `pd_web_menu` VALUES ('1c84ac7b6ca34bfea808890938ac4022', '日志监控', '2', '9217f4e385aa4845aef9533c78353af6', '0', null, null, 'static/core/systemMonitor/logMonitor/views/logMonitor.html', '1', 'logMonitor', 'logMonitorCtrl', 'static/core/systemMonitor/logMonitor/logMonitorCtrl','');
INSERT INTO `pd_web_menu` VALUES ('3b4b5e5a3c004dac85ab922a370c1015', '查询设计器（建设中）', '2', '7240681d50174131964674bd0fa680d1', '1', null, '查询设计器', 'static/core/system/queryDesign/views/qdMgrCenter.html', '1', 'queryDesign', 'coreQueryDesign', 'static/core/system/queryDesign/queryDesignCtrl','');
INSERT INTO `pd_web_menu` VALUES ('5d346390ec6b4c1cb82a7edb2b0f716e', '页面定制', '2', '1599dd58952f4e41a113a570c35a5dc5', '8', null, null, 'static/core/system/pageInfo/views/index.html', '1', 'pageInfo', 'corePageInfoCtrl', 'static/core/system/pageInfo/pageInfoCtrl','');
INSERT INTO `pd_web_menu` VALUES ('69e52967fbc947e6a76f3a2298bdab3d', '性能监控', '2', '9217f4e385aa4845aef9533c78353af6', '0', null, null, null, '1', null, null, null,'');
INSERT INTO `pd_web_menu` VALUES ('7240681d50174131964674bd0fa680d1', '系统工具（建设中）', '1', '1599dd58952f4e41a113a570c35a5dc5', '4', null, null, null, null, null, null, null,'');
INSERT INTO `pd_web_menu` VALUES ('8123db55c8de4d0fb23e47e4c63628dc', 'menu菜单', '2', '44d7a7d2f90c4f709cb39dcd0ade7bc2', '3', '', 'menu菜单', 'static/core/examples/common.html', '1', 'menuComp', 'menuCompCtrl', 'static/core/examples/util/menu/menuCompCtrl','');
INSERT INTO `pd_web_menu` VALUES ('9217f4e385aa4845aef9533c78353af6', '系统监控', '1', 'root', '3', 'fa fa-bar-chart', null, null, null, null, null, null,'');
INSERT INTO `pd_web_menu` VALUES ('96cbdba35d654bd4905fcf6915a7d90f', '用户设置', '2', '1599dd58952f4e41a113a570c35a5dc5', '10', null, '用户设置', 'static/core/profile/views/profile.html', '1', 'profile', 'profileCtrl', 'static/core/profile/profileCtrl','');
INSERT INTO `pd_web_menu` VALUES ('9e2ecf2fcac149ee90110e224a158914', '服务器监控', '2', '9217f4e385aa4845aef9533c78353af6', '3', null, '监控服务器、OS、JVM信息', 'static/core/systemMonitor/serverMonitor/views/serverMonitor.html', '1', 'serverMonitor', 'serverMonitor', 'static/core/systemMonitor/serverMonitor/serverMonitorCtrl','');
INSERT INTO `pd_web_menu` VALUES ('a6f03a7edee0423a8a31a1b0ed1ebf20', 'ntkoOffice', '2', '44d7a7d2f90c4f709cb39dcd0ade7bc2', '0', null, null, 'static\\core\\examples\\util\\ntko\\views\\main.html', '1', 'ntkoOffice', 'ntkoOfficeCtrl', 'static\\core\\examples\\util\\ntko\\ntkoOfficeCtrl','');
INSERT INTO `pd_web_menu` VALUES ('a810f123344d446495e7526cb2343508', '网页播放器', '2', 'a940051720114014be1e5d936e73f7a8', '0', null, null, 'static/core/examples/common.html', '1', 'ckplayer', 'lab_ckplayer', 'static/core/examples/thirdParty/ckplayer/ckplayerCtrl','');
INSERT INTO `pd_web_menu` VALUES ('a940051720114014be1e5d936e73f7a8', '实验室', '1', '4cd840238ee94195b459811d8a5b9749', '5', null, null, null, null, null, null, null,'');
INSERT INTO `pd_web_menu` VALUES ('dd92a431a718435aa10e33f817bac82d', '持久层监控', '2', '9217f4e385aa4845aef9533c78353af6', '2', null, 'druid持久层监控', 'static/core/systemMonitor/dbMonitor/views/dbMonitor.html', '1', 'dbMonitor', 'dbMonitorCtrl', 'static/core/systemMonitor/dbMonitor/dbMonitorCtrl','');
INSERT INTO `pd_web_menu` VALUES ('e49e323ff4eb4ef9bb5ce3494449c344', 'API&CSS规范', '2', '8aa05930a7684a78a9116753cb2c6ffc', '0', null, null, 'static/core/examples/util/standard/view/doc.html', '1', 'standard', 'standardCtrl', 'static/core/examples/util/standard/ctrl','');
INSERT INTO `pd_web_menu` VALUES ('35c01d01ac0d44e282f43c798517bc2f', '缓存监控', '2', '9217f4e385aa4845aef9533c78353af6', '0', null, null, 'static/core/systemMonitor/cacheMonitor/views/cacheMonitor.html', '1', 'cacheMonitor', 'cacheMonitorCtrl', 'static/core/systemMonitor/cacheMonitor/cacheMonitorCtrl','');
INSERT INTO `pd_web_menu` VALUES ('d5f5b4c8eff34502a85d8b0f48516f88', 'Sword平台信息', '2', '9217f4e385aa4845aef9533c78353af6', '0', null, null, 'static/core/systemMonitor/serverInfo/views/serverInfo.html', '1', 'serverInfo', 'serverInfoCtrl', 'static/core/systemMonitor/serverInfo/serverInfoCtrl','');
#数据字典相关
INSERT INTO `pd_web_dictionary` VALUES ('2801aecbd9aa4ce3b0009499b89d4901', 'module_service', '模块依赖服务项', '', '模块加载时动态注入的服务项集合', '1', '0', 'ROOT', 'ROOT', '0', '', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-06 13:36:18', '', '');
INSERT INTO `pd_web_dictionary` VALUES ('31a6c32e67da4513856a0e03cbf7390b', 'route', '$route', '', '', '1', '1', '2801aecbd9aa4ce3b0009499b89d4901', '2801aecbd9aa4ce3b0009499b89d4901', '0', '', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-06 13:41:42', '', '');
INSERT INTO `pd_web_dictionary` VALUES ('587d563db1e54819864d2b8754c071c6', 'routeParams', '$routeParams', '', '', '1', '1', '2801aecbd9aa4ce3b0009499b89d4901', '2801aecbd9aa4ce3b0009499b89d4901', '0', '', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-06 13:41:59', '', '');
INSERT INTO `pd_web_dictionary` VALUES ('66c9df86cbab489187b47611113aadb7', 'compile', '$compile', '', '', '1', '1', '2801aecbd9aa4ce3b0009499b89d4901', '2801aecbd9aa4ce3b0009499b89d4901', '0', '', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-06 13:42:24', '', '');
INSERT INTO `pd_web_dictionary` VALUES ('84fb53bd8f2b4f7bb2eeb8a3bb4d3790', 'scope', '$scope', '', '', '1', '1', '2801aecbd9aa4ce3b0009499b89d4901', '2801aecbd9aa4ce3b0009499b89d4901', '0', '', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-06 13:38:45', '', '');
INSERT INTO `pd_web_dictionary` VALUES ('8700650fd17749fdb6817b11e60ad473', 'http', '$http', '', '', '1', '1', '2801aecbd9aa4ce3b0009499b89d4901', '2801aecbd9aa4ce3b0009499b89d4901', '0', '', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-06 13:37:09', '', '');