package _00_Misc.model;

import java.util.ArrayList;
import java.util.List;

import _00_Misc.model.dao.CodeDAOHibernate;

public class CodeService {

	private CodeDAOHibernate dao = new CodeDAOHibernate();

//	參數可選擇county、forum_type、label process_status、region、report_type、sight_time、trans_form 、type_id
	public List<CodeVO> select(String codeName) {
		List<CodeVO> result = new ArrayList<CodeVO>();
		List<CodeVO> temp= dao.select();
		for(CodeVO vo:temp) {
			String codeId=vo.getCodeId();
			if(codeId.startsWith(codeName)){
				result.add(vo);
			}
		}		
		return result;
	}	
}
