package com.rowan.ruber.repository;

import org.springframework.data.repository.CrudRepository;
import com.rowan.ruber.model.Chatroom;

// This will be AUTO IMPLEMENTED by Spring into a Bean called addressRepository
// CRUD refers Create, Read, Update, Delete
public interface ChatroomRepository extends CrudRepository<Chatroom, Integer> {

}