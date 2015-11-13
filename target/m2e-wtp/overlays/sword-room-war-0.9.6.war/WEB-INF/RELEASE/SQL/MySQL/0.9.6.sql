#字典管理更新菜单
-- set @dictDirId =replace(uuid(), '-', '') 

#删除旧的
delete from pd_web_menu where menu_router ='dictService' and menu_ctrl ='exam_dictMgrService' ;

#添加分类目录
insert into pd_web_menu(menu_id,menu_name,menu_type,menu_pid,menu_order)  
values('71678a4a814d11e5b4be8c89a522e1b2','字典管理',1,'b9b1bb999e434b65a3a989980d4a056c',0);
commit;
#插入两个菜单页
insert into pd_web_menu(menu_id,menu_name,menu_type,menu_pid,menu_order,menu_desc,menu_url,menu_open,menu_router,menu_ctrl,menu_ctrl_url)  
values('58f2c451814e11e5b4be8c89a522e1b2','Service说明',2,'71678a4a814d11e5b4be8c89a522e1b2',0,'字典管理前端Service说明','static/core/examples/develop/dict/views/ServiceResume.html',1,'exam_DictServiceResume','exDictSampleCtrl','static/core/examples/develop/dict/dictCtrl');

insert into pd_web_menu(menu_id,menu_name,menu_type,menu_pid,menu_order,menu_desc,menu_url,menu_open,menu_router,menu_ctrl,menu_ctrl_url)  
values('58f85376814e11e5b4be8c89a522e1b2','DictAPI说明',2,'71678a4a814d11e5b4be8c89a522e1b2',0,'字典管理后端API说明','static/core/examples/develop/dict/views/DictAPI.html',1,'exam_DictAPIResume','exDictSampleCtrl','static/core/examples/develop/dict/dictCtrl');

#  字典管理sql 结束

# 调度器任务数据表更改，去掉时间字段默认值
DROP TABLE IF EXISTS `sword_scheduler_log`;
CREATE TABLE `sword_scheduler_log` (
  `uuid` varchar(32) NOT NULL,
  `job_id` varchar(32) NOT NULL COMMENT '任务的标示',
  `job_status` varchar(32) DEFAULT NULL COMMENT '任务的状态',
  `create_time` timestamp  COMMENT '创建时间',
  `message` varchar(500) DEFAULT NULL COMMENT '消息',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `sword_scheduler_running_info`;
CREATE TABLE `sword_scheduler_running_info` (
  `job_id` varchar(32) NOT NULL COMMENT '任务的标示',
  `execute_counts` int(11) NOT NULL COMMENT '执行总次数',
  `finished_time` timestamp NULL DEFAULT NULL COMMENT '任务结束时间',
  `completed_success_counts` int(11) DEFAULT NULL COMMENT '执行成功次数',
  `completed_failure_counts` int(11) DEFAULT NULL COMMENT '执行失败次数',
  `first_execute_time` timestamp  COMMENT '第一次执行时间',
  `last_execute_time` timestamp COMMENT '最后一次执行时间',
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
# 调度器任务数据表更改sql 结束

# ---------------------------开发样例下的菜单调整--------------------------
# 删除开发样例中的ntkoOffice菜单
delete from pd_web_menu where menu_router ='ntkoOffice' and menu_ctrl ='ntkoOfficeCtrl';
# 去掉实验室菜单目录下的DOM元素托管菜单
delete from pd_web_menu where menu_router ='floatTouch' and menu_ctrl ='exFloatTouchCtrl';
# 删除实验室菜单分类
delete from pd_web_menu where menu_name ='实验室' or menu_id='a940051720114014be1e5d936e73f7a8';
# 把网页播放器菜单放到第三方组件下
UPDATE pd_web_menu SET menu_pid = 'bd517830fd3e45fa80b641879d035986',menu_order='20' WHERE menu_name = '网页播放器' ;
# 删除uploaderAndGrid菜单
delete from pd_web_menu where menu_name ='uploaderAndGrid' or menu_ctrl='ep_uploaderAndGrid';
# 删除搜索面板菜单
delete from pd_web_menu where menu_name ='搜索面板' or menu_ctrl='searchPanel';