package com.CPG.service;


import com.CPG.domain.Visitor;

import java.io.InputStream;
import java.util.List;


public interface VisitorService {

    void add(Visitor visitor) throws Exception;

    List<Visitor> findAll(int page, int size) throws Exception;

    List<Visitor> search(int page, int size, String keyword) throws Exception;

    void logout(String id, String end_date) throws Exception;

    InputStream getInputStream() throws Exception;

    List<Visitor> log(int page, int size) throws Exception;

}
