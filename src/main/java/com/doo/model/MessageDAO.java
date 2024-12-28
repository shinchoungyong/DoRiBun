package com.doo.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import Database.SqlSessionManager;

public class MessageDAO {

	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	SqlSession sqlSession = sqlSessionFactory.openSession(true);
    
		//메세지 전송 기능.
		public int insertMessage(MessageDTO Message) {
			
			int row = 0;
			try {
				row = sqlSession.insert("insertMessage",Message);
			} catch (Exception e) {
				// TODO: handle exception
			} finally {
				sqlSession.close();
			}
			return row;
		}
		
		//나에게 온 메세지 조회기능
		public List<MessageDTO> showMessage(UserDTO user){
			List<MessageDTO> m_list = null;
			try {
				System.out.println("메세지 조회 시작");
				m_list = sqlSession.selectList("showMessage",user.getUser_id());
				
			} catch (Exception e) {
				// TODO: handle exception
			} finally {
				sqlSession.close();
			}
			return m_list;
		}
		
		// 메세지 삭제 기능
		public int deleteMessage(int num) {
			
			int cnt = 0;
			try {
				cnt = sqlSession.delete("deleteMessage", num);
			} catch (Exception e) {
				// TODO: handle exception
			} finally {
				sqlSession.close();
			}
			return cnt;
		}
		
		// 관리자가 삭제하면서 FK로 묶여있는 Report테이블의 user_id의 데이터 삭제
		public int deleteMessageTable(UserDTO vo) {
			int result1 = 0;
			int result2 = 0;
			try{
				result1 = sqlSession.delete("Database.MessageMapper.deleteMessageTableReceiver", vo);
				result2 = sqlSession.delete("Database.MessageMapper.deleteMessageTableSender", vo);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();			
			}
			return result1*result2;
		}
}
