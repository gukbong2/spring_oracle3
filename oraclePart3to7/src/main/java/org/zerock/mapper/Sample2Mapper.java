package org.zerock.mapper;

import org.apache.ibatis.annotations.Insert;

public interface Sample2Mapper {

	
	@Insert("INSERT INTO TBL_SAMPLE2 (COL2) VALUES (#{data})")
	public int insertCol2(String data);
	
	
	
	
	
	
	
}
