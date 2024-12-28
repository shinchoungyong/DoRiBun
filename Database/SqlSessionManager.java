package Database;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlSessionManager {
	// 데이터베이스와 연결, SQL 실행에 대한 모든것을 가진 중요한 객체
	public static SqlSessionFactory sqlSessionFactory;
	
	static {
		String resource = "Database/Mybatis-config.xml";
			
		
		Reader reader;
		
		try {
			//  파일 읽기
			reader = Resources.getResourceAsReader(resource);
			// DB관련 기능을 가진 SqlSessionFactory만들기
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	//static(초기화 블럭)에서 셍상한 SqlSessionFactory 반환하기
	public static SqlSessionFactory getSqlSession() {
		return sqlSessionFactory;
	}
}
