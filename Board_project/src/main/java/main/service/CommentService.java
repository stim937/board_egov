package main.service;

import java.util.List;

public interface CommentService {

	public int insertComment(CommentVO vo) throws Exception;
	
	public List<?> selectComment(int boardUnq) throws Exception;
	
	public int updateComment(CommentVO vo) throws Exception;
	
	public int selectCommentPass(CommentVO vo) throws Exception;
	
	public int deleteComment(CommentVO vo) throws Exception;
}
