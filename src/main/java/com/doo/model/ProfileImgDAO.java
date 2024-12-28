package com.doo.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import Database.SqlSessionManager;

public class ProfileImgDAO {

	// 세션을 생성해 줄 수 있는 Factory 생성
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

	// connection, close, sql문 실행...
	SqlSession sqlSession = sqlSessionFactory.openSession(true);
	// 프로필 사진 바꾸기

	public int insertProfileImg(ProfileImgDTO dto) {
		
		int cnt = 0;
		try {
			cnt = sqlSession.insert("Database.ProfileImgMapper.insertProfileImg", dto);
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			sqlSession.close();
		}

		return cnt;
	}

	// 프로필 사진 로딩
	public ProfileImgDTO loadingImg(UserDTO vo) {
		
		ProfileImgDTO loadingImg = null;
		try {
			loadingImg = sqlSession.selectOne("Database.ProfileImgMapper.laodingImg", vo);
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			sqlSession.close();
		}

		return loadingImg;
	}

	// 프로필 사진
	public int updateProfileImg(ProfileImgDTO vo) {
		int result = 0;
		try {
			result = sqlSession.update("Database.ProfileImgMapper.updateProfileImg", vo);
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			sqlSession.close();
		}

		return result;
	}
	// 관리자가 삭제하면서 FK로 묶여있는 deleteUserFromProfileImg테이블의 user_id의 데이터 삭제
	public int deleteUserFromProfileImgTable(UserDTO vo) {

		int result = 0;

		// 자동으로 세션을 닫아줌
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true)) {

			// 쿼리 실행 후 삭제된 행 수를 result에 저장
			result = sqlSession.delete("Database.ProfileImgMapper.deleteUserFromProfileImgTable", vo);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
