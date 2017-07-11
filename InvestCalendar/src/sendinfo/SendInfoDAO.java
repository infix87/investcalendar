package sendinfo;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class SendInfoDAO {
	DataSource dataSource;
	
	public SendInfoDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/InvestCalendar");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
}
