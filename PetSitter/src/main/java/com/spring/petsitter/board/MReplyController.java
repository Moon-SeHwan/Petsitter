package com.spring.petsitter.board;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MReplyController {

	@Autowired
	MReplyService mReplyService;
	
	/* ��� ��� ��Ʈ�ѷ� */
	
	@RequestMapping(value="/read_Reply.bo", produces="application/json; charset=UTF-8")  //��� ����Ʈ
	private List<MReplyVO> mCommentServiceList(@RequestParam int bno) throws Exception{
  	List<MReplyVO> mReplyList = mReplyService.readReply(bno);  
    return mReplyList;
  }
	
	@RequestMapping(value="/write_Reply.bo", produces="application/json; charset=UTF-8") //��� �ۼ� 
  private int writeReply(MReplyVO comment, HttpSession session) throws Exception{
      comment.setWriter_name((String)session.getAttribute("name"));
      comment.setWriter_id((String)session.getAttribute("id"));
      
      return mReplyService.writeReply(comment);
  }
  
  @RequestMapping(value="/update_Reply.bo", produces="application/json; charset=UTF-8") //��� ����)
   private int updateReply(@RequestParam int rno,  @RequestParam String content) throws Exception{
  	MReplyVO comment = new MReplyVO();
  	comment.setRno(rno);
  	comment.setContent(content);
  	
  	return mReplyService.updateReply(comment);
  }
  
  @RequestMapping(value="/delete_Reply.bo",  produces="application/json; charset=UTF-8") //��� ����
  private int deleteReply(@RequestParam(value="rno") int rno) throws Exception {
  	return mReplyService.deleteReply(rno);
  }
	
	/* ������� */
}
