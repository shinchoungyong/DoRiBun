package com.doo.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import Database.SqlSessionManager;


public class UserDAO {

	// 세션을 생성해 줄 수 있는 Factory 생성
		SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
		
		// connection, close, sql문 실행...
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		
		// 회원가입
		public int joinMember(UserDTO dto) {
			
			int cnt = 0;
			try {
				 cnt = sqlSession.insert("Database.UserMapper.join", dto);
			} catch (Exception e) {
				// TODO: handle exception
			} finally {
				sqlSession.close();
			}

			return cnt;
		}

		// 로그인
		public UserDTO loginMember(UserDTO dto) {
			
			UserDTO loginMember = null;
			try {
				loginMember = sqlSession.selectOne("Database.UserMapper.login", dto);
			} catch (Exception e) {
				// TODO: handle exception
			} finally {
				sqlSession.close();
			}

			return loginMember;
		}
		
		// 비밀번호 변경
		public int PwUpdateMember(UserDTO dto) {
			
			int cnt = 0;
			try {
				cnt = sqlSession.update("Database.UserMapper.pwupdate", dto);
			} catch (Exception e) {
				// TODO: handle exception
			} finally {
				sqlSession.close();
			}

			return cnt;
		}
		
		// 정보 수정
		public int updateMember(UserDTO dto) {
			
			int result = 0;
			try {
				result = sqlSession.update("Database.UserMapper.updateInfo", dto);
			} catch (Exception e) {
				// TODO: handle exception
			} finally {
				sqlSession.close();
			}

			return result;
		}
		
		// 프로필 로딩(유저, 상대방 것 구현 X)
		public UserDTO profileLoading(UserDTO dto) {
			
			UserDTO profile = null;
			try {
				profile = sqlSession.selectOne("Database.UserMapper.profileLoading", dto);
			} catch (Exception e) {
				// TODO: handle exception
			} finally {
				sqlSession.close();
			}
			
			return profile;
		}
		
		// 회원 삭제 (직접가능 관리자 가능)
		public int deleteMember(UserDTO dto){
			
			int row = 0;
			try {
				row = sqlSession.delete("Database.UserMapper.deleteId",dto);
			} catch (Exception e) {
				// TODO: handle exception
			} finally {
				sqlSession.close();
			}

			return row;
		}
		
		// admin삭제로 전체회원조회하기(리스트에 담아서,관리자제외 유저 정보만 들어옴)
		public List<UserDTO> allusers() {
			List<UserDTO> users = null;
		    try {users = sqlSession.selectList("Database.UserMapper.allusers");
		    } catch (Exception e) {
				// TODO: handle exception
			}finally {
				sqlSession.close();
			}
			return users;
		}

		// admin삭제로 인한 생성
		public int AdminDeleteId(UserDTO dto) {
		    int row = 0;

		    try { 
		        row = sqlSession.delete("Database.UserMapper.AdminDeleteId", dto);
		        
		    } catch (Exception e) {
		        e.printStackTrace();  
		    }finally {
				sqlSession.close();			
			} 

		    return row; 
		}
		
		 // 아이디 중복 확인 메소드 추가
	    // 9-24 12:39
	    public boolean isIdDuplicate(UserDTO vo) {
	        boolean isDuplicate = false;
	        try {
	            int count = sqlSession.selectOne("Database.UserMapper.checkIdDuplicate", vo);
	            isDuplicate = (count > 0); // 중복되면 true, 아니면 false
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            sqlSession.close();
	        }
	        return isDuplicate;
	    }
}
