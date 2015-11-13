# 数据字典表修改列名
ALTER TABLE pd_web_dictionary CHANGE COLUMN comment remarks varchar(200);

# 快捷菜单功能
DROP TABLE IF EXISTS `pd_web_shortcut`;
CREATE TABLE `pd_web_shortcut` (
  `shortcut_id` varchar(50) NOT NULL COMMENT '主键',
  `shortcut_user_id` varchar(50) DEFAULT NULL COMMENT '用户id',
  `shortcut_menu_id` varchar(50) DEFAULT NULL COMMENT '菜单id',
  `shortcut_order` int(11) DEFAULT NULL COMMENT '排序索引',
  PRIMARY KEY (`shortcut_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='快捷方式表（用户快捷菜单表）';

#增加监控的五张数据表
#增加监控告警信息设置表
CREATE TABLE `monitor_alarm_setting` (
  `itemname` varchar(50) NOT NULL,
  `operator` varchar(20) DEFAULT NULL,
  `threshold` double DEFAULT NULL,
  `enable` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`itemname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#增加监控告警方式数据表
CREATE TABLE `monitor_alarm_way` (
  `itemname` varchar(50) NOT NULL,
  `way` varchar(30) DEFAULT NULL,
  `uuid` varchar(32) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='alarm ways table';

#增加监控告警方式对应的目标数据表
CREATE TABLE `monitor_alarm_way_totarget` (
  `uuid` varchar(32) NOT NULL,
  `target` varchar(50) DEFAULT NULL,
  `wayuuid` varchar(32) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#增加监控采集全局开关和频率数据表
CREATE TABLE `monitor_collection_global_setting` (
  `name` varchar(50) NOT NULL,
  `freq` int(11) DEFAULT NULL,
  `enable` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#增加监控采集设置菜单信息
INSERT INTO `pd_web_menu` VALUES ('5afd7e818bf345448cb6a7eb5fa13b44','监控采集设置','2','9217f4e385aa4845aef9533c78353af6',4,NULL,'配置监控采集指标参数','static/core/systemMonitor/collectionConfig/views/collectionConfig.html','1','collectionConfig','collectionConfigCtrl','static/core/systemMonitor/collectionConfig/collectionConfigCtrl',NULL);

#增加告警日志监控菜单信息
INSERT INTO `pd_web_menu` VALUES ('78509ecfb3134f8f939be3c6e73ad366','告警日志监控','2','9217f4e385aa4845aef9533c78353af6',0,NULL,NULL,'static/core/systemMonitor/alarmLogMonitor/views/alarmLogMonitor.html','1','alarmLogMonitor','alarmLogMonitorCtrl','static/core/systemMonitor/alarmLogMonitor/alarmLogMonitorCtrl',NULL);

#增加监控采集指标设置数据表
CREATE TABLE `monitor_collection_setting` (
  `name` varchar(50) NOT NULL,
  `freq` int(11) DEFAULT NULL,
  `enable` varchar(1) NOT NULL,
  `schedule_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#调度器任务数据表
CREATE TABLE `sword_scheduler_job` (
  `job_id` varchar(32) NOT NULL COMMENT '任务的标示',
  `job_name` varchar(50) DEFAULT NULL COMMENT '任务的名字',
  `group_name` varchar(50) DEFAULT NULL COMMENT '组的名字',
  `description` varchar(200) DEFAULT NULL COMMENT '任务描述',
  `class_name` varchar(100) DEFAULT NULL COMMENT '任务的类名',
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户标示',
  `org_id` varchar(32) DEFAULT NULL COMMENT '机构标示',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#调度器任务日志数据表
#delimiter $$
CREATE TABLE `sword_scheduler_job_log` (
  `uuid` varchar(32) NOT NULL,
  `job_id` varchar(32) NOT NULL COMMENT '任务的标示',
  `job_status` varchar(32) DEFAULT NULL COMMENT '任务的状态',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `message` varchar(500) DEFAULT NULL COMMENT '消息',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
#) ENGINE=InnoDB DEFAULT CHARSET=utf8$$

#调度器任务状态数据表
CREATE TABLE `sword_scheduler_job_status` (
  `job_id` varchar(32) NOT NULL COMMENT '任务的标示',
  `execute_counts` int(11) NOT NULL COMMENT '执行总次数',
  `finished_time` timestamp NULL DEFAULT NULL COMMENT '任务结束时间',
  `completed_success_counts` int(11) DEFAULT NULL COMMENT '执行成功次数',
  `completed_failure_counts` int(11) DEFAULT NULL COMMENT '执行失败次数',
  `first_execute_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '第一次执行时间',
  `last_execute_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后一次执行时间',
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#调度器参数数据表
CREATE TABLE `sword_scheduler_params` (
  `param_id` varchar(32) NOT NULL COMMENT '参数的标示',
  `job_id` varchar(32) DEFAULT NULL COMMENT '任务的标示',
  `param_key` varchar(32) DEFAULT NULL COMMENT '参数的属性',
  `param_value` varchar(64) DEFAULT NULL COMMENT '参数的值',
  `description` varchar(200) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`param_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
 
#触发器数据表
CREATE TABLE `sword_scheduler_trigger` (
  `job_id` varchar(32) NOT NULL COMMENT '任务的标示',
  `start_effevtive_time` timestamp NULL DEFAULT NULL COMMENT '起始有效时间',
  `end_effevtive_time` timestamp NULL DEFAULT NULL COMMENT '终止有效时间',
  `description` varchar(200) DEFAULT NULL COMMENT '描述',
  `cron_expression` varchar(100) DEFAULT NULL COMMENT 'Cron表达式',
  `interval_time` int(11) DEFAULT NULL COMMENT '时间间隔',
  `interval_unit` char(1) DEFAULT NULL COMMENT '时间间隔单位',
  `repeat_count` int(11) DEFAULT NULL COMMENT '重复次数',
  `is_auto_resume` char(1) DEFAULT NULL COMMENT '宕机是否自动重启',
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

