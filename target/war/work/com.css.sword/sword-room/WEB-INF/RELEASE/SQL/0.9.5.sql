# 字典管理添加列
alter table pd_web_dictionary add column dict_classification varchar(20) NOT NULL;
# 工作时间配置
DROP TABLE IF EXISTS `pd_wk_assign`;
CREATE TABLE `pd_wk_assign` (
  `id` varchar(50) NOT NULL COMMENT '主键',
  `assign_name` varchar(200) DEFAULT NULL COMMENT '名称备注',
  `assign_date` varchar(200) DEFAULT NULL COMMENT '包含日期',
  `assign_weekend` char(1) DEFAULT NULL COMMENT '是否是工作日',
  `assign_time` varchar(200) DEFAULT NULL COMMENT '工作时间（工作日）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='指定工作日的工作时间';

DROP TABLE IF EXISTS `pd_wk_assign_day`;
CREATE TABLE `pd_wk_assign_day` (
  `id` varchar(50) NOT NULL COMMENT '主键',
  `day_date` varchar(20) DEFAULT NULL COMMENT '日期',
  `day_weekend` char(1) DEFAULT NULL COMMENT '是否工作日',
  `day_time` varchar(200) DEFAULT NULL COMMENT '工作时间（工作日）',
  `assign_id` varchar(50) DEFAULT NULL COMMENT '所属主表id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='指定工作日的工作时间子表（每一天的工作时间）';

DROP TABLE IF EXISTS `pd_wk_holiday`;
CREATE TABLE `pd_wk_holiday` (
  `id` varchar(50) NOT NULL COMMENT '主键',
  `holiday_name` varchar(200) DEFAULT NULL COMMENT '名称',
  `holiday_date` varchar(200) DEFAULT NULL COMMENT '包含日期',
  `holiday_year` varchar(10) DEFAULT NULL COMMENT '所属年份',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='节假日配置表';

DROP TABLE IF EXISTS `pd_wk_holiday_day`;
CREATE TABLE `pd_wk_holiday_day` (
  `id` varchar(50) NOT NULL COMMENT '主键',
  `day_date` varchar(20) DEFAULT NULL COMMENT '日期',
  `holiday_id` varchar(50) DEFAULT NULL COMMENT '所属主表id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='节假日子表（每一天）';

DROP TABLE IF EXISTS `pd_wk_weekend`;
CREATE TABLE `pd_wk_weekend` (
  `id` varchar(50) NOT NULL COMMENT '主键',
  `weekend` varchar(20) DEFAULT NULL COMMENT '休息日',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='休息日、周末配置表';

DROP TABLE IF EXISTS `pd_wk_workhour`;
CREATE TABLE `pd_wk_workhour` (
  `id` varchar(50) NOT NULL COMMENT '主键',
  `begin_time` varchar(20) DEFAULT NULL COMMENT '开始时间',
  `end_time` varchar(20) DEFAULT NULL COMMENT '结束时间',
  `timezone` varchar(50) DEFAULT NULL COMMENT '所属地区、时区',
  `month` varchar(10) DEFAULT NULL COMMENT '所属月份',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作时间配置表';

# 菜单相关
INSERT INTO `pd_web_menu` VALUES ('e5b04d0b23364311b069e496c575ff8f', '登录日志', '2', '1599dd58952f4e41a113a570c35a5dc5', '105', '', '', 'static/core/system/loginLog/views/index.html', '1', 'loginlog', 'loginLogCtrl', 'static/core/system/loginLog/loginLogCtrl', '');
INSERT INTO `pd_web_menu` VALUES ('261f3fed9bed4d539ebaff7dcf7b389d', '工作时间配置', '2', '1599dd58952f4e41a113a570c35a5dc5', '12', '', '', 'static/core/system/worktime/views/index.html', '1', 'worktime', 'coreWorktime', 'static/core/system/worktime/worktimeCtrl', '');

# 附件上传相关
DROP TABLE IF EXISTS `pd_web_fileupload`;
CREATE TABLE `pd_web_fileupload` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `file_name` varchar(200) DEFAULT NULL COMMENT '附件名称',
  `file_suffix` varchar(6) DEFAULT NULL COMMENT '附件后缀',
  `file_size` varchar(20) DEFAULT NULL COMMENT '附件大小',
  `file_path` varchar(200) DEFAULT NULL COMMENT '物理路径',
  `completed` int(11) DEFAULT NULL COMMENT '是否上传完成',
  `uploader` varchar(50) DEFAULT NULL COMMENT '上传人',
  `upload_time` varchar(25) DEFAULT NULL COMMENT '上传时间',
  `auth_info` text COMMENT '权限信息',
  `reference_num` int(11) DEFAULT NULL COMMENT '引用数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='附件上传';

DROP TABLE IF EXISTS `pd_web_fileupload_chunk`;
CREATE TABLE `pd_web_fileupload_chunk` (
  `id` varchar(32) NOT NULL,
  `md5` varchar(32) DEFAULT NULL COMMENT '文件MD5',
  `chunk` int(11) DEFAULT NULL COMMENT '分片',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='附件分片记录';

DROP TABLE IF EXISTS `pd_web_fileupload_config`;
CREATE TABLE `pd_web_fileupload_config` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `base_dir` varchar(200) NOT NULL COMMENT '附件根目录',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='附件配置';



