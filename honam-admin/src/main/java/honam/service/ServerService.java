package honam.service;

import java.util.List;

import honam.domain.Server;

public interface ServerService {
	
	/**
	 * 서버 정보 총 건수
	 * @param server
	 * @return
	 */
	Integer getServerTotalCount(Server server);
	
	/**
	 * 서버 관리 목록 조회
	 * @param server
	 * @return
	 */
	List<Server> getListServer(Server server);
	
	/**
	 * 서버 정보 취득
	 * @param serverId
	 * @return
	 */
	Server getServer(Integer serverId); 
	
	/**
	 * 서버 정보 등록
	 * @param server
	 * @return
	 */
	int insertServer(Server server);
	
	/**
	 * 서버 정보 수정
	 * @param server
	 * @return
	 */
	int updateServer(Server server);
	
	/**
	 * 서버 정보 삭제
	 * @param serverId
	 * @return
	 */
	int deleteServer(Integer serverId);
}
