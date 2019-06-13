package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor

public class BoardServiceImpl implements BoardService {
	//spring 4.3 이상에서 자동 처리
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;

	@Override
	public void register(BoardVO board) {
		// TODO Auto-generated method stub
		log.info("register ..." + board);
		mapper.insertSelectKey(board);
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("===GET===" + bno);
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("===MODIFY===" + board);
		return mapper.update(board) == 1;
		//정상적으로 수정과 삭제가 이루어지면 1이라는 값이 반환되기 때문에 ==를 이용해서 true/false 처리한다.
	}

	@Override
	public boolean remove(Long bno) {
		log.info("===REMOVE===" + bno);
		return mapper.delete(bno) == 1;
		//정상적으로 수정과 삭제가 이루어지면 1이라는 값이 반환되기 때문에 ==를 이용해서 true/false 처리한다.
	}

//	@Override
//	public List<BoardVO> getList() {
//		
//		log.info("===getList===");
//		return mapper.getList();
//	}
	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("get List with Criteria : " + cri);
		
		return mapper.getListWithPaging(cri);
	}
	
	
	
	
	
}
