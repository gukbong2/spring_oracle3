package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardAttachMapper;
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

	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;
	
	@Override
	public void register(BoardVO board) {
		// TODO Auto-generated method stub
		log.info("=================register ..." + board);
		mapper.insertSelectKey(board);
		
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}
		
		board.getAttachList().forEach(attach -> {
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("===GET===" + bno);
		return mapper.read(bno);
	}
	
	
	@Transactional
	@Override
	public boolean modify(BoardVO board) {

		log.info("modify......" + board);

		attachMapper.deleteAll(board.getBno());

		boolean modifyResult = mapper.update(board) == 1;
		
		if (modifyResult && board.getAttachList().size() > 0) {

			board.getAttachList().forEach(attach -> {

				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		//return mapper.update(board) == 1;
		//정상적으로 수정과 삭제가 이루어지면 1이라는 값이 반환되기 때문에 ==를 이용해서 true/false 처리한다.
		return modifyResult;
	}
	
	@Transactional
	@Override
	public boolean remove(Long bno) {
		log.info("===REMOVE===" + bno);
		attachMapper.deleteAll(bno);
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

	@Override
	public int getTotal(Criteria cri) {
		log.info("get totalcount");
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		
		log.info("=====================GET ATTACH LIST BY BNO : " + bno);
		
		return attachMapper.findByBno(bno);
	}
	
	
	
	
	
}
