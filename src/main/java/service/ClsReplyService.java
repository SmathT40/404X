package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.ClsReplyDto;
import mapper.ClsReplyMapper;

@Service
public class ClsReplyService {

	@Autowired
	private ClsReplyMapper clsReplyMapper;
	
	public int addReply(ClsReplyDto dto) {
		return clsReplyMapper.insertReply(dto);
	}
	
	public List<ClsReplyDto> getReplyList(int class_id,Integer lec_id) {
        // (1) 해당 강의의 원댓글(부모)들만 먼저 최신순으로 가져옵니다.
        List<ClsReplyDto> parentList;
        
        if (lec_id == null || lec_id == 0) {
        	parentList = clsReplyMapper.selectParentReplies(class_id);
        } else {
        	parentList = clsReplyMapper.selectLectureParentReplies(class_id, lec_id);
        }
        // (2) 각 원댓글을 돌면서 그에 달린 대댓글(자식)들을 가져와서 꽂아줍니다.
        for (ClsReplyDto parent : parentList) {
            int parentNo = parent.getCls_reply_no();
            List<ClsReplyDto> childList = clsReplyMapper.selectChildReplies(parentNo);
            
            // DTO에 미리 만들어둔 List<ClsReplyDto> replyList에 세팅
            parent.setReplyList(childList);
        }

        return parentList;
    }

	public boolean deleteComment(int cls_reply_no, String userId, int userRole) {
        int result = clsReplyMapper.delete(cls_reply_no, userId, userRole);
        return result > 0;
    }
  
	//4 27 추가
	public List<ClsReplyDto> getBoardReplyList(int board_no) {
	    List<ClsReplyDto> parentList = clsReplyMapper.selectBoardParentReplies(board_no);
	    for (ClsReplyDto parent : parentList) {
	        int parentNo = parent.getCls_reply_no();
	        List<ClsReplyDto> childList = clsReplyMapper.selectChildReplies(parentNo);
	        parent.setReplyList(childList);
	    }
	    return parentList;
	}
	public List<ClsReplyDto> getMyCommentList(String userId, int pageNum, int limit) {
	    List<ClsReplyDto> list = clsReplyMapper.selectMyCommentList(userId, (pageNum-1)*limit, limit);
	    return list;
	}

	public int getMyCommentTotalPage(String userId, int limit) {
	    int count = clsReplyMapper.countMyComment(userId);
	    return (int) Math.ceil((double) count / limit);
	}
	}