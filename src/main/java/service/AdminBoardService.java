package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.AdminBoardDao;
import dto.Board;

@Service
public class AdminBoardService {

    @Autowired
    private AdminBoardDao adminBoardDao;

    public List<Board> getAdminPostList(int pageNum, int limit, String keyword) {
        return adminBoardDao.adminPostList(pageNum, limit, keyword);
    }

    public int getAdminPostTotalPage(int limit, String keyword) {
        int count = adminBoardDao.adminPostCount(keyword);
        return (int) Math.ceil((double) count / limit);
    }

    public void updateStatus(int board_no, int status) {
        adminBoardDao.updateStatus(board_no, status);
    }
}