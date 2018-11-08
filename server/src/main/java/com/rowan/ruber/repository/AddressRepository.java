package com.rowan.ruber.repository;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.EntityGraph.EntityGraphType;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

import com.rowan.ruber.model.Address;
import com.rowan.ruber.model.Profile;

// This will be AUTO IMPLEMENTED by Spring into a Bean called addressRepository
// CRUD refers Create, Read, Update, Delete
public interface AddressRepository extends CrudRepository<Address, Integer> {
}