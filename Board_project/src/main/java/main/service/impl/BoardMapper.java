package main.service.impl;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import main.service.BoardVO;

@Mapper("boardMapper")
public interface BoardMapper {

	public int insertBoard(BoardVO vo);

	public List<?> selectBoardList(BoardVO vo);

	public int selectBoardTotal(BoardVO vo);

	public BoardVO selectBoardDetail(int unq);

	public int updateBoardHits(int unq);

	public int updateBoard(BoardVO vo);

	public int selectBoardPass(BoardVO vo);

	public int deleteBoard(BoardVO vo);
}
