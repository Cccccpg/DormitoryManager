package com.CPG.service;

import com.CPG.domain.Repair;

import java.io.InputStream;
import java.util.List;

public interface RepairService {

    void add(Repair repair) throws Exception;

    List<Repair> findAll(int page, int size) throws Exception;

    List<Repair> search(int page, int size, String keyword) throws Exception;

    void logout(String id, String repair_endDate) throws Exception;

    InputStream getInputStream() throws Exception;

    List<Repair> log(int page, int size) throws Exception;

}
