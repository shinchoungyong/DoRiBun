package com.doo.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import Database.SqlSessionManager;

public class BoardDAO {

	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	SqlSession sqlSession = sqlSessionFactory.openSession(true);

	// 게시글 작성
	public int uploadBoard(BoardDTO vo) {
		
		int cnt = 0;
				
		try {
			cnt = sqlSession.insert("Database.BoardMapper.uploadBoard", vo);
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			sqlSession.close();
		}

		return cnt;
	}

	// 개시글 조회
	public List<BoardDTO> allBoard() {
		
		List<BoardDTO> boards = null;
		try {
			boards = sqlSession.selectList("Database.BoardMapper.allBoard");
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			sqlSession.close();
		}

		return boards;
	}
	
	// 프로필 화면 들어가면 보드 띄우기
	public List<BoardDTO> userBoard(UserDTO vo) {
		
		List<BoardDTO> boards = null;
		try {
			boards = sqlSession.selectList("Database.BoardMapper.userBoard", vo);
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			sqlSession.close();
		}

		return boards;
	}

	// 관리자가 삭제하면서 FK로 묶여있는 board테이블의 user_id의 데이터 삭제
	public int deleteUserFromBoardTable(UserDTO vo) {

		// 변수 이름을 result로 통일
		int result = 0;

		// 자동으로 세션을 닫아줌
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true)) {

			// 쿼리 실행 후 삭제된 행 수를 result에 저장
			result = sqlSession.delete("Database.BoardMapper.deleteUserFromBoardTable", vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	
	public int updateLikeCntPlus(LikeDTO dto) {
		
		int result = 0;
		try {
			result = sqlSession.update("Database.BoardMapper.updateLikeCntPlus", dto);
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			sqlSession.close();
		}

		return result;
	}
	
	public int updateLikeCntMinus(LikeDTO dto) {
		int result = 0;
		try {
			result = sqlSession.update("Database.BoardMapper.updateLikeCntMinus", dto);
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			sqlSession.close();
		}
		
		
		
		return result;
	}
	
	
	public BoardDTO likedPosts(BoardDTO dto) {
		
		BoardDTO board = null;
		try {
			board = sqlSession.selectOne("Database.BoardMapper.likedPosts",dto);
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			sqlSession.close();
		}
		return board;
	}
	
	// b_idx값으로 게시물 데이터 가져오기 
		public BoardDTO BringIndex(BoardDTO dto) {
			BoardDTO BringIndex = null;
			try {
				BringIndex = sqlSession.selectOne("Database.BoardMapper.BringIndex", dto);
			} catch (Exception e) {
				// TODO: handle exception
			} finally {
				sqlSession.close();
			}

			return BringIndex;
		}
}
