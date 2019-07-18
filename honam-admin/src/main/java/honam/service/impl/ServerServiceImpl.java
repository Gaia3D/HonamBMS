package honam.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import honam.domain.Server;
import honam.persistence.postgresql.ServerMapper;
import honam.service.ServerService;

@Service
public class ServerServiceImpl implements ServerService {

	@Autowired
	private ServerMapper serverMapper;

	@Transactional(readOnly = true)
	public Integer getServerTotalCount(Server server) {
		return serverMapper.getServerTotalCount(server);
	}
	
	@Transactional(readOnly = true)
	public List<Server> getListServer(Server server) {
		return serverMapper.getListServer(server);
	}

	@Transactional(readOnly = true)
	public Server getServer(Integer serverId) {
		return serverMapper.getServer(serverId);
	}
	
	@Transactional
	public int insertServer(Server server) {
		return serverMapper.insertServer(server);
	}

	@Transactional
	public int updateServer(Server server) {
		return serverMapper.updateServer(server);
	}

	@Transactional
	public int deleteServer(Integer serverId) {
		return serverMapper.deleteServer(serverId);
	}

}
