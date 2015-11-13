# 更改字典管理的菜单展示url
update pd_web_menu m set m.menu_url ='static/core/system/dict/views/dictFrame.html' WHERE m.menu_router =  'dict' AND m.menu_ctrl =  'coreDictCtrl';

#组织机构数据库兼容部门级别列名调整
ALTER TABLE org_dept CHANGE COLUMN level dept_level VARCHAR(20) COMMENT '部门级别';
# 字典管理添加列
alter table pd_web_dictionary add column dict_type varchar(6) NOT NULL;
# 调度器任务数据表更改
alter table sword_scheduler_job_status rename to sword_scheduler_running_info;
alter table sword_scheduler_job_log rename to sword_scheduler_log;
alter table sword_scheduler_job rename to sword_scheduler;
alter table sword_scheduler add column job_status varchar(16) DEFAULT NULL COMMENT '任务状态';

alter table monitor_collection_global_setting add column uuid varchar(32) NOT NULL;
alter table monitor_collection_global_setting drop column name;
alter table monitor_collection_global_setting add primary key (uuid);

alter table monitor_alarm_way_totarget rename to monitor_alarm_target;
alter table monitor_alarm_target add column alarm_way_uuid varchar(32) NOT NULL;
alter table monitor_alarm_target drop column wayuuid;