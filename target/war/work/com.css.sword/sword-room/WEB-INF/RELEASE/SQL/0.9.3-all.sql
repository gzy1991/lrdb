/*
Navicat MySQL Data Transfer

Source Server         : 10.12.10.146
Source Server Version : 50509
Source Host           : 10.12.10.146:3306
Source Database       : sword-room

Target Server Type    : MYSQL
Target Server Version : 50509
File Encoding         : 65001

Date: 2015-08-31 18:10:52
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

-- ----------------------------
-- Table structure for `monitor_alarm_way_totarget`
-- ----------------------------
DROP TABLE IF EXISTS `monitor_alarm_way_totarget`;
CREATE TABLE `monitor_alarm_way_totarget` (
  `uuid` varchar(32) NOT NULL,
  `target` varchar(50) DEFAULT NULL,
  `wayuuid` varchar(32) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of monitor_alarm_way_totarget
-- ----------------------------

-- ----------------------------
-- Table structure for `monitor_collection_global_setting`
-- ----------------------------
DROP TABLE IF EXISTS `monitor_collection_global_setting`;
CREATE TABLE `monitor_collection_global_setting` (
  `name` varchar(50) NOT NULL,
  `freq` int(11) DEFAULT NULL,
  `enable` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of monitor_collection_global_setting
-- ----------------------------
INSERT INTO `monitor_collection_global_setting` VALUES ('collectionGlobalFreq', '60', 'N');
INSERT INTO `monitor_collection_global_setting` VALUES ('collectionGlobalSwitch', '60', 'N');

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
INSERT INTO `monitor_collection_setting` VALUES ('LOG', '60', 'N', null);
INSERT INTO `monitor_collection_setting` VALUES ('MEMAVALIABLE', '60', 'N', null);
INSERT INTO `monitor_collection_setting` VALUES ('PERSISTENCECONNECTCOUNT', '60', 'N', null);
INSERT INTO `monitor_collection_setting` VALUES ('SECONDCACHE', '60', 'N', null);
INSERT INTO `monitor_collection_setting` VALUES ('SERVICE', '60', 'N', null);

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
INSERT INTO `org_certification` VALUES ('c8f1ba6c7cf842409aba43206e9f7442', '$s0$e0801$77jrffrqKY5/YbaxXCY32g==$UA4kWJWMx+kwVVYQ013YVq7H4oIfEqMrqtT/WmF31cM=', 'a18721153de246dfb9726864e327c473', '0', '0', '2015-08-31 18:07:48');
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
  `level` varchar(20) DEFAULT NULL COMMENT '部门级别',
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
INSERT INTO `org_log` VALUES ('682ba7dd0f314f5a8a41c25ede0f3253', '2015-08-31 15:53:41', 'c8f1ba6c7cf842409aba43206e9f7442', '人员更新', '更新：测试用户2/dev2');

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
INSERT INTO `org_user` VALUES ('bebbdc094b844c22aa2980bab5a3f20b', 'dev8', '测试用户8', '男', '1988-10-29', '010-8293735', '13666788989', '010-8293854', 'dev8@gmail.com', '', '', null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pd_web_dictionary
-- ----------------------------
INSERT INTO `pd_web_dictionary` VALUES ('2801aecbd9aa4ce3b0009499b89d4901', 'module_service', '菜单依赖注入项', null, '模块加载时动态注入的服务项集合，配置菜单处使用', '1', '1', 'ROOT', 'ROOT', '0', null, 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-06 13:36:18', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 15:48:24');
INSERT INTO `pd_web_dictionary` VALUES ('31a6c32e67da4513856a0e03cbf7390b', 'route', '$route', '', '', '1', '1', '2801aecbd9aa4ce3b0009499b89d4901', '2801aecbd9aa4ce3b0009499b89d4901', '0', '', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-06 13:41:42', '', '');
INSERT INTO `pd_web_dictionary` VALUES ('587d563db1e54819864d2b8754c071c6', 'routeParams', '$routeParams', '', '', '1', '1', '2801aecbd9aa4ce3b0009499b89d4901', '2801aecbd9aa4ce3b0009499b89d4901', '0', '', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-06 13:41:59', '', '');
INSERT INTO `pd_web_dictionary` VALUES ('66c9df86cbab489187b47611113aadb7', 'compile', '$compile', '', '', '1', '1', '2801aecbd9aa4ce3b0009499b89d4901', '2801aecbd9aa4ce3b0009499b89d4901', '0', '', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-06 13:42:24', '', '');
INSERT INTO `pd_web_dictionary` VALUES ('84fb53bd8f2b4f7bb2eeb8a3bb4d3790', 'scope', '$scope', '', '', '1', '1', '2801aecbd9aa4ce3b0009499b89d4901', '2801aecbd9aa4ce3b0009499b89d4901', '0', '', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-06 13:38:45', '', '');
INSERT INTO `pd_web_dictionary` VALUES ('8700650fd17749fdb6817b11e60ad473', 'http', '$http', '', '', '1', '1', '2801aecbd9aa4ce3b0009499b89d4901', '2801aecbd9aa4ce3b0009499b89d4901', '0', '', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-06 13:37:09', '', '');

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
INSERT INTO `pd_web_login_key` VALUES ('3f22baf29c064287acac128914eddd49', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
INSERT INTO `pd_web_login_key` VALUES ('41d44cfa63414deb804e34a40065416f', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
INSERT INTO `pd_web_login_key` VALUES ('43de12adf0ba4cd3917650f472512e94', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
INSERT INTO `pd_web_login_key` VALUES ('494e483c30874e2aa991e7cd2a88581d', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
INSERT INTO `pd_web_login_key` VALUES ('58d9f3b37f96489ba57f7046a2675e2e', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
INSERT INTO `pd_web_login_key` VALUES ('67edba55ac174fbabaf40ee5d606e743', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
INSERT INTO `pd_web_login_key` VALUES ('7173e83a536a4e3fb5d2fc6782afcbd5', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
INSERT INTO `pd_web_login_key` VALUES ('96b8de38de654d0e85de50385c9b8a34', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
INSERT INTO `pd_web_login_key` VALUES ('9f9bd66a04cf44d38f31323f302b0740', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
INSERT INTO `pd_web_login_key` VALUES ('ab66df90a3374367833ee006340315ca', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
INSERT INTO `pd_web_login_key` VALUES ('de763e59da684770974907ed37ad35b5', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
INSERT INTO `pd_web_login_key` VALUES ('e179c5fd84ad46d487a3add9bb950f68', '4fc960e1479593d8a38c7256801530e75c9876dc08ef0a66a76b3900b1458d80f6f9b5276df1d723068c833a5c14f07847a0f2e89a050255ef0a9b50b2afa13bbd0c1de8deec5b707c3ec8627b432d4d3b8aa5aa64f8f09e5861bdd8e87a5b97b5745afed2f4031d078cb94d25d4b3301c1b7ba1ba5fd1815d8c17ae92f4cce1-0090736b88e1d80a00596d20a4e148b6e2e52574e59ce2dd9b4b0df1224eeceb08fdeec263b925b904675544082b9d813c5164bb05ff1ecd185f72a203d8e141e439cbb504e5200085ae96c87235b5ce16c23711f57f205d4b8a46dfd5c33380973185caea3ab48f35460905bc9727646cc029617da7fe7ab7e2c9fad2af6417d7');
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
INSERT INTO `pd_web_login_success_log` VALUES ('3f22baf29c064287acac128914eddd49', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 16:30:47', '', '127.0.0.1', '127.0.0.1');
INSERT INTO `pd_web_login_success_log` VALUES ('41d44cfa63414deb804e34a40065416f', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 17:15:26', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('43de12adf0ba4cd3917650f472512e94', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 17:13:53', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('494e483c30874e2aa991e7cd2a88581d', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 18:07:48', '', '127.0.0.1', '127.0.0.1');
INSERT INTO `pd_web_login_success_log` VALUES ('58d9f3b37f96489ba57f7046a2675e2e', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 16:09:00', '', '127.0.0.1', '127.0.0.1');
INSERT INTO `pd_web_login_success_log` VALUES ('67edba55ac174fbabaf40ee5d606e743', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 16:25:12', '2015-08-31 16:56:20', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('7173e83a536a4e3fb5d2fc6782afcbd5', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 17:18:35', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('96b8de38de654d0e85de50385c9b8a34', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 17:16:49', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('9f9bd66a04cf44d38f31323f302b0740', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 17:05:34', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('ab66df90a3374367833ee006340315ca', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 16:16:50', '2015-08-31 16:30:01', '127.0.0.1', '127.0.0.1');
INSERT INTO `pd_web_login_success_log` VALUES ('de763e59da684770974907ed37ad35b5', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 17:21:39', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
INSERT INTO `pd_web_login_success_log` VALUES ('e179c5fd84ad46d487a3add9bb950f68', 'c8f1ba6c7cf842409aba43206e9f7442', '2015-08-31 17:25:14', '', '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1');
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
INSERT INTO `pd_web_menu` VALUES ('fd5b4cf46c724b8995c454b3db94ed12', '字典管理', '2', '1599dd58952f4e41a113a570c35a5dc5', '6', null, '用于字典管理', 'static/core/system/dict/views/DictManager.html', '1', 'dict', 'coreDictCtrl', 'static/core/system/dict/dictCtrl', null);
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
-- Table structure for `sword_scheduler_job`
-- ----------------------------
DROP TABLE IF EXISTS `sword_scheduler_job`;
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

-- ----------------------------
-- Records of sword_scheduler_job
-- ----------------------------

-- ----------------------------
-- Table structure for `sword_scheduler_job_log`
-- ----------------------------
DROP TABLE IF EXISTS `sword_scheduler_job_log`;
CREATE TABLE `sword_scheduler_job_log` (
  `uuid` varchar(32) NOT NULL,
  `job_id` varchar(32) NOT NULL COMMENT '任务的标示',
  `job_status` varchar(32) DEFAULT NULL COMMENT '任务的状态',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `message` varchar(500) DEFAULT NULL COMMENT '消息',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sword_scheduler_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for `sword_scheduler_job_status`
-- ----------------------------
DROP TABLE IF EXISTS `sword_scheduler_job_status`;
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

-- ----------------------------
-- Records of sword_scheduler_job_status
-- ----------------------------

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
