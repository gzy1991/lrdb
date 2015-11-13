#组织机构新增
alter   table   org_user   add   direct_leader   VARCHAR(32);
drop table if exists org_log;

/*==============================================================*/
/* Table: org_log                                               */
/*==============================================================*/
create table org_log
(
   uuid                 varchar(32) not null comment 'UUID',
   create_date          varchar(30) comment '创建时间',
   user_uuid            varchar(32) comment '创建人Uuid',
   operate_info         varchar(30) comment '操作信息',
   log_info             text comment '日志信息',
   primary key (uuid)
);

alter table org_log comment '组织日志';

#页面定制新增
drop table if exists pd_web_pageinfo;

/*==============================================================*/
/* Table: pd_web_pageinfo                                       */
/*==============================================================*/
create table pd_web_pageinfo
(
   uuid                 varchar(50) not null comment '主键',
   system_name          varchar(100) comment '系统名称',
   login_bg_url         varchar(500) comment '登录页面背景图地址',
   home_logo_url        varchar(500) comment '首页logo地址',
   primary key (uuid)
);

alter table pd_web_pageinfo comment '页面定制参数';

#资源权限新增
alter   table   acl_res   add   res_order   int;

