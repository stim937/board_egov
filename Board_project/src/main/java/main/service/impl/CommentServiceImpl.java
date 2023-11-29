package main.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import main.service.CommentService;
import main.service.CommentVO;

@Service("commentService")
public class CommentServiceImpl extends EgovAbstractServiceImpl implements CommentService {

	@Resource(name = "commentMapper")
	private CommentMapper commentDAO;

	@Override
	public int insertComment(CommentVO vo) throws Exception {
		return commentDAO.insertComment(vo);
	}

	@Override
	public List<?> selectComment(int boardUnq) throws Exception {
		return commentDAO.selectComment(boardUnq);
	}

	@Override
	public int updateComment(CommentVO vo) throws Exception {
		return commentDAO.updateComment(vo);
	}

	@Override
	public int selectCommentPass(CommentVO vo) throws Exception {
		return commentDAO.selectCommentPass(vo);
	}

	@Override
	public int deleteComment(CommentVO vo) throws Exception {
		return commentDAO.deleteComment(vo);
	}

}
