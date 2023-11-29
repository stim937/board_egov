package main.service;

public class CommentVO {

    private int commentUnq;
    private int boardUnq;
    private String name;
    private String pass;
    private String content;
    private String rdate;
	
    public int getCommentUnq() {
		return commentUnq;
	}
	public void setCommentUnq(int commentUnq) {
		this.commentUnq = commentUnq;
	}
	public int getBoardUnq() {
		return boardUnq;
	}
	public void setBoardUnq(int boardUnq) {
		this.boardUnq = boardUnq;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRdate() {
		return rdate;
	}
	public void setRdate(String rdate) {
		this.rdate = rdate;
	}


}

