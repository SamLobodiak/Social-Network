package com.samuel.javatwo.repositories;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.samuel.javatwo.models.StatusReply;

@Repository
public interface StatusReplyRepository extends CrudRepository <StatusReply, Long> {
	
	@Query(value = "DELETE FROM statuse_replies WHERE status_id = ?1", nativeQuery=true)
	void removeStatusReplies(Long status_id);

}
