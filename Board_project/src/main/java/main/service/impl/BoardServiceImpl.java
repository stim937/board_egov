package main.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import main.service.BoardService;
import main.service.BoardVO;

// 컨트롤러와 연결되는 설정
@Service("boardService")
public class BoardServiceImpl extends EgovAbstractServiceImpl implements BoardService {
	// ibatis 사용  
	//@Resource(name="boardDAO") private BoardDAO boardDAO;
	 	 		
	// mybatis 사용
	@Resource(name = "boardMapper") private BoardMapper boardDAO;
		 
	@Override
	public int insertBoard(BoardVO vo) throws Exception {
		return boardDAO.insertBoard(vo);
	}

	@Override
	public List<?> selectBoardList(BoardVO vo) throws Exception {
		return boardDAO.selectBoardList(vo);
	}

	@Override
	public int selectBoardTotal(BoardVO vo) throws Exception {
		return boardDAO.selectBoardTotal(vo);
	}

	@Override
	public BoardVO selectBoardDetail(int unq) throws Exception {
		return boardDAO.selectBoardDetail(unq);
	}

	@Override
	public int updateBoardHits(int unq) throws Exception {
		return boardDAO.updateBoardHits(unq);
	}

	@Override
	public int updateBoard(BoardVO vo) throws Exception {
		return boardDAO.updateBoard(vo);
	}

	@Override
	public int selectBoardPass(BoardVO vo) throws Exception {
		return boardDAO.selectBoardPass(vo);
	}

	@Override
	public int deleteBoard(BoardVO vo) throws Exception {
		return boardDAO.deleteBoard(vo);
	}

}
