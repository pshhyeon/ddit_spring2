package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.Board;

public interface IBoardMapper {

	public void create(Board board);

	public List<Board> list();

	public Board read(int boardNo);

	public void update(Board board);

	public void delete(int boardNo);

	public List<Board> search(String title);

}
