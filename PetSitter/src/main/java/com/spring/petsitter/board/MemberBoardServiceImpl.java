// 만드는중

package com.spring.petsitter.board;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.mapper.MemberBoardMapper;

@Service("MemberBoardService")
public class MemberBoardServiceImpl implements MemberBoardService {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int getListCount() {
		MemberBoardMapper memberboardMapper = sqlSession.getMapper(MemberBoardMapper.class);
		int res = memberboardMapper.getListCount();
		return res;
	}
	
	@Override
	public List<MemberBoardVO> getBoardList(HashMap<String, Integer> hashmap) {
		MemberBoardMapper memberboardMapper = sqlSession.getMapper(MemberBoardMapper.class);
		
		List<MemberBoardVO> memberboardlist = memberboardMapper.getBoardList(hashmap);
		return memberboardlist;
	}

	@Override
	public MemberBoardVO getDetail(int num) {
		MemberBoardMapper memberboardMapper = sqlSession.getMapper(MemberBoardMapper.class);
		memberboardMapper.setReadCountUpdate(num);
		MemberBoardVO memberboard = memberboardMapper.getDetail(num);
		return memberboard;
	}

	@Override
	public int boardInsert(MemberBoardVO board) {
		MemberBoardMapper memberboardMapper = sqlSession.getMapper(MemberBoardMapper.class);
		int res = memberboardMapper.boardInsert(board);
		
		return res;
	}
	
	@Override
	public MemberBoardVO boardModifyForm(int num) {
		MemberBoardMapper memberboardMapper = sqlSession.getMapper(MemberBoardMapper.class);
		MemberBoardVO memberboard = memberboardMapper.getDetail(num);
		return memberboard;
	}	

	@Override
	public int boardModify(MemberBoardVO modifyboard) {
		MemberBoardMapper memberboardMapper = sqlSession.getMapper(MemberBoardMapper.class);
		int res = memberboardMapper.boardModify(modifyboard);		
		
		return res;
	}

	@Override
	public int boardDelete(HashMap<String, String> hashmap) {
		MemberBoardMapper memberboardMapper = sqlSession.getMapper(MemberBoardMapper.class);
		int res = memberboardMapper.isBoardWriter(hashmap);
		int num = Integer.parseInt(hashmap.get("num"));
		if (res == 1) {
			res = memberboardMapper.boardDelete(num);
		}
		return res;
	}




}
