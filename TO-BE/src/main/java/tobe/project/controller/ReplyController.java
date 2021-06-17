package tobe.project.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import tobe.project.dto.ReplyVO;
import tobe.project.service.ReplyService;

@Controller
@RequestMapping(value="/reply")
public class ReplyController {

	@Inject
	private ReplyService service;
	
	//댓글 작성
	@RequestMapping(value = "/write", produces = "application/json; charset=utf8")
	@ResponseBody
	public List<ReplyVO> write(ReplyVO vo) throws Exception {
		
		service.addReply(vo);
		List<ReplyVO> list = service.listReply(vo.getBidx());
		
		return list;
	}
	
	//댓글 삭제
	@RequestMapping(value = "/delete", produces = "application/json; charset=utf8")
	@ResponseBody
	public List<ReplyVO> delete(@RequestParam Map<String, String> param) throws Exception {

		String ridx = param.get("ridx");
		String bidx = param.get("bidx");

		System.out.println("ridx->" + ridx + " bidx->" + bidx);
		service.removeReply(Integer.parseInt(ridx));
		List<ReplyVO> list = service.listReply(Integer.parseInt(bidx));
		return list;
	}
	
	//댓글 수정
	@RequestMapping(value = "/modify", produces = "application/json; charset=utf8")
	@ResponseBody
	public List<ReplyVO> modify(ReplyVO vo) throws Exception {

		System.out.println(vo.getRidx());
		System.out.println(vo.getR_content());
		System.out.println(vo.getBidx());
		
		service.modifyReply(vo);
		List<ReplyVO> list = service.listReply(vo.getBidx());
		return list;
	}
}
