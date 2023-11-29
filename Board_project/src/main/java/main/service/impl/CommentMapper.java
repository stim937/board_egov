package main.service.impl;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import main.service.CommentVO;

@Mapper("commentMapper")
public interface CommentMapper {

	public int insertComment(CommentVO vo);
	
	public List<?> selectComment(int boardUnq);
	
	public int updateComment(CommentVO vo);
	
	public int selectCommentPass(CommentVO vo);
	
	public int deleteComment(CommentVO vo);
}
