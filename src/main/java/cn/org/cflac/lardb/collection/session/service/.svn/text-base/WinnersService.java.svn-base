/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.collection.session.service<br/>  
 * <b>文件名：</b>WinnersService.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月28日 下午4:33:03<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.collection.session.service;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.common.util.StringHelper;

import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;

import cn.org.cflac.lardb.collection.session.entity.TWinnersOpusRelEntity;
import cn.org.cflac.lardb.collection.session.entity.TWinnersOrgRelEntity;
import cn.org.cflac.lardb.collection.session.entity.TWinnersStaffRelEntity;
import cn.org.cflac.lardb.collection.session.entity.TYearThWinnersEntity;
import cn.org.cflac.lardb.collection.session.entity.TYearThWinnersGroupingEntity;
import cn.org.cflac.lardb.common.UUIDUtil;

/**
 * @description TODO
 * @createTime 2015年10月28日 下午4:33:03
 * @modifyTime 
 * @author huqs@css.com.cn
 * @version 1.0
 */
public class WinnersService {

	public void save(List<TYearThWinnersGroupingEntity> winnerGroups , String sessionId) throws SwordBaseCheckedException{
		
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		
		//查询已有的获奖名单分组信息
		String winnersGroupIds = "";
		String sql = "select * from t_year_th_winners_grouping t where t.year_th_id=? and t.invalid='N'";
		List<String> param = new ArrayList<String>();
		param.add(sessionId);
		List<TYearThWinnersGroupingEntity> winnerGroupList = dao.findAllBySql(TYearThWinnersGroupingEntity.class, sql, param);
		
		//保存获奖名单分组信息
		for(TYearThWinnersGroupingEntity groupEntity : winnerGroups){
			groupEntity.setYearThId(sessionId);
			if(StringHelper.isEmpty(groupEntity.getWinnersGroupingId())){
				groupEntity.setWinnersGroupingId(UUIDUtil.generateUUID());
			}else{
				winnersGroupIds += (groupEntity.getWinnersGroupingId() + " ");
			}
			dao.saveOrUpdate(groupEntity);
			String winnerGroupId = groupEntity.getWinnersGroupingId();
			
			//查询已存在的组内获奖名单信息
			String winnersIds = "";
			String sql1 = "select * from t_year_th_winners t where t.winners_grouping_id=? and t.invalid='N'";
			List<String> param1 = new ArrayList<String>();
			param1.add(winnerGroupId);
			List<TYearThWinnersEntity> winnerList = dao.findAllBySql(TYearThWinnersEntity.class, sql1, param1);
			
			//保存组内获奖名单信息
			List<TYearThWinnersEntity> winners = groupEntity.getWinners();
			for(TYearThWinnersEntity winner : winners){
				winner.setWinnersGroupingId(winnerGroupId);
				if(StringHelper.isEmpty(winner.getWinnersId())){
					winner.setWinnersId(UUIDUtil.generateUUID());
				}else{
					winnersIds += (winner.getWinnersId() + " ");
				}
				dao.saveOrUpdate(winner);
				String winnerId = winner.getWinnersId();
				
				//查询已存在的与该获奖名单信息关联的人员、作品及团体
				String winnerStaffIds = "";
				String winnerOpusIds = "";
				String winnerOrgIds = "";
				String sql2 ="select * from t_winners_staff_rel t where t.winners_id=?";
				String sql3 = "select * from t_winners_opus_rel t where t.winners_id=?";
				String sql4 = "select * from t_winners_org_rel t where t.winners_id=?";
				List<String> param2 = new ArrayList<String>();
				param2.add(winnerId);
				List<String> param3 = new ArrayList<String>();
				param3.add(winnerId);
				List<String> param4 = new ArrayList<String>();
				param4.add(winnerId);
				List<TWinnersStaffRelEntity> staffList = dao.findAllBySql(TWinnersStaffRelEntity.class, sql2, param2);
				List<TWinnersOpusRelEntity> opusList = dao.findAllBySql(TWinnersOpusRelEntity.class, sql3, param3);
				List<TWinnersOrgRelEntity> orgList = dao.findAllBySql(TWinnersOrgRelEntity.class, sql4, param4);
				
				//保存获奖名单相关联的人员、作品及团体
				List<TWinnersStaffRelEntity> staffRels = winner.getStaff();
				List<TWinnersOpusRelEntity> opusRels = winner.getOpus();
				List<TWinnersOrgRelEntity> orgRels = winner.getOrgs();
				for(TWinnersStaffRelEntity staff : staffRels){
					staff.setWinnersId(winnerId);
					if(StringHelper.isEmpty(staff.getWinnersStaffId())){
						staff.setWinnersStaffId(UUIDUtil.generateUUID());
					}else{
						winnerStaffIds += (staff.getWinnersStaffId() + " ");
					}
					dao.saveOrUpdate(staff);
				}
				for(TWinnersOpusRelEntity opus : opusRels){
					opus.setWinnersId(winnerId);
					if(StringHelper.isEmpty(opus.getWinnersOpusId())){
						opus.setWinnersOpusId(UUIDUtil.generateUUID());
					}else{
						winnerOpusIds += (opus.getWinnersOpusId() + " ");
					}
					dao.saveOrUpdate(opus);
				}
				for(TWinnersOrgRelEntity org : orgRels){
					org.setWinnersId(winnerId);
					if(StringHelper.isEmpty(org.getWinnersOrgId())){
						org.setWinnersOrgId(UUIDUtil.generateUUID());
					}else{
						winnerOrgIds += (org.getWinnersOrgId() + " ");
					}
					dao.saveOrUpdate(org);
				}
				//删除关联人员、作品及团体
				for(TWinnersStaffRelEntity delStaff : staffList){
					if(winnerStaffIds.indexOf(delStaff.getWinnersStaffId()) < 0){
						dao.delete(delStaff);
					}
				}
				for(TWinnersOpusRelEntity delOpus : opusList){
					if(winnerOpusIds.indexOf(delOpus.getWinnersOpusId()) < 0){
						dao.delete(delOpus);
					}
				}
				for(TWinnersOrgRelEntity delOrg : orgList){
					if(winnerOrgIds.indexOf(delOrg.getWinnersOrgId()) < 0){
						dao.delete(delOrg);
					}
				}
			}
			//删除获奖名单，及其关联人员、作品、团体
			for(TYearThWinnersEntity delWinner : winnerList){
				if(winnersIds.indexOf(delWinner.getWinnersId()) < 0){
					String sql5 ="select * from t_winners_staff_rel t where t.winners_id=?";
					String sql6 = "select * from t_winners_opus_rel t where t.winners_id=?";
					String sql7 = "select * from t_winners_org_rel t where t.winners_id=?";
					List<String> param5 = new ArrayList<String>();
					param5.add(delWinner.getWinnersId());
					List<String> param6 = new ArrayList<String>();
					param6.add(delWinner.getWinnersId());
					List<String> param7 = new ArrayList<String>();
					param7.add(delWinner.getWinnersId());
					List<TWinnersStaffRelEntity> delStaffList = dao.findAllBySql(TWinnersStaffRelEntity.class, sql5, param5);
					List<TWinnersOpusRelEntity> delOpusList = dao.findAllBySql(TWinnersOpusRelEntity.class, sql6, param6);
					List<TWinnersOrgRelEntity> delOrgList = dao.findAllBySql(TWinnersOrgRelEntity.class, sql7, param7);
					dao.delete(delWinner);
					dao.deleteBatch(delStaffList);
					dao.deleteBatch(delOpusList);
					dao.deleteBatch(delOrgList);
				}
			}
		}
		
		//删除获奖分组，及分组内的获奖名单、关联人员作品团体
		for(TYearThWinnersGroupingEntity delGroupEntity : winnerGroupList){
			if(winnersGroupIds.indexOf(delGroupEntity.getWinnersGroupingId()) < 0){
				String sql1 = "select * from t_year_th_winners t where t.winners_grouping_id=? and t.invalid='N'";
				List<String> param1 = new ArrayList<String>();
				param1.add(delGroupEntity.getWinnersGroupingId());
				List<TYearThWinnersEntity> delWinnerList = dao.findAllBySql(TYearThWinnersEntity.class, sql1, param1);
				List<TWinnersStaffRelEntity> delWinnersStaffList = new ArrayList<TWinnersStaffRelEntity>();
				List<TWinnersOpusRelEntity> delWinnersOpusList = new ArrayList<TWinnersOpusRelEntity>();
				List<TWinnersOrgRelEntity> delWinnersOrgList = new ArrayList<TWinnersOrgRelEntity>();
				for(TYearThWinnersEntity delWinnerEntity : delWinnerList){
					String id = delWinnerEntity.getWinnersId();
					String sql2 ="select * from t_winners_staff_rel t where t.winners_id=?";
					String sql3 = "select * from t_winners_opus_rel t where t.winners_id=?";
					String sql4 = "select * from t_winners_org_rel t where t.winners_id=?";
					List<String> param2 = new ArrayList<String>();
					param2.add(id);
					List<String> param3 = new ArrayList<String>();
					param3.add(id);
					List<String> param4 = new ArrayList<String>();
					param4.add(id);
					List<TWinnersStaffRelEntity> delStaffList = dao.findAllBySql(TWinnersStaffRelEntity.class, sql2, param2);
					List<TWinnersOpusRelEntity> delOpusList = dao.findAllBySql(TWinnersOpusRelEntity.class, sql3, param3);
					List<TWinnersOrgRelEntity> delOrgList = dao.findAllBySql(TWinnersOrgRelEntity.class, sql4, param4);
					delWinnersStaffList.addAll(delStaffList);
					delWinnersOpusList.addAll(delOpusList);
					delWinnersOrgList.addAll(delOrgList);
				}
				dao.deleteBatch(delWinnersStaffList);
				dao.deleteBatch(delWinnersOpusList);
				dao.deleteBatch(delWinnersOrgList);
				dao.deleteBatch(delWinnerList);
				dao.delete(delGroupEntity);
			}
		}
	}
	
	public List<TYearThWinnersGroupingEntity> query(String yearThId){
		IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
		String sql = "select * from t_year_th_winners_grouping t where t.year_th_id=? and t.invalid='N'";
		List<String> param = new ArrayList<String>();
		param.add(yearThId);
		List<TYearThWinnersGroupingEntity> winnerGroups = dao.findAllBySql(TYearThWinnersGroupingEntity.class, sql, param);
		
		for(TYearThWinnersGroupingEntity winnerGroup : winnerGroups){
			String groupId = winnerGroup.getWinnersGroupingId();
			String sql1 = "select * from t_year_th_winners t where t.winners_grouping_id=? and t.invalid='N'";
			List<String> param1 = new ArrayList<String>();
			param1.add(groupId);
			List<TYearThWinnersEntity> winners = dao.findAllBySql(TYearThWinnersEntity.class, sql1, param1);
			
			for(int i=0;i<winners.size();i++){
				TYearThWinnersEntity winner = winners.get(i);
				String winnerId = winner.getWinnersId();
				String sql2 = "select * from t_winners_staff_rel t where t.winners_id=?";
				String sql3 = "select * from t_winners_opus_rel t where t.winners_id=?";
				String sql4 = "select * from t_winners_org_rel t where t.winners_id=?";
				List<String> param2 = new ArrayList<String>();
				param2.add(winnerId);
				List<String> param3 = new ArrayList<String>();
				param3.add(winnerId);
				List<String> param4 = new ArrayList<String>();
				param4.add(winnerId);
				List<TWinnersStaffRelEntity> staffList = dao.findAllBySql(TWinnersStaffRelEntity.class, sql2, param2);
				List<TWinnersOpusRelEntity> opusList = dao.findAllBySql(TWinnersOpusRelEntity.class, sql3, param3);
				List<TWinnersOrgRelEntity> orgList = dao.findAllBySql(TWinnersOrgRelEntity.class, sql4, param4);
				winner.setStaff(staffList);
				winner.setOpus(opusList);
				winner.setOrgs(orgList);
			}
			
			winnerGroup.setWinners(winners);
		}
		
		return winnerGroups;
	}
	
}
