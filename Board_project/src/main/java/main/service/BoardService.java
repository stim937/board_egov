package main.service;

import java.util.List;

public interface BoardService {
	/**
	 * 글을 등록한다
	 * @param vo - 등록할 정보가 담긴 BoardVO
	 * @return 등록결과
	 * @throws Exception
	 */
	public int insertBoard(BoardVO vo) throws Exception;

	/**
	 * 게시판 전체조회목록
	 * @param vo
	 * @return 조회결과
	 * @throws Exception
	 */
	public List<?> selectBoardList(BoardVO vo) throws Exception;
	
	/**
	 * 게시판 전체 글 갯수
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public int selectBoardTotal(BoardVO vo) throws Exception;
	
	/**
	 * 게시글 상세보기
	 * @param unq
	 * @return
	 * @throws Exception
	 */
	public BoardVO selectBoardDetail(int unq) throws Exception;
	
	/**
	 * 게시글 조회수 증가
	 * @param unq
	 * @return
	 * @throws Exception
	 */
	public int updateBoardHits(int unq) throws Exception;
	
	/**
	 * 게시글 수정
	 * @param unq
	 * @return
	 * @throws Exception
	 */
	public int updateBoard(BoardVO vo) throws Exception;
	
	/**
	 * 암호 확인
	 * @param vo
	 * @return
	 * @throws Exception
	 */	
	public int selectBoardPass(BoardVO vo) throws Exception;
	
	/**
	 * 게시글 삭제
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public int deleteBoard(BoardVO vo) throws Exception;
}
