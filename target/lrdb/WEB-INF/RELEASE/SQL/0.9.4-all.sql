/*
Navicat MySQL Data Transfer

Source Server         : 10.12.10.146
Source Server Version : 50509
Source Host           : 10.12.10.146:3306
Source Database       : sword-room

Target Server Type    : MYSQL
Target Server Version : 50509
File Encoding         : 65001

Date: 2015-09-23 10:59:44
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `acl_res`
-- ----------------------------
DROP TABLE IF EXISTS `acl_res`;
CREATE TABLE `acl_res` (
  `res_id` varchar(50) NOT NULL COMMENT '资源标识',
  `res_name` varchar(100) DEFAULT NULL COMMENT '资源名称',
  `res_type` varchar(1) DEFAULT NULL COMMENT '资源类型',
  `res_url` varchar(100) DEFAULT NULL COMMENT '资源地址',
  `res_pid` varchar(50) DEFAULT NULL COMMENT '上级资源',
  `res_order` int(11) DEFAULT NULL COMMENT '资源排序索引',
  `res_desc` varchar(300) DEFAULT NULL COMMENT '资源描述',
  `is_referer` int(11) DEFAULT NULL COMMENT '是否进行referer验证',
  `is_token` int(11) DEFAULT NULL COMMENT '是否进行token验证',
  `is_enable` int(11) DEFAULT NULL COMMENT '是否可用',
  `is_csrf_enable` int(11) DEFAULT NULL COMMENT 'csrf验证是否可用',
  `match_type` varchar(1) DEFAULT NULL COMMENT '验证类型',
  PRIMARY KEY (`res_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源功能URL';

-- ----------------------------
-- Records of acl_res
-- ----------------------------
INSERT INTO `acl_res` VALUES ('44beaf10d09e4c3b93435fbb6b376b1c', '根目录', '1', null, null, '1', '根目录', null, null, null, null, null);

-- ----------------------------
-- Table structure for `acl_res_auth`
-- ----------------------------
DROP TABLE IF EXISTS `acl_res_auth`;
CREATE TABLE `acl_res_auth` (
  `uuid` varchar(50) NOT NULL COMMENT 'uuid',
  `res_id` varchar(50) DEFAULT NULL COMMENT '资源标识',
  `user_id` varchar(50) DEFAULT NULL COMMENT '用户标识',
  `user_type` varchar(20) DEFAULT NULL COMMENT '用户类型',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户-资源';

-- ----------------------------
-- Records of acl_res_auth
-- ----------------------------

-- ----------------------------
-- Table structure for `monitor_alarm_setting`
-- ----------------------------
DROP TABLE IF EXISTS `monitor_alarm_setting`;
CREATE TABLE `monitor_alarm_setting` (
  `itemname` varchar(50) NOT NULL,
  `operator` varchar(20) DEFAULT NULL,
  `threshold` double DEFAULT NULL,
  `enable` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`itemname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of monitor_alarm_setting
-- ----------------------------
INSERT INTO `monitor_alarm_setting` VALUES ('BUSYWEBTHREADS', 'BIG', '100', 'N');
INSERT INTO `monitor_alarm_setting` VALUES ('CPUSYSTEMRATIO', 'BIG', '100', 'N');
INSERT INTO `monitor_alarm_setting` VALUES ('CURRENTWEBTHREADS', 'BIG', '100', 'N');
INSERT INTO `monitor_alarm_setting` VALUES ('HTTPERRORCOUNT', 'BIG', '100', 'N');
INSERT INTO `monitor_alarm_setting` VALUES ('MEMAVALIABLE', 'BIG', '20', 'Y');
INSERT INTO `monitor_alarm_setting` VALUES ('PERSISTENCECONNECTCOUNT', 'BIG', '100', 'N');
INSERT INTO `monitor_alarm_setting` VALUES ('SECONDCACHE', 'BIG', '100', 'N');

-- ----------------------------
-- Table structure for `monitor_alarm_target`
-- ----------------------------
DROP TABLE IF EXISTS `monitor_alarm_target`;
CREATE TABLE `monitor_alarm_target` (
  `uuid` varchar(32) NOT NULL,
  `target` varchar(50) DEFAULT NULL,
  `alarm_way_uuid` varchar(32) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of monitor_alarm_target
-- ----------------------------

-- ----------------------------
-- Table structure for `monitor_alarm_way`
-- ----------------------------
DROP TABLE IF EXISTS `monitor_alarm_way`;
CREATE TABLE `monitor_alarm_way` (
  `itemname` varchar(50) NOT NULL,
  `way` varchar(30) DEFAULT NULL,
  `uuid` varchar(32) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='alarm ways table';

-- ----------------------------
-- Records of monitor_alarm_way
-- ----------------------------
INSERT INTO `monitor_alarm_way` VALUES ('HTTPERRORCOUNT', 'LOG', '054b16751f08453db0e86ca667ab1139');
INSERT INTO `monitor_alarm_way` VALUES ('SECONDCACHE', 'LOG', '07bfd69c079146fc9c1406d621a32e46');
INSERT INTO `monitor_alarm_way` VALUES ('PERSISTENCECONNECTCOUNT', 'LOG', '08f4ab5c0a814700974b25d5988b4269');
INSERT INTO `monitor_alarm_way` VALUES ('MEMAVALIABLE', 'LOG', '0fb2c362464c489d8bb9d00133a7db83');
INSERT INTO `monitor_alarm_way` VALUES ('BUSYWEBTHREADS', 'LOG', '794ccd0766d64abcb0574138b5da6802');
INSERT INTO `monitor_alarm_way` VALUES ('CPUSYSTEMRATIO', 'LOG', '8893c5d10b8a40ceaaf142dc41d95387');
INSERT INTO `monitor_alarm_way` VALUES ('CURRENTWEBTHREADS', 'LOG', 'e01d0130d2ec4ee387a1720b1d8b7779');

-- ----------------------------
-- Table structure for `monitor_collection_global_setting`
-- ----------------------------
DROP TABLE IF EXISTS `monitor_collection_global_setting`;
CREATE TABLE `monitor_collection_global_setting` (
  `freq` int(11) DEFAULT NULL,
  `enable` varchar(1) DEFAULT NULL,
  `uuid` varchar(32) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of monitor_collection_global_setting
-- ----------------------------
INSERT INTO `monitor_collection_global_setting` VALUES ('60', 'Y', 'f174503ae19c43a783dfd76c391a7437');

-- ----------------------------
-- Table structure for `monitor_collection_setting`
-- ----------------------------
DROP TABLE IF EXISTS `monitor_collection_setting`;
CREATE TABLE `monitor_collection_setting` (
  `name` varchar(50) NOT NULL,
  `freq` int(11) DEFAULT NULL,
  `enable` varchar(1) NOT NULL,
  `schedule_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of monitor_collection_setting
-- ----------------------------
INSERT INTO `monitor_collection_setting` VALUES ('BUSYWEBTHREADS', '60', 'N', null);
INSERT INTO `monitor_collection_setting` VALUES ('CPUSYSTEMRATIO', '60', 'N', null);
INSERT INTO `monitor_collection_setting` VALUES ('CURRENTWEBTHREADS', '60', 'N', null);
INSERT INTO `monitor_collection_setting` VALUES ('HTTPERRORCOUNT', '60', 'N', null);
INSERT INTO `monitor_collection_setting` VALUES ('MEMAVALIABLE', '30', 'Y', 'ee001bd495fc40c0908ab98f26187939');
INSERT INTO `monitor_collection_setting` VALUES ('PERSISTENCECONNECTCOUNT', '60', 'N', null);
INSERT INTO `monitor_collection_setting` VALUES ('SECONDCACHE', '60', 'N', null);

-- ----------------------------
-- Table structure for `org_certification`
-- ----------------------------
DROP TABLE IF EXISTS `org_certification`;
CREATE TABLE `org_certification` (
  `user_uuid` varchar(32) NOT NULL COMMENT '用户UUID',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `salt` varchar(32) DEFAULT NULL COMMENT '盐',
  `locked` int(11) DEFAULT NULL COMMENT '是否冻结',
  `login_fail_num` int(11) DEFAULT NULL COMMENT '登录失败次数',
  `login_fail_time` varchar(20) DEFAULT NULL COMMENT '登录失败时间',
  PRIMARY KEY (`user_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人员认证信息表';

-- ----------------------------
-- Records of org_certification
-- ----------------------------
INSERT INTO `org_certification` VALUES ('0e218205a8f641a8988e742e81014568', '$s0$e0801$vkAfRwsdsWTsmeNOL5049g==$Msfoevb/PUcyAsSbn8opytUeo85WvoZpXpqzGWlH9sM=', 'ced5a9aab6d54e079190afd4b2dc05f7', '1', '0', null);
INSERT INTO `org_certification` VALUES ('163c9782458a4474b3de382e39a7097f', '$s0$e0801$X1lHdVgXJdQl+UYfbTNfcw==$CE5zP0KUNU+I+Lax5ZxU2fpQNsU2esNZzqtx0smEZeE=', '3823bc2f086243cc8c45d9c1d896958e', '0', '0', null);
INSERT INTO `org_certification` VALUES ('3e300967a5d246448d1aced717e38401', '$s0$e0801$e4q+8ult8tZYh1G5Vf5BUw==$6BT/QwMYASvVKSPmuHRGEDCHsNbBdyeROc0miieebbk=', 'babf4129b5f54e1cb500cdec3c2680e6', '0', '0', null);
INSERT INTO `org_certification` VALUES ('3e33b50047394b9bafe115528f6843a8', '$s0$e0801$3FTbOhavz6OCCrY1DIqK+A==$6BDNAY+Ra/1oLmE90lPR3mpNusyrib6GywND0cyKJXM=', '69bafbb877db4be18cffc6a252057bfa', '0', '0', null);
INSERT INTO `org_certification` VALUES ('4a49bfa606a54683aa99195cf93478d0', '$s0$e0801$dXQW1oGjNgDMeQbdME596A==$sN0ukh7wjzHkUQMGhqDOJUydfZ1TAYOAO06b7G4zUHc=', '8003ad47d9b44592a3fc55a91b1e70b9', '0', '0', null);
INSERT INTO `org_certification` VALUES ('4ba31363fef14039ac43899ddd8acbc2', '$s0$e0801$rcnZWwJD/dZ4P0kkitpB5g==$EeFlzfQvZkguuaTAZjmQEe7AMMO/OnLOS5JSAA7J3go=', '0f9d0518b3e5467f8d5db7beb02235c0', '0', '0', null);
INSERT INTO `org_certification` VALUES ('7dc1d65135c946a9ae17406bb209f320', '$s0$e0801$BYQrFwnTdz/Me0LpOAK98Q==$SNPuG+TVTuVhgEaBu794FV3Bz7Y68sxszoRDZnNBA3c=', '3bb49a09757f49fe83b1ba5e112a15a6', '0', '0', null);
INSERT INTO `org_certification` VALUES ('7ea28ba1d55b4614ae6945705faf9c59', '$s0$e0801$It7Qzv75sYzTshCCfBxLfQ==$XYhxuIFRzX1nCxkiJZA+SuDfFItRYTZ9m1deQA9Cl+U=', '5307780f1a4d4f65bfa272dc535367bd', '0', '0', null);
INSERT INTO `org_certification` VALUES ('8b9b52afb852480c9eb226ec0b283649', '$s0$e0801$aG+TWGGIDP7Y2KXFmPvNfw==$0FlfIOq7EvV3rKz4/duNwipwHjm3m7IsekDC3U5EGfo=', '0d3a4ad5708f478785e23818af0994f9', '0', '0', null);
INSERT INTO `org_certification` VALUES ('8c8aced6d7d04a0489655e9a1ae73897', '$s0$e0801$KI1f2rbVhTxR7jcptagHcg==$rNt6GOY98WgrIdG7pKENNL4gGsHUAbB8pfNW2KvqMRw=', '47a2173811874ecb9a4b09cd7ad5d5e0', '0', '0', null);
INSERT INTO `org_certification` VALUES ('a85cd658f19e4bc6b9c0e4f52824074a', '$s0$e0801$f/mWo54fnJl0RGJ1wLBCLA==$/TF1RjXTDu+pvZAXqSy42AqQ1gO7QTH7dIBWfoGSrA0=', 'c677fa512feb4a0fbc3381d02720e023', '0', '0', null);
INSERT INTO `org_certification` VALUES ('aed20805ca6f45369a3f374b9148878b', '$s0$e0801$ycSHr0xSo8W9Zi8ibyXFOA==$EO5bjjLLRX5ZeAtuuAGXVAIp6FdcwwGuEM9uZVkKUk8=', '6100770f738f485aaade383ef59af25b', '0', '0', null);
INSERT INTO `org_certification` VALUES ('b306c6de523b41719c7bbff2b5fa6469', '$s0$e0801$7v9hkCgbaV5Rxbt168AHrg==$uH9dCFLGY8YboIqt5KDByRC1KKfdla8gbzldLapG+64=', 'e4999d672c1c4929bce45b677f2004f3', '0', '0', null);
INSERT INTO `org_certification` VALUES ('bebbdc094b844c22aa2980bab5a3f20b', '$s0$e0801$5zf7wm822cfL8GKJpP9N/Q==$5NBCXMRsMIajCfLuerYOeOqrUH2P/W4Rejd8HixsZu8=', '171e5bcc34004e4b91cfdf46e14e18f1', '0', '0', null);
INSERT INTO `org_certification` VALUES ('c7f9c97235114cc29cbe10ce36d9587e', '$s0$e0801$wgBbqIpCbgdIepkzWWZBAA==$ECjBjfZz9MMykCEzNtvLCM7LlIc911NAdmMb9OW+nFg=', '4ccbb45029a6426787e4081040633288', '0', '0', null);
INSERT INTO `org_certification` VALUES ('c8216f7edc984f8bbba83de3abe128ce', '$s0$e0801$6yfstOFrg62ZsGAFZ8txow==$qV28VSfq2CvBAy66I6Vh3eGj3k+EYgvSyoqeKAyVtrM=', 'e7fe2868c99d4987843a0e93cfd8eda9', '0', '0', null);
INSERT INTO `org_certification` VALUES ('c8f1ba6c7cf842409aba43206e9f7442', '$s0$e0801$77jrffrqKY5/YbaxXCY32g==$UA4kWJWMx+kwVVYQ013YVq7H4oIfEqMrqtT/WmF31cM=', 'a18721153de246dfb9726864e327c473', '0', '0', '2015-09-23 10:58:03');
INSERT INTO `org_certification` VALUES ('da31f25604fc4cf78404b3ca5f91482d', '$s0$e0801$iRiI/QPEH6HsaBOqUrc7jA==$vBTn8M8c2lO9XVEPpzEzaEiCUnFkvtY6GGUfI097DBg=', '031d3d3fb35d48a080af9d889a6ebdb9', '0', '0', null);
INSERT INTO `org_certification` VALUES ('e2669af5f55b459985d3e836aaa72cb2', '$s0$e0801$wAxIguvsCewRi1dQX//ZPQ==$HFoQhRfxpaTKPpJAPGiOhlo0wFgOPn0VJ5xcasoWZBY=', '851926b552994b0b9175c6db2b7f7742', '0', '0', null);
INSERT INTO `org_certification` VALUES ('e9109979b8eb4ac89709ea6fe3097416', '$s0$e0801$k6CkPN8Z+5mhSQdotKuSBQ==$AnQFTTlRKoTjcl9nEckdHslF3lHqySkvpoKd4wFTnBE=', '61eb9828185d42678a68606287aa314b', '0', '0', null);
INSERT INTO `org_certification` VALUES ('fa25703db8874956be2dc5de9e6e29d8', '$s0$e0801$AYdHxTe6UR4EJjmVoEiu0Q==$hGz7/Gruddeca+Vd0f2sXlXBk4VNmQ9TbEz08OQ7BgU=', '0d7b033f95944b69a93cd40481beb82e', '0', '0', null);

-- ----------------------------
-- Table structure for `org_config`
-- ----------------------------
DROP TABLE IF EXISTS `org_config`;
CREATE TABLE `org_config` (
  `uuid` char(32) NOT NULL COMMENT 'UUID',
  `def_password` varchar(20) DEFAULT NULL COMMENT '默认密码',
  `dept_extend_config` text COMMENT '部门扩展字段配置',
  `person_extend_config` text COMMENT '人员扩展字段配置',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组织配置';

-- ----------------------------
-- Records of org_config
-- ----------------------------
INSERT INTO `org_config` VALUES ('dd2be9ec6363452ca6cda4187ce952e5', '111111', null, null);

-- ----------------------------
-- Table structure for `org_dept`
-- ----------------------------
DROP TABLE IF EXISTS `org_dept`;
CREATE TABLE `org_dept` (
  `dept_uuid` varchar(32) NOT NULL COMMENT '部门UUID',
  `dept_code` varchar(20) DEFAULT NULL COMMENT '部门编号',
  `dept_name` varchar(100) DEFAULT NULL COMMENT '部门名称',
  `leader_uuid` varchar(32) DEFAULT NULL COMMENT '部门领导UUID',
  `cost_center_code` varchar(32) DEFAULT NULL COMMENT '成本中心编号',
  `cost_center_name` varchar(100) DEFAULT NULL COMMENT '成本中心名称',
  `dept_level` varchar(20) DEFAULT NULL COMMENT '部门级别',
  `sort` int(11) DEFAULT '1000' COMMENT '显示序号',
  `dept_tree_id` varchar(32) DEFAULT NULL COMMENT '部门树ID',
  `p_dept_tree_id` varchar(32) DEFAULT NULL COMMENT '所属部门树ID',
  `ou` varchar(200) DEFAULT NULL COMMENT '部门OU',
  `ou_dept_uuid` varchar(250) DEFAULT NULL COMMENT 'ou_dept_uuid',
  `ou_dept_code` varchar(100) DEFAULT NULL COMMENT 'ou_dept_code',
  `ou_dept_tree_id` varchar(100) DEFAULT NULL COMMENT 'ou_dept_tree_id',
  `deleted` int(11) DEFAULT NULL COMMENT '删除标识',
  `extend1` varchar(50) DEFAULT NULL COMMENT 'extend1',
  `extend2` varchar(50) DEFAULT NULL COMMENT 'extend2',
  `extend3` varchar(50) DEFAULT NULL COMMENT 'extend3',
  `extend4` varchar(50) DEFAULT NULL COMMENT 'extend4',
  `extend5` varchar(50) DEFAULT NULL COMMENT 'extend5',
  `extend6` varchar(50) DEFAULT NULL COMMENT 'extend6',
  `extend7` varchar(50) DEFAULT NULL COMMENT 'extend7',
  `extend8` varchar(50) DEFAULT NULL COMMENT 'extend8',
  `extend9` varchar(50) DEFAULT NULL COMMENT 'extend9',
  `extend10` varchar(50) DEFAULT NULL COMMENT 'extend10',
  `extend11` varchar(50) DEFAULT NULL COMMENT 'extend11',
  `extend12` varchar(50) DEFAULT NULL COMMENT 'extend12',
  `extend13` varchar(50) DEFAULT NULL COMMENT 'extend13',
  `extend14` varchar(50) DEFAULT NULL COMMENT 'extend14',
  `extend15` varchar(50) DEFAULT NULL COMMENT 'extend15',
  `extend16` varchar(50) DEFAULT NULL COMMENT 'extend16',
  `extend17` varchar(50) DEFAULT NULL COMMENT 'extend17',
  `extend18` varchar(50) DEFAULT NULL COMMENT 'extend18',
  `extend19` varchar(50) DEFAULT NULL COMMENT 'extend19',
  `extend20` varchar(50) DEFAULT NULL COMMENT 'extend20',
  PRIMARY KEY (`dept_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门表';

-- ----------------------------
-- Records of org_dept
-- ----------------------------
INSERT INTO `org_dept` VALUES ('06c62e1917cb4b3dac92f61da118c5c9', 'D006', '重庆分公司', null, 'C10006', '重庆分公司', '2', '7', 'D006', 'root', 'XX集团.重庆分公司', 'de4457db545b461bb359d3179adf50b4.06c62e1917cb4b3dac92f61da118c5c9', 'root.D006', 'root.D006', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_dept` VALUES ('07e069f4c74447c3977b42b95dad6595', 'D002001', '行政部', null, 'C10014', '行政部', '3', '15', 'D002001', 'D002', 'XX集团.北京分公司.行政部', 'de4457db545b461bb359d3179adf50b4.ff0a4c5b8e964ff5a6041d03761d3131.07e069f4c74447c3977b42b95dad6595', 'root.D002.D002001', 'root.D002.D002001', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_dept` VALUES ('2e6c3cd7f3df4ee79ce7f74cdcc5ed8c', 'D002002', '财务部', null, 'C10015', '财务部', '3', '16', 'D002002', 'D002', 'XX集团.北京分公司.财务部', 'de4457db545b461bb359d3179adf50b4.ff0a4c5b8e964ff5a6041d03761d3131.2e6c3cd7f3df4ee79ce7f74cdcc5ed8c', 'root.D002.D002002', 'root.D002.D002002', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_dept` VALUES ('3ad654244cbd4cc7bf2732b6d2bc03d7', 'D001005', '售后服务', null, 'C10013', '售后服务', '3', '14', 'D001005', 'D001', 'XX集团.集团总部.售后服务', 'de4457db545b461bb359d3179adf50b4.e263d55b902f463a8cf46917c89ee8dd.3ad654244cbd4cc7bf2732b6d2bc03d7', 'root.D001.D001005', 'root.D001.D001005', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_dept` VALUES ('44e1059013cd488c80b72a3a5204f4df', 'D005', '武汉分公司', null, 'C10005', '武汉分公司', '2', '6', 'D005', 'root', 'XX集团.武汉分公司', 'de4457db545b461bb359d3179adf50b4.44e1059013cd488c80b72a3a5204f4df', 'root.D005', 'root.D005', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_dept` VALUES ('595ff98e87c84d3fbbcab745ea4fd859', 'D001001', '行政部', null, 'C10009', '行政部', '3', '10', 'D001001', 'D001', 'XX集团.集团总部.行政部', 'de4457db545b461bb359d3179adf50b4.e263d55b902f463a8cf46917c89ee8dd.595ff98e87c84d3fbbcab745ea4fd859', 'root.D001.D001001', 'root.D001.D001001', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_dept` VALUES ('5ea1d1f4e84049c89c13155acd6dcacb', 'D003', '上海分公司', null, 'C10003', '上海分公司', '2', '5', 'D003', 'root', 'XX集团.上海分公司', 'de4457db545b461bb359d3179adf50b4.5ea1d1f4e84049c89c13155acd6dcacb', 'root.D003', 'root.D003', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_dept` VALUES ('78a69b6f23774f5bafc7a0499d6cdfeb', 'D004', '广州分公司', '', 'C10004', '广州分公司', '2', '5', 'D004', 'root', 'XX集团.广州分公司', 'de4457db545b461bb359d3179adf50b4.78a69b6f23774f5bafc7a0499d6cdfeb', 'root.D004', 'root.D004', '0', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `org_dept` VALUES ('b0a97425962543de9cea4530326807fe', 'D008', '西安分公司', null, 'C10008', '西安分公司', '2', '9', 'D008', 'root', 'XX集团.西安分公司', 'de4457db545b461bb359d3179adf50b4.b0a97425962543de9cea4530326807fe', 'root.D008', 'root.D008', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_dept` VALUES ('b9e479278d68472aa3bd9a0fb9772bed', 'D001004', '销售部', null, 'C10012', '销售部', '3', '13', 'D001004', 'D001', 'XX集团.集团总部.销售部', 'de4457db545b461bb359d3179adf50b4.e263d55b902f463a8cf46917c89ee8dd.b9e479278d68472aa3bd9a0fb9772bed', 'root.D001.D001004', 'root.D001.D001004', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_dept` VALUES ('c0629375eeb5461a91c789a305ce4e48', 'D001003', '产品研发', null, 'C10011', '产品研发', '3', '12', 'D001003', 'D001', 'XX集团.集团总部.产品研发', 'de4457db545b461bb359d3179adf50b4.e263d55b902f463a8cf46917c89ee8dd.c0629375eeb5461a91c789a305ce4e48', 'root.D001.D001003', 'root.D001.D001003', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_dept` VALUES ('d62767b8e0c04fbb8f974a0d4d3a3e33', 'D007', '深圳分公司', null, 'C10007', '深圳分公司', '2', '8', 'D007', 'root', 'XX集团.深圳分公司', 'de4457db545b461bb359d3179adf50b4.d62767b8e0c04fbb8f974a0d4d3a3e33', 'root.D007', 'root.D007', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_dept` VALUES ('dd9b5e1fedee448ab8ea3f341739131f', 'D002003', '销售部', null, 'C10016', '销售部', '3', '17', 'D002003', 'D002', 'XX集团.北京分公司.销售部', 'de4457db545b461bb359d3179adf50b4.ff0a4c5b8e964ff5a6041d03761d3131.dd9b5e1fedee448ab8ea3f341739131f', 'root.D002.D002003', 'root.D002.D002003', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_dept` VALUES ('de4457db545b461bb359d3179adf50b4', 'root', 'XX集团', null, '', '', '', '1', 'root', null, 'XX集团', 'de4457db545b461bb359d3179adf50b4', 'root', 'root', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_dept` VALUES ('e263d55b902f463a8cf46917c89ee8dd', 'D001', '集团总部', null, 'C10001', '集团总部', '2', '2', 'D001', 'root', 'XX集团.集团总部', 'de4457db545b461bb359d3179adf50b4.e263d55b902f463a8cf46917c89ee8dd', 'root.D001', 'root.D001', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_dept` VALUES ('e9d8a4db6df14250bd520bfca350fe34', 'D001002', '财务部', null, 'C10010', '财务部', '3', '11', 'D001002', 'D001', 'XX集团.集团总部.财务部', 'de4457db545b461bb359d3179adf50b4.e263d55b902f463a8cf46917c89ee8dd.e9d8a4db6df14250bd520bfca350fe34', 'root.D001.D001002', 'root.D001.D001002', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_dept` VALUES ('ff0a4c5b8e964ff5a6041d03761d3131', 'D002', '北京分公司', null, 'C10002', '北京分公司', '2', '4', 'D002', 'root', 'XX集团.北京分公司', 'de4457db545b461bb359d3179adf50b4.ff0a4c5b8e964ff5a6041d03761d3131', 'root.D002', 'root.D002', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for `org_dept_gw`
-- ----------------------------
DROP TABLE IF EXISTS `org_dept_gw`;
CREATE TABLE `org_dept_gw` (
  `uuid` char(32) NOT NULL COMMENT 'UUID',
  `dept_uuid` varchar(32) NOT NULL COMMENT '部门UUID',
  `gw_uuid` varchar(32) NOT NULL COMMENT '岗位UUID',
  `extend` int(11) DEFAULT '0' COMMENT '是否继承',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门-岗位表';

-- ----------------------------
-- Records of org_dept_gw
-- ----------------------------

-- ----------------------------
-- Table structure for `org_dept_gw_user`
-- ----------------------------
DROP TABLE IF EXISTS `org_dept_gw_user`;
CREATE TABLE `org_dept_gw_user` (
  `uuid` char(32) NOT NULL COMMENT 'UUID',
  `dept_uuid` varchar(32) DEFAULT NULL COMMENT '部门UUID',
  `gw_uuid` varchar(32) DEFAULT NULL COMMENT '岗位UUID',
  `user_uuid` varchar(32) DEFAULT NULL COMMENT '用户UUID',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门-岗位-人员表';

-- ----------------------------
-- Records of org_dept_gw_user
-- ----------------------------

-- ----------------------------
-- Table structure for `org_dept_user`
-- ----------------------------
DROP TABLE IF EXISTS `org_dept_user`;
CREATE TABLE `org_dept_user` (
  `uuid` char(32) NOT NULL COMMENT 'UUID',
  `dept_uuid` varchar(32) DEFAULT NULL COMMENT '部门UUID',
  `user_uuid` varchar(32) DEFAULT NULL COMMENT '用户UUID',
  `jz` int(11) DEFAULT '0' COMMENT '是否兼职',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门-人员';

-- ----------------------------
-- Records of org_dept_user
-- ----------------------------
INSERT INTO `org_dept_user` VALUES ('0676819994394663850a1c724f79009a', '5ea1d1f4e84049c89c13155acd6dcacb', '3e33b50047394b9bafe115528f6843a8', '-1');
INSERT INTO `org_dept_user` VALUES ('06fe76dd92b34a7db4428918cfe7ebfa', '5ea1d1f4e84049c89c13155acd6dcacb', '0e218205a8f641a8988e742e81014568', '-1');
INSERT INTO `org_dept_user` VALUES ('0f47008b4dcd4b3c80073205e7eaf599', '44e1059013cd488c80b72a3a5204f4df', 'aed20805ca6f45369a3f374b9148878b', '-1');
INSERT INTO `org_dept_user` VALUES ('13f9f5ee910c4da5b2cbf1897235cd71', '44e1059013cd488c80b72a3a5204f4df', '3e33b50047394b9bafe115528f6843a8', '1');
INSERT INTO `org_dept_user` VALUES ('190787bbb3c849978cf6d28fbd820594', '06c62e1917cb4b3dac92f61da118c5c9', 'c8216f7edc984f8bbba83de3abe128ce', '-1');
INSERT INTO `org_dept_user` VALUES ('19e2225f64564778aefbc1d036a84652', 'd62767b8e0c04fbb8f974a0d4d3a3e33', '4ba31363fef14039ac43899ddd8acbc2', '-1');
INSERT INTO `org_dept_user` VALUES ('1d5d111e75e24374b8e92f8c1216b08f', 'd62767b8e0c04fbb8f974a0d4d3a3e33', 'fa25703db8874956be2dc5de9e6e29d8', '-1');
INSERT INTO `org_dept_user` VALUES ('1da79d9b478142d384d2ba768aa60125', '44e1059013cd488c80b72a3a5204f4df', 'bebbdc094b844c22aa2980bab5a3f20b', '-1');
INSERT INTO `org_dept_user` VALUES ('3475f229c5e943869c869f084d1cb95e', '78a69b6f23774f5bafc7a0499d6cdfeb', '3e33b50047394b9bafe115528f6843a8', '1');
INSERT INTO `org_dept_user` VALUES ('39e25daa554942ba8031e3a12bdeffa7', 'b0a97425962543de9cea4530326807fe', 'da31f25604fc4cf78404b3ca5f91482d', '-1');
INSERT INTO `org_dept_user` VALUES ('5750e8c401b5453ea5e892cf426f553a', 'd62767b8e0c04fbb8f974a0d4d3a3e33', '8c8aced6d7d04a0489655e9a1ae73897', '-1');
INSERT INTO `org_dept_user` VALUES ('5c33caa176f949afb8becb655e4c0604', '44e1059013cd488c80b72a3a5204f4df', '3e300967a5d246448d1aced717e38401', '-1');
INSERT INTO `org_dept_user` VALUES ('7066fed32ae242ccbe324998f85e9aea', '78a69b6f23774f5bafc7a0499d6cdfeb', 'c7f9c97235114cc29cbe10ce36d9587e', '-1');
INSERT INTO `org_dept_user` VALUES ('766dac1b0c9547818c3f4d6f04bf884f', 'd62767b8e0c04fbb8f974a0d4d3a3e33', '4a49bfa606a54683aa99195cf93478d0', '-1');
INSERT INTO `org_dept_user` VALUES ('8f666157e53a435ba70bb5b951b6c586', 'd62767b8e0c04fbb8f974a0d4d3a3e33', '163c9782458a4474b3de382e39a7097f', '-1');
INSERT INTO `org_dept_user` VALUES ('a8d0a1da55a64ed6967c18ae8617e5da', '78a69b6f23774f5bafc7a0499d6cdfeb', 'e2669af5f55b459985d3e836aaa72cb2', '-1');
INSERT INTO `org_dept_user` VALUES ('ae34c1442c634b5e94c04f03b06b9092', '06c62e1917cb4b3dac92f61da118c5c9', '7dc1d65135c946a9ae17406bb209f320', '-1');
INSERT INTO `org_dept_user` VALUES ('bc1dabdef25d4f2882b75fb232f97db0', 'd62767b8e0c04fbb8f974a0d4d3a3e33', 'b306c6de523b41719c7bbff2b5fa6469', '-1');
INSERT INTO `org_dept_user` VALUES ('d230e2fcc20e428791b497ec19dc9c5a', '5ea1d1f4e84049c89c13155acd6dcacb', 'e9109979b8eb4ac89709ea6fe3097416', '-1');
INSERT INTO `org_dept_user` VALUES ('ea7f56a9796b4e52be033e81eba328fe', '5ea1d1f4e84049c89c13155acd6dcacb', '8b9b52afb852480c9eb226ec0b283649', '-1');
INSERT INTO `org_dept_user` VALUES ('ef1258c29bf842379c72e051bcd655c8', '06c62e1917cb4b3dac92f61da118c5c9', '7ea28ba1d55b4614ae6945705faf9c59', '-1');
INSERT INTO `org_dept_user` VALUES ('f0d38aba3ff74a1b8db2c62bb53ebf29', '44e1059013cd488c80b72a3a5204f4df', 'a85cd658f19e4bc6b9c0e4f52824074a', '-1');

-- ----------------------------
-- Table structure for `org_gw`
-- ----------------------------
DROP TABLE IF EXISTS `org_gw`;
CREATE TABLE `org_gw` (
  `gw_uuid` varchar(32) NOT NULL COMMENT '岗位UUID',
  `gw_code` varchar(32) DEFAULT NULL COMMENT '岗位编号',
  `gw_name` varchar(50) DEFAULT NULL COMMENT '岗位名称',
  `sort` int(11) DEFAULT '1000' COMMENT '显示序号',
  PRIMARY KEY (`gw_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='岗位表';

-- ----------------------------
-- Records of org_gw
-- ----------------------------
INSERT INTO `org_gw` VALUES ('024bc37c7859428d9bf1d6c8c0b06eb5', 'GW0015', '团委书记', '1000');
INSERT INTO `org_gw` VALUES ('06782de84d7b44cdafaa377ec8f8d171', 'GW0054', '办公室综合处', '1000');
INSERT INTO `org_gw` VALUES ('0a943deaeec348caaca49dc06bc51489', 'GW0047', '办公室主任', '1000');
INSERT INTO `org_gw` VALUES ('0b7daeee3e8246e5819c3be14481fa8c', 'GW0022', '部门主任', '1000');
INSERT INTO `org_gw` VALUES ('0ede86623bfd48918096305adc6a73f3', 'GW0053', '审计部负责人', '1000');
INSERT INTO `org_gw` VALUES ('13229a04fd5d4aaba2b89aa393033b6e', 'GW0068', '总监', '1000');
INSERT INTO `org_gw` VALUES ('1595feb7b2534d5d8e1e03a2c64b9f10', 'GW0005', '数据管理员', '1000');
INSERT INTO `org_gw` VALUES ('16e5ee5e3d6149abaf1279ad3f98bd1b', 'GW0042', '人事主管', '1000');
INSERT INTO `org_gw` VALUES ('17681dfdbb824144b50d225eff08843b', 'GW0025', '副处长', '1000');
INSERT INTO `org_gw` VALUES ('1990c17f10c745f9b116f81e2c55625b', 'GW0017', '出纳', '1000');
INSERT INTO `org_gw` VALUES ('1a6cb2c4009848e3b7f8a1a711805376', 'GW0041', '固资机关事务局经办人', '1000');
INSERT INTO `org_gw` VALUES ('30e7855c3e22452e8274fc51b9437889', 'GW0044', '办公室秘书处核稿人', '1000');
INSERT INTO `org_gw` VALUES ('363b662c6b074c8bb8c54a2320fa967e', 'GW0002', '分管副总监', '1000');
INSERT INTO `org_gw` VALUES ('3719f23ddfc14c33819b7dff1fe59bed', 'GW0021', '副总经理', '1000');
INSERT INTO `org_gw` VALUES ('42ad9d86b53b4cfd8322ddf87017c23e', 'GW0045', '办公室秘书处转呈人', '1000');
INSERT INTO `org_gw` VALUES ('443dd94e57754483b0b49c4d30438357', 'GW0057', '纪委书记', '1000');
INSERT INTO `org_gw` VALUES ('49960acdacdf4d438ae7b9124f359882', 'GW0010', '办公用品管理员', '1000');
INSERT INTO `org_gw` VALUES ('5034745b4f9a446dae2801f5bc328ab7', 'GW0003', '组长', '1000');
INSERT INTO `org_gw` VALUES ('50a153396bd744449e14be7f610e64a4', 'GW0034', '物业管理员', '1000');
INSERT INTO `org_gw` VALUES ('52f75988c4c74868ade55c9264d5c9e4', 'GW0033', '综合处处长', '1000');
INSERT INTO `org_gw` VALUES ('56799315b87b483d96cd4bdf4eb1c991', 'GW0036', '分管财务领导', '1000');
INSERT INTO `org_gw` VALUES ('598ef791818a4240ad5a1a976594d1bb', 'GW0038', '财务资金处负责人', '1000');
INSERT INTO `org_gw` VALUES ('5ebdba00f429485991d11a8acf86eae6', 'GW0027', '客服', '1000');
INSERT INTO `org_gw` VALUES ('67a20b0786ab4f9eaaaf632debcd1623', 'GW0066', '课长', '1000');
INSERT INTO `org_gw` VALUES ('695fc1e075874c99a957684a755b1156', 'GW0064', '预算专员', '1000');
INSERT INTO `org_gw` VALUES ('6e28c9e08547497f929c746693ea1a6d', 'GW0048', '党办主任', '1000');
INSERT INTO `org_gw` VALUES ('6e9d6b1394d04dec9df98717613c52ef', 'GW0055', '审计部领导', '1000');
INSERT INTO `org_gw` VALUES ('710a05de325e4c89a997037440d2aca8', 'GW0012', '名片管理员', '1000');
INSERT INTO `org_gw` VALUES ('726e6639a7384c1aaa799e20ee2ad202', 'GW0050', '法律部合同管理人', '1000');
INSERT INTO `org_gw` VALUES ('745fb580f7d741af84385e3d4dd1ae12', 'GW0051', '审计部初审员', '1000');
INSERT INTO `org_gw` VALUES ('760f319289dc40d8a96eaf690f82d816', 'GW0016', '会计', '1000');
INSERT INTO `org_gw` VALUES ('7d2b7924b43246b79033d0291f93ae4b', 'GW0008', '副总裁', '1000');
INSERT INTO `org_gw` VALUES ('808bcece5f394d3d9dc869d597e57820', 'GW0019', '收文管理员', '1000');
INSERT INTO `org_gw` VALUES ('80a766cee6dc4564bbf688828fc51249', 'GW0030', '分管领导', '1000');
INSERT INTO `org_gw` VALUES ('8471bf0a1a564394ae2e5172cdbdd00b', 'GW0052', '总审计师', '1000');
INSERT INTO `org_gw` VALUES ('87b3462b4d9b41da8ae3947af3aaeda9', 'GW0058', '固资管信部负责人', '1000');
INSERT INTO `org_gw` VALUES ('9113d76f78534cba88578b44edf0bc23', 'GW0029', '总法律顾问', '1000');
INSERT INTO `org_gw` VALUES ('95f9d4d0298a42eaab98f1276f4e1a82', 'GW0004', '财务主任', '1000');
INSERT INTO `org_gw` VALUES ('96f5b0b535c4447784a3263b0bd0621d', 'GW0059', '固资机关事务局负责人', '1000');
INSERT INTO `org_gw` VALUES ('97464efbc78e47fd8315b25aaea8e6cb', 'GW0067', '数据内部顾问', '1000');
INSERT INTO `org_gw` VALUES ('a47c6b7a69444254a37721c9d299aebd', 'GW0024', '处长', '1000');
INSERT INTO `org_gw` VALUES ('a586b42027fd443b9ab19fe006b53825', 'GW0013', '科级主管', '1000');
INSERT INTO `org_gw` VALUES ('a6bb68c899674c0b80fe1ef8f8a8cd14', 'GW0011', '车辆管理员', '1000');
INSERT INTO `org_gw` VALUES ('af5caebcabe3482eb4873c351505f509', 'GW0056', '党委书记', '1000');
INSERT INTO `org_gw` VALUES ('b24497fd61214553bf009d96ca98f156', 'GW0018', '主编', '1000');
INSERT INTO `org_gw` VALUES ('b253ff6375394d5f9eba62bb80a1261c', 'GW0009', '总裁', '1000');
INSERT INTO `org_gw` VALUES ('ba3f5867ce654abf8cb462c01872da39', 'GW0037', '人事专员', '1000');
INSERT INTO `org_gw` VALUES ('ba4ae863b1234c9a9bfef1333a5e7329', 'GW0061', '固资财务经办人', '1000');
INSERT INTO `org_gw` VALUES ('be7438ee31044fd09c722b50dd1c3e7c', 'GW0020', '总经理', '1000');
INSERT INTO `org_gw` VALUES ('be8fd40858984ebb9bb4f998613f3d10', 'GW0043', '法律部负责人', '1000');
INSERT INTO `org_gw` VALUES ('bebd87179cc2496eb6194726aaf1010b', 'GW0065', '分管副经理', '1000');
INSERT INTO `org_gw` VALUES ('c8b806ee840e4dc99a046e4ebe95a60a', 'GW0046', '办公室盖章人', '1000');
INSERT INTO `org_gw` VALUES ('cb372e111712440bab037a522d36514f', 'GW0014', '工会主席', '1000');
INSERT INTO `org_gw` VALUES ('cf49bc02addb4d608f2b03d6290c3e87', 'GW0049', '档案管理员', '1000');
INSERT INTO `org_gw` VALUES ('d07066b645044fdc8b86de524a98c109', 'GW0032', '集团司机', '1000');
INSERT INTO `org_gw` VALUES ('dd050401aee849a98a06a67e6d4fb749', 'GW0026', '集团餐厅管理员', '1000');
INSERT INTO `org_gw` VALUES ('df555d036b2f48bd8b592354ba276503', 'GW0028', '综合处', '1000');
INSERT INTO `org_gw` VALUES ('e173598b915b449a8de31758af827fbb', 'GW0039', '固资分管领导', '1000');
INSERT INTO `org_gw` VALUES ('e231849cfa0c463e980704015b9c169e', 'GW0060', '机关事务局局长', '1000');
INSERT INTO `org_gw` VALUES ('e5258cb3351249769df52d1829f061ed', 'GW0006', '数据专员', '1000');
INSERT INTO `org_gw` VALUES ('e7db6bf06d1744cfb349ff15c6460938', 'GW0035', '停车场管理员', '1000');
INSERT INTO `org_gw` VALUES ('e963196859044263979e19bf3163bc26', 'GW0001', '部门经理', '1000');
INSERT INTO `org_gw` VALUES ('e9be473e82ea4a1d9a0c003fb203517c', 'GW0007', '部门主管', '1000');
INSERT INTO `org_gw` VALUES ('f109fc7a0ccf41a0b88351412a58cabd', 'GW0063', '财务会计', '1000');
INSERT INTO `org_gw` VALUES ('f550c2654e944622bd81ec72cf905e2f', 'GW0062', '考勤专员', '1000');
INSERT INTO `org_gw` VALUES ('f7c5aaa46a6c4f149321ad1cfe6f4aac', 'GW0031', '管理与信息部业务管理员', '1000');
INSERT INTO `org_gw` VALUES ('f9a146c0c8124a35aae301ae1ebd922f', 'GW0023', '部门副主任', '1000');
INSERT INTO `org_gw` VALUES ('fae0def2d73d4763a6ae1d7ec697239a', 'GW0040', '固资管信部经办人', '1000');
INSERT INTO `org_gw` VALUES ('ff29afaf5169428aa55a2aff3d4c0fab', 'GW0069', '经理', '1000');

-- ----------------------------
-- Table structure for `org_log`
-- ----------------------------
DROP TABLE IF EXISTS `org_log`;
CREATE TABLE `org_log` (
  `uuid` varchar(32) NOT NULL COMMENT 'UUID',
  `create_date` varchar(30) DEFAULT NULL COMMENT '创建时间',
  `user_uuid` varchar(32) DEFAULT NULL COMMENT '创建人Uuid',
  `operate_info` varchar(30) DEFAULT NULL COMMENT '操作信息',
  `log_info` text COMMENT '日志信息',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组织日志';

-- ----------------------------
-- Records of org_log
-- ----------------------------
INSERT INTO `org_log` VALUES ('cc3ca5b344184cff8986187051740209', '2015-09-21 18:51:53', 'c8f1ba6c7cf842409aba43206e9f7442', '人员更新', '更新：测试用户2/dev2');

-- ----------------------------
-- Table structure for `org_role`
-- ----------------------------
DROP TABLE IF EXISTS `org_role`;
CREATE TABLE `org_role` (
  `role_uuid` varchar(32) NOT NULL COMMENT '角色UUID',
  `role_code` varchar(50) DEFAULT NULL COMMENT '角色编号',
  `role_name` varchar(50) DEFAULT NULL COMMENT '角色名称',
  `hierarchy` varchar(200) DEFAULT NULL COMMENT '层级',
  `manager_uuid` varchar(50) DEFAULT NULL COMMENT '管理人员UUID',
  `dir_code` varchar(32) DEFAULT NULL COMMENT '目录编号',
  `sort` int(11) DEFAULT '1000' COMMENT '显示序号',
  PRIMARY KEY (`role_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of org_role
-- ----------------------------
INSERT INTO `org_role` VALUES ('001b596b7b3e477eb8638d139f03b015', 'R0006', '发文管理员', null, null, 'RD002', '0');
INSERT INTO `org_role` VALUES ('1ebc41df342046ccb9c96e8411eee234', 'R0007', '收文管理员', null, null, 'RD002', '0');
INSERT INTO `org_role` VALUES ('260aa2c287114e57a522d8938113c651', 'R0002', '财务经理', null, null, 'RD001', '0');
INSERT INTO `org_role` VALUES ('699cff42b5074b7cb42ede5ffc46b0d2', 'R0008', '人事专员', null, null, '', '100');
INSERT INTO `org_role` VALUES ('8829896d0bc64ff398505cf383df681f', 'R0004', '出纳', null, null, 'RD001', '0');
INSERT INTO `org_role` VALUES ('90f50e35ead942a1ad375feee2f0ce94', 'R0010', '车辆管理员', null, null, '', '100');
INSERT INTO `org_role` VALUES ('b1bb0209d6094533865571e1e64c0e0c', 'R0003', '存货会计', null, null, 'RD001', '0');
INSERT INTO `org_role` VALUES ('b8f188c3ad7943dba92fa086cf3e400a', 'R0005', '费用会计', null, null, 'RD001', '0');
INSERT INTO `org_role` VALUES ('bb0d5b3eb761462881a93ce529accbad', 'R0001', '财务管理员', null, null, 'RD001', '0');
INSERT INTO `org_role` VALUES ('cf8380a5d32d430f8fc1ec14d92421a2', 'R0009', '图书管理员', null, null, '', '100');

-- ----------------------------
-- Table structure for `org_role_dir`
-- ----------------------------
DROP TABLE IF EXISTS `org_role_dir`;
CREATE TABLE `org_role_dir` (
  `dir_code` varchar(32) NOT NULL COMMENT '目录编号',
  `dir_name` varchar(50) DEFAULT NULL COMMENT '目录名称',
  `p_dir_code` varchar(32) DEFAULT NULL COMMENT '父节点编号',
  PRIMARY KEY (`dir_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色目录表';

-- ----------------------------
-- Records of org_role_dir
-- ----------------------------
INSERT INTO `org_role_dir` VALUES ('RD001', '财务相关', 'root');
INSERT INTO `org_role_dir` VALUES ('RD002', '公文相关', 'root');
INSERT INTO `org_role_dir` VALUES ('RD003', '采购部', 'root');
INSERT INTO `org_role_dir` VALUES ('RD004', '销售部', 'root');
INSERT INTO `org_role_dir` VALUES ('root', '角色类别', null);

-- ----------------------------
-- Table structure for `org_role_user`
-- ----------------------------
DROP TABLE IF EXISTS `org_role_user`;
CREATE TABLE `org_role_user` (
  `uuid` char(32) NOT NULL COMMENT 'UUID',
  `role_uuid` varchar(32) DEFAULT NULL COMMENT '角色UUID',
  `user_uuid` varchar(32) DEFAULT NULL COMMENT '用户UUID',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色-人员表';

-- ----------------------------
-- Records of org_role_user
-- ----------------------------
INSERT INTO `org_role_user` VALUES ('739e3796794c4d8a84b797ad1b8bec3f', '001b596b7b3e477eb8638d139f03b015', '0e218205a8f641a8988e742e81014568');

-- ----------------------------
-- Table structure for `org_user`
-- ----------------------------
DROP TABLE IF EXISTS `org_user`;
CREATE TABLE `org_user` (
  `user_uuid` varchar(32) NOT NULL COMMENT '用户UUID',
  `user_code` varchar(20) DEFAULT NULL COMMENT '用户编号',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户名称',
  `sex` varchar(4) DEFAULT NULL COMMENT '性别',
  `birthday` varchar(20) DEFAULT NULL COMMENT '生日',
  `office_phone` varchar(20) DEFAULT NULL COMMENT '办公电话',
  `phone` varchar(20) DEFAULT NULL COMMENT '移动电话',
  `fax` varchar(20) DEFAULT NULL COMMENT '传真',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `zw_uuid` varchar(32) DEFAULT NULL COMMENT '职务UUID',
  `zw_name` varchar(50) DEFAULT NULL COMMENT '职务名称',
  `direct_leader` varchar(32) DEFAULT NULL COMMENT '直属领导',
  `sort` int(11) DEFAULT '1000' COMMENT '显示序号',
  `extend1` varchar(50) DEFAULT NULL COMMENT 'extend1',
  `extend2` varchar(50) DEFAULT NULL COMMENT 'extend2',
  `extend3` varchar(50) DEFAULT NULL COMMENT 'extend3',
  `extend4` varchar(50) DEFAULT NULL COMMENT 'extend4',
  `extend5` varchar(50) DEFAULT NULL COMMENT 'extend5',
  `extend6` varchar(50) DEFAULT NULL COMMENT 'extend6',
  `extend7` varchar(50) DEFAULT NULL COMMENT 'extend7',
  `extend8` varchar(50) DEFAULT NULL COMMENT 'extend8',
  `extend9` varchar(50) DEFAULT NULL COMMENT 'extend9',
  `extend10` varchar(50) DEFAULT NULL COMMENT 'extend10',
  `extend11` varchar(50) DEFAULT NULL COMMENT 'extend11',
  `extend12` varchar(50) DEFAULT NULL COMMENT 'extend12',
  `extend13` varchar(50) DEFAULT NULL COMMENT 'extend13',
  `extend14` varchar(50) DEFAULT NULL COMMENT 'extend14',
  `extend15` varchar(50) DEFAULT NULL COMMENT 'extend15',
  `extend16` varchar(50) DEFAULT NULL COMMENT 'extend16',
  `extend17` varchar(50) DEFAULT NULL COMMENT 'extend17',
  `extend18` varchar(50) DEFAULT NULL COMMENT 'extend18',
  `extend19` varchar(50) DEFAULT NULL COMMENT 'extend19',
  `extend20` varchar(50) DEFAULT NULL COMMENT 'extend20',
  PRIMARY KEY (`user_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of org_user
-- ----------------------------
INSERT INTO `org_user` VALUES ('0e218205a8f641a8988e742e81014568', 'dev2', '测试用户2', '男', '1988-10-23', '010-8293729', '13666788983', '010-8293848', 'dev2@gmail.com', 'ZW002', '总裁', '', '0', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `org_user` VALUES ('163c9782458a4474b3de382e39a7097f', 'dev16', '测试用户16', '女', '1988-11-06', '010-8293743', '13666788997', '010-8293862', 'dev16@gmail.com', '', '', null, '100', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_user` VALUES ('3e300967a5d246448d1aced717e38401', 'dev9', '测试用户9', '男', '1988-10-30', '010-8293736', '13666788990', '010-8293855', 'dev9@gmail.com', '', '', null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_user` VALUES ('3e33b50047394b9bafe115528f6843a8', 'dev1', '测试用户1', '男', '1988-10-22', '010-8293728', '13666788982', '010-8293847', 'dev1@gmail.com', 'ZW001', '董事长', null, '100', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_user` VALUES ('4a49bfa606a54683aa99195cf93478d0', 'dev14', '测试用户14', '男', '1988-11-04', '010-8293741', '13666788995', '010-8293860', 'dev14@gmail.com', '', '', null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_user` VALUES ('4ba31363fef14039ac43899ddd8acbc2', 'dev17', '测试用户17', '女', '1988-11-07', '010-8293744', '13666788998', '010-8293863', 'dev17@gmail.com', '', '', null, '100', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_user` VALUES ('7dc1d65135c946a9ae17406bb209f320', 'dev13', '测试用户13', '男', '1988-11-03', '010-8293740', '13666788994', '010-8293859', 'dev13@gmail.com', '', '', null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_user` VALUES ('7ea28ba1d55b4614ae6945705faf9c59', 'dev12', '测试用户12', '男', '1988-11-02', '010-8293739', '13666788993', '010-8293858', 'dev12@gmail.com', '', '', null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_user` VALUES ('8b9b52afb852480c9eb226ec0b283649', 'dev3', '测试用户3', '男', '1988-10-24', '010-8293730', '13666788984', '010-8293849', 'dev3@gmail.com', 'ZW003', '副总裁', null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_user` VALUES ('8c8aced6d7d04a0489655e9a1ae73897', 'dev19', '测试用户19', '女', '1988-11-09', '010-8293746', '13666789000', '010-8293865', 'dev19@gmail.com', '', '', null, '100', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_user` VALUES ('a85cd658f19e4bc6b9c0e4f52824074a', 'dev10', '测试用户10', '男', '1988-10-31', '010-8293737', '13666788991', '010-8293856', 'dev10@gmail.com', '', '', null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_user` VALUES ('aed20805ca6f45369a3f374b9148878b', 'dev7', '测试用户7', '男', '1988-10-28', '010-8293734', '13666788988', '010-8293853', 'dev7@gmail.com', 'ZW007', '科长', null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_user` VALUES ('b306c6de523b41719c7bbff2b5fa6469', 'dev18', '测试用户18', '女', '1988-11-08', '010-8293745', '13666788999', '010-8293864', 'dev18@gmail.com', '', '', null, '100', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_user` VALUES ('bebbdc094b844c22aa2980bab5a3f20b', 'dev8', '测试用户8', '男', '1988-10-29', '010-8293735', '13666788989', '010-8293854', 'dev8@gmail.com', '', '', '', '0', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `org_user` VALUES ('c7f9c97235114cc29cbe10ce36d9587e', 'dev5', '测试用户5', '男', '1988-10-26', '010-8293732', '13666788986', '010-8293851', 'dev5@gmail.com', 'ZW005', '经理', null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_user` VALUES ('c8216f7edc984f8bbba83de3abe128ce', 'dev11', '测试用户11', '男', '1988-11-01', '010-8293738', '13666788992', '010-8293857', 'dev11@gmail.com', '', '', null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_user` VALUES ('c8f1ba6c7cf842409aba43206e9f7442', 'swordadmin', '管理员', '男', '', '', '', '', '', null, null, '', '0', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `org_user` VALUES ('da31f25604fc4cf78404b3ca5f91482d', 'dev20', '测试用户20', '女', '1988-11-10', '010-8293747', '13666789001', '010-8293866', 'dev20@gmail.com', '', '', null, '100', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_user` VALUES ('e2669af5f55b459985d3e836aaa72cb2', 'dev6', '测试用户6', '男', '1988-10-27', '010-8293733', '13666788987', '010-8293852', 'dev6@gmail.com', 'ZW006', '副经理', null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_user` VALUES ('e9109979b8eb4ac89709ea6fe3097416', 'dev4', '测试用户4', '男', '1988-10-25', '010-8293731', '13666788985', '010-8293850', 'dev4@gmail.com', 'ZW004', '总经理', null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `org_user` VALUES ('fa25703db8874956be2dc5de9e6e29d8', 'dev15', '测试用户15', '男', '1988-11-05', '010-8293742', '13666788996', '010-8293861', 'dev15@gmail.com', '', '', null, '100', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for `org_zw`
-- ----------------------------
DROP TABLE IF EXISTS `org_zw`;
CREATE TABLE `org_zw` (
  `zw_uuid` varchar(32) NOT NULL COMMENT '职务UUID',
  `zw_code` varchar(50) DEFAULT NULL COMMENT '职务编号',
  `zw_name` varchar(50) DEFAULT NULL COMMENT '职务名称',
  `sort` int(11) DEFAULT '1000' COMMENT '显示序号',
  PRIMARY KEY (`zw_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='职务表';

-- ----------------------------
-- Records of org_zw
-- ----------------------------
INSERT INTO `org_zw` VALUES ('0c4126aafd9948c68c853503ca2a38a0', 'ZW007', '科长', '100');
INSERT INTO `org_zw` VALUES ('12c1c09a2e144c6d95d4ff5607a6fc82', 'ZW006', '副经理', '100');
INSERT INTO `org_zw` VALUES ('30b480293d6346a88ae942c8a06135ed', 'ZW002', '总裁', '100');
INSERT INTO `org_zw` VALUES ('53c3a2350ec04efe99b0c9c343a28254', 'ZW003', '副总裁', '100');
INSERT INTO `org_zw` VALUES ('9dcc63e605bb4134a650f29d3fd0a5da', 'ZW005', '经理', '100');
INSERT INTO `org_zw` VALUES ('c56ae3a0d9bc4de1a3af8ef246030fbe', 'ZW004', '总经理', '100');
INSERT INTO `org_zw` VALUES ('fc6334b3a7de4b5e9f71dd20e5417678', 'ZW001', '董事长', '100');

-- ----------------------------
-- Table structure for `pd_web_dictionary`
-- ----------------------------
DROP TABLE IF EXISTS `pd_web_dictionary`;
CREATE TABLE `pd_web_dictionary` (
  `id` varchar(32) NOT NULL,
  `code` varchar(200) NOT NULL,
  `name` varchar(40) NOT NULL,
  `short_name` varchar(40) DEFAULT NULL,
  `description` varchar(256) DEFAULT NULL,
  `is_alive` int(1) NOT NULL,
  `is_leaf` int(1) NOT NULL,
  `parent_id` varchar(32) NOT NULL,
  `root_code` varchar(200) NOT NULL,
  `code_sequence` int(9) unsigned DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `creator` varchar(40) DEFAULT NULL,
  `create_time` varchar(20) DEFAULT NULL,
  `updater` varchar(40) DEFAULT NULL,
  `update_time` varchar(20) DEFAULT NULL,
  `dict_type` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pd_web_dictionary
-- ----------------------------
INSERT INTO `pd_web_dictionary` VALUES ('2801aecbd9aa4ce3b0009499b89d4901', 'module_service', '菜单依赖注入项', null, '模块加载时动态注入的服务项集合，配置菜单处使用', '1', '1', 'ROOT', 'ROOT', '0', null, 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-06 13:36:18', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 15:48:24', 'simple');
INSERT INTO `pd_web_dictionary` VALUES ('31a6c32e67da4513856a0e03cbf7390b', 'route', '$route', '', '', '1', '1', '2801aecbd9aa4ce3b0009499b89d4901', '2801aecbd9aa4ce3b0009499b89d4901', '0', '', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-06 13:41:42', '', '', 'simple');
INSERT INTO `pd_web_dictionary` VALUES ('587d563db1e54819864d2b8754c071c6', 'routeParams', '$routeParams', '', '', '1', '1', '2801aecbd9aa4ce3b0009499b89d4901', '2801aecbd9aa4ce3b0009499b89d4901', '0', '', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-06 13:41:59', '', '', 'simple');
INSERT INTO `pd_web_dictionary` VALUES ('66c9df86cbab489187b47611113aadb7', 'compile', '$compile', '', '', '1', '1', '2801aecbd9aa4ce3b0009499b89d4901', '2801aecbd9aa4ce3b0009499b89d4901', '0', '', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-06 13:42:24', '', '', 'simple');
INSERT INTO `pd_web_dictionary` VALUES ('84fb53bd8f2b4f7bb2eeb8a3bb4d3790', 'scope', '$scope', '', '', '1', '1', '2801aecbd9aa4ce3b0009499b89d4901', '2801aecbd9aa4ce3b0009499b89d4901', '0', '', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-06 13:38:45', '', '', 'simple');
INSERT INTO `pd_web_dictionary` VALUES ('8700650fd17749fdb6817b11e60ad473', 'http', '$http', '', '', '1', '1', '2801aecbd9aa4ce3b0009499b89d4901', '2801aecbd9aa4ce3b0009499b89d4901', '0', '', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-06 13:37:09', '', '', 'simple');

-- ----------------------------
-- Table structure for `pd_web_login_error_log`
-- ----------------------------
DROP TABLE IF EXISTS `pd_web_login_error_log`;
CREATE TABLE `pd_web_login_error_log` (
  `id` char(33) NOT NULL,
  `ip` varchar(20) DEFAULT NULL,
  `error_code` int(11) DEFAULT NULL,
  `user_code` varchar(45) DEFAULT NULL,
  `user_id` char(33) DEFAULT NULL,
  `error_date` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='登录错误日志';

-- ----------------------------
-- Records of pd_web_login_error_log
-- ----------------------------
INSERT INTO `pd_web_login_error_log` VALUES ('075ad74573674700939743496f1e1408', '0:0:0:0:0:0:0:1', '7', 'swordadmin', '', '2015-08-31 17:13:43');

-- ----------------------------
-- Table structure for `pd_web_login_key`
-- ----------------------------
DROP TABLE IF EXISTS `pd_web_login_key`;
CREATE TABLE `pd_web_login_key` (
  `id` char(33) NOT NULL,
  `rsa_key` varchar(600) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='org_login_key';

-- ----------------------------
-- Records of pd_web_login_key
-- ----------------------------
INSERT INTO `pd_web_login_key` VALUES ('140bb7ddacbf45b6a96d874f4f4b9668', '008e7fc5ba1d08e1d5710da8a626d630d989fac9cdd160e254fe22f0774e392edf3fb8e2194f7c3c1ac239b22aad2f3328607da7dcde5c0bdaa5927fffc334d0575f0b41cf51a4330ab40abb541d68e07f7dd96a1210cf832d16ef4c1ab2a724f00842da701302cb65728bd6b082cec4285d8b552a9825b402e85c284d2864c0e1-00914f80b3dcf17e11424e430997f77569d5a09db522a93f5a6d016ca6fd27671bbcdfea056a6313f2b89c211c3e215f834a6f6dd7260a2e9b5c5728f1e87613f264af9c53a154c1b4819f4a65b92cca96942f9bcc1978b082c83e3f1b8abcc346225e33bf5594ca805c2da63bc3c9e5853b51af0e0e0f9835a8e9febad3439be5');
INSERT INTO `pd_web_login_key` VALUES ('2e8c2324635e49b5bd9aa088a4c90752', '201642c510e4be227e7ceda309053fb15b6a784bcfb52d00bfc484ded520e6a5b2833666ff540f6b7b6fc8e3a766f442bc42ee189571a3bf54e5ccf481af3a16ffce8f06698b24298f68819c2c63b833b09ead1a1a8da7bcc2ef65303a35c9e043747acd80217582e88110399cbf65c32d8f225debafccfcc2f7152775c927f9-008e04fe7bf5090f5b59645d916e1e8b7fc4badb17b4154ffed6710c1bc42ccf3cdc47745794ffa65d83adb59cccd142fd6ed5b31fc967a26100cc2e950b13e55993902410c90426fd4d2d3860841c60182cf717f7dce5f9e6dd39c1309b21e8c6291bf8f9149782528a4cf132eb1dd5d1463a27e9d3492f3ce2fb4ef613c76e13');
INSERT INTO `pd_web_login_key` VALUES ('36c6c8e25696458494eaa0c809c3c4be', '25d7529a2c9e173274b6696a647b2b5d66c4d044a1b38d3b6ece539a40385d9da9e965eab9bf7bdbd2e20158ff33674711d2a3034122c8dd2e2738ffa74d14891816bb9661252cd5e4ca97ab4f87f4ae8291439e4269ef0b2728e3983a1cf051fafa11394126b4540e82d287a27cf5550383507f286d634f649aad6d49edbb01-00f0baae483e3ad6d023356147f632c9e452286e5e2dd3bdc68c7e4ba80738c095ae91d017d8e45b874ca1b9ffb726ad82e29222d61b7c0c85f6dd8996bea9f7836bcf081847b01c8f89d021379ce5ab4792590e7666125faa81722f5cac7e45d31c5f805b7e3f3acc5d954b9cafb2d7e7fc46b38dd7464706f65995b274a00639');
INSERT INTO `pd_web_login_key` VALUES ('3b72349bed484bee9d5d61bcfd4e060a', '438eb0ca6c33637e5b72bf2dffd7f53335fc1093fdb42e0d4175a69a690819c1c5ed2eeabedbab7f994d89a12975c24f57b7caaadf7446256608384bbcd9b6d05e92769833866e68a7fef9f2ef2350759f779ffcf3834c9d1261d6639fd9aeba088171ded49433ea38fd412dae39a85b83a7bb452c697e79a117fec9c5d06f71-00e24f1784045e35b988fdadd5974a8c1b27820c7538b0050b246a40cc8b428fdb9105fa58a2f82099513f872e0c569f142d867ece0ac56623a5860604c72d37e1eb28386ecfecddd8e81b70e1804d5aa89f68dd45299f2c0915077117a9ee21c7abc30e9c88004b6cffbc219038be41ad27d121a6ea66bc2781640d8c50cf6969');
INSERT INTO `pd_web_login_key` VALUES ('3ed6ff9f6bcd4db085b25d983e78d1f8', '43a96d96a32689504639ad7178c53ee8a921350434d44588237575e8b41c845d1997d3e166bf65e093431edd6f5deeef9a41162b9f14d3529c40cb25eb25f30e5aafa3e50436b1bf35562ceefdc6ca0d05b1cd65bcd8dc7d9096f509401eec21dd230ae0f3b8cf9268ccdebabb219199b0e7474418f09572f26a8eca87c78a59-0090a00d17a4aaeea1b9326b4843fc8eb09f7484440bcb15afcde23cd173d3047f42be87384e170864117f6bb847e6450fe616dd36ceaf1b38fb1c530c7c1a9a524a3a0d7b893ba2aaf00642af121705a0d989b6a67c6b43e4cf22df6ed9b3cd164dd5cdbf0f185d84246c817ee6b9c0b1b4190b640e30f25b3cf529b2c48e82ab');
INSERT INTO `pd_web_login_key` VALUES ('3f22baf29c064287acac128914eddd49', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
INSERT INTO `pd_web_login_key` VALUES ('41d44cfa63414deb804e34a40065416f', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
INSERT INTO `pd_web_login_key` VALUES ('43de12adf0ba4cd3917650f472512e94', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
INSERT INTO `pd_web_login_key` VALUES ('494e483c30874e2aa991e7cd2a88581d', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
INSERT INTO `pd_web_login_key` VALUES ('4c164ce8e635497d8af63f89b673474d', '008e7fc5ba1d08e1d5710da8a626d630d989fac9cdd160e254fe22f0774e392edf3fb8e2194f7c3c1ac239b22aad2f3328607da7dcde5c0bdaa5927fffc334d0575f0b41cf51a4330ab40abb541d68e07f7dd96a1210cf832d16ef4c1ab2a724f00842da701302cb65728bd6b082cec4285d8b552a9825b402e85c284d2864c0e1-00914f80b3dcf17e11424e430997f77569d5a09db522a93f5a6d016ca6fd27671bbcdfea056a6313f2b89c211c3e215f834a6f6dd7260a2e9b5c5728f1e87613f264af9c53a154c1b4819f4a65b92cca96942f9bcc1978b082c83e3f1b8abcc346225e33bf5594ca805c2da63bc3c9e5853b51af0e0e0f9835a8e9febad3439be5');
INSERT INTO `pd_web_login_key` VALUES ('4f472304d8b9420e9e727e5d20b2625b', '008e7fc5ba1d08e1d5710da8a626d630d989fac9cdd160e254fe22f0774e392edf3fb8e2194f7c3c1ac239b22aad2f3328607da7dcde5c0bdaa5927fffc334d0575f0b41cf51a4330ab40abb541d68e07f7dd96a1210cf832d16ef4c1ab2a724f00842da701302cb65728bd6b082cec4285d8b552a9825b402e85c284d2864c0e1-00914f80b3dcf17e11424e430997f77569d5a09db522a93f5a6d016ca6fd27671bbcdfea056a6313f2b89c211c3e215f834a6f6dd7260a2e9b5c5728f1e87613f264af9c53a154c1b4819f4a65b92cca96942f9bcc1978b082c83e3f1b8abcc346225e33bf5594ca805c2da63bc3c9e5853b51af0e0e0f9835a8e9febad3439be5');
INSERT INTO `pd_web_login_key` VALUES ('58d9f3b37f96489ba57f7046a2675e2e', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
INSERT INTO `pd_web_login_key` VALUES ('6592b5c3d9174bf1b336d455dc450730', '6a43ccf1273de60f24d6d3dd4f6c1400128e94126a9fe435d41fd6c324ae29c5c88dd9ec5353cf988307f60075119b6b1d3a121993ecf8fa6cddeab2f2fa3a0e3268b3d96901237210f3ce7a923ee5bb0e9b334c9aad0e0ce8f3c54aed58f7544a8968809f33fcd255396743e075bd509b1101e9dfac2eb9ef9c89362922ad41-0098a7b5e968c9dcc6f413546cd0314f6892904340d2600160fc0da40b88b537ff12014df5fc26bc4417c5d386a71bff8e1d15ced49b56da7ecba43777eba5f4089d5a2fceb3ae0f5fb1fbd01fa25af68e7303a1e0fe34e8d6772cf51806d84b206df4d9347e3c1c3952d11cfae11d42e34fa977378bb45d6b12dc94f1e7b31bcd');
INSERT INTO `pd_web_login_key` VALUES ('67edba55ac174fbabaf40ee5d606e743', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
INSERT INTO `pd_web_login_key` VALUES ('6a6a748f682e42f3901a6d9e3f7f28ac', '201642c510e4be227e7ceda309053fb15b6a784bcfb52d00bfc484ded520e6a5b2833666ff540f6b7b6fc8e3a766f442bc42ee189571a3bf54e5ccf481af3a16ffce8f06698b24298f68819c2c63b833b09ead1a1a8da7bcc2ef65303a35c9e043747acd80217582e88110399cbf65c32d8f225debafccfcc2f7152775c927f9-008e04fe7bf5090f5b59645d916e1e8b7fc4badb17b4154ffed6710c1bc42ccf3cdc47745794ffa65d83adb59cccd142fd6ed5b31fc967a26100cc2e950b13e55993902410c90426fd4d2d3860841c60182cf717f7dce5f9e6dd39c1309b21e8c6291bf8f9149782528a4cf132eb1dd5d1463a27e9d3492f3ce2fb4ef613c76e13');
INSERT INTO `pd_web_login_key` VALUES ('709c55e1a3544f6097433ef09e805b04', '44b204818cc2f22eabecc14de641755d18d4ecf4b3dc5072e35db949b1df5e328b5bc270717bdd03b138479c7ea38dd121a9fe2e0466c8b2bc9b6b7656fdcb6ca8dff5e021f1cfa1fcab3a0b0c158310e58282d7c66570f67157542f339a8f1e06f15a67d2ba9a0e93d9f11e2c1c8669f9329ac17480015c069c47fd29147ef9-00bb545847828644a3361de714cc782696689a635bab593c3a8aa1c4bf4d248155fd30ec2dc2a056ea6ea1af6a41ae4dc9d17be458f357e156a01f720c7246bbdede5f4ece9a5b953111cdbdd9bb4850b36337c3920c6eba1e7dd2c9b8f17365628ff5e55fae249177cfbb8104026bd0cd4644231586430c53c6bbe9c8f8c56033');
INSERT INTO `pd_web_login_key` VALUES ('7173e83a536a4e3fb5d2fc6782afcbd5', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
INSERT INTO `pd_web_login_key` VALUES ('80295358882e44d79624b580e0c8d47d', '008e7fc5ba1d08e1d5710da8a626d630d989fac9cdd160e254fe22f0774e392edf3fb8e2194f7c3c1ac239b22aad2f3328607da7dcde5c0bdaa5927fffc334d0575f0b41cf51a4330ab40abb541d68e07f7dd96a1210cf832d16ef4c1ab2a724f00842da701302cb65728bd6b082cec4285d8b552a9825b402e85c284d2864c0e1-00914f80b3dcf17e11424e430997f77569d5a09db522a93f5a6d016ca6fd27671bbcdfea056a6313f2b89c211c3e215f834a6f6dd7260a2e9b5c5728f1e87613f264af9c53a154c1b4819f4a65b92cca96942f9bcc1978b082c83e3f1b8abcc346225e33bf5594ca805c2da63bc3c9e5853b51af0e0e0f9835a8e9febad3439be5');
INSERT INTO `pd_web_login_key` VALUES ('804dc4fcf2e442719ba37b71a8c0256c', '44b204818cc2f22eabecc14de641755d18d4ecf4b3dc5072e35db949b1df5e328b5bc270717bdd03b138479c7ea38dd121a9fe2e0466c8b2bc9b6b7656fdcb6ca8dff5e021f1cfa1fcab3a0b0c158310e58282d7c66570f67157542f339a8f1e06f15a67d2ba9a0e93d9f11e2c1c8669f9329ac17480015c069c47fd29147ef9-00bb545847828644a3361de714cc782696689a635bab593c3a8aa1c4bf4d248155fd30ec2dc2a056ea6ea1af6a41ae4dc9d17be458f357e156a01f720c7246bbdede5f4ece9a5b953111cdbdd9bb4850b36337c3920c6eba1e7dd2c9b8f17365628ff5e55fae249177cfbb8104026bd0cd4644231586430c53c6bbe9c8f8c56033');
INSERT INTO `pd_web_login_key` VALUES ('8726c010bb404ea58c14dbeec77274ce', '3ef18d79d75ac323d1217e8e8e2c634c76771b45e6ce8c064ac57ea7a5563d19b4661e2a0057e7850f7bb9735fdb098d888c92165e513bbf5d8e6eb489284c32b7f33faf02dce2cc08059689c635d79610e86b7b7433a1ca964e2662cbcbf87a376136219a4af8e8a07cd06224edf07604d2d282cef45fb93c0f5a4e88513df1-00828bda14789ecf5f0a88d509bc604a58b18caa23dfcabf50eebbe2c7692a3877973280586447a614b732aebe16a7baa7d4fb54a0c51731f7894fa1c9820f7c2321f40bcc641af2bb266e46d3044dbae85bf44b3ac2a7b9270a192e218fb012503c83c0f63b72c17ac943bfb9cbb71da2f6b5bb9c932c455162b4cf2eded9897b');
INSERT INTO `pd_web_login_key` VALUES ('96b8de38de654d0e85de50385c9b8a34', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
INSERT INTO `pd_web_login_key` VALUES ('9f9bd66a04cf44d38f31323f302b0740', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
INSERT INTO `pd_web_login_key` VALUES ('a45d0d3adfa14a938ee7748f3373104d', '008e7fc5ba1d08e1d5710da8a626d630d989fac9cdd160e254fe22f0774e392edf3fb8e2194f7c3c1ac239b22aad2f3328607da7dcde5c0bdaa5927fffc334d0575f0b41cf51a4330ab40abb541d68e07f7dd96a1210cf832d16ef4c1ab2a724f00842da701302cb65728bd6b082cec4285d8b552a9825b402e85c284d2864c0e1-00914f80b3dcf17e11424e430997f77569d5a09db522a93f5a6d016ca6fd27671bbcdfea056a6313f2b89c211c3e215f834a6f6dd7260a2e9b5c5728f1e87613f264af9c53a154c1b4819f4a65b92cca96942f9bcc1978b082c83e3f1b8abcc346225e33bf5594ca805c2da63bc3c9e5853b51af0e0e0f9835a8e9febad3439be5');
INSERT INTO `pd_web_login_key` VALUES ('a461bd13166648368ca980f3683ce28f', '44b204818cc2f22eabecc14de641755d18d4ecf4b3dc5072e35db949b1df5e328b5bc270717bdd03b138479c7ea38dd121a9fe2e0466c8b2bc9b6b7656fdcb6ca8dff5e021f1cfa1fcab3a0b0c158310e58282d7c66570f67157542f339a8f1e06f15a67d2ba9a0e93d9f11e2c1c8669f9329ac17480015c069c47fd29147ef9-00bb545847828644a3361de714cc782696689a635bab593c3a8aa1c4bf4d248155fd30ec2dc2a056ea6ea1af6a41ae4dc9d17be458f357e156a01f720c7246bbdede5f4ece9a5b953111cdbdd9bb4850b36337c3920c6eba1e7dd2c9b8f17365628ff5e55fae249177cfbb8104026bd0cd4644231586430c53c6bbe9c8f8c56033');
INSERT INTO `pd_web_login_key` VALUES ('a640b3bdba4b46ffa47e9a1b8f13f7ce', '3ef18d79d75ac323d1217e8e8e2c634c76771b45e6ce8c064ac57ea7a5563d19b4661e2a0057e7850f7bb9735fdb098d888c92165e513bbf5d8e6eb489284c32b7f33faf02dce2cc08059689c635d79610e86b7b7433a1ca964e2662cbcbf87a376136219a4af8e8a07cd06224edf07604d2d282cef45fb93c0f5a4e88513df1-00828bda14789ecf5f0a88d509bc604a58b18caa23dfcabf50eebbe2c7692a3877973280586447a614b732aebe16a7baa7d4fb54a0c51731f7894fa1c9820f7c2321f40bcc641af2bb266e46d3044dbae85bf44b3ac2a7b9270a192e218fb012503c83c0f63b72c17ac943bfb9cbb71da2f6b5bb9c932c455162b4cf2eded9897b');
INSERT INTO `pd_web_login_key` VALUES ('ab66df90a3374367833ee006340315ca', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
INSERT INTO `pd_web_login_key` VALUES ('c31b464d996449c8a070864730540d3d', '008e7fc5ba1d08e1d5710da8a626d630d989fac9cdd160e254fe22f0774e392edf3fb8e2194f7c3c1ac239b22aad2f3328607da7dcde5c0bdaa5927fffc334d0575f0b41cf51a4330ab40abb541d68e07f7dd96a1210cf832d16ef4c1ab2a724f00842da701302cb65728bd6b082cec4285d8b552a9825b402e85c284d2864c0e1-00914f80b3dcf17e11424e430997f77569d5a09db522a93f5a6d016ca6fd27671bbcdfea056a6313f2b89c211c3e215f834a6f6dd7260a2e9b5c5728f1e87613f264af9c53a154c1b4819f4a65b92cca96942f9bcc1978b082c83e3f1b8abcc346225e33bf5594ca805c2da63bc3c9e5853b51af0e0e0f9835a8e9febad3439be5');
INSERT INTO `pd_web_login_key` VALUES ('c3686a39836f41b4b7dea270bfdd7fd8', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
INSERT INTO `pd_web_login_key` VALUES ('c9f5f96989cf4106aed8ae9c08db7c37', '3ef18d79d75ac323d1217e8e8e2c634c76771b45e6ce8c064ac57ea7a5563d19b4661e2a0057e7850f7bb9735fdb098d888c92165e513bbf5d8e6eb489284c32b7f33faf02dce2cc08059689c635d79610e86b7b7433a1ca964e2662cbcbf87a376136219a4af8e8a07cd06224edf07604d2d282cef45fb93c0f5a4e88513df1-00828bda14789ecf5f0a88d509bc604a58b18caa23dfcabf50eebbe2c7692a3877973280586447a614b732aebe16a7baa7d4fb54a0c51731f7894fa1c9820f7c2321f40bcc641af2bb266e46d3044dbae85bf44b3ac2a7b9270a192e218fb012503c83c0f63b72c17ac943bfb9cbb71da2f6b5bb9c932c455162b4cf2eded9897b');
INSERT INTO `pd_web_login_key` VALUES ('de763e59da684770974907ed37ad35b5', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
INSERT INTO `pd_web_login_key` VALUES ('e179c5fd84ad46d487a3add9bb950f68', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
INSERT INTO `pd_web_login_key` VALUES ('f64455b59ee640a6bcc91527fd5c0b1a', '008e7fc5ba1d08e1d5710da8a626d630d989fac9cdd160e254fe22f0774e392edf3fb8e2194f7c3c1ac239b22aad2f3328607da7dcde5c0bdaa5927fffc334d0575f0b41cf51a4330ab40abb541d68e07f7dd96a1210cf832d16ef4c1ab2a724f00842da701302cb65728bd6b082cec4285d8b552a9825b402e85c284d2864c0e1-00914f80b3dcf17e11424e430997f77569d5a09db522a93f5a6d016ca6fd27671bbcdfea056a6313f2b89c211c3e215f834a6f6dd7260a2e9b5c5728f1e87613f264af9c53a154c1b4819f4a65b92cca96942f9bcc1978b082c83e3f1b8abcc346225e33bf5594ca805c2da63bc3c9e5853b51af0e0e0f9835a8e9febad3439be5');
INSERT INTO `pd_web_login_key` VALUES ('ffffefbeae484edb90c7d32d869a63c4', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');

-- ----------------------------
-- Table structure for `pd_web_login_success_log`
-- ----------------------------
DROP TABLE IF EXISTS `pd_web_login_success_log`;
CREATE TABLE `pd_web_login_success_log` (
  `id` char(33) NOT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `login_time` varchar(20) DEFAULT NULL,
  `logout_time` varchar(20) DEFAULT NULL,
  `client_ip` varchar(20) DEFAULT NULL,
  `server_ip` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pd_web_login_success_log
-- ----------------------------
INSERT INTO `pd_web_login_success_log` VALUES ('05fc5bcc78a94b139f2c2ad9b5f3a226', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-14 18:17:29', '2015-09-14 19:15:14', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('06030562d3d04c8a89aab8d558568f3c', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-15 09:19:48', '2015-09-15 10:25:28', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('140bb7ddacbf45b6a96d874f4f4b9668', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-10 10:11:58', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('2e8c2324635e49b5bd9aa088a4c90752', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-11 14:06:33', '2015-09-11 14:37:19', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('327c81d097104264856a687bac5dcdb7', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-22 10:16:43', '2015-09-22 11:01:10', '127.0.0.1', '127.0.0.1');
INSERT INTO `pd_web_login_success_log` VALUES ('33127e19137142aab9fa4e797aa71bfa', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-14 17:21:40', '2015-09-14 17:54:37', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('36c6c8e25696458494eaa0c809c3c4be', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-02 10:52:00', '2015-09-02 11:22:32', '127.0.0.1', '127.0.0.1');
INSERT INTO `pd_web_login_success_log` VALUES ('387768a9c76b48e6aa076265d831bac7', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-14 17:20:33', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('3b72349bed484bee9d5d61bcfd4e060a', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-23 10:58:03', '', '127.0.0.1', '127.0.0.1');
INSERT INTO `pd_web_login_success_log` VALUES ('3be0a5bb93784f06820ce3cfe075ca81', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-23 09:49:15', '', '127.0.0.1', '127.0.0.1');
INSERT INTO `pd_web_login_success_log` VALUES ('3ed6ff9f6bcd4db085b25d983e78d1f8', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-12 18:18:51', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('3f22baf29c064287acac128914eddd49', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 16:30:47', '', '127.0.0.1', '127.0.0.1');
INSERT INTO `pd_web_login_success_log` VALUES ('41d44cfa63414deb804e34a40065416f', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 17:15:26', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('43de12adf0ba4cd3917650f472512e94', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 17:13:53', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('468661e597934fc5b99a84eb806ad5b3', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-23 09:47:36', '', '127.0.0.1', '127.0.0.1');
INSERT INTO `pd_web_login_success_log` VALUES ('468feb0d4d8542f99b37d46807015aff', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-15 10:31:55', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('494e483c30874e2aa991e7cd2a88581d', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 18:07:48', '', '127.0.0.1', '127.0.0.1');
INSERT INTO `pd_web_login_success_log` VALUES ('4c164ce8e635497d8af63f89b673474d', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-10 09:51:09', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('4f472304d8b9420e9e727e5d20b2625b', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-10 09:44:03', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('4fb98da7a95947788403cc4e5fdae7bc', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-22 15:02:23', '', '127.0.0.1', '127.0.0.1');
INSERT INTO `pd_web_login_success_log` VALUES ('54548d50a9d74084b079ce6e739d9a4f', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-14 17:12:48', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('58d9f3b37f96489ba57f7046a2675e2e', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 16:09:00', '', '127.0.0.1', '127.0.0.1');
INSERT INTO `pd_web_login_success_log` VALUES ('6592b5c3d9174bf1b336d455dc450730', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-07 14:14:00', '2015-09-07 14:45:49', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('67edba55ac174fbabaf40ee5d606e743', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 16:25:12', '2015-08-31 16:56:20', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('6a6a748f682e42f3901a6d9e3f7f28ac', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-11 15:16:38', '2015-09-11 15:46:52', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('709c55e1a3544f6097433ef09e805b04', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-08 10:12:09', '2015-09-08 10:46:57', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('7173e83a536a4e3fb5d2fc6782afcbd5', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 17:18:35', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('75d7f5c255e04b9699473f6285a5a872', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-22 11:05:06', '2015-09-22 11:45:22', '127.0.0.1', '127.0.0.1');
INSERT INTO `pd_web_login_success_log` VALUES ('7752d2cdbe604f9a8909c2873361608b', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-15 10:34:16', '2015-09-15 14:36:42', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('80295358882e44d79624b580e0c8d47d', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-10 10:18:45', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('804dc4fcf2e442719ba37b71a8c0256c', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-08 13:24:23', '2015-09-08 13:55:08', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('8726c010bb404ea58c14dbeec77274ce', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-22 17:48:33', '2015-09-22 18:39:42', '127.0.0.1', '127.0.0.1');
INSERT INTO `pd_web_login_success_log` VALUES ('9350e5bcb56f4ab6a9900cc19e2158e0', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-21 18:37:45', '', '127.0.0.1', '127.0.0.1');
INSERT INTO `pd_web_login_success_log` VALUES ('96b8de38de654d0e85de50385c9b8a34', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 17:16:49', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('9f9bd66a04cf44d38f31323f302b0740', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 17:05:34', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('a45d0d3adfa14a938ee7748f3373104d', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-10 09:45:33', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('a461bd13166648368ca980f3683ce28f', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-08 14:30:40', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('a640b3bdba4b46ffa47e9a1b8f13f7ce', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-22 17:35:28', '', '127.0.0.1', '127.0.0.1');
INSERT INTO `pd_web_login_success_log` VALUES ('a90aeec239ab4ae7807b87dd60f32505', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-21 18:51:25', '', '127.0.0.1', '127.0.0.1');
INSERT INTO `pd_web_login_success_log` VALUES ('ab66df90a3374367833ee006340315ca', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 16:16:50', '2015-08-31 16:30:01', '127.0.0.1', '127.0.0.1');
INSERT INTO `pd_web_login_success_log` VALUES ('b13dbf375b4b48399d46c1b73e9c8ead', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-15 10:36:55', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('c08c7270b663450eb504a2f104fdabee', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-22 13:59:26', '2015-09-22 14:54:55', '127.0.0.1', '127.0.0.1');
INSERT INTO `pd_web_login_success_log` VALUES ('c31b464d996449c8a070864730540d3d', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-10 09:29:19', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('c3686a39836f41b4b7dea270bfdd7fd8', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 19:03:11', '', '127.0.0.1', '127.0.0.1');
INSERT INTO `pd_web_login_success_log` VALUES ('c9f5f96989cf4106aed8ae9c08db7c37', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-22 15:07:41', '', '127.0.0.1', '127.0.0.1');
INSERT INTO `pd_web_login_success_log` VALUES ('de763e59da684770974907ed37ad35b5', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 17:21:39', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('e0e1689b0bcd4dc6b483e96d8c3f3004', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-14 19:43:10', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('e179c5fd84ad46d487a3add9bb950f68', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 17:25:14', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('f64455b59ee640a6bcc91527fd5c0b1a', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-09-10 16:25:33', '2015-09-10 16:56:23', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('ffffefbeae484edb90c7d32d869a63c4', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 17:20:02', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');

-- ----------------------------
-- Table structure for `pd_web_menu`
-- ----------------------------
DROP TABLE IF EXISTS `pd_web_menu`;
CREATE TABLE `pd_web_menu` (
  `menu_id` varchar(50) NOT NULL COMMENT '菜单标识',
  `menu_name` varchar(100) DEFAULT NULL COMMENT '菜单名称',
  `menu_type` varchar(2) DEFAULT NULL COMMENT '菜单类型',
  `menu_pid` varchar(50) DEFAULT NULL COMMENT '上级菜单',
  `menu_order` int(11) DEFAULT NULL COMMENT '排序编号',
  `menu_icon` varchar(100) DEFAULT NULL COMMENT '菜单图标',
  `menu_desc` varchar(500) DEFAULT NULL COMMENT '菜单描述',
  `menu_url` varchar(100) DEFAULT NULL COMMENT '菜单地址',
  `menu_open` varchar(1) DEFAULT NULL COMMENT '菜单打开方式',
  `menu_router` varchar(100) DEFAULT NULL COMMENT '菜单路由地址',
  `menu_ctrl` varchar(100) DEFAULT NULL COMMENT '菜单对应控制器名称',
  `menu_ctrl_url` varchar(100) DEFAULT NULL COMMENT '菜单对应控制器地址',
  `menu_service` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜单管理';

-- ----------------------------
-- Records of pd_web_menu
-- ----------------------------
INSERT INTO `pd_web_menu` VALUES ('007a714809054013bb5d921e3a09093e', '图片裁剪', '2', '44d7a7d2f90c4f709cb39dcd0ade7bc2', '110', null, null, 'static/core/examples/common.html', '1', 'crop', 'ep_crop', 'static/core/examples/util/crop/cropCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('031828e15648493da1644e524927dddd', 'Util', '2', '44d7a7d2f90c4f709cb39dcd0ade7bc2', '1', null, 'Util', 'static/core/examples/common.html', '1', 'util', 'ep_UtilCtrl', 'static/core/examples/util/util/utilCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('08ffd0aa1b75494e8c424d236622d465', '系统版本', '2', '1599dd58952f4e41a113a570c35a5dc5', '1000', null, null, 'sword/changeLog', '5', null, null, null, null);
INSERT INTO `pd_web_menu` VALUES ('1599dd58952f4e41a113a570c35a5dc5', '系统管理', '1', 'root', '2', 'fa fa-cog', '系统管理', null, null, null, null, null, null);
INSERT INTO `pd_web_menu` VALUES ('1afd2ac483c6416bab290d7c80f5c733', '侧边栏', '2', '44d7a7d2f90c4f709cb39dcd0ade7bc2', '9', null, '侧边栏', 'static/core/examples/common.html', '1', 'slidebar', 'ep_slidebar', 'static/core/examples/util/slidebar/slidebarCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('1bc856e2a82d426e948d28155993113b', '表格', '2', '44d7a7d2f90c4f709cb39dcd0ade7bc2', '7', null, '表格', 'static/core/examples/common.html', '1', 'grid', 'ep_GridCtrl', 'static/core/examples/util/grid/gridCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('1c84ac7b6ca34bfea808890938ac4022', '日志监控', '2', '9217f4e385aa4845aef9533c78353af6', '1', null, null, 'static/core/systemMonitor/logMonitor/views/logMonitor.html', '1', 'logMonitor', 'logMonitorCtrl', 'static/core/systemMonitor/logMonitor/logMonitorCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('20b8e3982af34d46b74837d56d31d345', '搜索面板', '2', '44d7a7d2f90c4f709cb39dcd0ade7bc2', '1000', null, null, 'static/core/examples/common.html', '1', 'searchPanel', 'searchPanel', 'static/core/examples/util/searchPanel/searchPanelCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('365b6a50e81f451d9c0513cbcf11d3fc', 'DOM元素托管', '2', 'a940051720114014be1e5d936e73f7a8', '8', null, 'DOM元素托管', 'static/core/examples/common.html', '1', 'floatTouch', 'exFloatTouchCtrl', 'static/core/examples/thirdParty/floatTouch/floatTouchCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('38c1c995477747638c10033e05f3131b', '数据选择', '2', '44d7a7d2f90c4f709cb39dcd0ade7bc2', '80', null, '人员选择', 'static/core/examples/common.html', '1', 'dataSelect', 'ep_dataSelect', 'static/core/examples/util/org/dataSelectCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('3edf0a279e81429db2726001e6312644', '表单验证', '2', 'bd517830fd3e45fa80b641879d035986', '3', null, '表单验证', 'static/core/examples/common.html', '1', 'validate', 'exValidateCtrl', 'static/core/examples/thirdParty/validate/validateCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('44d7a7d2f90c4f709cb39dcd0ade7bc2', 'Util', '1', '4cd840238ee94195b459811d8a5b9749', '1', null, 'Util', null, null, null, null, null, null);
INSERT INTO `pd_web_menu` VALUES ('4cd840238ee94195b459811d8a5b9749', '开发样例', '1', 'root', '1', 'fa fa-bars', 'a', null, null, null, null, null, null);
INSERT INTO `pd_web_menu` VALUES ('5afd7e818bf345448cb6a7eb5fa13b44', '监控采集设置', '2', '9217f4e385aa4845aef9533c78353af6', '4', null, '配置监控采集指标参数', 'static/core/systemMonitor/collectionConfig/views/collectionConfig.html', '1', 'collectionConfig', 'collectionConfigCtrl', 'static/core/systemMonitor/collectionConfig/collectionConfigCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('5d346390ec6b4c1cb82a7edb2b0f716e', '主题设置', '2', '1599dd58952f4e41a113a570c35a5dc5', '100', null, null, 'static/core/system/pageInfo/views/index.html', '1', 'pageInfo', 'corePageInfoCtrl', 'static/core/system/pageInfo/pageInfoCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('6b2565f29ae247cc8175eb124e4d3f77', '字典管理', '2', 'b9b1bb999e434b65a3a989980d4a056c', '1', null, 'dict', 'static/core/examples/develop/dict/views/source.html', '1', 'dictService', 'exam_dictMgrService', 'static/core/examples/develop/dict/dictCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('6f86bc428501457bb5f419c9d69cc179', '图标', '2', 'bd517830fd3e45fa80b641879d035986', '5', null, '图标', 'static/core/examples/common.html', '1', 'fontawesome', 'exIconCtrl', 'static/core/examples/thirdParty/fontawesome/fontCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('78509ecfb3134f8f939be3c6e73ad366', '告警日志监控', '2', '9217f4e385aa4845aef9533c78353af6', '30', null, null, 'static/core/systemMonitor/alarmLogMonitor/views/alarmLogMonitor.html', '1', 'alarmLogMonitor', 'alarmLogMonitorCtrl', 'static/core/systemMonitor/alarmLogMonitor/alarmLogMonitorCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('8123db55c8de4d0fb23e47e4c63628dc', '右键菜单', '2', '44d7a7d2f90c4f709cb39dcd0ade7bc2', '100', null, '右键菜单', 'static/core/examples/common.html', '1', 'menuComp', 'menuCompCtrl', 'static/core/examples/util/menu/menuCompCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('82883a104cf24744af6d43a0e80cbbca', '图表', '2', 'bd517830fd3e45fa80b641879d035986', '4', null, '图表', 'static/core/examples/common.html', '1', 'ECharts', 'exEchartCtrl', 'static/core/examples/thirdParty/ECharts/eChartsCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('86edd1c526fe4cd598e2f93493830ba1', '缓存监控', '2', '9217f4e385aa4845aef9533c78353af6', '0', null, null, 'static/core/systemMonitor/cacheMonitor/views/cacheMonitor.html', '1', 'cacheMonitor', 'cacheMonitorCtrl', 'static/core/systemMonitor/cacheMonitor/cacheMonitorCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('89162b39499d4c728e657594b2284d9b', '弹出框', '2', '44d7a7d2f90c4f709cb39dcd0ade7bc2', '10', null, '弹出框', 'static/core/examples/common.html', '1', 'dialog', 'ep_DialogCtrl', 'static/core/examples/util/dialog/dialogCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('8aa05930a7684a78a9116753cb2c6ffc', '开发规范', '1', '4cd840238ee94195b459811d8a5b9749', '0', null, null, null, null, null, null, null, null);
INSERT INTO `pd_web_menu` VALUES ('8b380aaa0a4a4711982ab67e73ae1b74', 'treeDialog', '2', '44d7a7d2f90c4f709cb39dcd0ade7bc2', '1000', null, null, 'static/core/examples/common.html', '1', 'treeDialog', 'treeDialogCtrl', 'static/core/examples/util/treeDialog/treeDialogCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('90fae14ab99d498586ddfdd92ac23208', '资源管理', '2', '1599dd58952f4e41a113a570c35a5dc5', '5', null, null, 'static/core/system/acl/views/index.html', '1', 'auth', 'coreAuthCtrl', 'static/core/system/acl/aclCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('9217f4e385aa4845aef9533c78353af6', '系统监控', '1', 'root', '3', 'fa fa-bar-chart', null, null, null, null, null, null, null);
INSERT INTO `pd_web_menu` VALUES ('96cbdba35d654bd4905fcf6915a7d90f', '用户设置', '2', '1599dd58952f4e41a113a570c35a5dc5', '10', null, '用户设置', 'static/core/profile/views/profile.html', '1', 'profile', 'profileCtrl', 'static/core/profile/profileCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('9e2ecf2fcac149ee90110e224a158914', '服务器监控', '2', '9217f4e385aa4845aef9533c78353af6', '3', null, '监控服务器、OS、JVM信息', 'static/core/systemMonitor/serverMonitor/views/serverMonitor.html', '1', 'serverMonitor', 'serverMonitor', 'static/core/systemMonitor/serverMonitor/serverMonitorCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('a141173264e849caa3626b95fa302f55', 'inputSelect', '2', '44d7a7d2f90c4f709cb39dcd0ade7bc2', '3', null, 'inputSelect', 'static/core/examples/common.html', '1', 'inputSelect', 'ep_inputSelect', 'static/core/examples/util/inputSelect/inputSelectCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('a405a09596d94c9b895983d1ecc1bfe6', 'treeAndGridDialog', '2', 'b9d4630e9e21419b97fc18a2272bb2e6', '2', null, 'treeAndGridDialog', 'static/core/examples/common.html', '1', 'treeAndGridDialog', 'ep_treeAndGridDialog', 'static/core/examples/collaboration/treeAndGridDialog/treeAndGridDialogCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('a6f03a7edee0423a8a31a1b0ed1ebf20', 'ntkoOffice', '2', '44d7a7d2f90c4f709cb39dcd0ade7bc2', '1000', null, null, 'static\\core\\examples\\util\\ntko\\views\\main.html', '1', 'ntkoOffice', 'ntkoOfficeCtrl', 'static\\core\\examples\\util\\ntko\\ntkoOfficeCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('a810f123344d446495e7526cb2343508', '网页播放器', '2', 'a940051720114014be1e5d936e73f7a8', '0', null, null, 'static/core/examples/common.html', '1', 'ckplayer', 'lab_ckplayer', 'static/core/examples/thirdParty/ckplayer/ckplayerCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('a940051720114014be1e5d936e73f7a8', '实验室', '1', '4cd840238ee94195b459811d8a5b9749', '200', null, null, null, null, null, null, null, null);
INSERT INTO `pd_web_menu` VALUES ('b95413c223e941639962fd71e4b613fd', '菜单管理', '2', '1599dd58952f4e41a113a570c35a5dc5', '3', '', '', 'static/core/system/menu/views/index.html', '1', 'menu', 'core_menuCtrl', 'static/core/system/menu/menuCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('b9b1bb999e434b65a3a989980d4a056c', '后端API', '1', '4cd840238ee94195b459811d8a5b9749', '6', null, null, null, null, null, null, null, null);
INSERT INTO `pd_web_menu` VALUES ('b9d4630e9e21419b97fc18a2272bb2e6', '组件组合', '1', '4cd840238ee94195b459811d8a5b9749', '3', null, '组件组合', null, null, null, null, null, null);
INSERT INTO `pd_web_menu` VALUES ('bd517830fd3e45fa80b641879d035986', '第三方组件', '1', '4cd840238ee94195b459811d8a5b9749', '2', null, '第三方组件', null, null, null, null, null, null);
INSERT INTO `pd_web_menu` VALUES ('ca1632492ea64d4381bd89eee450b4f9', '附件上传', '2', '44d7a7d2f90c4f709cb39dcd0ade7bc2', '120', null, '附件上传', 'static/core/examples/common.html', '1', 'fileUploader', 'ep_fileUploaderCtrl', 'static/core/examples/util/fileUploader/fileUploaderCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('ccd4f246ab1f49d390cbaad97ca13688', 'typeahead', '2', '44d7a7d2f90c4f709cb39dcd0ade7bc2', '2', null, 'typeahead', 'static/core/examples/common.html', '1', 'typeahead', 'ep_typeahead', 'static/core/examples/util/typeahead/typeaheadCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('d449d791a7544431942ece0bb2a24eb6', '树', '2', 'bd517830fd3e45fa80b641879d035986', '1', null, '树', 'static/core/examples/common.html', '1', 'zTree', 'exZtreeCtrl', 'static/core/examples/thirdParty/zTree/zTreeCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('dd92a431a718435aa10e33f817bac82d', '持久层监控', '2', '9217f4e385aa4845aef9533c78353af6', '2', null, 'druid持久层监控', 'static/core/systemMonitor/dbMonitor/views/dbMonitor.html', '1', 'dbMonitor', 'dbMonitorCtrl', 'static/core/systemMonitor/dbMonitor/dbMonitorCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('e461feb8e45f453c91e66e9830f60216', '组织管理', '2', '1599dd58952f4e41a113a570c35a5dc5', '2', null, null, 'static/core/system/org/views/org.html', '1', 'org', 'core_OrgCtrl', 'static/core/system/org/orgCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('e49e323ff4eb4ef9bb5ce3494449c344', 'API&CSS规范', '2', '8aa05930a7684a78a9116753cb2c6ffc', '0', null, null, 'static/core/examples/util/standard/view/doc.html', '1', 'standard', 'standardCtrl', 'static/core/examples/util/standard/ctrl', null);
INSERT INTO `pd_web_menu` VALUES ('f01bb2b9d6f84b028b4ca5d562edf4f0', '日期', '2', 'bd517830fd3e45fa80b641879d035986', '2', null, '日期', 'static/core/examples/common.html', '1', 'dateTimePicker', 'exDateCtrl', 'static/core/examples/thirdParty/dateTimePicker/dateTimePickerCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('f10edc3ef2af4598adbf6c2e5ae54dfc', 'Sword平台信息', '2', '9217f4e385aa4845aef9533c78353af6', '100', null, null, 'static/core/systemMonitor/serverInfo/views/serverInfo.html', '1', 'serverInfo', 'serverInfoCtrl', 'static/core/systemMonitor/serverInfo/serverInfoCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('f2f598c6cf404ee19ac7918114bf67fe', '滚动条美化', '2', 'bd517830fd3e45fa80b641879d035986', '7', null, '滚动条美化', 'static/core/examples/common.html', '1', 'mcScrollbar', 'exScrollCtrl', 'static/core/examples/thirdParty/mCustomScrollbar/mcScrollbarCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('f39aa06c58544e99b4ff15351e74f51f', 'uploaderAndGrid', '2', 'b9d4630e9e21419b97fc18a2272bb2e6', '3', null, 'uploaderAndGrid', 'static/core/examples/common.html', '1', 'uploaderAndGrid', 'ep_uploaderAndGrid', 'static/core/examples/collaboration/uploaderAndGrid/uploaderAndGridCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('fd5b4cf46c724b8995c454b3db94ed12', '字典管理', '2', '1599dd58952f4e41a113a570c35a5dc5', '6', null, '用于字典管理', 'static/core/system/dict/views/dictFrame.html', '1', 'dict', 'coreDictCtrl', 'static/core/system/dict/dictCtrl', null);
INSERT INTO `pd_web_menu` VALUES ('root', '根目录', '1', '-1', '0', null, '根目录', null, null, null, null, null, null);

-- ----------------------------
-- Table structure for `pd_web_menu_auth`
-- ----------------------------
DROP TABLE IF EXISTS `pd_web_menu_auth`;
CREATE TABLE `pd_web_menu_auth` (
  `uuid` varchar(50) NOT NULL COMMENT 'uuid',
  `menu_id` varchar(50) DEFAULT NULL COMMENT '菜单标识',
  `user_id` varchar(50) DEFAULT NULL COMMENT '用户标识',
  `user_type` varchar(20) DEFAULT NULL COMMENT '用户类型',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜单权限';

-- ----------------------------
-- Records of pd_web_menu_auth
-- ----------------------------

-- ----------------------------
-- Table structure for `pd_web_pageinfo`
-- ----------------------------
DROP TABLE IF EXISTS `pd_web_pageinfo`;
CREATE TABLE `pd_web_pageinfo` (
  `uuid` varchar(50) NOT NULL COMMENT '主键',
  `system_name` varchar(100) DEFAULT NULL COMMENT '系统名称',
  `login_bg_url` varchar(500) DEFAULT NULL COMMENT '登录页面背景图地址',
  `home_logo_url` varchar(500) DEFAULT NULL COMMENT '首页logo地址',
  `theme` varchar(50) DEFAULT NULL COMMENT '主题样式',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='页面定制参数';

-- ----------------------------
-- Records of pd_web_pageinfo
-- ----------------------------
INSERT INTO `pd_web_pageinfo` VALUES ('18034eecf75f43f5927cfcf8d9f2e2bc', 'Sword-Room', null, null, 'blue');

-- ----------------------------
-- Table structure for `pd_web_shortcut`
-- ----------------------------
DROP TABLE IF EXISTS `pd_web_shortcut`;
CREATE TABLE `pd_web_shortcut` (
  `shortcut_id` varchar(50) NOT NULL COMMENT '主键',
  `shortcut_user_id` varchar(50) DEFAULT NULL COMMENT '用户id',
  `shortcut_menu_id` varchar(50) DEFAULT NULL COMMENT '菜单id',
  `shortcut_order` int(11) DEFAULT NULL COMMENT '排序索引',
  PRIMARY KEY (`shortcut_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='快捷方式表（用户快捷菜单表）';

-- ----------------------------
-- Records of pd_web_shortcut
-- ----------------------------

-- ----------------------------
-- Table structure for `sword_scheduler`
-- ----------------------------
DROP TABLE IF EXISTS `sword_scheduler`;
CREATE TABLE `sword_scheduler` (
  `job_id` varchar(32) NOT NULL COMMENT '任务的标示',
  `job_name` varchar(50) DEFAULT NULL COMMENT '任务的名字',
  `group_name` varchar(50) DEFAULT NULL COMMENT '组的名字',
  `description` varchar(200) DEFAULT NULL COMMENT '任务描述',
  `class_name` varchar(100) DEFAULT NULL COMMENT '任务的类名',
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户标示',
  `org_id` varchar(32) DEFAULT NULL COMMENT '机构标示',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `job_status` varchar(16) DEFAULT NULL COMMENT '任务状态',
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sword_scheduler
-- ----------------------------
INSERT INTO `sword_scheduler` VALUES ('ee001bd495fc40c0908ab98f26187939', 'collectMemoryRatio', 'collectionService', null, 'com.css.sword.core.components.scheduler.job.SwordServiceJob', null, null, 'creatorCurrentUser', '2015-09-15 10:34:42', 'RUNNING');

-- ----------------------------
-- Table structure for `sword_scheduler_log`
-- ----------------------------
DROP TABLE IF EXISTS `sword_scheduler_log`;
CREATE TABLE `sword_scheduler_log` (
  `uuid` varchar(32) NOT NULL,
  `job_id` varchar(32) NOT NULL COMMENT '任务的标示',
  `job_status` varchar(32) DEFAULT NULL COMMENT '任务的状态',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `message` varchar(500) DEFAULT NULL COMMENT '消息',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sword_scheduler_log
-- ----------------------------
INSERT INTO `sword_scheduler_log` VALUES ('000d329429e945d8a0763ab0cd834ec5', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:05:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('002801dbe4ac417b95e53b67d77c66e1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:41:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0042de08b5f749a998f56408c92a15ca', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:45:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('011dcdc9cc384af2a0161bb0c8ae2518', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 15:00:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('01235a1e768949d3b67f2b4bcb020b4c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:00:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('01709f645dfa4c00b49f353a36983ba9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:40:01', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('01a15d2e344f49d588e8baae0c0f0059', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:41:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('01b287a943b1451d90117e2621b537b6', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:39:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('01c7fd69d72c4a8e902783eb0d065130', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:45:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('02465b42b1df42af93dcf9b9db5da8b8', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:51:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('02555bbb5bdd49c4b2abe0f6ef8d8169', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:51:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('029465e8f41d4e24be10b87f8201771e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:10:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('02a85c0bbd8b4e36a1f6a757c8115d8b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:39:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('02ad2d1eacde42aaadf329887928b2cf', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:50:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('02ce9809ccc04ca7b1cefd57cbc85b15', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:36:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('02dda6d8f2334c33a0de93204a46ad64', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:46:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('02f591a26c6449e398e195b49723a475', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:42:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('031fbab3d6f74af7b6bd3408671ba2d7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:20:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('032551e0baa242f2ae95ee1472617117', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:17:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0326736dfc354064878403dd2a5789e8', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:30:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0340951296f8416698d8e13fbfb8d66e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:17:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0356ab0851ed4959805736e31b8e056b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:35:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('03ab752bbed54775ae7a809178e2391c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:53:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('03ada7e3ed1846bb909dfe3c773cb8f3', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:29:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('03cd860f9b574f7585bdfa58f13c51e8', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:05:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('03d36132631d43e28cf655a8b24ae390', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:54:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('04427d5b16f242c1bc9a334fb1dfb7b8', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:30:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('046566116d63412687aea39d97a60ace', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:58:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('04d2f0a1dcfa44dbbc7c37b3e6fa2779', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:54:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('04eceb641b5c49aa98669464baa4a360', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:40:01', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0519a9bbbd0047aeb2820fc2a6bd3d7b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:40:28', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('052f8fc00bae4bc6ada0d17cee45e91f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:45:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0557e6f127534fdbbf6a9597e5728a2e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:03:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('055b3176ffec49a3b98fe5c616c43a9e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:28:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('05ec25a8d5d44e80a13dc6343364c437', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:07:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('061c6446ab7e423c81f8831cd3082fe6', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:40:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('063ff58f9e5f40098f8490d65c98903c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:39:28', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('06424d0102e74e5cb87f49254887c7fe', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:23:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('067b288ad5ab4737b1cc5caf214bc5a8', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:41:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('06bc7f5800e94336973a3a940fcbd7f9', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:01:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('06ce6c03d548410e9a434c8a87ea04db', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:50:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('06d6c95adc8b47b6a158b76dc298efc7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:55:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0705b2937a394cf98bbf9b08e42a4842', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:03:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0725b7ba5e734bb284931b8c22b76a06', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:36:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('07592052a32f49f1a8149a17b98de9b5', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:01:47', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('07f84fdb97db4027ad83c846e63b25b9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:11:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0807861be4f74a05b9703d5007fb7398', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:53:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0844ffdea3be4d1993f518d3ff8607e2', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:31:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0850ff3ae88d46a7852772a94b26805c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:46:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0870e5fd8a2541abbbf1c278a47fd900', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:36:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0877739b79284e44903d6863a781d8b0', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:27:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('088162a9e3004de2afb4f8a027519f02', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:56:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0885887017024885a2e149368a0721c4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 20:03:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('08ad9088fce7484a992869a8083ddf75', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:36:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('08b30ab2cbbc468bbcee963759631191', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:46:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('08b3234b49434a158176ff8dea19f692', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:57:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('08c856d6ee6f4d299f6273a065ebf942', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:27:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('08d253de8acf43e3bd53667f93194969', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 11:02:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0936e2a5c3554feb8f341c04cf0387d8', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:05:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('096dc14a579940449d3a11508b26844d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:39:49', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('098bf34a9fc64817939d3fde2d959436', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:38:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('099061fa553b43f8b14ba098e4370555', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:19:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('09bf2428ed9d41b8b28258275c12fb0f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:47:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('09c2aecbc5a040e2880957551b00254a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:51:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('09d9a303e9bb4621bc09b2221761d437', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:01:17', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0a0849955e1e4990931ecbafe7a2cf26', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:45:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0a15400a85d74fa3a55063a8eb342e35', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:43:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0a2dd625ae53453883306a8be3bc1a1c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:33:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0a58f2fbc5894fa7a71283101fdde1bd', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:49:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0a5a8ae40ddc4864b548eb25837d4211', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:58:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0a8ee24ea82a42b39109342f15adf4c7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:39:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0ace25df7c604cd4a1fc1b910a529783', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:36:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0ad0f491e0c645798da69c658a17c8a5', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:20:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0ad1418b9315476eb71f49f0b1f78f31', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:20:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0ad71a902aaa4cfe9b337e77d0439c28', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:14:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0af1d6d267af411698783b6408fa73d6', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:24:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0b02c97baa834dde9a1d18bf824bc0f1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:11:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0b3ecfc464964e51af034502dea436c0', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:49:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0b8461a6e91546959c9ac37d2a184566', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:34:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0b9eb41211d64bf282245dd5df99091f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:24:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0bb06c3bdec345ab86e1972a7a47a049', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:31:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0be7af9ab1b44505a9b2a508cfa75f8f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:52:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0c02d1530310473f891f7b4d42c091af', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:05:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0c250ba768be4f129f310fd3d1ad489e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:18:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0c587ff160444b699262bae7dcbda67a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:03:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0c95f0ea02ac4c3b9336bc8f754c1831', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:47:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0c9758dc41ca416080d67283359cc4b0', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:18:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0cbf22f77290435da1e30ee207795372', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:47:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0cc6e11994ea45a4b5a3f6264212c344', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:48:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0d501157255946b284e80376b372a6a5', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:18:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0d63338bd1b54d7b960a7f1618339533', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:57:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0d7695b92ce64f5f91bbbaaea3825944', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:55:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0d8246d07e634b03b9e66a9a6d8b2fef', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:25:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0d8bac56913944b7934dc1774c2aa54f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:51:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0daf57307e814d50a6fd1152ba4c6e96', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:38:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0e05372fe12a4611872290e89c7fa5ca', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:02:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0e058f79f35e480b94554ff69c5f2f90', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:29:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0e0fa90840044f97ab8e81fa7361e006', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:08:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0e54d675fd4e4b1e8df2334d83040580', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:09:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0e698ef855664469b225d8af433f9937', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:27:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0e93e9a31eda43dbb4827a2544bd1a57', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:22:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0ed95e5ce77f45dd8def2135f2ee7f73', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:42:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0f1e63fe415b4caa9a77164f19fe427f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:17:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0f2f72735c3c4ee2abc01c344a5007a4', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:43:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0f49c45eb0014db8889e97a174ca7848', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:44:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0f7118bc7b744682928bef4b47897e9e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:49:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0f7ed1abc86f4fcf93795266a0c18920', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:15:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0fac4039684e4e79b6468d645f96813c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:55:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0fba5b5c43424cdb842b2851cbaa0c96', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:54:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0fce16e366f649e3b8875a5d567c5d97', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:23:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0fdb18bd1e3048fea69c18a9578ed995', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:46:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0ff8c431580e4bfeb073725c7695ef59', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:29:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('0fff47e1cd69442392ef2efe6d437dd4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:10:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('105aab87e4fa403b8586b2640c2e505c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:35:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('10a438fb1077468e9a3a2bb29611fb37', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:05:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('110d0f7f1575428292f22da0f6be9b8f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 15:01:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('111c3f1b2e1544f7b2aab5ea39800863', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:47:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1186689e1ce945c489ab1a1aa5ef6803', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:51:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('118a63f95bbe414fb98a8b2cc91baca5', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:58:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('11add798a5464efb80b3ef5593e552d5', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:01:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('11d10e442f144ead8dbba32ab84f0cd8', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:20:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('11d7a7cfef5e495b94f8b1a0ab17e59e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:46:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('12033451ee9547669ae1b0714473de82', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:19:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('12154779825b41f2ae1c8cbd13ace940', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:39:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('12303703acb84a8082104d347e5e51a0', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:38:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('12475ee525a2427fbac8c5693217c931', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:51:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('124925392ea2488bbda2e7b54fbdf589', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:38:28', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('129718988b354474b26de0fa9977727e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:53:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('13183862ed2a41e8a0fc8ab8847afa94', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:30:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('137a26fc4464422b9428d3c8da38201a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:45:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('13a5d1f564ac4ec4beae2e661fad9d33', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:11:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('13b4c862acd84efab3b4959501a77181', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:51:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('13d73604daae4e909bad066b51d6c539', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:50:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('13e3ead719014ffbb281c674e7e29a2c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:01:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('13e440aecb6f42d1a1bac41d94963d71', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:15:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('13f80279d65f4dadb74646403176f8c4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:24:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1403578d600a47168701e1c87f96b457', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:08:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1419f666214945faa5d49b0985a1064d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 13:59:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1458b5d0babb4d13a0ce59d1120e4217', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:13:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1469d5fcaf6d4bd5ad63453526369d22', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:13:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('14772383a9ae436bb312f6538eabeee4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:31:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('14a9902da39c477d8cea0d9b7ef677ba', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:28:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('14d045852e5343daaf6bdb05545af204', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:46:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('15151a811008470e8cbd8b38d8ea4789', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:54:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1590f6c731174a34b760f4f453b3a9ca', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:22:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('15a0c6235754479a9624f9106e2d250c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:04:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('15f473308db04bc8a1f01b60cd94417e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:17:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('167bca9446274a7eb5b8cdba09777272', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:45:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('16abf5d549be4696a90d28a0b2ad146f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:43:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('16afd092a8f54316b21227ce771d9719', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:47:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('16b7a8e8598e48eba4c9d7696558a6cc', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:57:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('16cb2947c68e4a9b88ba9d847acf229b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:37:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('16ddb3094bc94f90a831fd14dcf2d9e4', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:54:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('16df4ff615734623ae2a3ab067dac380', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:44:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('170de224741e45aeafda89a056ad6c96', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:08:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('17154997bb29471e89ee20309a4c8792', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:38:49', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('176401f67c9c452892b3d187bd59ffe5', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:23:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('176bb20a370b4adba89157db8b24363c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:42:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('177163cb91de430380bed5bff64ade9b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:34:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('177d5c726ebf4985835f6a7235b52982', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:14:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1788de8414424b748b880efe069dd4c4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:30:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('17bc5313e6384c87becc61414838278b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:26:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('17beaeade451445eaa4957164a2f477f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:34:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('17d6da1b861b4522af3da5729de373d9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:52:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('18a77036c6f44f6289f2e7b511f39781', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:11:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('18ae34775d8246a1859365c2e9c5f2f4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:31:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('18cfba46134d4efba3f872168d766351', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:28:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('18f6c2fa8169483d9e0dd793854d3101', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:57:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1957e66959af4e8cac51207d800bda30', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:58:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1977454cf21540278c7bf1fc4afb0979', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:07:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1989a4cbd67242a3ab1ab407229c69da', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:37:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('199d1e2ad53e49f9aa2a95b32bff86fb', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:48:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('19b137ed4e44406da0f76857bf6a90ba', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:56:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('19c708f9645744a689ae5dc7c1bc882a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:40:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('19e46f596a8e4a8ca717cfb5acd4e43c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:40:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('19ed11af1599438dab97e5fa00aa3366', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:53:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('19ed7b5fe91f4fb6a206bbf9ba4c030d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:58:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('19f286e95fcc46e9875afa36cca62b67', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:39:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1a4f83b4e9074b76ba7ef34f7a172222', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:37:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1aa7052097074b25bbfa05c684811b48', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:27:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1ae4ca6a1f6f49368567bbde45a25014', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:40:28', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1b03cc90195b4744a1ba01c812457649', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:43:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1b18a39761554934b5045fe9b0b0e06d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:18:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1b22355e296c48a2a50c4940e36ce552', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:57:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1b304319b9ef48d99e243566925dec98', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:30:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1b778f8989794552933783da50fd5f2f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 20:06:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1b9a1caa47c74f2abaa206395babc79e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:48:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1bad606714e74ff3919400292b3b6a49', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:57:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1bc52f8a63e4472da19d62fb357d0c5a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:19:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1be3052779134c52bb59c138dc79c2a3', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:41:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1c0c1873465a4d82b13ded1e10e8a053', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:07:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1c67d2675ed342998a8857aea587a488', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:44:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1c753b3f434644e08d3918c78dc6c0e6', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:55:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1c899b5f15264521a27e66d1fe4c9228', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:38:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1ca38fd6e216467ebfb958051e2eff7a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:26:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1cb0721f424e4b8aabca2edff1fd7e99', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:44:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1cc6d19a5b3646dba5603b61852cf3f7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:45:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1ccfbb748674425ebc7eaecef96651fa', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:26:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1ced07f014ff4f8991dd96860d065c6b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 15:07:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1cf1008d7fa8484ca8db0a0bcb64323f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:41:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1d47d582472143999cf26ff75375c420', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:01:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1d511a7a2ee54e199255488d8fd70213', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:54:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1d69d3e481e64f63a51ef7fe9f82c96b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:47:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1d6d981cdd434c6da75e0062a38ae9a2', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:16:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1d724f54d3d74f63a2ba83e55984650b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:43:28', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1d9bf1b87d37452a8fe0a3e9438eb4d5', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:34:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1da80ea17836403bb4cc40329032f151', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:40:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1db6b8b974f846088e902f6636779cf2', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:39:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1dca1a153a7d4d1799ad2b40e59cc128', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:34:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1df69fef0f0f40dc86aa765b2e7893e7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:43:03', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1e03866ea8a742c289ff6df2993a1c2b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:56:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1e11e4bf10904355b4667162b17d4fee', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:47:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1e2d02edd3ff4b449fa59880e64a3b79', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:38:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1e38189df09c497284fa219ba0a27c1b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 20:02:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1f2d79ba603c4e52b106b9e2d99d65b9', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:17:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1f4fe761207b4e48bde456ced85a3b5e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:16:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1f5c9764aa2041ef8e0e4bebee4a60e6', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:48:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1f5f5d1abaed4001a095a234e2aabba5', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:33:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1f629368fe43491f94dafe4da82687c9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:07:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1f64f39926ea44cb9073d452f8f7c387', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:06:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1f6ad1a1a6e34d70ade86bd570c5974a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:30:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1f96c43fd2234e83baff1992a4d64acb', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:00:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1fac274836774741b8a4e887edc7a6cd', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:23:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1fbeb3e89f3f46a3b68867184ed54726', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:36:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1fc5493c8bcd43039f78cf50482475df', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:26:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1fd8b3c4c1b247ec921dfa554adc8fdb', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:38:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('1fe03f87938b4ebbbd03f10c5e986ae1', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:03:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('20119db8b7474975822fe612787d4cfa', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:08:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('207c0c7769c3498e95c5a6ed43275574', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:08:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('20affc979db8429494b91136235b6e7f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:42:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('20beaa157f6044e698823430aeee90ec', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:44:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('20d8eb5fe5c946f6a670c0791e58b4a3', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:52:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('20dcab738cd14b1cab1389d3fb05e17c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:13:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('20fb60b6064a4d889427179779240dd8', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:05:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('211164d36aad46e99754b2fd5b8a576b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:48:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('211932f9b3df4b3cbd3a963162841dd9', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:02:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('211d7b84703a4414b912489e52316436', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:52:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('214418da99ec4422b064b527236cf64c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 11:01:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('21871e47fe884f87bb34c717c14d80be', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:24:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('21987f7fc93d434eab4824193432da0c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:06:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('21c08790a21847fa86291bfa85adb1e2', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:35:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('21dbc4b5ef0d40d095e8917f4d25c614', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:57:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('220a6011ddb34020a0459b3cfca0f2fc', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 15:01:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('222b52ba03c1433cb76d5c009af67f18', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:33:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2236b17a126a4cd792ba28ca9162c10b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 11:04:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2239bec96bd14d52a9782d6abceed33b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:34:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('227b3928b94943b8b89e16ab24e80456', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:20:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('22a152108c814e04b2b5371009f27cd9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:24:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('231c46b81bcd4feda21007d0478054a5', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:43:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('236516f2ec024b7ab53ea5d6f96a76db', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:31:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('23691a75eb834ee49ad46884019f068a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:09:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('23ac70decf74490ead3e2abdc3785001', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:22:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2423b497eca146da8cc8270dd5cc5f98', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:39:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('24259b7688004e57b1a289e4f89ad34d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:05:47', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('24301e83eebf42549d4aedbef4edeb37', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:18:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('24629d0c46f5448993d3393f2c5e69ba', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 11:01:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2490f5555d7043ccace78dd8609e4117', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:30:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('249938bf461d4ffd9c869eff11fac3cc', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:37:19', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('24bd6e836662413eaf7f53b40dd6d60c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:33:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('24c868be97f04027aac7852a63db6301', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:37:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('252e8d778a3c4f46a65c0bc9d9bd5e4a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:12:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2589d90d36024130883b9681662a32ce', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 11:04:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2596e08565654872a3fd7ad818611332', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:52:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('259d3918824245bcb316ae1cecf41bdf', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:51:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('25c2219bd3364a639e02c2f238c6134a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:50:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('25e5c330ba084fe7ab582b2ca3e63ffe', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:14:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('25f62d62c9e1470d96de4679d9e7ce4b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:18:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('26051d7c291946df802a63de9ce8c2db', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:58:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2613c8cf0e57450091cb3c3e33df3c83', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:42:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('261fee263be04fd8a460616cb6bce451', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:52:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('268e4521cbbc45e3ab671a146e2d5b40', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:19:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('26965307a6e24d3a99e726a81339ef47', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:27:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('26b6f0eb0ba243c88ab63d1d20fa9ec6', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:25:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('26d0980af1e540758ed2195ac9d33f85', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:43:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('26d30d761f594f11b872dc9a802cf65a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:28:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('26d7e0876f414e96958e6d21a13b8182', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:41:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('26dc8a8ddd7c496691be8909e9f82664', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:53:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2720b44ceb98497687a028fe8b77e53c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:17:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2777391fed594f309d0947cbbb330072', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:41:49', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('279978638a7e4828a704fa5b0b54383b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:39:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('27bcba8c4b0446b093579685bb6bb6cf', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:17:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('27ce1735f45449df8fdee349b4092462', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:12:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('27de2cb0dcd24a2aa4e28dd28d3f25ce', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 15:02:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('27ecfebc0412478b8538ba70bfdd78c6', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:02:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('28449c5a366648d0b2741d35bf798cbd', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:50:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('285ce42864e641cca6ce89fb0bb4fe1a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:50:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('286cb0364abf4497922ce995288e74ed', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:52:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('289507c6b8024aeab8048315a8fefe5f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:33:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('28aaec1e8624400899bd2e4cced8827d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:10:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('28bfe991c0e94aee9c31edef7408ff11', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 14:36:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('28e3c155fe92408ea2f4b9a706b63a13', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:59:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('28fe37e8717949b28ad9764fa0cba9ff', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:28:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('291703a04ac24c2bba778c2ddef35180', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:22:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('29602e059ec84fe19a71fca86bdb7a1b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 15:01:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('29607be8df12480198c5fdc4e92a5962', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:00:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2991848393264999996fe768f9ed9f5c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 20:04:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('29caacfd7d454c5aa4a4f77fb6770bad', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:21:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('29d9540b7b9c4d1f955718dbaa24b14c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:07:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('29ddec5d416f406aa4ab46f5707c439a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:43:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('29ff379af33541c9b86b6a1198a6d369', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:34:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2a1c03d511134552b1ed3f2e027eb429', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:34:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2a4253a434e242dd978368ec1fe53f84', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:54:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2a67f0fe796646a0a4cf533e4718c158', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:23:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2af93b1762aa4110b1714047eeb52af4', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:21:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2afe2f59ed6341cb8940d2dc68b2722c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:53:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2b3df11409b243009b7fd400119d53b1', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:02:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2b41de64e487496c9410ddd1b0bbdc15', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:07:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2b5ef65628264569aabe57a6fee6ff28', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:12:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2b88eb0dac2e4d10bb053990dd1f7311', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:13:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2c02eb51f5694a36a86179b01ec76ee1', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:26:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2c17c618751a4c608750416520c266af', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:27:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2c49c51324bc4935ade5a298a3a52142', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:49:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2c5c0da607b6464d97d789af3e0b03f4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:16:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2c81e39daa704c0089b40e218aa52d1a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:32:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2c8515e65b68463d9d5858da3bccb02a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:02:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2cbf1f624ad447e383d2a02b2e284fd2', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:41:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2cc121d1bbc14579ae7f84e60d482a18', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:18:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2cc63bd130d54b87b834e79a839e585e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:02:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2ce22cdc898447a0970aff8dd14ce9cc', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:49:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2ce2561b54e24f4d97e07c70cfaf7e56', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:37:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2cef1af0faec4f419d7464f3fd37ce9f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:29:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2d161d3a04e94dfeb40c8c31204519bf', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 20:06:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2d3bc117722a424cb45e4e4af7ca1f30', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:57:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2d44e42b4654454483b5b6058f5ba73c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:18:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2de7d6e0f93844b5ac902b1301a53280', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:43:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2dfd35f6fb84497abaeee53e4ef54575', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:06:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2dfef11efd924da494ee0326843b4984', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:28:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2e18477ca9a94896b3f54246c6ad06b3', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:39:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2e81fba5d371492485510f32f5bbf81e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:54:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2e9a1fffce7f40f8997406dde144badd', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:50:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2ea573c5d4a94072ad97679f1b2b8593', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:00:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2ea95cb27deb4c83b4aa9f2b26f67f7d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:56:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2ec1d91efa704f1da0a69e1fe970e3c0', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:43:03', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2ecee39f4ef4428ba9165c2bdc70e617', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:19:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2ee014d309884b4f90a8e61f50df3bca', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:35:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2ee4cb473dcf4de4b257dc937bc9c57c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:51:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2eeb50b3cab149eebf2cafa4e67fd2ec', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:49:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2f328aadc3714a3dbe66d79ba4fbe1c0', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:43:00', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2f65ace0dde1499abaea121854bda1a4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:48:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2f8788f61aef4bd8b7cc76b045c60623', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:30:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2fbd0d78b33c4f24b9e82053edf29508', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:43:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2fd642e702b9401ab9d6d9ee692c56b4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:45:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('2fd7759fce964bc78bbde63fcc43258a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:10:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('307b469cdbc742458d91dd1f29939694', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:45:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('308a0065e0cb4d49a4b10290271ae1cb', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:01:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('30d1f398993b437ab501a9622ca7d5e4', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:49:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('30d9749026e242d0b9fa9dbec622210d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:55:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('30eaada322974711a0f83650ca67988b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:46:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('30f9afdb30404a29b8bbdfd2de542ddc', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:59:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3127e64947574e018dd587c908e33231', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:40:31', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3149bf69e67d48baa92db23b6c2dc18f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:04:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3170116e8d6440868476f88c2b9f6ec7', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:43:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('317e87f5b2154870808db31ac3ee026a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:13:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('317fa102c6544232af15936f78b47857', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:35:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3192499862f14ed2992dde4d4e4272e8', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:58:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('31b2e3d5fe0d4760bf2a6df9240b1853', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:55:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('31b4e0e1062744b08f53c0e4a6b386d2', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:44:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('31c2e4fae0a84ebb896ef87bf608fdd0', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:46:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3242639063b94267be3f986e967aad1f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:55:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3256e3d20e384f169504108f06dd927b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:02:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('326c5f269fa347c583bb7fce5b12d2ce', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:19:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3272588d7a37414192f255804ea25c57', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:37:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3286f0e53cb44bb5a528fa659385a825', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:45:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('32bfcde417b649c89a984a793fdb38f6', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:58:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('32dd706faa3f49ef8d219f734a395682', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:41:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('32eae2a1a2bf4d53bcb43052711cafe1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:30:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('330cf0498eb84e5fad3da604a7ee0888', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:45:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('330e345d00e54c7a81f5d65aadd8e053', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:39:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3345414bfdbe4d839aa418194b92755b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:06:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('334b94b9a1c5497c9eeaaf1e4012f7cf', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:26:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('334ec5b06edb426b91d785464023eaaf', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:20:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3354f42d670b44ca988a04b9d5a1426d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:55:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('33a69381670a49a5b62b22d5f16042df', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:20:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('33d008b66b12430cbb1d73cab384ed1a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 20:05:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3425ed96b7d74c6aab0970357c897ba0', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:29:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('342cd843118d43e5892a2829d2351be8', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:18:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('34340bed588d4a5b9bc73ddffdf8584f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:28:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3465a0eb90794760b9ce03d93819601a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:06:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('34683ab93ecc47d486311fb5929a20fb', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:24:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('34929e850cc54e199f654f178a9e2400', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:15:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('34a2ee4f351f4ffe9d80260be6d6a42f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:05:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('34a392ef7920423594417ef3fd268b69', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:37:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('34a54ce0113e44c0a107ad0094032b9a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:59:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('34a6dc2fa2584e7f96fd1fdb3fa80bc7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:23:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('34a71aa56c6e4a96b28f94b0b8a77c52', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:19:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('34a9d885bb0d41bfa37fb90bf7d0347e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:39:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('34b3e6a4684a4bbd89c182eb025c436d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:41:28', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('34db261aaa43477689105f067d2eb0dd', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:50:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('34dfd446884b41f4b523a86477ce31b7', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:02:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('34e80ff5554a4301ba41b08834610c6d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:15:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('352f8173c2ab4a208fd1c887ad23849a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:46:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('353b61b4b4ec4db6adbc9d1ca9914ae8', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:49:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3554f9e5e51c4f8091a45712c40a183f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:36:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('355d1d458d414daba0c26419d30985a5', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:43:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('356102ba5cfb47b89f56a8ef4e2f7eee', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:35:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('35809b584ef24964bd3e1c60d24f5d4f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:59:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('358f46aa198342459162e8bd90b92672', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:54:47', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('35940bf31b754e959e6d2dad74d337c2', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:20:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('35f1d22363d54e99a080b2242ede3e2b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:49:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3611da0e83e94444b6f1bb3f90ebae38', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:22:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('363fdc82dd444862b3f852b2264e5904', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:53:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3651ef7350284eac88fc99726fdee522', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:38:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3689bf2ed108436ebb8080054b36b062', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:06:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('36abde98d9c34c268857a41287c7988f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:59:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('36d1b51e85d84b518666d0fa7a018685', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:15:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('36d586662623422db4ec3714169d8061', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:55:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('36dd1db4e6b044feb6491739531cb2c6', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:07:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('36de92ee83a94035adecc1d628140952', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:57:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('370cf3f466a048bd80a40a804de7d6e5', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:40:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3710733e8a604a5f87598134e8ac469b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:36:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('373d831f536745889d949095194f647f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:12:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3741525e64ba4168835b0d0e0e59cfb9', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:18:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3758f4546f864091898db98c6535c5c0', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:08:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('377b319800f549a1b239b6bae008f08d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:32:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('377cbdb440c24371a7fbdb46f5b82b9b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:37:31', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('37cd734d900d41d4bd6ab25c8e64feed', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:00:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('37d81974ea5a4dd7849e2704b2100976', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:53:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('37db02e83b6b451988431b93bc1e7e0b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:27:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('37ee89bd4ba24d549b810d66ceedd2dd', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:56:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('380f5634f454445883f884c80213e783', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:15:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3829d464208c4ad7903324565ded997f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 14:37:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('383a864d82c842e8abd067d1b02834cb', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:39:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('385080d61dcc44f7bb7a1d08267edeb3', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:41:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('386609a0a5ef4c33804568787db40906', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:30:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3889078ccfee4d378abdb6756b33e7c8', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:38:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('38dbb12706454616a07db1c6ec152d80', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:46:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('38ec96b9b63e493b8c45fe5aa460bcb1', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:51:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('391e1b7d02914dac85804ac8b4d87d37', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:44:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('392a34305a764e8c826ffd1264d302c8', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:59:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('39430c78ba404c55b2cb3d60eed4b02c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:47:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3974a7a855f04742a2fb805c62b47904', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:25:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('39aa8e7e2c1f4efc9c36081a007a844a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:34:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('39b26ffc5d6d445798193ccd13ff25cb', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:25:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('39d6a8d6dabe48b185b6bf8bfc7c788e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:46:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('39eb15182bd94b9a8ac3382de0d9d071', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:19:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('39ecb0ad2db54eac9c450104fce1e40f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:23:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3a01f95cdd174d0a84c77285974ea5e7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:58:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3a4bf8ec23904f27b32274c023b3dd54', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:36:28', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3a8b6b562f53430e882a6862dec4b317', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:10:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3a9968cba544462287400b117de8f04c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:32:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3a9a4b0e2bfa4b7c8a4ba11bbb15b977', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:36:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3aa42725f9b548ad97ae2e09c3e51d68', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:32:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3aa4ba7e1eb241d194529bcc8535af8f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:38:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3ab84a3cd61744eab09cff0510f1ebab', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:10:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3abded9cae0d4ca397fd0b346cf962bf', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:37:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3b12cfa32b534bf89356deef9b491b1c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:34:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3b272832dc7241459043235356482f82', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:10:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3b39d901338b44f2a9c8cab61796d76e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:36:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3b8a15ab2a944a629a5966bf0dddbc96', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:16:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3b9243ba7f844cae83c924ad7736a32c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:17:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3bb3d21aa80c4393a9b1fcc845eb6e71', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:17:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3bd3c0c94111481380c0d6c6f09b6ea7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:06:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3bdd39d47642437c8fd9da99473eb668', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:57:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3bee8a518b5b434b8579c4443b1f3860', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:14:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3bf9758038bb4b839067e0c883017229', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:39:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3c1fff94538b4e949e6505459d51b8b5', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:32:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3c528728d3f6473f8a072fe4857462f6', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:01:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3c80f5ebfbb345dcad3fbd8b38422e32', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:10:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3c83f5f887b549cca21cb24331078eff', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:23:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3ca12411a61e4e99afe27369f058c699', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:22:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3cc7d18ee5514831a2ebb8aa0716f134', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:09:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3ce2e1e9feb44d2db296bc8003d1e93a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:42:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3ce443b384be4a1cac40b750d342332c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:14:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3d14cacca8bd4ecf8702987160e87a16', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:46:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3d2429770d8b40f4b5220feabbdc5de9', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:59:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3d38571d446a40c38b74c9a805e04336', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:16:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3d62227034784e63a4e5ade0ad830a70', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:00:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3d8df05b28894ba296ec7178950b3649', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:42:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3d9e00ca1c074de0924bbeebaa50fddc', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:20:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3dbda59f0d64488a889e275edeb69b88', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:10:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3dc24c08a73949f1bff8029ab3f914a5', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:25:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3e1c5f1cdd0e45be86f47a8ab326f05c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:38:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3e4b8c44bea5486fa1d2f741ec14e9e1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:22:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3eb0ca5589ee4a0c99878066d3c93000', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:49:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3eb32071fb4e46529370c33f93dcb2f6', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:10:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3ecba2b9d2a2492880ceb6ee422321d2', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:21:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3eeb79069d2f4b5ea351857260aa6f6c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:36:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3f30268f982543d2983d28583e443e05', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:59:17', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3f438d77ea6047d2a0fbb09300141a98', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:00:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3f503af6fb11443aaba35753700c2859', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:24:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3f57675745244aabb2dfe3142b442447', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:46:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3f74b2060c5b41ed8eb599f65895a87e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:26:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3f74e57b2a054255823aa3f8d7d43591', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:23:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3f9df91c532d4759aeda2c50fe806d8e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:40:31', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3f9ebb6d582246b4b2232306649a264c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:02:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3fac7bfed75940959773514cd6e7e4c7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:53:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('3feed9c9dda44e038e823718fd7cbf73', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:54:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('400da3f14125402c8189ed298999b2d9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:59:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4014a35ecaca4819a1f0d0b2f8b985fa', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:58:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('401bce98f36640bd9786624c562ca6e5', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:39:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('401f052a2d39484ba6ca84c5617d2572', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:42:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4022df05feba43d798180567950637ed', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:54:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('405e312f1b30406eaac2565322f295bb', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:43:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('410269a4ab05470584acea3460c0f387', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:31:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('41872f134a2f42c6bc8d5ac698d7dc36', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 20:04:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('41c031f66ee549e78e9a2cbb70586ae2', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:35:49', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('41c1cbdd2b384eac9a0e62a7a7dca2d4', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:54:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('41e535a29e4247169492b36f7cf246dc', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:07:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('42027bdeb9804b69a65a2f4656478e25', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:15:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('42167d3138884c1ea88c8b20d4897dbc', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:47:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('42ae445928e14826806690be67232325', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:42:28', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('42c0637423a2413dbc44b8fe6949bfd6', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:27:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('42c7010448d343188b664a71071ff275', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 11:00:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('42c8b5303c2247f58cec646acbf0375f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:55:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('42e2b5a583eb4f69b50a72c793467b38', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:16:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4338e3607628483faacd7827d6e40846', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:38:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('438366926b054c129caa48f94e1e3c0b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:29:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('43caf2f5687f4c9fa71c66e5d7bf8a69', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:58:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4417433f81a14af5adda31b98aa5c387', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:56:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('445e61404b3f453097316a6431fce469', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:02:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('44a6a68a977149fb913c02a1662d7ddc', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:35:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('44c4030144b04fa283aefc33a9e5bb9d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:01:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('44ee92d6ebc74d35b0c2f484bf0241b4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:31:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('45143a39921a4d988507c4673f6acd77', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:23:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('452c99d7ad604666b2e8666fba42cbb0', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:55:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('452e40729b524f949130c343c926c2f1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:35:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('453b243d629041b883a9c792c511e5bb', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:24:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4549f1de0fd74b4d9dd5aad6e4554729', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:53:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('455a88291e6347b0a078e1eff80733bd', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:58:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('45891a8fcbb04ce3ba38badfc79437f0', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:30:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('45b93e43f9ad4935b45b02e4da6727c6', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:52:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('45c143f7a29547f292cc90a79ca95167', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:24:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('45e6ee602fe64066951465e4198bcfbb', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:34:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('45fefcbb300a4a71ab9a5d17d4dd0ab4', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:45:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('45ffd108c4234717a64e557721239a8b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:23:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4645afc59490472d93142ff8acf86733', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:44:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4659af07607e4288bd631e8dcf4fed70', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:47:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('477e394375044ddeae20904d1aeece40', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:31:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('477ef60083f3459490c17b007d9a2c37', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:13:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4784402df015497e9fa7719948d92ebf', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:16:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('47a782b1517342b2b8ff2ee418518dbb', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:35:19', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('484a477444894159a99ee44187e7a414', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:04:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('484ecaabb00b48f0896279f6ad71bdcd', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:09:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('485882a42617495394de999054824b9b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:58:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4881ec1ac1674be382a1d3b1c7ac2f44', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:38:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('48893dcf3d394e32a219c011120668fa', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:14:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4898e8e665404d9284650d33c9e2559d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:32:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('48e73821e78b472e8510399e3b45f13a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:48:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4906bca91d1749209f3d3f58067e2d00', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:57:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('49080209ee7e40399ecd35a56188ee76', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:20:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4912d670a45c4953b448148adfae8e65', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:46:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('493bbb95b90049d1aa03e361430de7b9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:05:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('495114829b4841539cbe1df33cce8a4e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:19:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('496537067c074548aa6bff9522ccc360', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:54:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('498195deff384422bf4ca1c2a00e7b34', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:28:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('498b5bd33e8843ecad6db563ab62ada0', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:46:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('49d54a2ea603456aa25c82980350aa1a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:09:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4a573aa07c6d4f0f9b015f3f2b3c295b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:41:01', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4a9c192d8a61431097aa7be226398cf4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:49:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4af7e28476e54304959ffffa5e3050cf', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:41:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4b168ddca6464b2eb70ab4544cc8d8d8', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:22:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4b42aaefe9e041078b0d266d171cdde8', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:11:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4b4e5a90e0e34131a9e75ac00ab0be36', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:33:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4b52cd6a59524d37bbbd3f8ee2abf11a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:45:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4b841ba49b1849f182b304a20a69ede8', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:15:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4be65784c2324305b0c4b53137ce757c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:37:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4bef7e882c8d43308d2b2e31fed59e49', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:37:28', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4bfa0dbfd6274fd98589502761d089ca', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:33:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4c1faa8add9c4efdbf7dc926c5b39879', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:23:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4c34d09fac494e1e9a58b3a397d953e7', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:30:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4c37299587f84bfd8a121879045ab3cd', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:33:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4c445adceaa84375addea1309dba4a7c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:11:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4c6afa5a006b4cb4a19f5bbf00bb7fa0', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:38:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4cd68ba383244c58b53c29ffb229d117', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:20:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4cd736801e5c42738b59bf6283e50899', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:00:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4d88bf887d4a46b5b139e032363bacca', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:13:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4da88f30f5d74cc1bd4817d673aa4510', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:51:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4dbb85f7dcf34352906f158ee561a4c5', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:25:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4dc4548414e94b0395214fca534c56d9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:17:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4de6c246e8914dca8daa27ae9520c09e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:25:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4df17034d4884686be16833d6025c253', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:46:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4e08d1af0b7e4d97a72df1b1294e773a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 20:00:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4e5f82ec82664335904d78d58d3403d4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:25:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4e7eef999cab4df58830f129e8e159b5', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:06:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4e8bdcbd18ef45fe91eff704bdb4ea72', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:52:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4ede309106ab4ce3b572be349c95c992', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:42:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4edf3e75df0d4a569f582dc80a9f4eeb', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:44:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4ef05cdef4244c9783b704a1d98e446c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:39:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4ef7834cc5b8454e9914ba806afb1c40', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:58:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4f0c6b7740164366bf13a15c3824016a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:52:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4f2567ee3f9446c2881fdd98b4d2144a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:09:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4f28e2b608674ea7ab1901c83a6d8e4c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:46:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4f98cd9af50d4b0fbcaf0996fc4e2434', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:49:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4fbb1369497748139d50e0ce7a906e33', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:48:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4fece15232b74cdfb7919cd73041fb66', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:44:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4ff482f508af40b18e86d99832966d09', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:24:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('4ffc36432c26426bb26861fd7ebb21aa', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:14:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('50188d9ca6824c2e92ef1eb88a1cb663', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:56:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('50447b8743764c108528f4f6a1ee426b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:58:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('505cfd17fb3d4f42aa0d0fc89c664bd6', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:48:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('508d72eead27435eabcfd2f8e6d37bbe', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:37:58', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('50b3d9fb1f4f46c48e9db8bc5be1eedc', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:13:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('50d7e76f717648d7a2049c88b3bc7728', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:38:01', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('50ffccbb787345dbbd2d99dced077758', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:43:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('514c3070e7f844baa880a7653c8c1910', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:43:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('514ec11ea812425496691e34de1f1749', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:32:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('515bc2c989a84e6cbeb9d225662c807c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:45:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('515dbe650c2a4e9d82eb30b75426f3a1', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:50:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('51839790aa63472688c173f0f9c832b9', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:24:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('51c5eb0dfb53449d9f2860163595276e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:41:31', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('51c6231c92af4a8c9ce357d98ba83dfa', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:08:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5246f8e58057457ba32df01d85f8ae9a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:53:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5248b0d9a6914b29bf2ed559139224a3', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:02:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('527e9b9e16a7476e8ba693c2e5f31f14', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:34:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('528edad978e04f4ab1af4bc076759791', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:53:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('52a73b6d633c407ba18f1682914532cd', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:13:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('52b50663bf8b4f14bf3c5bf0dc279c50', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:11:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('52c6cb490dfe458fb432f4438990b5da', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:31:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('52dd289c3b944a4db962ed278e655082', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:25:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5319000166d34a2eae35f3c0fdb48bd0', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:22:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('533debe1d82145ab8883f0612ff29e56', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:29:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('534a6e9406da4123865f334b24405e50', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:07:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('534f7db81ecb4e60b1a14ff20f26b236', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:37:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5393dc63ee484df580e17f2846d06ec7', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:56:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5396d849acf34f49a8701f038fd6130d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:16:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('53e712cb34c84fda80b249507ec1d874', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:41:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('53e82cf7d3de4300854d5853e3f10744', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:18:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5450aa4ac0fc48f1832701eedc054593', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:56:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5481721dff534b3fb65f1c7133dd917e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:32:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('54a4a366e09640c2a45f862344017fb6', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:12:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('54b3c22face24d858a192c51f09e5fe1', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:18:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('54dddf8ac8104b138274196fabc58994', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:12:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5524e6406a4d4032a5651dbdb4f0e688', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:51:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('55327af958694690aa102346a1291165', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:29:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5538a70d33a7496bb22d333aa415097a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:54:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('559ce22261d74c4796a32cd335fbf4f0', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:08:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('55a096e5ecab4be9aa640d3b07fa6a01', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:54:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('55b9b3a2528640659c6aac465b2f03c4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:55:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('55c42e0fddf948a69214ff982bfa3ca7', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:40:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('55f6476c51fb4593991f427572878805', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:37:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5601fc2e1ffd425a9951edd2f63374fa', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:10:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('567fa9b51a704dabb2c2adea99aef1ac', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:25:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('567faa0264944ebd9352706145f807c7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:52:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('569c97d259ba451d8e8f83171d95b3e0', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:17:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('56b7d2ceab344554bb7dca9a3f0d99d9', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:59:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('56beef0bfd42421a9dabebef20ca4fc1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:02:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('56db2ff9bdbd447fa8e33be7d491ea72', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:45:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('56e5b4661ef744e2bb8b4caf83d4f2b3', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:59:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('570351ee0dcc49d895b4bc37b0c23033', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:06:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5756b1da702248b6b8a4fb2148810816', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:26:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('57742ee1c5694820b95ec31c510c3be0', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:12:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5774ffdb4aa84481933ead958950289b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:54:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('57792684d12747979840ed3fd2768f91', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:07:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('57a0f3cf41e047da83b39e7c0d183b73', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:55:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('57d59250d192409a8f5086f77d4fb781', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:30:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('57f15d08c5c7402d9a1b6165bc9d7450', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:54:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('57f233e22152442ba7f5eae32efca4fd', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:33:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('585cabe48bd247b3876214884e493e52', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:38:19', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('585f8460b33145aea50f0519cec428d4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:58:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('586c0c8668524b41a1f7d3cbd6b66530', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 11:04:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('586d2b3bd6db44b084acf1a445eae1ff', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:20:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('586e6b6f58cb4bf0aebecfe3b9d6cfe1', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:15:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('58ad38f8964c4840bc5206b44aca0690', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:44:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('58d3e06f8efa4fc59fdddb8825baaebd', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:58:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('58d7384a86224f929c67ba045763bf96', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:18:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('58e7efa5a6924fdd9a05517f777c1e02', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:35:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('58f126e2c0d1483e9edaac485747b2d4', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:53:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('59006b5baa254ebba07577279a73970b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:53:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('591aeaddd0194936968eba31b6a28b74', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:49:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('59487b7d751c402aaf1ace3839f76e81', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:50:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('596d379497444db18a667803b04c20c9', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:58:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('597a310193394798bf874c602789b933', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:37:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('59a0100ff5814772afe16fe4684b745b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:11:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('59b4bd9bdb1b4f9d8536c3180859bd8a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:57:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('59b76030819e4a309ab6cb9eb5b90e66', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:58:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('59dbb8343e6e49d7b19826d449d48452', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:25:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('59eca2a8095f46e1a5c6be088241a202', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:15:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5a35b05679a74f21acc49d71cdbc9c28', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:01:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5a4a5d99a5d04b828555b5190d41ef6a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:06:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5a4c0a52a53445c3ba4b8150f4d1f000', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:50:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5a570a478ed34758b014ca1309f7511b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:59:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5a87ed8b12744bebac054b96d5892127', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:16:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5a9440a7095c4a83a62b028479b4824b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:12:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5ac2e0d1017740cb9b24d6cd594e44f3', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:15:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5ad4fe18a504446a9959079cedb70f2c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:32:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5af2714513194d439aa3bdc50066c081', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:50:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5b3ff43bd6b94045bb15ee261da91411', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:42:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5b4a2034790440ca9efb51e488f58cef', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:52:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5b753b9587a94e74bab4ebeab6412cea', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:15:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5b77e3274b2349468ee34607cc2c18e1', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:44:49', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5b9ab10a7e2c4d1d9b12c6c95fcd164a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:35:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5b9fc6fdeac649a7bdfaa3ead232e3c1', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:47:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5bb77dbb4733491c90936fd6f708b169', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:00:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5bd8eb08a21b4382980209582c2ad069', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:21:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5c3dcce2938744cfa88f2e1ac5377575', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:14:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5c6613020af948d5816206a9f0f70c90', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:33:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5c730ed5cc8544d09febb20075a34912', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:44:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5caef73b5761483ebac5a73102134d5c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:07:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5cba14cbc1944234a398063768085739', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:48:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5cd759c3dcfe4d009652185d444411a0', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:29:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5ce37b0298e34fb595e98f42bf305973', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:51:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5d1ad2c4cdcd4aaf97f567660b12151e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:53:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5d34e37a8d3844f5b44f04056527deb9', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:20:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5d6f98e4603742588c1dfbcde91ce45e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:39:58', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5db504deef28433ab961567db03b104c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 20:00:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5dc9faf25bd24e8081735eed9024a003', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:53:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5dd86013a88f47eb88e9fca5275e3207', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:04:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5dde99d19f774166be8705c9acd8be68', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:08:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5e2e7a58257143efad74ea6e0527cc74', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:39:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5e51fbb7fe6f45e9be651cc5bcd0660b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:16:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5e719a431de74edd9fe457f948fa9737', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:11:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5e9908c8fd7c44f8be007a9231646044', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:52:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5e9f8c08289f4c239924f7cddaf8c8fc', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:39:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5ec1bf6f2b074ea9a4fc1282bca1a83e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:26:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5eeeaa24fa344a9a97f404691563dcdd', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:26:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5efdd357f1234de3b2995bd145a28ad0', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:26:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5f20926800c6438a8c6e1efe137b69a7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:38:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5f2423a99b984a788f60f5183c83fdf1', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:39:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5f805d66857a4d70a7a1ae2a9d2d3168', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:41:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5f8f672108c34f0480b4a517207d3221', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:48:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5f9f2b5e038b44c29fb58a3678434412', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:49:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5fa6303fafa043e09f55e9a99d4fb066', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:12:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5fb1a96d3a2f425d8fa739ae2b666f04', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:06:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5fb2747a406d4757a711f6e28d0fb5f2', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:44:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5fd0decd202c4385a5729e6ffd94c32e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:28:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5fdb5f55355b47ddbf45b445658652b2', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:56:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('5fecb5e73ba84267b77e3cc7e57986ac', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:49:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6004872acf494a82af91cd90088b3662', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:40:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6022053ea2ea4cf4abd2072dc2557575', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:11:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('60400e41769542418d932000acc74384', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:27:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('605e83be55884bf48a2db381030dc8a2', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:37:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('608c5aa99c234532b8ef286b74375a25', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:22:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('60beab43efa64a3a85301e4bb2b4f97b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:47:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('60fb5861a9b8403d821a8b5b2bf4d748', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:10:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('60feb34d598c4f86bc7dbf7cdf00061c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:36:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6115077c275f4268b6fcc44815b2df45', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:44:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('611e0bd0d31845b5a4a189dc493ef72e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:45:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('618e571e3ebf4acf8229dcc939320044', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:01:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6197c671c53e4704ac345a1bfe3cb1f1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:49:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('61ab5737a9f043709ef1686f22027942', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:56:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('61ebbf5d1de74754b507a7aa60806b02', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:14:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('61f22ed20e9549a29fd3e469d6db54d8', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:59:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('61f6cd63645e437f9e295637ab6dee2c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:43:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('622cc0eaded04cb79bddbf986e76eec8', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:44:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('62335d0a4072458282e4236d64ed40ef', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:01:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6245468d54c9423da85261e2f3dbe1bf', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:29:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('626a21967be04e0b9452e8e3d63d255f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:55:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6270496a6e8d4982a7b08ef26e1c9667', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:23:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('627672702c254d0ba09ca4ad60ea961d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:05:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('628223710f7b49659651410535f2c8e7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:34:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('62a144e55e564f699359186cb871ec29', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:38:28', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('62b013f694774290870e14d695f33134', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:36:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('62c063bcc9cd458c8f7665b93d97b670', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:33:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('62ef4b7eda454eb18f9f4e270efbb30c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:54:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('62f3c11a8ad247d7926177c8b1bc97dc', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:51:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6327cb200741469ba81b8cdcf05cb9f4', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:24:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('63519cb7d20a46678f17f0881f613ad0', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:46:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('637676bc20e84691a2261d68f28a9f94', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:00:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('63b278a663fc442293639865df7dd248', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:12:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('63e72bc94866401ab6abb8c8c35f14ba', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:46:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('63ef059047064310aec213f5d45c0f98', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:37:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('640525eb0ee14336819243c65b84c15d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:19:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('640f2ad254ef45feb0d6238d4e319dfe', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:08:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('640f718159994230ad616130cbdbfae0', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:42:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('643eaba0b66e4bd5aff750246bffc18b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:23:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('646b7eca39cd455a98fdcf8d151bc1da', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:50:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('648e625d3797419197983c85b796a1a7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:11:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('64a7d57e98fd4ff88f47f5b45dfa52b9', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:25:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('64ac4ed043ec4878be4c04b37897abf0', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:48:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('64aff2a0706e4ef7bf0f2170567f54e9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:43:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('64bcbac1df2d4642bc8ec41cadd824a4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:58:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('64e27a8dd89d481a866ec3ccd6c4056b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:40:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('65125fa2fa604a8ca60996eceb9a89a1', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:04:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6547526c4e454f478a33154d8db00c36', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:41:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6557f61845d14b20afde62b48370041f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:11:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('65a875d01c24430db1039b54d9d5738f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:51:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('65ae267c80074ef3b9f9d9cc2e50f087', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:12:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('65aeb52d4a8d444f9405a9e49b932c4e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:21:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('65bb8b30f63343b9bad868aba99ed56b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:44:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6607faee0dae40db9f15d37ef737bfb1', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:36:49', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6634f61431ee4765b4c74320905ee958', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:35:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('663dd6e75c314a51bbe611d66a2ac498', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:00:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('664af8885f314b44bf4cb72963d54177', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:55:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('664d6d3cd623471a912c24ab11f25468', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:06:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('665544f2c2944210a1815282dd223f08', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:23:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6661de4cbccc47d8ba62d6a175f014dc', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:20:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6662bfeb58dd4472b3dfd80520a8d629', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:01:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('666f42472083431faa59fd9668387d82', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:16:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6697dd8a2239499f9d4b4a358b7bf843', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:40:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('66a397225d8e47fc81beb102f5977b28', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:44:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('66cb98c9bcd74ce296897de17d81575b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:39:19', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('66ec2e6c63234a50892a4210f4202e0f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:07:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('670df7d6a330403a9a0dd8f2f757dac9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:36:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('67297b5ec3ed41969ee77cd483981c3d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:01:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('672e8ec56d2a49358e54974d20469355', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:37:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('67443f8e3bc9453c817d524488b98ccf', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:04:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('67503d17918049139e1e3e4c9f8bbf01', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:15:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6764553b0334425e98791432daf40f9c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:22:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('679eaaee3f6d45659427bca5f890a09d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:00:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('67c94c8e71af4f76a68a66083b585cee', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:49:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('67e54927af4c4f29a13cbb738e69dc57', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:48:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('67fc9c40a2794fe78b88b94fa425aa68', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:35:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('680f8cf7d5394d5e85c4ff8e3c868185', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:17:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('681299df743b4c94bc979d9eb87e762e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:51:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('686bf5b2302c4f468a5eceae01c72cab', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:30:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('68a0017e5ec447e0bdc8a98923f8babc', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:14:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('68b5f5b8743f41e9a14e5bfead6746b2', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:23:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('68e22eff0d2a4ec8b7170e85ba1c29b6', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:57:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('68e7b98aea0e40cc9940aba19f246cd3', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:54:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('692197aa78a64cb7abd745c5314bc2ce', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 11:02:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('69577ab177dc4d3c8201c42a2ba57dc8', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:51:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6a1f32e08c3840d29ef953bae33163ba', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:41:01', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6a446c330a284afbbdbb8d3485595ffd', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:14:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6a72a5a029704243a49184988bef1439', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:24:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6a72a7855c754b00944df30ca56d8d68', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:00:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6a7c1f8f615b46b0960fcb057b49f153', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:55:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6aa68adb36d3485fa21c3144c6e89a70', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:51:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6ab1f79d92d24a03a9d36429951c70bc', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:51:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6ae752d3d6c749d686b2ef4e61ec5a85', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 11:03:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6b0e18dcf0da4885a5a3d38ca440c9e8', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:37:58', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6b3d5de38b884632a3e81e6fc9e7bc39', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:08:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6b7301ddc3de4b54912520a5a59e2823', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:04:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6ba39331baec4cfbbf0df6d93385d8ab', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:41:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6bcac1c142aa48e886fb4a369bf39f82', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:39:31', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6be167a48e9d441e85555196b14bbf41', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:51:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6be4f6a285904a52aed988d17bfd91ae', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:26:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6be9185f6f554f62bc9b4ea145b8bc4d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:42:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6c27dcd30d3a466e89dd547790a6b086', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:42:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6c3ccc18cf0a4ef2922d5c57c5d0ec49', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:06:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6cf9046a852040f89338fa70656739d3', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:28:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6d2eb6a94da7467088da300996b1117b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:40:58', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6d2fa020f41c4e289caf223525dfef6d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:08:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6d9f89150cd74f05ba12ff1665c48619', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:37:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6dbe0c147afb4a5c8d003a34270a4564', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:40:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6dcae47a6e614ac7b44d2cf144a57416', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:04:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6dcecef7b2634ad787bc9d4e00970cfb', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:56:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6de4da7cc7b94f899f632afe1284d1d7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:38:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6df2ca87378e4629abc63381dde8d057', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:33:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6e06cf358dd74d8c891f106f8fbff54b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:40:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6e13453b1a204ebaa273c0e0696a6171', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:58:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6e190f5bc65f4357bc7f5f57d9d08f77', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:41:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6ea68dad614649ed964536b24bd98a50', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:33:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6eb23aae068345958c88324eaf89c9b7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 20:01:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6f2e25ada4af44f299222403fc9e1ad0', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:51:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6f35f33f55474f6e9d02ed3b51b05f33', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:51:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6f38f2f52494431aa07ba48cf8dae03b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:58:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6f9552a49def44929b0d39bf85d187ed', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:33:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6fac5aae2dab42fdbc24f37a298a53f9', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:07:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('6fb128ddbfd645b5956c05db3dfec81a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:44:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('701bf870af2a45a88c8453de71fefbe7', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:39:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('704dbb5075ad4ad9839c1666b849c900', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:02:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7055a8020aa44a2188aa229decfb1602', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:53:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('709d6a3439df4b7487d91be3b039d441', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:04:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('70a3e6fe6f3942679ad6e231285dd35d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:28:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('70bc8ec635c343a6bbd281b5e266e464', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:54:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('70cdc91dabed4071a65f48f1d014629f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:34:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('71139e48adac4267a279584380c86f60', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:45:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('716351ae73e54d449285d6351f2ffb54', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:00:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('717f0c52e7804d6199999f258153232f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:45:49', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('718069ddd33a4384b0d9a9199bb61d51', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:42:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('71aed4fc5c8743ad875354b014726473', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:11:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('71c53bb61e4c474e8b3ca231c1322c9c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:13:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('71d27e821ca54860ab32a5c9db957481', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:55:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7221aee5128c4530b6a1414561b44b9e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:35:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('723ae6fc8120455e88429f63646604f7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:38:59', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7247df4bec6242698f30112bf18d6266', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:09:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7251fad47c9c4714ae266ebf1d7eb5fb', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:42:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('727855bb27d1496a9c2412c8094b9d7b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:56:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7293496de7744672b83ab4ee4d1ead15', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:28:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('729f1da939d3405c82c9cbdb71b9130e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:35:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('72c2008c3a7c4c37a49d8b0efd31a7e9', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:40:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('72c3c8df646c4d9592c23f9c691de0a8', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:03:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('730b7aee141f4775b8fd6ba401652d54', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:00:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('73243042e342409299b395d903129ded', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:52:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('732721148e9345acb3fe32525ab431c5', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:22:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('73381c1d1db74bddbd8860a4063986c7', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:33:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('73603f6ad0634d0c92ce2ec21c568bf6', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:32:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('737d140044cc45cbb3caa33587d1d930', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 20:02:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('737dfac983164c7fb51e45859d30487a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:12:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('738b8ebd0780493fb528e7348e9e6225', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:33:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('73b4fa2ba5c94c1fbd3e666d9216f1c4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:31:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('73ce9cc7d2de4dfb94fc3148e6063fbd', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:28:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('73dda083c8ec4ac89276666f24b2a513', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:37:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('73f9884dfed64185b9e8180c5715c8a3', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:50:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('746620c9e88a48f687d719e242d91797', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:20:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('746f1b9c470947908d01e1c2283090fa', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:33:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('746fea74cb114434ba14c4483d36df00', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:37:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7491f4bfbb3e44bf92f3ef029920654b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:03:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7494c189916a4866aee6d0ae2c0361cf', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:17:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('74b44b9a3fcd416d9bd5ee4fe798e7b2', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:45:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('74c1111460d645f18e37381f508d8d47', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:00:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('74de7d548bed4b7c9a15b2ecd08c7d83', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:38:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('74ea0c39e4af4adb930bcb628ed8661a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:38:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7510b61ee28744abacfb5eedaf0723a2', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:25:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('75613cbe4750417cb646e97f0e67a99a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:36:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7566ec5289d24b0090f759b0cb5a2279', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:59:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('756b87f69c21498b98db9991984b63fc', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:31:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7574c5dace264d3dbde06c6b75fa7985', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:30:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('75c3cd4b204f4dfd94b839184e1dfa82', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:14:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('75e61ba2f3f6491997081706ebdcfee2', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:19:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('75f5fc9fd4544fa1b841d27efa3375b7', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:50:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('76129893ff264c65853f6f40df9bf699', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:08:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('764dc274df5c4e549de70cab5ee4c0cf', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:54:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('764f584826064748a33ee367aa83270e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:23:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('76541f02b8414d19a9a834f9ce79c0d4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:55:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('766245c78134492aae195b68157a959d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:03:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7674be32ddd44d178adb2c1a59ce411d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:17:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('768811b718cc4058a8581ee57ee1404b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:01:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('76920fb973af44f5b24bc9c7bf0ebc79', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:57:47', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('76961cc128244fc4b078f2b6965ba09f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:57:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('769f90fd04da4f4182120a8101f05ba2', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:22:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('76a7b1f6d70a4c05840e2df637aeacfb', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:52:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('76ebadfdd09e490b9d8941a96e80aa83', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:49:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7712694b313342f4a8e0963c4d96a9c4', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:03:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7750ef2f553e4bd19e47afef9b60cd92', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:17:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7752ce466f984ecfba7ed65d7445924f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:55:17', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('775b50d77363434c95785612f5e1c3b2', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:36:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('77773fde7f264aa1a5b60c9c399f09e3', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:09:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('77881fb05347448eb386177b49108a96', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:13:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('77961d8f56a5476289073391ad0c0e25', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:37:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('77a66092c9e0499497b93acd6290757f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:35:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('77ae89968aec40cea880d8d9d4724b1a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:43:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7804e7e34f954a1286e572c3bac6025c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:09:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7810f7a93e4b401aafae95ace5c4a30b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:00:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7813013ce102434a94b179c454c6c988', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:53:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('78202213739c4db994e69a04e0dfdfc5', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:55:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7827c79272694a899f7d98f500a1894a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:41:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('78314464b0db46afb610a41fcf6406f0', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:21:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('78426c3178d24f4191808d3e80c8fd21', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:16:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('785746a8e2f0434986dc5bad250395b5', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:11:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('786074a81fd045ee89b470d22eadf38f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:52:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('78654503974c459198eb039afc4b1052', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:52:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7895a642a8104246beee478ec469bc9e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:21:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('78ca5f3792a542bbb99933b8c0f319c0', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:09:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('78edf85aa83d4c08b58a82927ca31481', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:53:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('791e1f3d91094bacbd580611773d741b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 20:05:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('792be751d3824ccca4f94b40759ccef6', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 20:05:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('792e612cce87485cb6410506eaed87bb', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 15:03:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7930c0a8ef0d44dfa41bf85531c4a4ef', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 20:01:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('795a9e3bae9346cb8afba4c6712307c6', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:43:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('798f8d18e12c4aaabd185bb8f461810e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 20:05:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('79927ca6f1744593b8a3e405ac0a4fa1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:27:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('799e7ce92df14f9e9466e853a169e7b2', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:47:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('79b00a0faff246658769e3f4d7a58c8e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:04:47', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('79f85a238b8a4e57b32dbba6185dd14a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:46:19', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7a0291aa8db84603a479b87eb06f9a45', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:32:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7a1e9040402e4bf68caceb8089c2ab72', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:20:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7a60d57132d640f8bf216ede0a744216', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:56:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7a71d907476045ec97be08efb514fd1e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:09:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7a7c4766648b4cd2b74a29fd7e31562b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:03:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7abd58728000406c8524e8e11439b8d4', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:01:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7b088043dbea46669a69b67189fecba1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:31:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7b180496fc2e4ab3a8231583f752c784', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:58:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7b834051bb504228a3a0d478a69ca2d1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:45:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7b8deff13e454219a3c183da7a0dda41', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:37:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7bd19f0ca76f4f55b6f921d2e384a3f6', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:48:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7bf10966923a4a5697309bbdad9d80da', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:55:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7bf37b5b43794dd986e9f68aeceb2f44', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:40:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7c0075753ff2465da56599c648210617', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:36:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7c17142725804b2eaf27e46fde9b90a2', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 20:00:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7c361f1428c241e7bcc17494c0a89d13', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:34:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7c58fd35b723467699d52c7b5e05332a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:14:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7ca6e7571edb4f178e2811bc67af7e39', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:27:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7ccd010c0b614035bf32ad22e8db855c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:51:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7d28cc52437e4f6da3ed96a9b749cd60', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:40:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7d3d85cd10434a5aab704459a2b80c20', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 15:03:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7d6e498896c049f4bcf2a2c0d6f54200', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:38:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7d7707336b054a869c6486746ea05735', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:29:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7da14091530143d4b0e349cd770758a3', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:13:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7e3195402a014c38a71665699a27964b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:51:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7e941d68a5004a4d89ae533ef562ad15', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:57:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7ef16b25e28b436cafaae4999860f073', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:45:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7f2a8e8f475e4d58ae3f4cf17a564941', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:00:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7f4b5c7b2c43478cafd8d549d9277281', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:50:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7f625e947e7d4f638e1d1f7609719ceb', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:23:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7f68c95298c546068b7a47dfb333b5f4', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:40:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7f73b00a8fff44f794983af9d04f7512', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:12:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7f85e2afe9134e2ebc4eb31ae9a1ce7e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:48:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7fac09cf5b0d4b9c939626c7a57331c4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:11:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7faf9975d79a41f884d34ae3bda3e065', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:56:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7fd0d920fe664e0595a50ba0dcd087d1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:20:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('7fff24e03acf404cad9f7070ed3e4dcf', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:25:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8011f8b8690c4c468156fa27742e3dc1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 20:04:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8018cf1c9ca64d56ab84535618937168', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:57:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('802b592ccb67421199f37762a810db55', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:47:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8040958e9e634556a7534b9b7c8d13b2', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:41:58', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('804616f6c221467da4be9f0651375ff3', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:53:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('809bc5e8e0414f29abb2ebab66c9ab83', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:32:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('80c78dadbad84abf98dbc73c66b78ad9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:23:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('810908cb0f2c441e8acd0eea88f5b057', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:21:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('817ef4188e7f4962b5ad8f1df2f3d321', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:29:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('818ceae79b0c46b3bee1a2dc2b1e7c48', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 11:00:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('819534e67e614e12a126bf95bddb846e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:33:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('81c70741f0434a358e7870f92a5dc6c3', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:04:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('81f670bbece243c1b0b8997d9cb9d984', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:39:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('81fe805cc81740e28b423a42408c3a8b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:52:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('82434c4fab5e4ca091d9b65c8e402a59', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:36:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8284fe1d78c5429fa21541d9036fa079', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:07:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('82cc3ccd31024146804a0ac3a6f2f579', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:12:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('82d07ed06b754231999c985b702a552c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:54:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('82d24a745d2840d9a7d2c5c300af2f1a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:50:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8308cb22688f46e19b5031331fec296e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:49:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('830d810c5e5241489a3aea30435b82ca', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:26:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8314be184c7d4b02a85b716b860a7d33', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:52:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8316e5180bd04df783e2335a64607ef4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:54:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8318b81e69df47cda9cddba71225d173', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:01:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('83226479ac504a81845eb96da6da41af', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:04:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('832c235b4f4b48059ec8a8cb8cf41835', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:16:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8385cf34f2444d56ae75d558ce778b60', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:09:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('83e9ff52a58d47b1bca85e5e431c6168', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:58:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('83eb06cce5364a4cae8f589cbdfa15cc', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:20:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('84823405f49b4eb8a8838951c1e50a68', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:28:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('848bc1b5cd594dab8588e14856efb6a0', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 20:01:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('84a430ec138b4e569ba6048f55f890f2', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:52:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('84b499173d894478bb5ad2ae1791a75b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:11:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('84dc91c2023b47478e3125f7bcaa8205', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:40:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8511703ed70047759f603dd9d77f5c58', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:50:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('85194d425a5e4580a48c9b882b2dc550', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:50:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8541a4d1e28e46e4837579b76689cac7', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:31:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8581ddb149ae4be98123024495373f7b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:48:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('85825bb860544e14ab732fa9e9d367ed', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:10:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('85a92d34f41b4246a67a778b740904b4', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:52:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('85b86bb2c87449a4a8052dfe71e52533', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:33:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8609d233caa74d7aa35ec956a3016834', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:27:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('864f6e96927b4dddb168afbed2172ea1', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:13:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('868599f6ee2648058523735f1226700f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:35:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('86fedc0c0f04483c8a7c3161dbfed200', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:46:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('86fffa63f9254bfe8abaa1cbe2603b15', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:31:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8727f95a52b742f1be3a954bf729770d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:50:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('872b052601ba4a35b07c71a831f3deb6', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:37:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('87379f48f9c44f8d8f618fcf5d1c845e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:20:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('873e448cbd5e47b7967e38b6790eebc3', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:53:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('873ea7cae8f9495aa66fdf68c85740bb', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:41:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('87b2eaf80e594e6280dcad8fe85c2ddf', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:47:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8806d4fa5d0b45bcbaec2f6450bb8fd4', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 13:59:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('88183cebb8f44978bbcd124b46d19054', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:45:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('883966313b8840bfb2c06e67e81998b7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:56:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('88854b28c8e24a329792dc045fdd91fa', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:28:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('88ab8e01708b4a76b292e23e31fecbb2', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:46:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('88cf2235b8b2407d850952e11234208d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:18:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('88ea1181e953433f8ef837f8f5880cee', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:30:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('88ef1590be714426bf7c358cfa44e550', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:08:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8909fd436e9041fcadf375fa844e2abd', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:45:19', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('891b93dbd2ed4465887854c1ff87e21f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:37:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('89678c3b4a2c43fa92e4072be772102d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:51:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('898340523fc24a8f8e998a628bf7dade', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:27:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('89bc384b179b4fd69355ee86c992f3b7', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:48:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8a1b2ba180ea47d4862e6080ebedd9b2', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:29:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8a41d9d814344032a6a6cdc484f46632', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:40:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8a4705945b7a4e1bbf7de9d1bb73505d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:39:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8a6f0e032e974bf79baa6eb281796aa4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:40:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8aaf9a3e652f4c7aaee85a822f5a5ca1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:07:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8b1ec1f4ecaa4a248cd9e0085be543a8', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:42:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8b37ad9e60eb41228e1f4917e3c4a2b9', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:42:19', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8b3e9b075e72411ead4ee9c23c756cc3', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:33:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8b6ba23b3d6948a18ebc8588feb199d7', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:50:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8b7794314cad4181b836072da99154a8', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:55:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8b8556008d854b0181c36dbb3b0f466b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:43:19', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8b8812a300b04abeb41a6d87d79aca32', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:03:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8b8b86703a0f4158ae12c3f104af9c41', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:02:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8bbd1653f4c7472d94c1d37fce9c6575', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:42:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8bc64fe226ea466c8794963cfe919dfd', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:53:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8bc68173945f4c0e86ae873583d9da9f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:57:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8bdb98ebddc546aaa0a3c9a79553eeb7', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:49:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8bf1e011d71748a5997d924169453d0b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:49:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8bffb606607142b5be6533e80d4f95f7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:15:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8c337776264249458d535a3e78ef2eaa', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:31:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8c8667f59b2445b39f5911f1c48963f1', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:29:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8c8c06d8044a487fabd88192661e86ee', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:18:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8c97a7fd88f146ec8a6c4ad3efaf5374', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:25:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8ca796fe9fae4401a3443cecdc57b519', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:30:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8cd9f528e9624c9b8019becbd7be0b1d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:03:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8ce29d48923a4d59be913439ceaccfbd', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:19:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8d4df333f86c4098aa45a0a7257489f9', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:47:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8d6a5a920c9c4f37a2ed6da0b4653d62', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:50:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8df3c69338e740eeb35a40be7ea38d0e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:47:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8dfa1077b1ec4426a0afc0db7b627329', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:56:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8ea47367aa5e46f9a21fc58dd2dd0780', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:26:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8ef1b3eca90f466383992dcdd215fb09', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:52:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8f037c04ff5c4e04a5d5179fcba3ad9f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:38:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8f31e2f040224311afed2f28dc66ce6b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:02:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8f34349194ee4a86836e12c950c12404', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:02:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8f3b0e010f0b4dc3b81018f2837369e1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:44:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8f648058323449ee9f7b04875c7d2fb6', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:48:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8f6df6d311f4457b93635479add353ba', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:57:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8fb8c956b72d4b81b1733452f9b3a990', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:49:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8ff71e1065a34ccab61eb0f1b94f29d3', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:38:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('8ffe4bd9d2274389bf9a0431ab5558ce', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:44:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9006a04a0d1a4dcf9bd4fe271ebfe562', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:36:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('901adc778ec74ec9b55e0cd4e4db478e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:57:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('901e2bb3e1c64e2da918d8867e5bae57', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:40:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9049dcbbb59642e2a9a01b2d05d07b0d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:39:01', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('90608b593f8d42bdb398b6e879a15644', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:19:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('90c006602cd24735ade459dee4ebf6d1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:37:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('90c347c3ab4b427191ea15675081b287', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:01:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9136aeda2f9e4fb0a4ee395a97791d2e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:30:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('914a72bf16e6466d8515b090efc2dcc2', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:59:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('914a7a87f4ca431db376c791cb0d9562', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:18:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('91813e2a4bf44313b0dea43457934cff', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:19:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('918cac9312154c819fd60a9ff640291d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:37:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('91bd236afe6f49f398e1a308ccb8429a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:06:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9259f3eb10de4cfa9463b3b088a0fcb9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:49:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('92778ecb40b142389ac27abd860bde61', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:53:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9294fd70df7e4eb89dcf9336ff3dee62', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:48:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('92a95d55247443e2ac1c8d00aae1b5dc', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:38:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('92bcb85d7b57471c994dcab0403e853c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:42:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('92c649c5689c4a69a041ac9e0b69a873', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:50:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('931371daec204b4fa024ae578438d17a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:17:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('932b5356a2c4450786d3f1727b145baa', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:53:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('935402c061294a2485b6a13b11d79a8f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 11:00:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('93cbf09db23d4c70b4f9a05b65d1f407', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:41:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('93d32ba2b62f4cefb934b1c2fc2ac638', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:09:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('93d6ff2eaa544c168ff271628b23165d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:53:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('93d9392d861a4910b7bfdbf448f358e9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:42:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('941acfd7f82c466bbb9ec0969aa5afb6', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:18:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9459ecbfb0864dd19da71b4ecb63c15d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:37:49', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('94631ed184db4ad3992379fc45da2315', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:35:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('947a8f0546e94a0e809e7494d5f7b5ab', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:30:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('948b907565294e4e8bddfc21e8de9e03', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 11:03:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('94a63bb912e241d2bf1962cbf79f84b9', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:26:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('94d314b671ca488386789323e9bf7101', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:51:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('94d9cc93b1a849c9adf81a9d55071c36', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:07:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('952634e6ed0d468c9f18b5352d826887', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:51:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('954bd2bcb0f445be84ea0f5209a26da7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:36:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9554d5e768274f348d6f83589d56ed23', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:28:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('955fb572858a421198ea85c750bfbc99', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:52:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('95afba7811a74dc1b01ed9640aa950f1', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:26:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('95d443db198344fc84ec2ad8fe140abd', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:37:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('960e2dc420a6411387377def9374ce50', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:36:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('96258be8383145179a694d2619ac94fb', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:35:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9656b29cc1e349af807d71c96e8575b6', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:26:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('96bea7fb980c44eea27c6bf81e720e64', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:07:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('96dbaa67b70048fe8360c54d82ec0169', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:42:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('96e36e6854e2425b94286980988da654', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:12:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('96ec253d466c482f9fe1a8849ac5c540', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:34:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('97054e5ca1834b9d906b8f91283d0144', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:09:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('972e7702c2924d09ae6034507c29cc9c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:55:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('974f4e7c7a6b49aebe0c47967c9089fa', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:41:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9761fabea0a74e94b1de6a2988829eeb', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:14:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9780794247a44cbc9c06984a127099be', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:36:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9785bdd5df5344fb923f7328743de409', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:52:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('978b3e7fcd704d36ba3328a2b99c6715', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:59:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('97966e1b8f954e3a92f2314b28a6046b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:05:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('979ea10954744f778232b105fbb26d5b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:51:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('97af71ce0e774830881d34552357b264', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:41:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('983da1cbb5814ab3a1a4a15d5dde080a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:16:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('987edc069d96458c8b158a69a8c7dd84', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 11:01:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('988b645301da4174b44ae50fff9e1d9a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:59:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('989aaf5c7f2c4a72ba6da66dcd149fe6', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:18:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('98d0ec94e8d44c628aaae4dd2337e78b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:11:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('993a258c56744287b0a92cbe7c537fc5', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:47:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('993d8825f0734fec91f6fc41ec7430b9', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:58:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('99466bfa7e224b46914bf2e1402d672e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:32:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('99dee478ff7f4ea3bdd0cc6fde8aec12', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:04:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('99ed307300934930903c1a8ed7672ca9', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:16:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('99fb6889f557430e853838f6e596be66', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:16:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('99fd9dc1523b4d1db9c3c02940f00620', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:39:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9a03fcca45c74c1c8bd9c5a672bf4526', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:55:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9a252301fa81436c940c1be1460be409', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:57:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9a630c2ab97642b58a0cf56d69be6baf', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 15:07:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9aa641c6ebc445c3b55c01bf20393342', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:05:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9abebde4f59d4f52a902a0a9ff8ef24a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:05:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9ad4c6fd29934d15aab42ee5e6f255fb', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:16:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9af9b215deb44fb2ba01d4562cc32864', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:49:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9b094a25f992479886cc3d0c1fc7a734', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:37:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9b4b5d04120e49f9a500cfd84643ad8a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:42:49', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9b5156a201554241b3617ca8edb427ba', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:56:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9b676309376a421b82dda3582429d956', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 15:02:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9b9d8e350bdf443c8d16a09cd147e46d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:42:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9baf566d3c6840d6b15b48887aa8b5c0', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 14:36:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9bc9851f92a84fd994dba4f554e1ed6b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:58:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9be00eddcdc44a8ebc6870ecbdf819bf', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:15:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9beea9e005984f548690431872fd13bb', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:03:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9c83a90e23af4e94a35fb34aa0166aeb', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:51:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9c8f2e4a98ac4144b9e6cfbe2e3ddb6a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:23:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9d05679915e24126be840bea15a94773', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:47:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9d1f08ece33449d6acd5cf82aa2da25e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:00:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9d62b979a4fa4ac594e21a6139725668', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:05:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9d8c6bccbcb24d768b950cce256b453e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:04:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9de52952e8bd4aba96a406db843a0cf7', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:35:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9e0d9dfc3eef4280b84ed96403e9da24', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:50:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9e1fe89515d2471a8a58e0d9abedf3bf', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:10:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9e576ae37d8a47c9979158f1bebb2c5c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:56:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9e6b53744272449aaec68e6777a9bf09', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:39:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9e84247424414c7d8d447bf1d500addd', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:22:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9e84f0b6a6e24fb2b52c895751cbd272', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:49:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9e8c101fbac74ecc96e817fabf43a6fc', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:36:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9e972f226c5b4963bdcf88412094673e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:40:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9e994a7014564d4484f3779cac41e559', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:43:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9ea0b9f93f854101b518e23af99b23d7', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:47:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9ea6dc47122c47a9b316bcddd9827d94', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:41:28', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9ea75a5275cb4d7e99fb83e0d8122110', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:58:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9ebb6bbcb14c4176bc9d4e945388279f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:24:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9ed459b5e0a240c7808e0988865bc86c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:36:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9ef3b1da21ec458690ee2522d5989394', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:58:47', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9f0565b4c41a4ff2b9729b6980cf246e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:08:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9f10c2d05f034bdbad57b44dfff28b76', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:17:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9fa6e55bc4f247c99caf2af706597f21', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:04:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('9fdd62b4de4b4d81a95dba7255f5c95a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:25:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a0cfc5d75c2e4e0fbdac8a4a9b9d7565', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:55:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a10a9bd80521463ba22dc61559d824c7', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:11:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a12ecfb713a64e46a4b08394714c6f38', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:55:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a1593bec552a4555a0633f23d0ad7374', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:02:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a167e64535c24ad58b6d2401b9cec6bc', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:21:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a169661afe354d579761496730f7550b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:18:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a174b9eb57e14ddab4748ea760dc6522', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:03:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a181c645358a4eebb57b8f4e0343a13c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:53:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a1943659f8544f61b3b1d4611d38ee13', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:53:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a19d904106614cc7accd67eadad9545e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:43:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a1cc21bfd15b4c3097b21cc9b2b3e829', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:56:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a1d97c81a87a4570993dc315b874ee5b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:55:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a200821c9267459183802e9a2ea690e8', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:27:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a22ddebab17846a59ca7d0fc312fe107', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:18:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a2581958f91a4467ae0603b23019af4e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:55:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a279920be9eb44ca8fa7853d8c9c96cf', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:35:19', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a2df4b7621bc45c8ae3f5c392ec23428', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 13:58:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a2f94585b92e4c3db9c22a7baf1b6019', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:52:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a30eb220efba4e4096023502b3f1f1ea', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:59:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a352e13ade5d4433a29d2885485ccbb3', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:59:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a38e6405bc2c42d7b27a86b88b1bc329', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:36:58', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a39bd243194e4149a4fc6ceca313c592', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:34:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a4324b7fbb10427e8ed7a99faeec6520', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:42:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a46d771bf87544a79709642fd012961b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:56:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a493741a77e54884a72fcdd00e724f01', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:50:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a4b79b5bdbce4ac4b83891a010775dac', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:37:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a4caa0b950a64a71a7cf8e771532a251', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:35:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a4dfde4a0e0d4d02976944c9d4e2cb5b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:34:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a50c3915035a4a93bb063ea8acb6c448', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:31:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a50f917f58eb46cfbeeab5a131e5ee4c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:55:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a5180702174943ad9e9d3472957d56a9', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:29:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a53138c72cba4a59abb1e579cd44f859', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:27:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a590a3cc1127436a8bc87edcd23bd50f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:04:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a5c25c149e384c6697f87e55b99edf00', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:48:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a5d4765633594b7cb687fc37b3de4257', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:46:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a60c44c8e5c548108d9de332104727bf', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:58:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a618843ec3c94d58b733ab2aa0666e6f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:26:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a636bd9348c34f539721b6f64425e334', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:10:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a6440cf911de4c0d83c7b9d53610589e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:00:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a649694e9d5347eb945e8a38ef195ce5', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:41:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a6987f5772a54a11b2d74700d008c885', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:05:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a6ca9b888a8e4cd09d0509b82ee9cdac', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:34:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a6ed90347d034533a1134c0533d4355d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:27:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a6f3077dfe9d4d23bec08f2159644750', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:34:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a707b130408f4e7f9ae251cdedecce3a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:44:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a71bb103bc7b4c1ea43509698bb0e5f3', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:44:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a71da220dcad4d9cbf583fedb093d633', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:50:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a73047246d8d4bb7997000d351be5e81', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 13:59:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a74f30f50d1e4bd285465a16a3bd4c4d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:43:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a75a1080d731402c9b52be07ce4bae4b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 14:36:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a789437ef24d4a6780c529d164984581', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:53:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a78ef70343054babbd2bdcbfaa8a0a06', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:21:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a78f7a659d3a46e5af1bcdfc8d2f5af7', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:45:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a79015a8617642b5a6cdeae97a7b89f8', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:21:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a79ccbb5317a4ac9818e668a20ed2510', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:42:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a7ae9265f9754278b7fbaf9ea87de602', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:54:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a7b65c39e0cb4ec9a0133c5dea2165f9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:10:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a7cd82fa310b4a42bf5812cab0350acd', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:27:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a84b84542120416892c42ed9a313c81f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:49:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a84e9a348a5d438bb45f21ea71cfb505', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:45:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a85599817ea84b8c837f6684e0b676f8', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 13:58:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a87e5d7fbc124776813cedea8815efa2', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:38:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a8ca794b3ac74c51b37ed41ee4fde661', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:32:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a8dada1e9b004c4bac6315b3d0db8056', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:36:59', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a8e60711b7fc4c0ea7cc86ba4f693dd5', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:32:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a8fec5fd50d04a1e880c1c0f8297e323', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:09:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a9225965d51e44eeb287bbe96476e0d2', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:15:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a929a911060749cdb08f952375b2e3d1', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:41:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a92f05d4a05c4334b1f16d6e34cb8979', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:41:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a94cbd74c9834c0db02d8756f41ab724', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:21:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a962e0d604514690a6d3a29485ffd7af', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:58:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a9b1925a07fc41de9cfcf1f66905b0bb', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:01:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a9c213e0eed149c4b2b30edabe5fca43', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:33:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a9c3dce93f1843a7bbdd915a71899e30', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:21:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('a9e326718cf74e95b4229cf6e94ef1d6', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:33:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('aa0984552e5e4e55bbbf14c294977305', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:04:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('aa254d22b0ce4372bb30b2b9ef55355d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:03:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('aa419d76eaaa4e78abe73b36709baba4', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:36:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('aa4e3d595a6d4130888b9b9d2b41e126', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:23:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('aaabf8d38d9942289f211400311d926a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:55:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('aab116150b9445bd9c1e7bba503052fe', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:21:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('aab4a27d9b7a4ebb981232378459e113', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 20:04:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('aac61b969c594fd0af7d9fbae921c211', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:22:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('aacbb32a2c0b47b4893fcd72ad55fa96', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:54:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ab6b8857cf0c45f4a2ef0bb959339e90', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:05:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ab8a0329852341e3b41ffc6051b9b66f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:01:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('abb365e7ade548de926d10c3ac5d97e3', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:21:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('abdbf170dcb640bab58232c19ad25893', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:12:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('abe9284c492e4d21972f0ddef0c206af', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:06:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('abf6b40de5e1439181fcdb1ce27b2046', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:02:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ac483ac75f0c4ed9ba3e15e1c7a081b4', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:37:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ac639be8bee84878b1f172ddb1765597', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:38:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ac74c8c62d254c0482c29385eb0425e9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:46:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('acd35255e4a54087bf29db73193069e8', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:38:31', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ad4687b561024f90879e193973977cee', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:13:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ad46b9c0c6cc4e37a83c24bd8eb6e4c0', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:46:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ad7739326af342e78a3e288cbd665707', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:18:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('adc1e0ce70034afeb631a6f11492abc6', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:53:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('add9aa011b2d4f7481b5fb2e6db268ee', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:51:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('addee7445ed84e368a1ad63b44631023', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:43:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('adefd972deb2438692f769055059c314', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:40:19', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ae4ce82f8cd9472f9142828eebf9d556', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:32:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ae7b1405e37c430baf205ab01b8ad701', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:40:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ae9cca8df6a5417994e25f544931fc38', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:35:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('aecd4264210c43dda26c22246d60bc3b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:33:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('aeff687f50644da3bee76c8d7ba24259', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:16:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('af089a4470bf421c9a568bf0227b6787', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 11:02:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('af7502133bf94341b085e482a79cd762', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:22:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('af787e17128f4f1e8b368b7f7d050247', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:00:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('af7e8b7339e4478fa3a96be69b4bdab4', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:43:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('af7ec242d79846eab9f9830d32b1c6de', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:40:58', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('af965b39e3184439998c0cfc90c7faee', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:25:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('af9671cbad4b46bfa14fce6d467b8a1e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:19:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('af9dd9dceac64170a3077bf8be575702', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:34:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('afab44b7c0a8450b982b50c8643a6556', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:13:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('afb3276b77484041943d18ac49e18f4f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:02:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('afb3547d32584a1b9d29d542d1f19fc8', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:14:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('afcfdfb50e2f4dba8a1c3c756b41bdbf', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:38:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('afe2345a7ac447f683324681bafb274e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:50:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('afe7bd131f034974b87a1c498f478d6b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:52:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b01ca1d2997e4648b3c3d3999a41496a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:02:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b054fd9a44be415c9e855bc378a23c32', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:55:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b0a12a88a072413184b00650d5c57481', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:51:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b0b88ddb476c47fbbb312a6c7cb0e05f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:04:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b0ce8e0d6cee421a8312e8b096eb9984', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:22:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b0cff46c113e4efeb111e2d698716a8f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:38:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b113747d8d9c4136af8d7c0ef15d4a58', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:59:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b1189fe78f27415c9b46a546444c59cb', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:18:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b120282575104e68845bdaf18eaed529', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:40:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b1232cf8117f42819541732d59845966', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:27:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b12b95fdee1a4709be7b265f4af7fe8f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:36:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b15b718134ad4901a03e7b0d75d35e15', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:59:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b15f5db728ba4120862d9afd5b4f7800', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:45:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b169d1e785e04c12b9426c4ab22386bf', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:14:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b19e2be577264bf38d6fb667628f01c8', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:32:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b1dc3e9f7acb48b5abdc3a88312c6b38', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:40:49', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b1edeac52f9e42acb8af4ba2b2743707', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:07:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b1efe027032e4231b4a415aee11004f1', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:28:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b21f32faf28640b5a32941286627f2d8', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:34:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b22cb544e4194ee699f64e1e251f2517', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:56:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b2376bcabb2546b2869395473045f3da', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:42:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b254ab20434c496fab8178fc3e85555d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:12:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b25db740d43343e6b7c3570cb993ed39', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:26:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b267d730a06f4cea96e0fa9b44a530b9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:25:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b270a82286614b0f850dcb5800c4bf88', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:30:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b2c7c1bc2c344941a3e7522d83464049', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:10:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b2cd07d4a2aa428bafea655f3fcffa26', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 13:59:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b31baea468c94772947da114cf9f42ff', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:46:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b35a9c480cec4b48ab1f3a619b18c266', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:03:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b36b322a05c04f6b9d7fb03c1fb67a63', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:57:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b382fe7f942448d99da51acf1e9b06fd', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:12:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b3c49dbd21b147509514a43b1efcb9fa', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:59:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b3ce07bb79af4ab0a49b341644445c6b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:22:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b3d28786d1aa4b4f937a9ab85b4e9a5c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:15:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b42a8e58823043de950ed9307ca2d42a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:41:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b4b6eb749dca47dcaa0e26b7d905ee29', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:37:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b4f2f309ba6f4eb99a72847dcaf4928d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:35:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b4fe5f6077df4d93b553a0798dbcfd9c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:45:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b4ff583d25c4405b8e0ff23a765b292b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:10:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b501c10f67ea4e3b9ee0a9531f049b4e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:01:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b512b622aa5949cabb337083187d412c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:13:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b550c4d102ff4b82adba199cdaf12c88', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:44:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b565befc55954b21ad08ef73c03405a6', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:50:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b5671acd549e4fef886fefccbf0c704e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 14:36:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b59dc00161af4cca87c55c99c7533055', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:56:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b5d3994b966f4cc5aae2b19a916a94c4', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 11:03:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b5d4c32b6fa64fbaaa901f358bb4d070', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:34:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b5f96ff9aedf4c5f92edd99b8719a8a1', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:31:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b632c5f966de4496ac7326fdb4ecc810', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:57:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b6391c677d54414b9e7f4321f5db5d04', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:20:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b642d8991dcf4af393bb61595704148e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:58:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b6f44783ff2c42fbad63003ca40638b7', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:59:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b6f9787250214ad09c181151b0542248', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:13:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b711d847f91d4d9ea49361de70879727', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:17:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b7850db3258c4d8c8584d7ede5a4f703', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:51:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b78683334a43451fa6103f213f73a94d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:44:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b79a33fc44f24067a8d26d3ba7f28b59', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:58:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b7d5451c5bb34451b24170c8216b43a6', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:19:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b7f2abf6b5d8468d8878210c439d7c38', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:13:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b800287afa1545ebb97ec5f7fb5e7992', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 15:00:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b8040784d4984a058552593744bf7771', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:34:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b80a796814e14fbcbbcadf529244a34d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:40:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b80bf98cb68743fea0f2189440bf79fd', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:52:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b81a82dbfa8d4113a8b1a7eab39acb85', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:20:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b83f6e7adf2344c19a710e2af1804e39', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:39:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b86c6669fe9549f890d189c6f0a13508', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:48:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b88cb76dca934ec7801c48bc3e27f4a4', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:10:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b8ca371f34dc4f58a71eb9722e80871d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:59:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b8f09343d8b74d6c8fd7925edd8311c8', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:21:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b932a465af6c4d3d9bf17e1940d9d7f9', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:50:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b93be2268f7948388d191d0b7fd057ed', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:11:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b946ba1dcc614fc4b36dafb6206ccfce', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:56:17', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b97d7e68d01c4ad1b6e512ccbc6ec30c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:01:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b9e2b581657b4d4ca59a05fc2ee23438', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:19:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('b9f8ed50fa5e4281b463131814284922', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:43:49', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ba4064c32e504023a6521a95f5288558', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:55:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ba5e56c45c16443d9fce05c9567a8440', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:03:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ba6e6e338931437d92274b9800a298dd', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:06:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ba8e548927424d608c29d7e28c7100d7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:24:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bac7635cbd204f56971a7e42128080d7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:44:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bacf99b5306c42ea992abdf0efd6f17a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:29:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('baff783645664599b43626828d779692', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 14:36:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bb16a67217254915997493d0a28ac2f1', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:10:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bb2cba96407f4fc38a92539ac4731f34', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:24:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bb53aefc89a24337940b9070fd5e8693', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:55:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bb67c2c4f4134047829b23702b877c0a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:39:31', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bb6a5e0e551c40d39889e452065816e0', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:23:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bb79eb72917848859d8b49500a1d79ef', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:25:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bb7f12e2772242daa6a96d1c93cac77d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:03:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bbb00fb7304d462289dfa8075429b560', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:39:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bbf2e4f4f55a42a8b51aa6f0c67daa48', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:34:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bc27d6c8bbf74cdd962840c68ecc112c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:19:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bc2da77aa46a4a4ba995ac185c2a85c5', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 15:07:27', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bc3be38ca5c8411da4851507eb2d148f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:13:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bc5934377a2a43698c32a3a576714de1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:57:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bc613c615b404847844b53105d18a561', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:18:17', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bc68966c427c4f57bbf28dec05c2f730', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:57:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bcd85032567947768b97f0fa7f929895', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:04:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bd06389c48cb4da1b3c8cd04e3480bdf', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:48:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bd297014c5d0440283da1343cc4d73d7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:47:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bd5975466cbe40669336c347e245dca5', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:59:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bd7d10c75d374f5b9cda5ec8d72fa4d5', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:56:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bdb343092bc847e6a6b90d0dc127d3e7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:42:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bdba0a97e97145b9ab8d09f5a7ccc50e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:03:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bdbe292ab2c84ce8a2d39d9e98e1ad56', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:38:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bde545e029514571ac479ab3a5bcade1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:09:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('be136e393b17441c9043ec9f035f31de', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:50:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('be2dc0cc89e34588aa1c6a949235a655', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 20:00:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('be4c16afdf0545bfa50a592c8cda3b09', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:59:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('be6a4d3d776444318b52a13fbbb58ab0', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:33:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('be9b9a6389f248bf96e8d506741a606f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:46:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bf12e7d000564c2398093555295415a3', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:31:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bf27dc6828a5461ba0e8e9dae30bc90f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:16:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bf316e430cf549cfa73b9a1ac604a128', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:13:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bf9b2767b4c844e6af122e58d295ec8f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:59:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bfb2ac7605d846bd889efd3cda493a6e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 15:02:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bfc955a83911492eae66458fb6f60b9b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:04:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bfda90ecf734443f83e20bb22a580e7d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:32:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bfe1b204a4de4acfae3bfcc6980b86fb', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:58:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('bfec035c0b414d3083187bfe1a4b71e2', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:17:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c0176cc3aaf0477b9e7e8ae2a453c169', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:22:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c043e1a6708a4d398124d09449f75a76', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:51:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c0519e25964b4d9d8ed193a4af567cf8', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:05:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c07e988321e84ffc9fbec2c8716cc76f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:32:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c0a86716954e4c9b853e1ee0d1ee5cd4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:25:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c0b567911e4a4c1ba33d1cc5740c632b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:08:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c0c43a300955433397276f657ddde797', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:43:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c0e765ef15fa4ae78fa6204742f5b1a1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:18:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c0fa35dd142c4d048812cb3f41449112', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:17:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c0fe9a1d56ab4bd5ac0ef05d93ebc95d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:41:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c13c0caad21d4df69fcced17bf239a57', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:49:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c1425f3adb764712bcaaea4323dbbbae', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:45:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c14ed6262d17474baeca977ec2479ff7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:58:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c17d953edc704dcb9b2a5742cd16f40a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:22:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c19982e618c443de900bc428e8204356', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:21:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c1d8e54bcc554a78a3730929d8687434', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:47:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c23223a13361417da870871782bdac26', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:27:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c26a94538a8a4695a7d0e1d77b66840c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:41:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c28d63263e394be6a283d2e41b8594dd', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:09:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c2b06a4c6e724effae8de171af5719e6', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:24:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c2d5b2d276ea476d964c194c9827a1fe', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:06:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c33961c931a54cd0a7f2938d16a0aaf6', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:29:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c37629af91d446a8936802facad034a3', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:13:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c3bc6781d1e7491d8c0ca3cc0461630f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:54:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c3dde86e215b4446868be376d357b14b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:15:57', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c3f1ed9521bc42e68c04b389f68a9874', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:02:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c3fbb30c3230402287b77253f43b1030', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:26:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c40831b1696a4e719c886874f4c4b3b1', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:51:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c4372d1c7db14d86ac60272931f52074', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:39:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c445ffdcd23343e4bc85683f54b5a204', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:46:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c44a5b06587a4c94a7af82af958c0623', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:39:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c46b2bfe9ac64e9999b884df264d9406', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:37:31', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c4800a0cad67447486290ce11b0609b1', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:45:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c4b71a9858524a5e8efdee1e2c1e2bea', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:55:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c4b876975fb74ab5871803265614b604', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:26:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c4c8fbdb837f49268daa6437a194f7e5', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:57:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c4ccc3c5bd964a42a38315f0a7cf2398', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 11:03:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c4f39aa0d25447408b6b96d2b21e1bda', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:56:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c50dc1160ad64aeaabd790736d1c1d27', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:51:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c5102aca3d0e496d8d20e38b5e94b841', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:03:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c55b626b14a94d118bd87b4f4fd6539f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:05:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c56832134dee4dfb9a88c53c56987194', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:05:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c57e94a031784afb8220b728e9f8d7f7', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:30:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c58922bed67f4997b63f7018a26322dd', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:47:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c591206d352b4db49774d0136b4e6ba1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:47:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c595af0b655f477a886d7f5c89adb82a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:49:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c5991be30375407f8489c6de95d50110', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:48:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c59c08f2e1f74070859186793aba3617', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:48:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c59c0a3dc84b4e01b9b9802d11d61886', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:41:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c5ad01e230c64e0088ce886b805c027a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:39:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c5cd64c19c9a44c0a34b2f6debf83dbd', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:53:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c5ce1517ebd449f3b1211345c4f0c44b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:38:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c5f30a970a0a40d0a254224366358a12', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:28:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c5f85ebc73bc42be81e6a41c140658d3', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:47:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c5fcf3a987b94dbbb38ac984b359d63d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:56:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c6ac357b09884f54891645795ec6514d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:35:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c6ca2cd8139c4eb39b2f2cf71cd97bce', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:43:00', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c6df395c6b274be091690236ac765f6a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:54:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c6ece38ada024caca474660f976d1432', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 20:01:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c70668503ec74d798a9b1c164f3a12ca', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:46:49', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c741f8ba96f342028f912bb63e340bab', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:49:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c75036142f8d483cbbe82a3483da0252', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:06:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c7526fa536cd4429b8696edab54dabc9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:42:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c776baae95764325b6554f75130fcce3', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:54:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c798e69394c8487ea7626c343b6be637', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:21:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c7b2c0dbc16840588e12671c833aea0b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:48:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c7b86e849a5c466fb8cc6f0aee71ab21', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 14:36:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c7db238bf75947db8adc5a5d1391be0d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:24:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c7f15ae56bed4ccb87534641697ca5ad', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:48:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c806cdcc1549459195e177d244a9adeb', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:58:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c859e45e46a1434abf641bbf515da3f5', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:54:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c8c758bfccca4383b0bfcd0cce475e9c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:55:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c8e15ab0f157459fb7dc470ea251abf2', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:56:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c8fa0a6ee0564a8480c3c6f9cf1eae7b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:05:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c9438c6806c44fd38426a7acfdb6eab9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:20:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c9693385654c49f9a28aeed018a28f61', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:21:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c96bbb4ffbe448deaeb080e5223ee24e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:35:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c988cc768a494b9c92a192149ada4d4a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:53:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c9ae150bedc141a185cac3d8db44eafe', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:57:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('c9bc21b8f8e64e26b16ccac2ca842f38', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:39:58', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ca370f16a0544b5391f3a6a109b67276', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 15:00:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ca4d787026b54e94bf5fc31337eeb87e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:36:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ca4d88c5a2ca4aa583f355dfb72c768a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:44:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ca9d10cf3b8849e2b00940c8d66405f7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:49:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('caa063ddead44ec19ca1743bf19c2eb1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:09:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cab0833367d443338ec2229fffcd1dd9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:41:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cb28496ab2c04738b6a5427cb1657919', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:28:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cb6c0ea08d3d4582909372e453e21293', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:36:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cbc6a93964424e75a9b057e9584ce16a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:00:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cc2e4e141bcb4f7d8b9e71601515eab2', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:46:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cc4442e1aee84774af6a30dfa5471316', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:41:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cc4829a1b4e54c81bc72e11519ce71cd', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:14:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cc5e1954f5494fd1b74e4375dff39bb7', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:24:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cc6ae75bc1d641de8df3f619a2cc8fe5', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:47:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cc97433706504ceea4dc1b3c5f9de690', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:13:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ccc529c486d844fca5a51b250f739534', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:41:58', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cccfc79452f34b7db7895e75b761341e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:28:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cceb67f29cf74c689d0d434be11567e3', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:34:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cd1bae95f5164d6e872b225b85817022', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:32:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cd3201c423c3453b90298e5aa1b127e2', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:54:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cd7d86995be346f997ccc7eb00986d1d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:08:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cda57aa3604e470597c3565329f6ed3e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:35:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cddb2a031b6d452faa4b5189764b6020', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:17:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cdf6cb0451714b089055065057258614', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:40:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cdf7679519c749d58162ae73380e9cdb', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:22:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cdfba8d030e64f0ca9630560889bb9e6', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:52:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ce21609c237149bda90ce162f0b10866', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:00:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ce7f1f27a55944068256d3537d94f5f6', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:14:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ce8228bdd4504181b8731f9f67be0025', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 11:02:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cecb01c717444d59837f57c359f9dcd2', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:51:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cf01ad625439460084b4356500abaac1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:38:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cf2ea7489896462ab84a6c9a83655288', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:38:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cf3aa211bb844ed5a0540351c0d1936f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:55:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cf78ee1d146c4f4faabe053e40bab898', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:32:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cf908731db534682854213484ae70274', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:42:28', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cfadab6ed7394a75b7bfbe52d99a4d96', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:46:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cfe3162e200343e193ccb2255ab09638', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:01:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('cff8a403d98d4eedb42ddd275a8201dc', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:32:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d04cd005ba764915a414185932ccce04', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:41:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d06d4e5b192247d4b457a575a7314719', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:57:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d070f9ac089047338931ca645c4d34c1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:28:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d07e6c8915b740778b2f6571324aea66', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:10:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d0869bc3b5454c52a3af7f00f741a11a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:46:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d0966474bbff445d9bc31e90338ff636', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:03:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d0a9ad0b70ef46539302884e582bb539', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:25:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d0ba8ed17ea545678a81defb96bc97a3', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:57:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d0bca9313c2e4467b9fe2ad8a1c890ae', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:29:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d0f373607b3549bf9e74722f898040ff', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:32:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d11c1559eba24eeca68a225e68facf8d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:59:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d141c7d18e414740b21aa086f21aa0e6', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:46:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d14a466cfa3f43e6a58fc53c9b7300a9', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:37:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d1858ce6d48f462996fb309aacc84d1f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:31:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d1976fb0e733461a8f411c1c81be136f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:51:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d1abee7f0631444d9c502a3c809e30e2', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:48:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d1b5659d43d8412da0fa4c2a7ca74744', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:01:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d1c5d9284c5c4a828539d0be77ae917f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:16:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d1d9d05cd47444bfb2a8c154446af6a3', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:24:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d1f3f229152f41ceb42a3fb99d7713d7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:12:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d21b342772d64ff283c14107d3e26cb4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:17:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d22f7ee55dc04862beabf217a5f09b12', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:12:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d25bd58c518143cb8457eba8fe56f2e2', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:59:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d271e3892d8c4a0bbf99135ddcd73f06', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:54:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d2a1b08cdfd84506ae959a0e0ac55202', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:30:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d2a4504a91434278a2ddfd426d01eee7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:48:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d2be26c9bc1a473c898f8ca10b1e7216', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:52:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d2dbd939cad046b5a4a413ccf4dc7cb6', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 20:03:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d2e41db5a55244f382e3c2d0f1ffe381', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:24:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d31b389db5d8462eb86e31c68d6fee11', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:59:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d323caaa86294f4d9bcbb948807cdf5d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:36:19', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d32f7f171c2a4ba6b94c50e98d5e26c6', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:56:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d3546469d2a64e9dafebbd080b6e3fe3', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:41:31', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d3563757b1824ca6bdadd7df67c1c6e3', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:52:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d35cabd90adc410ebd84f338a8bee79f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:07:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d3819c32d3544a1baf299cf8c16523df', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:38:01', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d39170f7699848ff9873d6409e5e8535', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:33:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d3c3a7e4678c4cc2b15ce8d2ffadb45c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:49:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d3cb005a473f475fa41a7a785a4fa105', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:02:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d401061bb0f24e8e8621ebb3a7dda101', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:08:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d406ff4184f54e5287025c43c1066932', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:07:47', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d4b79d7a85524c3bb83f1ca880352621', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:54:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d4bd97f4bfed4613a90663b0bf94e04c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 15:02:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d4cfe59a584c4a128addf90c984a48c8', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:34:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d4d7e07181cb4d1a82e14911df39af4e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:41:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d4f44ea3eed14f938e3cbca1e26290fa', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:46:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d4f49c84aac54ec3af305896232c66a4', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:38:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d50a630304b74490991fb69dc1143600', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:37:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d54046cad8664c91a7fd05b515255aa5', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:52:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d571559a8af64243acc9761621bf50b3', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:49:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d5844b5d074e426aa7c0d8440f573db8', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:31:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d588041b8cff449db20014a16f0a76ba', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:24:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d59241470f994e6e976b0a4fd49e3f52', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:00:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d5a5a5f3ebb94975ad90e6c775fc5df1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:39:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d5a9072b976845b9a46e2cd57f2319eb', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:16:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d5b2e248b41647aa84a3f144b1dc8f28', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:50:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d5b9fdb3918346459467e9d8cb368691', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:29:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d61618dbddb8456bad87b1972997a5ec', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:12:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d6331c5e784b46aa839bff8134668970', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:19:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d639efd12f144f529b60b8d5ba5b6f70', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:35:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d652ead635ec4fb9a132f68d9dc2a099', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:42:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d671a696bcde42099e08cabc753d7c08', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:37:28', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d69b40e948b045789451706c6f91a66e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:44:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d6dbac7736994557b55e17408ff3e277', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:16:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d722ec8946d14798be4e0340da6d3902', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 18:38:31', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d72d3e9092754ff9bf6c56aac1ea32a4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:49:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d74389d2eecb4d4e98aa484990ad7114', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:19:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d754534bff584c658d7fe5ccffe3e764', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:11:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d7638ee9d5ce40c3995dce642da6191b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:52:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d76974bec4394e1688c621f4d13c2ae2', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:23:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d778f523d09d4d2789dc9b23ec2cc6ab', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:16:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d7967bf99eb045608ef44e06e14ad454', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:34:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d7a113ec0a0b4089b7fc76fdd3a3500d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:26:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d7a5104a3ee14240bd4dc0e5436df15b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:35:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d7c72d17bf7144479b22b32dc844ab35', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:54:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d7caed73400d4bbdb2fc745ab5e04ed2', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 14:37:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d7d744bd65184129a13348678319c649', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:40:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d80534d688e64e69af54b029d9c5789b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:08:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d808f0f62f314c0cb8b26206f85c3079', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:36:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d80e17955d5b4cb3a06bcae23acb5423', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:15:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d80f0200e38c474ebabc2aa6ab5aa3b2', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:40:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d81560fd06704a0ba5a64b696735e53b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:29:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d8314fa663fa4ea78d6cde654023cb09', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:54:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d84d7c72c4e04b86917f662f59893212', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:50:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d867e788eab545deb8e86e182d2d48b7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:19:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d8724c84509247129c7be4ccf1f9982a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:57:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d8779adc0774416b8d0741a056ee800a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:59:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d899341ee84a4e5c834126cc53d2ba8d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:23:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d8ae78a9b2f641958187f825a8c29703', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:55:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d8c9ad554be141ddbd74d3878b7ad5fc', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:53:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d8de08e64d034a508b2bf821d8be10a0', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:47:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d901fa6a47a8415dbf5d4843bf7f6c1e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:59:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d9210d6dada844ee9e3c0529fd59d454', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:29:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d9328c0d855741a4b49c2387a0e3835c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:54:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d946a321bcfb4f3984c0ca74023c07cc', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:26:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d96eec1825ae48148a25e965fb8ebc79', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:15:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d97451f51d9a4fafa070291466f2bf05', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:12:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d98d7839a64441d380e7960b8a4cdc93', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:44:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d9994e77be5a465dbe63531e7c277e38', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:09:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d9a02f9226a14c01b6df519bed4262ef', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:16:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('d9dba7f60cd94738ac33c5a84dc01274', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:44:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('da165fc21e84467d953766fa0484054b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:39:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('da43650fe917477ba752f3a5205a517a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:43:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('da6b9f845c6d40499b051ddd8b8cda04', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:40:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('db6253ad2a234dfcafd607c875063246', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:06:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('dbad7d50fd4944ac826cc87dc8ad1151', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:33:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('dbb4d2d5093f424d90a0d53897470de6', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:57:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('dc0040f870c1470cbb4da9af7e4c828a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:36:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('dc19237d557b430fb58fa1f7d7389e40', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:29:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('dc23bc2fa03444108a44a6192a77c7e1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:53:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('dc3085e77cf243ab882e60ace284706c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:19:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('dc359cd1ccbb434e8fd102dca2bf788b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:37:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('dc500679a030403ebcd748d8094ac539', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:30:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('dc59de6eff524b97b9aaecd158181f21', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:41:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('dc6cf49f5938452d98a8165e313a50fc', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:29:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('dc8164e7d6c449ef82184c4d2021e5d9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:06:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('dc9bf2c4213e4ab897732763ad041746', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:15:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('dcbf2c37f51d49b1853ae75c10ec1ac7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:04:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('dccfe44cc91748e2bf70a3c71149811b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:06:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('dcdec3ce913b4117a33d473f232be523', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:12:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('dd00bb22457349a1bb0b45f13415cb67', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:08:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('dd1013ae9236462fb6e3dee79671902f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:22:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('dd590de07b04458e9db11cebfba60e63', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:11:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('dd93f97d3943474f8c9409ead454be3b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:03:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('dd9bb7ce064f48bc94b9eb0345366bf9', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:31:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ddb22123770940d0a46eef26989129f9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:35:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ddb56d27986446caa9b4281af6d467b8', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:33:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ddb6c189851f4921b9e3920d89e9a542', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:56:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ddc021585c54434a8d4600cc27eb781d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:52:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ddd37901d8254a15bfdb926d946fbb03', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:14:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ddd39f77c71b4f0cab3b0de0af4e8808', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:52:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ddedb1fada084fc8905b97002426f1d0', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:39:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('de36ba0c19a64abfb787d7132eefe9ba', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:07:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('de411e2f50854546ada8d783fa099e59', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:17:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('de43fc299d6e47448e3d90a25f3dedc3', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:38:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('de52ac80320649008a1c69cb727d4a8c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:58:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('de70b32ecb694f2bab55fe8e7de6c1dd', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:32:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('dec3821093504ea8b555027ff951ff63', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:22:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('def28a63ba064bdeb06af229ca6e1208', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:12:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('df36883abb744598a9bac7e5ec776938', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:06:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('df80de1ae3084d3f8061342f3cc22a42', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:48:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('df9419012aee43e497fac6ee2ff9dfcb', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:56:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('df97e286ef424849bb26ebcadeebc4ef', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:43:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('dfeaa5cbeabc48388e60d104e9d14cda', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:21:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e037c9d88c4c4c8998e0b7b458b4b0a3', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:31:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e0696cc8283d427b979a544844e083a9', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:52:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e06a8b20b37e4e67963ff527ea659f58', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:35:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e06aff95d3904864b308236aa023a02b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:11:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e07176aad84542f09b0fb31cc6a4c887', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:42:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e07f58a4cd7b4d6b9712cd38df8dc34a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:16:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e09384f4254145119944e2029626016d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:56:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e09cc03791e54db09eb25f061148503a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:50:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e0fbf6373c344188ad568fb6294f4e2c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:00:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e128a4f7dd9942bf874907c6e7f5b60c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:26:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e14254b2041d471e822480085364bc2e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:25:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e15ce78d0f39467484bdfe2502f7a39e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 11:04:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e175c3dbbf8546c9994aace27face966', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:07:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e18531b48bd0457cbb35c71bf2d9b8b4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:21:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e1bbaf133bd3489eb7bd05380920dd69', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:50:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e1c66279adea4b7fb3be8b849cd438c7', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:45:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e1cb75c6a8b144688d32fbf2923eb643', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:53:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e205c08baf174510ada5882315af1931', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:15:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e2253e5f01564a3a93915596ceaf553b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:10:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e24beea60a57463ca549e3fd6437fc15', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:48:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e2515ed9491a42dea18752354cece5fb', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:59:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e25773d92bb34260911c421f31c5469c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:17:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e2825cbf0be14656aed1f8f1ebb60606', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:10:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e2bb6c4b16ba4d9898173aaab47026c9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:59:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e2d1505f12f54997a01f9d5395190b05', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:13:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e2dd6e6465ed48f1b034a688ddfa21b8', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:38:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e2f52fc1249a436fb4b4bc55554745a8', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:50:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e3529aa2212140e0ae81037b5daf8dac', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 20:02:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e38fc9babac549ffa9ff663b3965f127', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:38:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e3c557cd1b6b4e31aa947921b1d978b9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 15:07:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e3d95c8f3d10430ea8b138715743d0cd', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:53:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e3f2644ead524eb4b592853127c58058', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:56:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e4884e50a3164732948dbd975ceaf941', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:09:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e494c35337c14b7dac53082c09b2f814', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:47:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e4f3b111ce814aa5994e6bf0ded3a93d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:34:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e51b737acf46481aa1ff966c4025957f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:15:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e529e9bc1508400d84677f4cac32f375', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:25:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e5389e2f755047b88ec727b691d55739', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:35:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e56850642c5842aea40ff24d646fb3f9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:04:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e58e6fa7b00f4f6ead259c1cf3601383', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:35:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e617f9be7c9a49efbe21bf8908ccb68e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:02:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e6aad44c0fc14baab24f938741660cd0', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:55:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e6cdc94dd0174443922e5e89e31a8903', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:07:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e6d8e601e96f404c9b089f15b07cbd61', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:14:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e70515b2a260444fbfe4637e5745c26d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:40:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e72d28a875b1454cae2ceff978ac4533', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:45:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e75d5d5d79e847d78f488fdfa7b13a70', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:47:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e76be25d0d6b4170be7c7e8977a3e687', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:45:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e7f66212e62645f5971b689208877879', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:58:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e85171e093764def856c1f6028796fa1', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:58:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e863ac1d3eba45758e3f68b741f5725f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:43:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e883183c098c4066a1bcb6b5b271ad88', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:50:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e887b178f85a4589a1181e280e88acd0', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:19:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e891aeca2d534f609bf3af534b5bcabf', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:42:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e8c25564d60e4939a6a97e7a1f79a471', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:53:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e8c27d02d6b34f7ab2683047601bd3d1', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:08:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e8cf5f84573443f6b333a4ae0803fb32', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:36:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e8f96e7642f54921ad5362d635ae3757', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:57:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e9846965aa48486a940e7801dcf772e0', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 11:01:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e9e12105d84a4d5faaf5d71ee05b7882', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:36:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e9f0065ad50d4b9785816c3119bf9e1b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:32:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('e9fc19c13a424e1680addc685f78800f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:00:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ea0a64f8e94d49e5a18a71c28e33e0cc', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:39:28', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ea27a2f50bc2467b8f3f9bf42b7af831', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:57:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ea3757452b9d49d7bdccf236ea0ed2ea', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:40:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ea6af0f68dd443b99f432bf50fff3abc', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:17:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ea930e0653f744819d91bdb54fd7c1ae', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:58:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('eaed2a427bd34821a8c1fd96f209b9a3', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:22:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('eb3ea6e696d04041b1d28751758a35f4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:02:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('eb629b3dbcc14bc794ad39593db15075', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:45:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('eb9647e0315541cca4abb794196c3aa8', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:43:28', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ebbfafb4fc1d464a92954bfb68b234fa', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 09:56:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ebcf8b9a165c4f4caec37cb7c8a84adb', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:54:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ebfae25f11c546e69a44347e486eb1e5', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:36:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ec0a60c936544bbb974848a76224fc91', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:40:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ec1ce6964cee43b89f7b0517b0a41af0', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:49:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ec1d496c575342898cb5559970b67792', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:14:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ec2e0995b9334592b0fdfd4942ac99cf', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:44:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ec3315960f614270be1be59900bf5c6e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:40:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ec63ea4aa00a46b2933ca6d5239061d0', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:08:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ecb6100c16e449cc8ceae4d14ef793bb', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:43:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ecbe4250e2e9407a892664fae8a3cb0b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:55:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('eccfc7ec201745fe987b137d19b9071e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:14:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ecf392630fc142c8ad0a4ae5e36d26ac', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:24:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ed1266fdb070411495d5002d1d9bbd3d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:16:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ed19a56278cd4f86bef10263fe23dc61', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:03:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ed42a59819874e51a1eeb2aa3adeff0c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:01:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ed65c37ba29b48939f68086f253451b4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:16:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ed731b7a48dc477a80d2711eddfb0c3b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:42:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ed79456195d14a63887a4941c56fd973', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:37:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('edc93d1a9a1848cd966431c57abcfb4f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:35:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('edd68d6fe05d4199832a871f3aedf259', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:03:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('edeb4b36323c4a3ab83fdadefc56f908', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:17:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('edf30d709dee4312a1b0762550dd1e8f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:36:29', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ee2f245e7b4b4293a9a37fceadaf63af', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:01:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ee662d2a6e2041be8a80dd7ee8ac599e', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:51:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ee7119df55c44137a73b53c39d036e00', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 20:02:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ee874f7d0e324484aa130a29d5c3f0cc', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:52:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ee9d6b49c847489b9b25db2aef83385a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:18:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('eead64e7e7234f9692443a4944860282', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:57:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('eed62aac43eb4cde89641967406809ca', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:29:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('eef3886f4d7943f886e1928e9d1e32e7', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:52:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ef378b2c3a8844e79080f10cdc467c45', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:05:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ef38049461444c828bff66abfb111876', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:36:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ef784110a0da4d6cb23375ac61885f3f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:20:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ef829e854a9441c98dead726915f592c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:20:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ef87883d36c045e49f3991ed0c654569', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:56:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('efec02856928477eaca193888e92137c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:27:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f0074709732540dc8e6116b91d886b09', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:10:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f0081ffb131a4effa0d9571938f4f513', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:48:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f01fb52c2ff44af29ed6cb1bd66298d5', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:52:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f024547dd2f7404b8c9738b91946a8fb', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:44:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f04fd1ab144f4bbe9725c48bb5f3acfc', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:27:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f076d5580b9244e3982dfd55b6a62538', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:50:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f0834cd372844776bda1b620364e4bc4', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:18:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f0a99263b86e4efebc8f56dd4720b684', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:56:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f0b61049987846c987ba1b40f36f8f88', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:21:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f12371ab73b247e1888aeefbd1d30b07', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:25:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f1354729cf8f4bc18bd47281b5baddfe', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:57:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f138a77bb92349aebde61555206faa31', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:08:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f13a294182484d509a63a760b806d23f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:09:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f166d4b0d2c649a1ae7dcec9f9f7f7f2', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:05:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f18ae9ac018249128d90e23c42ae8a6b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:04:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f1a052258c274f2b89ad31ad6a43d88e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:27:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f1a950dd978142b5ad75b0e0533cf670', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:14:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f1ac468e8d6345c39a9843fedf8298d9', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:21:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f1acae2a887242dcbf0e7130bc7246fc', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:13:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f1b4c26915784fa28c0d1e50b3aaeae4', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:52:48', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f20836b9f94346149a8ab21b50088402', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:53:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f229e72a22a94a2788a36dc2c863d380', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:56:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f2506e77a5864309842fcc77beb6b815', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:52:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f2822284b8c14039ac1a6ec5bf7ba67c', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:40:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f28cb298898d4e15a6edabe0f0d45f52', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:09:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f2d58ac610064403b53fb92efa04d3a2', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:01:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f30dd5c0d2e94073864ff8d2049fe2ad', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:45:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f311734c6da9478680fab269f8e093bc', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:11:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f315fc9c0eaa402989905db1f6b29d03', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:37:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f33027ccd5794e3a866f157f48454b13', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:57:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f359333522494c889f72f6fdef65078d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:55:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f35ed8471e294b33bdcb21fa4079ecc4', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:15:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f37643d6c48f46b09c0a1ab31f0a1b8a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:46:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f3956a742c0c48018c3fe874e178f95d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:24:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f39abc5623ba4d32ad719a84177c05d8', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:47:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f3ba7cf06c7944189577038b56b27c93', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 15:01:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f4598b0782f34db7992438c1f349e513', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:05:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f45c24e06ad840f08ec2b81e280d101f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:53:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f473027a191f423abdf25ae81ea2728d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 09:51:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f4a32082c7994b5197482118b2261074', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:33:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f4c6a6d391ce44558bab38b132394dd6', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:45:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f4da3d9171264465972cc437b455e2be', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:57:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f4fb4423c110419aa8d26acb70174455', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:21:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f525ca8c42b24040aa7fbad067ae0ee4', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:28:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f54c9eef85e646fb8b32f52f46223165', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:17:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f558eccd910a4aac83f2a1ef206337dc', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:57:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f5b180e2d30747388c1e01c9cb886717', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:06:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f60af0199d06465dac4c4a0625fb6236', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:07:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f639e78c0f1b4b83a7f36645872bb755', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:48:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f64ecb3f299d49e09c8e6b675ebac7c6', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:44:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f655367c1a574d9f9d7b441c4185496a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:38:58', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f655f843717c417d9ceec576ef4b7b65', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:04:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f6a7f4845c8d4e1fb68cd46608a7daa7', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:51:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f6e30a1c36354524a5d159cae1058d35', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:54:47', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f6f3584e477e449c9b7942d6ef22082e', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:54:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f724e7cb55eb4b38b03e2d75a74c5a48', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 10:17:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f74402e09b6f443d95439ff9fba690bf', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:40:42', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f7b2af04fe39428da0064043f647f3b1', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:54:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f7cfa45e858944bcb5d28073771b6a61', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:34:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f7d7477d16f54044b2d5cfd600e68897', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:56:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f7f13633821a453aa8f8b92af1e349cd', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:02:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f7f5a213302b443ebf4a64d38b990545', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:49:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f7f5a7d44d8543eea3390934419ef243', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:59:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f82c602a026d4d328bd5d107a499177f', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:39:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f850ee6b9788469fa2d71b86ea4918c5', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:00:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f87c0483019b4c6eb339ad202d792e45', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-23 10:39:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f889cc3056254bf6bb27884c1c00449f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:47:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f8a672b18b914972bef1093fd0315deb', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-15 10:53:12', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f8d2321e56c4407abe05158f078ecd98', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:38:18', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f8fba83890ae4e9fa7a4f113d966017d', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:02:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f926a293cfca42e7906f233a7c9dfb9c', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:44:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f93a17a5243e4fe994f78ba134b6d865', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:01:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f9526da789ab42499509772440b66bbe', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:06:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f9739c21c4c840c38905cd39c17399aa', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 19:03:17', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('f999ce280e004beebc9487001f65a3aa', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:31:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fa0a9456f45d428f98526a03c6f4bd00', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:45:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fa0f7099bc4b4b8ea28da34164fb96eb', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:27:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fa169d64bb764d5fb488cc1fb7ea6534', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 20:03:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fa649640df68493d958df412e5441a04', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:09:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fa68660825b04b619bd7306eb624b0a2', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 20:03:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fa866a0082e6479cbaac84aee0d6e4ef', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:46:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fad7fbf4699946db952586d7eb38e609', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:27:07', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fae0a923f2ee49fd820ed5ef272b2794', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:59:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('faeede9b5a3b46f7b8abe0985adc8903', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 11:39:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fb1694142a104752b76d413f86f66c66', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:08:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fb2af0d9a67e409281d124561babbc61', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:59:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fb4bd2e0de594935b2ae9e1ca2152cf4', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:47:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fb53283873e84c86b3872ba3d3089f3d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-21 18:39:01', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fb5bd023d3d645d0b666a2c3d873d343', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:41:19', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fb8c9cbce96f48cb95e73e63d2c49230', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:48:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fbb2321493204e6988154fffb3c03ab9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 19:32:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fc3c8daf2c2a4eb9ad9f165a87f7dc99', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:48:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fc54430e3c1d4ae497148c56789bb74d', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:53:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fc6e960cb98640ca9a1f0ee393da333a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:16:56', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fc7a5a5de27c46fc97f33dc2cfe08f83', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-23 10:43:48', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fc91c1c5ac98405995fcf07c62bfef45', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-21 19:11:18', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fcf8adce3f994e0bad1feab58258d58f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 11:00:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fd1619b11205400984726918b2a8b218', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:49:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fd3db826a6b04f6a8d6e78ad4c487734', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 17:50:24', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fd41d63482074c91bd2db860b1863184', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:15:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fd9c167d76054a6bb377ca6dba20d487', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:30:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fe6096fd6f394ccfb2fbef41e4a2ed55', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:58:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fe7be83df471478781aa510c54054e18', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 18:09:54', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fe9b4e16098d4151bdca32b8599add23', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:35:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('feb4facef87146ad9d529d4beb97e291', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:59:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('febc0e7d9d7144e3be26b733cfc65e67', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 18:28:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fed34c6083e349f684e1bf1d58d96b8b', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 14:31:37', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fef389041b4c4a7289ce9a90f5d17e56', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 10:28:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('fef6fb6a7b1746198c25e4fdedbad18a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 17:48:24', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ff075ce07d6848ed820537bbf889f44a', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 12:19:26', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ff0acb0a2f4c42599009c02220d03f15', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 19:54:54', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ff0d003fe5cc4143af6eca6899aff8a9', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:05:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ff3cfc19bd274a6c8418a431d7d5b331', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 11:15:26', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ff3d07a5b65747daa0fd71f235b4ec8f', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:40:42', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ff67f7340e114ae68e2995c9e7205f6b', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 15:00:37', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ff881d9fd2a143a49701090ba7d41fb2', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:00:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ff9026fa96584bcaaacbab256317097a', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-22 12:14:56', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ffd8aa0c97334e2db3da4cea03a3d0a2', 'ee001bd495fc40c0908ab98f26187939', 'beforeEXE', '2015-09-15 10:48:12', 'ee001bd495fc40c0908ab98f26187939job执行前的记录');
INSERT INTO `sword_scheduler_log` VALUES ('ffdb77c3aad14cfea646dd2fcf93b589', 'ee001bd495fc40c0908ab98f26187939', 'SuccesAfterEXE', '2015-09-22 14:43:07', 'ee001bd495fc40c0908ab98f26187939job成功执行后的记录');

-- ----------------------------
-- Table structure for `sword_scheduler_params`
-- ----------------------------
DROP TABLE IF EXISTS `sword_scheduler_params`;
CREATE TABLE `sword_scheduler_params` (
  `param_id` varchar(32) NOT NULL COMMENT '参数的标示',
  `job_id` varchar(32) DEFAULT NULL COMMENT '任务的标示',
  `param_key` varchar(32) DEFAULT NULL COMMENT '参数的属性',
  `param_value` varchar(64) DEFAULT NULL COMMENT '参数的值',
  `description` varchar(200) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`param_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sword_scheduler_params
-- ----------------------------
INSERT INTO `sword_scheduler_params` VALUES ('7e53deffcf3f419b8bf37a2760055af3', 'ee001bd495fc40c0908ab98f26187939', 'swordJobParamServiceName', '/collectionService/collectMemoryRatio', null);

-- ----------------------------
-- Table structure for `sword_scheduler_running_info`
-- ----------------------------
DROP TABLE IF EXISTS `sword_scheduler_running_info`;
CREATE TABLE `sword_scheduler_running_info` (
  `job_id` varchar(32) NOT NULL COMMENT '任务的标示',
  `execute_counts` int(11) NOT NULL COMMENT '执行总次数',
  `finished_time` timestamp NULL DEFAULT NULL COMMENT '任务结束时间',
  `completed_success_counts` int(11) DEFAULT NULL COMMENT '执行成功次数',
  `completed_failure_counts` int(11) DEFAULT NULL COMMENT '执行失败次数',
  `first_execute_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '第一次执行时间',
  `last_execute_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后一次执行时间',
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sword_scheduler_running_info
-- ----------------------------
INSERT INTO `sword_scheduler_running_info` VALUES ('ee001bd495fc40c0908ab98f26187939', '958', null, '958', '0', '2015-09-15 10:35:12', '2015-09-23 10:59:18');

-- ----------------------------
-- Table structure for `sword_scheduler_trigger`
-- ----------------------------
DROP TABLE IF EXISTS `sword_scheduler_trigger`;
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

-- ----------------------------
-- Records of sword_scheduler_trigger
-- ----------------------------
INSERT INTO `sword_scheduler_trigger` VALUES ('ee001bd495fc40c0908ab98f26187939', null, null, null, null, '30', 'S', '-1', 'Y');
