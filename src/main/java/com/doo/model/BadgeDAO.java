package com.doo.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import Database.SqlSessionManager;

public class BadgeDAO {

	
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

	SqlSession sqlSession = sqlSessionFactory.openSession(true);
	
    //  뱃지 부여
	public int assignBadge(UserDTO dto) {
		int cnt = 0;
		try {
			cnt = sqlSession.insert("Database.BadgeMapper.assignBadgeNewbie", dto);
		} catch (Exception e) {
			// TODO: handle exception
		}
		finally {
			sqlSession.close();
		}

		return cnt;
	}
	
	
	//  뱃지 부여
	public int assignBadge(BadgeDTO dto) {
		int cnt = 0;
		try {
			cnt = sqlSession.insert("Database.BadgeMapper.assignBadge", dto);
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			sqlSession.close();
		}
		return cnt;
	}

	// 프로필에 뱃지 로딩
	public List<BadgeDTO> loadingBadge(UserDTO vo) {
		
		List<BadgeDTO> loadingBadge = null;
		try {
			loadingBadge = sqlSession.selectList("Database.BadgeMapper.loadingBadge", vo);
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			sqlSession.close();
		}

		return loadingBadge;
	}
	
	// 관리자가 삭제하면서 FK로 묶여있는 Report테이블의 user_id의 데이터 삭제
		public int deleteBadgeTable(UserDTO vo) {
			int result = 0;
			try{
				result = sqlSession.delete("Database.BadgeMapper.deleteBadgeTable", vo);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();			
			}
			return result;
		}


}
