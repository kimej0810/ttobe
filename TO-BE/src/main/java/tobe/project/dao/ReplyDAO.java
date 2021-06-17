package tobe.project.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import tobe.project.dto.ReplyVO;

@Repository
public interface ReplyDAO {
	public List<ReplyVO> list(int bidx) throws Exception;
	public void create(ReplyVO vo) throws Exception;
	public void update(ReplyVO vo) throws Exception;
	public void delete(int ridx) throws Exception;
}
