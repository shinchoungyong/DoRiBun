package com.doo.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import Database.SqlSessionManager;

public class LikeDAO {
	
	
	// 세션을 생성해 줄 수 있는 Factory 생성
			SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
			
			// connection, close, sql문 실행...
			SqlSession sqlSession = sqlSessionFactory.openSession(true);
			
	public boolean checkIfUserLiked(LikeDTO dto)
	{
		boolean check = false;
		
		try {
			LikeDTO checking = sqlSession.selectOne("Database.LikeMapper.check", dto);
			
			if(checking == null)
			{
				check = false;
			}
			else
			{
				check = true;
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			sqlSession.close();
		}
	
		return check;
	}
	
	public int deleteLike(LikeDTO dto){
		
		int row = 0;
		try {
			row = sqlSession.delete("Database.LikeMapper.delete",dto);
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			sqlSession.close();
		}
		
		return row;
	}
	
	public int insertLike(LikeDTO dto) {
		int cnt = 0;
		try {
			cnt = sqlSession.insert("Database.LikeMapper.insert", dto);
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			sqlSession.close();
		}

		return cnt;
	}
	
	// 관리자가 삭제하면서 FK로 묶여있는 Like테이블의 user_id의 데이터 삭제
		public int DeleteLikeTable(UserDTO vo) {
			int result = 0;
			try{
				result = sqlSession.delete("Database.LikeMapper.DeleteLikeTable", vo);
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();			
			}
			return result;
		}
		
		public int deleteLikeB_idx(BoardDTO dto) {
			int result = 0;
			try{
				result = sqlSession.delete("Database.LikeMapper.deleteLikeB_idx", dto);
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();			
			}
			return result;
		}
		
		public List<LikeDTO> selectLikeBoard(UserDTO vo)
		{
			List<LikeDTO> likes = null;
			try{
				likes = sqlSession.selectList("Database.LikeMapper.selectLikeBoard", vo);
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();			
			}
			return likes;
		}

}
