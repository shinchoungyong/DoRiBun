package com.doo.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import Database.SqlSessionManager;

public class CommentDAO {
	
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	SqlSession sqlSession = sqlSessionFactory.openSession(true);
	
	public int insertComment(CommentDTO dto) {
		
		int row = 0;
		try {
			row = sqlSession.insert("Database.CommentMapper.insertComment",dto);
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			sqlSession.close();
		}

		return row;
	}
	
	public List<CommentDTO> allComment(Integer b_idx) {
		List<CommentDTO> comments = null;
		try {
			System.out.println("allComment 메서드 안" + b_idx);
			comments = sqlSession.selectList("Database.CommentMapper.allComment",b_idx);
			System.out.println(comments != null);
		} catch (Exception e) {
			// TODO: handle exception
		}
		finally {
			sqlSession.close();			
		}
		return comments;
	}
	
	//관리자가 삭제하면서 FK로 묶여있는 Comment테이블의 user_id의 데이터 삭제
		public int DeleteCommentTable(UserDTO vo) {
			int result = 0;

			// 자동으로 세션을 닫아줌
			try{

				// 쿼리 실행 후 삭제된 행 수를 result에 저장
				result = sqlSession.delete("Database.CommentMapper.DeleteCommentTable", vo);

			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();			
			}
			return result;
		}
		
		public int deleteCommentB_idx(BoardDTO dto) {
			int result = 0;

			// 자동으로 세션을 닫아줌
			try{

				// 쿼리 실행 후 삭제된 행 수를 result에 저장
				result = sqlSession.delete("Database.CommentMapper.deleteCommentB_idx", dto);

			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();			
			}
			return result;
		}
		
		public int deleteComment(CommentDTO vo) {
			int result = 0;

			// 자동으로 세션을 닫아줌
			try{

				// 쿼리 실행 후 삭제된 행 수를 result에 저장
				result = sqlSession.delete("Database.CommentMapper.deleteComment", vo);

			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();			
			}
			return result;
		}
}
