package com.doo.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import Database.SqlSessionManager;

public class ReportDAO {

	// 세션을 생성해 줄 수 있는 Factory 생성
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

	// connection, close, sql문 실행...
	SqlSession sqlSession = sqlSessionFactory.openSession(true);

	// 신고하기
	public int reportInsert(ReportDTO dto) {
		int cnt = sqlSession.insert("Database.ReportMapper.insert", dto);

		sqlSession.close();

		return cnt;
	}
	
	// 관리자가 삭제하면서 FK로 묶여있는 Report테이블의 user_id의 데이터 삭제
		public int DeleteReportTable(UserDTO vo) {
			int result = 0;
			try {
				result = sqlSession.delete("Database.ReportMapper.DeleteReportTable", vo);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();			
			}
			return result;
		}
		
		
		public int deleteB_idx(BoardDTO dto) {
			int cnt = 0;
			try {
				cnt = sqlSession.insert("Database.ReportMapper.deleteB_idx", dto);
			} catch (Exception e) {
				// TODO: handle exception
			} finally {
				sqlSession.close();
			}
			return cnt;
		}
		
		public List<ReportDTO> allreports() {
			List<ReportDTO> reports = null;
			// 로그 추가: 조회된 데이터 수 확인
			try {
				reports = sqlSession.selectList("Database.ReportMapper.ShowAllReports");
			} catch (Exception e) {
				// TODO: handle exception
			} finally {
				sqlSession.close();
			}
			return reports;
		}
		
		public int countreport(BoardDTO dto) {
			int cnt = 0;
			try {
				cnt = sqlSession.selectOne("Database.ReportMapper.countReport", dto);
			} catch (Exception e) {
				// TODO: handle exception
			} finally {
				sqlSession.close();
			}
			return cnt;
		}
}
