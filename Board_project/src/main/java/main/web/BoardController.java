package main.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import main.service.BoardService;
import main.service.BoardVO;
import main.service.CommentService;
import main.service.CommentVO;

@Controller
public class BoardController {

	@Resource(name = "boardService")
	private BoardService boardService;

	@Resource(name = "commentService")
	private CommentService commentService;

	@RequestMapping(value = "/boardWrite.do")
	public String boardWrite(BoardVO vo, ModelMap model) {
		model.addAttribute("boardVO", vo);
		return "board/boardWrite";
	}

	@RequestMapping(value = "/boardWriteSave.do")
	@ResponseBody
	public String insertBoard(BoardVO vo) throws Exception {

		int result = boardService.insertBoard(vo);
		String msg = "";

//		ibatis 사용시
//		if (result == 0) {
//			msg = "ok";
//		} else {
//			msg = "fail";
//		}

//		mybatis 사용시
		if (result == 1) {
			msg = "ok";
		} else {
			msg = "fail";
		}
		return msg;
	}

	@RequestMapping(value = "/boardList.do")
	public String selectBoardList(BoardVO vo, ModelMap model) throws Exception {
		// 현재 페이지
		int viewPage = vo.getViewPage();

		// 한 페이지 게시글 개수
		int perPage = vo.getPerPage();

		// 총 게시글 개수
		int total = boardService.selectBoardTotal(vo);

		// 총 페이지 개수
		int totalPage = (int) Math.ceil((double) total / perPage);

		// 정상적이지 않은 페이지값이 넘어올때 처리
		if (viewPage > totalPage || viewPage < 1) {
			viewPage = 1;
		}

		// 시작행, 마지막행 (sql문 완성을 위한 변수)
		int startIndex = (viewPage - 1) * perPage + 1;
		int endIndex = startIndex + (perPage - 1);

		vo.setStartIndex(startIndex);
		vo.setEndIndex(endIndex);

		// 화면 행 시작 번호
		int startRowNo = total - (viewPage - 1) * perPage;

		/**
		 * 페이지 그룹 계산
		 */
		// 한 화면에 보여질 페이지 그룹 갯수
		int perPageGroup = vo.getPerPageGroup();

		// 현재 화면에 보여지는 페이지 그룹
		int crrPageGroup = (int) Math.ceil((double) viewPage / perPageGroup);

		// 현재 화면에 보여지는 첫페이지 번호, 마지막 페이지 번호
		int startPage = ((crrPageGroup - 1) * perPageGroup) + 1;
		int endPage = crrPageGroup * perPageGroup;
		if (endPage > totalPage) {
			endPage = totalPage;
		}

		List<?> list = boardService.selectBoardList(vo);
		System.out.println(viewPage + "페이지목록 : " + list);

		model.addAttribute("total", total);
		model.addAttribute("rowNumber", startRowNo);
		model.addAttribute("resultList", list);

		model.addAttribute("totalPage", totalPage);
		model.addAttribute("crrPage", viewPage);
		model.addAttribute("perPageGroup", perPageGroup);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);

		return "board/boardList";
	}

	@RequestMapping(value = "/boardDetail.do")
	public String selectBoardDetail(BoardVO vo, ModelMap model) throws Exception {
		// 조회수 증가
		boardService.updateBoardHits(vo.getUnq());

		BoardVO boardVO = boardService.selectBoardDetail(vo.getUnq());
		boardVO.setSearchGubun(vo.getSearchGubun());
		boardVO.setSearchText(vo.getSearchText());
		boardVO.setViewPage(vo.getViewPage());

		System.out.println("글번호 : " + boardVO.getUnq());
		System.out.println("제목: " + boardVO.getTitle());
		System.out.println("작성자: " + boardVO.getName());
		
		List<?> CommentList = commentService.selectComment(vo.getUnq());
		System.out.println("댓글내역 : " + CommentList);

		// 개행문자,띄어쓰기 html 형식에 맞춰 변형
		String content = boardVO.getContent();
		boardVO.setContent(content.replaceAll(" ", "&nbsp;").replaceAll("\n", "<br>"));

		model.addAttribute("boardVO", boardVO);
		model.addAttribute("CommentList", CommentList);
		return "board/boardDetail";
	}

	@RequestMapping(value = "/boardModifyWrite.do")
	public String selectBoardModifyWrite(BoardVO vo, ModelMap model) throws Exception {

		BoardVO boardVO = boardService.selectBoardDetail(vo.getUnq());
		boardVO.setSearchGubun(vo.getSearchGubun());
		boardVO.setSearchText(vo.getSearchText());
		boardVO.setViewPage(vo.getViewPage());
		
		model.addAttribute("boardVO", boardVO);

		return "board/boardModify";
	}

	@RequestMapping(value = "/boardModifySave.do")
	@ResponseBody
	public String updateBoard(BoardVO vo) throws Exception {

		int result = 0;

		int count = boardService.selectBoardPass(vo);
		if (count == 1) { // 암호확인
			result = boardService.updateBoard(vo);
		} else {
			result = -1;
		}
		return result + "";
	}

	@RequestMapping(value = "/passWrite.do")
	public String passWrite(int unq, ModelMap model) {

		model.addAttribute("unq", unq);
		return "board/passWrite";
	}

	@RequestMapping(value = "/boardDelete.do")
	@ResponseBody
	public String deleteBoard(BoardVO vo) throws Exception {

		int result = 0;

		int count = boardService.selectBoardPass(vo);
		if (count == 1) { // 암호확인
			result = boardService.deleteBoard(vo);
		} else {
			result = -1;
		}
		return result + "";
	}

	@RequestMapping(value = "/commentSave.do")
	@ResponseBody
	public String insertComment(CommentVO vo) throws Exception {
		int result = commentService.insertComment(vo);

		String msg = "";
		if (result == 1) {
			msg = "ok";
		} else {
			msg = "fail";
		}

		System.out.println("메세지 : " + msg);
		return msg;
	}

	@RequestMapping(value = "/commentDelete.do")
	@ResponseBody
	public String deleteComment(CommentVO vo) throws Exception {

		int result = 0;

		int count = commentService.selectCommentPass(vo);
		if (count == 1) { // 암호확인
			result = commentService.deleteComment(vo);
		} else {
			result = -1;
		}
		return result + "";
	}

	@RequestMapping(value = "/commentModifySave.do")

	@ResponseBody
	public String updateComment(CommentVO vo) throws Exception {

		int result = 0;

		int count = commentService.selectCommentPass(vo);
		if (count == 1) { // 암호확인
			result = commentService.updateComment(vo);
		} else {
			result = -1;
		}
		return result + "";
	}

}
