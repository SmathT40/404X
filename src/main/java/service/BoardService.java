package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;
import java.util.UUID;

import dao.BoardDao;
import dto.Board;

@Service
public class BoardService {

    @Autowired
    private BoardDao boardDao;

    private String saveFile(MultipartFile file, String folder, HttpServletRequest request) throws Exception {
        if (file == null || file.isEmpty()) return null;
        String uploadPath = request.getServletContext().getRealPath("/resources/upload/" + folder + "/");
        File dir = new File(uploadPath);
        if (!dir.exists()) dir.mkdirs();
        String ext = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
        String savedName = UUID.randomUUID().toString() + ext;
        file.transferTo(new File(uploadPath + savedName));
        return savedName;
    }

    public void insert(Board board, HttpServletRequest request) throws Exception {
        if (board.getBoard_file_path() != null && !board.getBoard_file_path().isEmpty()) {
            String savedFile = saveFile(board.getBoard_file_path(), "file", request);
            board.setFileurl(savedFile);
        }
        if (board.getUser_id() == null || board.getUser_id().isEmpty()) {
            board.setUser_id("csw");
        }
        boardDao.insert(board);
    }

    public void update(Board board, HttpServletRequest request) throws Exception {
        if (board.getBoard_file_path() != null && !board.getBoard_file_path().isEmpty()) {
            String savedFile = saveFile(board.getBoard_file_path(), "file", request);
            board.setFileurl(savedFile);
        }
        boardDao.update(board);
    }

    public String uploadSummernoteImage(MultipartFile file, HttpServletRequest request) throws Exception {
        String savedName = saveFile(file, "summernote", request);
        return request.getContextPath() + "/resources/upload/summernote/" + savedName;
    }

    public List<Board> getList(int board_type, Integer pageNum, int limit, String searchtype, String searchcontent) {
        return boardDao.list(board_type, pageNum, limit, searchtype, searchcontent);
    }

    public int getCount(int board_type, String searchtype, String searchcontent) {
        return boardDao.count(board_type, searchtype, searchcontent);
    }

    public Board getDetail(int board_no) { return boardDao.selectOne(board_no); }
    public void delete(int board_no) { boardDao.delete(board_no); }
    public Board getPrev(int board_type, int board_no) { return boardDao.prev(board_type, board_no); }
    public Board getNext(int board_type, int board_no) { return boardDao.next(board_type, board_no); }
}